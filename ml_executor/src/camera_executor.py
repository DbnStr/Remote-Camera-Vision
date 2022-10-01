import datetime
import json
import logging

import cv2

from src.ml_executor import MLExecutor, read_test_set
from src.mqtt_publisher import MQTTPublisher


class CameraExecutor:
    """
    Класс для взаимоействия с камерой на сервере с MLExecutor

    Не в MVP версии будет включать логику взаимодействия с камерами на удаленных серверах
    """

    def __init__(self):
        self.ml_executor = MLExecutor()
        # self.ml_executor.load_data()

        self.mqtt_publisher = MQTTPublisher()
        self.mqtt_publisher.run()

        self.video_capture = cv2.VideoCapture(0)

        self.logger = logging.getLogger('ml_executor.{}'.format(__name__))

        self.last_recognized_persons = []

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

    def run(self):
        """
        Блокирующая функция
        Запускает процесс обработки информации с камеры и отправки данных брокеру
        """
        while True:
            ret, frame = self.video_capture.read()

            if not self.ml_executor.is_trained_enough():
                self.ml_executor.train()

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

        # When everything is done, release the capture
        self.video_capture.release()
        self.mqtt_publisher.stop()
        cv2.destroyAllWindows()
