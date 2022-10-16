import datetime
import logging
import pickle

from src.ml_executor import MLExecutor
from src.mqtt_publisher import MQTTPublisher


class FakeCameraExecutor:

    def __init__(self):
        self.ml_executor = MLExecutor()
        # self.ml_executor.load_data()

        self.mqtt_publisher = MQTTPublisher()
        self.mqtt_publisher.run()

        self.logger = logging.getLogger('ml_executor.{}'.format(__name__))

        self.last_recognized_persons = []

    def run(self):

        # data = pickle.loads(open("test_message.txt", "rb").read())
        data = "test"
        self.mqtt_publisher.send('current_view', data)
