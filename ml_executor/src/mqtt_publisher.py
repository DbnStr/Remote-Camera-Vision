import json
import logging
import random

import paho.mqtt.client as mqtt

username = 'root'
password = '4o4dMWWwP2'
# host = 'broker.emqx.io'
host = '194.87.232.100'
# host = 'localhost'

add_person_topic = 'new_recognizable_person'


class MQTTPublisher:

    def __init__(self, ml_executor, host=host, port=1883):
        self.mqtt_host = host
        self.mqtt_port = port
        self.client_id = f'python-mqtt-{random.randint(0, 100)}'

        self.client = self.connect_mqtt()

        self.ml_executor = ml_executor

        self.logger = logging.getLogger('{}.ml_executor'.format(__name__))

    def connect_mqtt(self) -> mqtt:
        def on_connect(client, userdata, flags, rc):
            if rc == 0:
                print("Connected to MQTT Broker!")
                client.subscribe(add_person_topic)
            else:
                print("Failed to connect, return code {}\n".format(rc))

        def on_message(client, userdata, msg):
            if msg.topic == add_person_topic:
                print("Got new person message")
                str_data = str(msg.payload.decode('UTF-8'))
                data = json.loads(str_data)
                name = data['name']
                photos = data['photos']
                self.ml_executor.add_person(name, photos)

        client = mqtt.Client(self.client_id)
        client.username_pw_set(username, password)
        client.on_connect = on_connect
        client.on_message = on_message
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
            # print(f"Send `{msg}` to topic `{topic}`")
            pass
        else:
            print(f"Failed to send message to topic {topic}: {result}")
