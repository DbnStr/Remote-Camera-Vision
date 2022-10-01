import json
import logging
import random

import paho.mqtt.client as mqtt

username = 'emqx'
password = 'public'
# host = 'broker.emqx.io'
host = 'localhost'


class MQTTPublisher:

    def __init__(self, host=host, port=1883):
        self.mqtt_host = host
        self.mqtt_port = port
        self.client_id = f'python-mqtt-{random.randint(0, 100)}'

        self.client = self.connect_mqtt()

        self.logger = logging.getLogger('{}.ml_executor'.format(__name__))

    def connect_mqtt(self) -> mqtt:
        def on_connect(client, userdata, flags, rc):
            if rc == 0:
                print("Connected to MQTT Broker!")
            else:
                print("Failed to connect, return code {}\n".format(rc))

        client = mqtt.Client(self.client_id)
        # client.username_pw_set(username, password)
        client.on_connect = on_connect
        client.connect(self.mqtt_host, self.mqtt_port)
        return client

    def run(self):
        self.client.loop_start()

    def stop(self):
        self.client.loop_stop()

    def send(self, topic, msg):
        result = self.client.publish(topic, json.dumps(msg))
        status = result[0]
        if status == 0:
            print(f"Send `{msg}` to topic `{topic}`")
        else:
            print(f"Failed to send message to topic {topic}: {result}")
