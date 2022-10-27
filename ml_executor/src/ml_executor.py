import asyncio
import base64
import logging
import os
import pickle
import uuid
from copy import deepcopy

import cv2
import face_recognition
import numpy as np
from imutils import paths

from db.fake_db import DataBase

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

    def __init__(self, db=None):

        """
        Класс посредник для взаимодействия с БД
        """
        if db is None:
            self.db = DataBase()
        else:
            self.db = db

        self.retrain_number = 1

        self.logger = logging.getLogger('ml_executor.{}'.format(__name__))

    def train(self):
        """
        На каждой фотографии из набора выделяются участки с лицом,
        после чего происходит эмбеддинг признаков и сохранение этих данных с именем человека
        """
        print("START TRAIN")
        persons_photos = deepcopy(self.db.get_persons_photo())
        persons_map = {}
        encodings_arr = []

        for person_name, photos in persons_photos.items():
            person_id = self.db.create_id(person_name)
            persons_map[person_id] = person_name
            for photo in photos:
                # image = cv2.imread(image_path)
                image = np.fromstring(photo, np.uint8)
                img = cv2.imdecode(image, flags=1)
                rgb = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)

                boxes = face_recognition.face_locations(rgb, model='hog')
                encodings = face_recognition.face_encodings(rgb, boxes)
                for encoding in encodings:
                    encodings_arr.append({self.db.person_id_field: person_id,
                                          self.db.encoding_data_field: encoding.tolist()})

        self.db.add_encoding(encodings_arr)
        self.db.set_persons(persons_map)

        print("TRAINED")

    def is_trained_enough(self):
        """
        Выполняется проверка на то, была ли уже обучена модель на выборке
        или накопилось ли достаточно новых данных для переобучения
        """
        known_persons_amount = self.db.known_person_amount()
        if len(self.db.get_encodings()) != 0 and \
                known_persons_amount - len(self.db.get_encodings()) < self.retrain_number:
            return True
        else:
            return False

    def load_data(self):
        self.db.load_data()

    def add_person(self, name, photos):
        self.db.add_person_photos(name, photos)

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
            known_encodings = [encoding[self.db.encoding_data_field] for encoding in self.db.get_encodings()]
            idx = [encoding[self.db.person_id_field] for encoding in self.db.get_encodings()]
            matches = face_recognition.compare_faces(known_encodings, encoding)
            name_id = "-1"
            if True in matches:
                matched_ids = [i for (i, b) in enumerate(matches) if b]
                counts = {}
                for i in matched_ids:
                    name_id = idx[i]
                    counts[name_id] = counts.get(name_id, 0) + 1
                name_id = max(counts, key=counts.get)

            if name_id == "-1":
                name = "Unknown"
            else:
                name = self.db.get_name_by_id(name_id)

            persons.append({'id': name_id, 'name': name, 'coordinates': {
                'top': top,
                'right': right,
                'bottom': bottom,
                'left': left
            }})

        img_encode = cv2.imencode('.jpg', image)[1]
        jpg_as_text = base64.b64encode(img_encode).decode()

        return jpg_as_text, persons
