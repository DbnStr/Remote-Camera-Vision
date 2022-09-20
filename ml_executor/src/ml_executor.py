import base64
import logging
import os
import pickle
import uuid

import cv2
import face_recognition
from imutils import paths

from src.db.fake_db import DataBase

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
        Класс посредник для взаимодействия с БД
        """
        self.db = DataBase()

        self.logger = logging.getLogger('ml_executor.{}'.format(__name__))

    def train(self):
        """
        На каждой фотографии из набора выделяются участки с лицом,
        после чего происходит эмбеддинг признаков и сохранение этих данных с именем человека

        Фотографии для обучения хранятся в директории ../training_set/<ФИО>
        Формат файлов: <ФИО>.jpg
        """
        image_paths = list(paths.list_images('../training_set'))
        dirs = set()
        for (i, image_path) in enumerate(image_paths):
            person_name = image_path.split("/")[-2]
            dirs.add(f'../training_set/{person_name}')

        for image_dir in dirs:
            image_subpaths = list(paths.list_images(image_dir))
            person_name = image_dir.split("/")[-1]
            id = uuid.uuid4()
            for (j, image_subpath) in enumerate(image_subpaths):

                # person_name = re.match(r'(?P<name>[^.]*).jpg', file_name).group('name')
                self.logger.debug("subpath: {}".format(image_subpath))
                self.logger.debug("name: {}".format(person_name))

                image = cv2.imread(image_subpath)
                rgb = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)

                boxes = face_recognition.face_locations(rgb, model='hog')
                encodings = face_recognition.face_encodings(rgb, boxes)
                for encoding in encodings:
                    self.db.add_encoding(id, encoding)

        data = {"encodings": self.db.get_encodings(), "names": self.db.get_persons()}
        with open("face_enc", "wb") as file:
            file.write(pickle.dumps(data))

    def is_trained_enough(self):
        """
        Выполняется проверка на то, была ли уже обучена модель на выборке
        """
        image_paths = list(paths.list_images('../training_set'))
        if len(image_paths) == len(self.db.get_encodings()):
            return True
        else:
            return False

    def load_data(self):
        self.db.load_data()

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
            name_id = "Unknown"
            if True in matches:
                matched_ids = [i for (i, b) in enumerate(matches) if b]
                counts = {}
                for i in matched_ids:
                    name_id = idx[i]
                    counts[name_id] = counts.get(name_id, 0) + 1
                name_id = max(counts, key=counts.get)

            if name_id == "Unknown":
                name = "Unknown"
            else:
                name = self.db.get_name_by_id(name_id)

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
