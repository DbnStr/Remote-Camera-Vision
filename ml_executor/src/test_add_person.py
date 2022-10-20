import base64
import binascii
import json
import os
import random

import cv2
import numpy as np

import paho.mqtt.client as mqtt

recognition_topic = 'recognition'
current_view_topic = 'current_view'
client_id = f'python-mqtt-{random.randint(0, 100)}'

# mqtt_host = 'broker.emqx.io'
mqtt_host = '194.87.232.100'
# mqtt_host = 'localhost'
mqtt_port = 1883
username = 'root'
password = '4o4dMWWwP2'


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


def run():
    client = connect_mqtt()
    home = os.path.expanduser('~daria-ismagilova')
    print(home)
    with open(f"{home}/Downloads/photo_2022-10-20_14-13-29.jpg", "rb") as f:
        image = f.read()
        image_encoded = base64.b64encode(bytes(image)).decode()
    data = {
        "name": "Даня",
        "photos": [image_encoded]
    }
    client.loop_start()
    result = client.publish('new_recognizable_person', json.dumps(data))
    status = result[0]
    if status == 0:
        print(f"Send msg to topic new_recognizable_person")
        pass
    else:
        print(f"Failed to send message to topic new_recognizable_person: {result}")

    client.loop_stop()


if __name__ == '__main__':
    run()
