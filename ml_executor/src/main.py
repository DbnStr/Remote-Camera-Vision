import datetime
import logging
import os
import cv2

from ml_executor import MLExecutor, read_test_set
from mqtt_publisher import MQTTPublisher

logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger('{}.ml_executor'.format(__name__))


if __name__ == '__main__':
    ml_executor = MLExecutor()
    ml_executor.load_data()

    mqtt_publisher = MQTTPublisher()
    mqtt_publisher.run()

    if not ml_executor.is_trained_enough():
        ml_executor.train()

    test_images = read_test_set()
    for (test_name, test_image) in test_images.items():
        image_encoded, results = ml_executor.face_recognize(test_image)
        time = str(datetime.datetime.now())
        data = {
            'image': None,
            'persons': results,
            'time': time
        }
        mqtt_publisher.send('recognition', data)
        logger.info("На фото {} распознаны {}".format(test_name, results))

    mqtt_publisher.stop()
