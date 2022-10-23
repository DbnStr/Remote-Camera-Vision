import logging

import asyncio
from camera_executor import CameraExecutor

logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')

if __name__ == '__main__':
    loop = asyncio.new_event_loop()
    # loop.set_debug(True)

    camera_executor = CameraExecutor(is_test=False)
    camera_executor.run(loop)




