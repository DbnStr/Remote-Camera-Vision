import datetime
import logging

from src.camera_executor import CameraExecutor

logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')

if __name__ == '__main__':
    camera_executor = CameraExecutor()
    camera_executor.run()




