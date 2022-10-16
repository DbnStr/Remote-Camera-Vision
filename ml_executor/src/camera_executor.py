import asyncio
import base64
import datetime
import json
import logging

import cv2

from ml_executor import MLExecutor
from mqtt_publisher import MQTTPublisher
from timer import Timer


class CameraExecutor:
    """
    Класс для взаимоействия с камерой на сервере с MLExecutor

    Не в MVP версии будет включать логику взаимодействия с камерами на удаленных серверах
    """

    def __init__(self, is_test=False):
        self.ml_executor = MLExecutor()
        # self.ml_executor.load_data()

        self.mqtt_publisher = MQTTPublisher()
        self.mqtt_publisher.run()

        self.screen_timer = Timer(2, self.make_screen)

        if is_test:
            self.video_capture = cv2.VideoCapture('https://www.sample-videos.com/video/mp4/720/big_buck_bunny_720p_2mb.mp4')
        else:
            self.video_capture = cv2.VideoCapture(0)

        self.logger = logging.getLogger('ml_executor.{}'.format(__name__))

        self.last_recognized_persons = []

    def run(self, loop=None):
        if loop is None:
            loop = asyncio.get_running_loop()
        self.screen_timer.start(loop)
        loop.run_until_complete(self.run_recognition())
        # asyncio.ensure_future(self.run_recognition())
        #
        # # суррогат сервера принимающего соединения
        # while True:
        #     await asyncio.sleep(1)

    def is_there_new_persons(self, new_names) -> bool:
        """
        Для снижения нагрузки на сеть можно вызвать этот метод и не отправлять
        данные с камеры, если новых людей не было обнаружено
        """
        if "Unknown" in new_names:
            return True
        else:
            for new_name in new_names:
                if not (new_name in self.last_recognized_persons):
                    return True
            return False

    async def run_recognition(self):
        """
        Блокирующая функция
        Запускает процесс обработки информации с камеры и отправки данных брокеру
        """
        while True:
            ret, frame = self.video_capture.read()

            if not self.ml_executor.is_trained_enough():
                self.ml_executor.train()

            if frame is not None:
                image_encoded, results = self.ml_executor.face_recognize(frame)
                new_names = [result['name'] for result in results]
                if self.is_there_new_persons(new_names):
                    time = str(datetime.datetime.now())
                    data = {
                        'image': image_encoded,
                        'persons': results,
                        'time': time
                    }
                    self.last_recognized_persons = new_names
                    self.mqtt_publisher.send('recognition', data)
                    self.logger.info("На кадре распознаны {}".format(json.dumps(results)))

                if cv2.waitKey(1) & 0xFF == ord('q'):
                    break


            await asyncio.sleep(0.5)

        # When everything is done, release the capture
        self.video_capture.release()
        self.mqtt_publisher.stop()
        cv2.destroyAllWindows()

    def make_screen(self):
        """
        Отправляет текущее состояние камеры пользователю
        """
        ret, frame = self.video_capture.read()
        if frame is not None:
            jpg_as_text = base64.b64encode(cv2.imencode('.jpg', frame)[1]).decode()
            print("make screen")
            self.mqtt_publisher.send("current_view", {
                'image': jpg_as_text,
                'time': str(datetime.datetime.now())
            })
