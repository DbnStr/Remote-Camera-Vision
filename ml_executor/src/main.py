import logging
import os
import pickle
import cv2

from ml_executor import MLExecutor, read_test_set

logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger('{}.ml_executor'.format(__name__))

cascPathface = os.path.dirname(
 cv2.__file__) + "/data/haarcascade_frontalface_alt2.xml"
faceCascade = cv2.CascadeClassifier(cascPathface)


if __name__ == '__main__':
    ml_executor = MLExecutor()
    ml_executor.load_data()
    if not ml_executor.is_trained_enough():
        ml_executor.train()

    test_images = read_test_set()
    for (test_name, test_image) in test_images.items():
        results = ml_executor.face_recognize(test_image)
        logger.info("На фото {} распознаны {}".format(test_name, results))
