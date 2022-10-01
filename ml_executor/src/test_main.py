import logging

from src.fake_camera import FakeCameraExecutor

logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')

if __name__ == '__main__':
    camera_executor = FakeCameraExecutor()
    camera_executor.run()




