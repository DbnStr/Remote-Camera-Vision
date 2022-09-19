import base64
import binascii
import logging
import os
import pickle
import re
import time

import cv2
import face_recognition
import numpy as np
from imutils import paths

cascPathface = os.path.dirname(
 cv2.__file__) + "/data/haarcascade_frontalface_alt2.xml"
faceCascade = cv2.CascadeClassifier(cascPathface)


def read_test_set():
    """
    С помощью opencv происходит чтение изображений
    Возвращается массив изображений

    Фотографии для проверки хранятся в директории ../test_set
    """
    image_paths = list(paths.list_images('../test_set'))
    images = {}
    for (i, image_path) in enumerate(image_paths):
        file_name = image_path.split("/")[-1]

        images[file_name] = cv2.imread(image_path)
    return images


class MLExecutor:

    def __init__(self):

        """
        Эмбеддинги, полученные на обучаемой выборке
        Используются для сравнения с данными о распознаваемом лице
        """
        self.known_encodings = []

        """
        Имена людей из обучаемой выборки
        Кажому лицу в списке соответсвуют эмбеддинги из массива known_encodings
        """
        self.names = []

        logger = logging.getLogger('{}.ml_executor'.format(__name__))

    def train(self):
        """
        На каждой фотографии из набора выделяются участки с лицом,
        после чего происходит эмбеддинг признаков и сохранение этих данных с именем человека

        Фотографии для обучения хранятся в директории ../training_set
        Формат файлов: <ФИО>.jpg
        """
        image_paths = list(paths.list_images('../training_set'))
        for (i, image_path) in enumerate(image_paths):
            file_name = image_path.split("/")[-1]
            person_name = re.match(r'(?P<name>[^.]*).jpg', file_name).group('name')
            self.logger.debug("person_name: {}".format(person_name))

            image = cv2.imread(image_path)
            rgb = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)

            boxes = face_recognition.face_locations(rgb, model='hog')
            encodings = face_recognition.face_encodings(rgb, boxes)
            for encoding in encodings:
                self.known_encodings.append(encoding)
                self.names.append(person_name)

        data = {"encodings": self.known_encodings, "names": self.names}
        with open("face_enc", "wb") as file:
            file.write(pickle.dumps(data))

    def is_trained_enough(self):
        """
        Выполняется проверка на то, была ли уже обучена модель на выборке
        """
        image_paths = list(paths.list_images('../training_set'))
        if len(image_paths) == len(self.names):
            return True
        else:
            return False

    def load_data(self):
        """
        Информация о известных признаках загружается из файла face_enc
        """
        data = pickle.loads(open('face_enc', "rb").read())
        self.names = data['names']
        self.known_encodings = data['encodings']

    def face_recognize(self, image):
        """
        Признаки каждого распознанного на изображении лица сравниваются с известными эмбеддингами,
        человек, с чьими изображениями получилось больше всего совпадений, признается распознанным
        на данном фото

        Возвращается закодированное изображение и список распознанных людей
        """
        rgb = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
        encodings = face_recognition.face_encodings(rgb)
        face_locations = face_recognition.face_locations(rgb)
        persons = []
        for (top, right, bottom, left), encoding in zip(face_locations, encodings):
            matches = face_recognition.compare_faces(self.known_encodings, encoding)
            name = "Unknown"
            if True in matches:
                matched_ids = [i for (i, b) in enumerate(matches) if b]
                counts = {}
                for i in matched_ids:
                    name = self.names[i]
                    counts[name] = counts.get(name, 0) + 1
                name = max(counts, key=counts.get)

            persons.append({'name': name, 'coordinates': (top, right, bottom, left)})

            # # Рисуем рамку
            # cv2.rectangle(image, (left, top), (right, bottom), (0, 0, 255), 2)
            #
            # # Рисуем метку с именем
            # font = cv2.FONT_HERSHEY_COMPLEX
            # print(name)
            # cv2.putText(image, name, (left + 6, bottom - 6), font, 1.0, (255, 255, 255), 1)

        img_encode = cv2.imencode('.jpg', image)[1]
        jpg_as_text = base64.b64encode(img_encode).decode()

        # # Выводим изоражение
        # cv2.imshow('Photo', image)
        # cv2.waitKey(0)
        # time.sleep(3)

        return jpg_as_text, persons
