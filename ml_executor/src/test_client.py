import base64
import binascii
import json
import random

import cv2
import matplotlib.pyplot as plt
import numpy as np

import paho.mqtt.client as mqtt

topic = 'recognition'
client_id = f'python-mqtt-{random.randint(0, 100)}'

# mqtt_host = 'broker.emqx.io'
mqtt_host = 'localhost'
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
    # client.username_pw_set(username, password)
    client.on_connect = on_connect
    client.connect(mqtt_host, mqtt_port)
    return client


def subscribe(client: mqtt):
    def on_message(client, userdata, msg):
        if msg.topic == topic:
            str_data = str(msg.payload.decode('UTF-8'))
            print(msg.topic + " " + str_data)
            data = json.loads(str_data)
            jpg_as_text = data['image']
            jpg_original = base64.b64decode(jpg_as_text)
            jpg_as_np = np.frombuffer(jpg_original, dtype=np.uint8)
            image_buffer = cv2.imdecode(jpg_as_np, flags=1)

            for person in data['persons']:
                name = person['name']
                (top, right, bottom, left) = person['coordinates']
                # Рисуем рамку
                cv2.rectangle(image_buffer, (left, top), (right, bottom), (0, 0, 255), 2)

                # Рисуем метку с именем
                font = cv2.FONT_HERSHEY_COMPLEX
                print(name)
                cv2.putText(image_buffer, name, (left + 6, bottom - 6), font, 1.0, (255, 255, 255), 1)


            # Выводим изоражение
            cv2.imshow('PhotoOnClient', image_buffer)
            # Для выхода нажать 'q'
            if cv2.waitKey(1) & 0xFF == ord('q'):
                return

    client.subscribe(topic)
    client.on_message = on_message


def run():
    client = connect_mqtt()
    subscribe(client)
    client.loop_forever()


if __name__ == '__main__':
    run()
