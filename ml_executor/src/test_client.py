import base64
import json
import random

import cv2
import matplotlib.pyplot as plt
import numpy as np

import paho.mqtt.client as mqtt

topic = 'recognition'
client_id = f'python-mqtt-{random.randint(0, 100)}'

mqtt_host = 'broker.emqx.io'
mqtt_port = 1883
username = 'emqx'
password = 'public'


def connect_mqtt() -> mqtt:
    def on_connect(client, userdata, flags, rc):
        if rc == 0:
            print("Connected to MQTT Broker!")
        else:
            print("Failed to connect, return code {}\n".format(rc))

    client = mqtt.Client(client_id)
    client.username_pw_set(username, password)
    client.on_connect = on_connect
    client.connect(mqtt_host, mqtt_port)
    return client


def subscribe(client: mqtt):
    def on_message(client, userdata, msg):
        if msg.topic == topic:
            str_data = str(msg.payload.decode('UTF-8'))
            print(msg.topic + " " + str_data)
            # data = json.loads(str_data)
            # image_str = data['image']
            # jpg_original = base64.b64decode(image_str)
            # jpg_as_np = np.frombuffer(jpg_original, dtype=np.uint8)
            # img = cv2.imdecode(jpg_as_np, flags=1)
            # plt.imshow(img)
            # plt.show()

    client.subscribe(topic)
    client.on_message = on_message


def run():
    client = connect_mqtt()
    subscribe(client)
    client.loop_forever()


if __name__ == '__main__':
    run()
