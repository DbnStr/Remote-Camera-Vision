import base64
import os
import pickle
import uuid

from db.abstract_db import AbstractDataBase
from imutils import paths


class DataBase(AbstractDataBase):
    def __init__(self):

        """
        Имена людей из обучаемой выборки

        MVP: {person_id: name}
        """
        self.persons = {}

        """
        Фотографии пользователей
        
        MVP: {person_id: photo_paths}
        """
        self.persons_photos = {}

        """
        Эмбеддинги, полученные на обучаемой выборке
        Используются для сравнения с данными о распознаваемом лице
        
        [{person_id_field: ..., encoding_data_field: ...}]
        """
        self.known_encodings = []

    def load_data(self):
        """
        Информация о известных признаках загружается из файла face_enc
        """
        data = pickle.loads(open('../face_enc', "rb").read())
        self.persons = data['persons']
        self.known_encodings = data['encodings']

    def get_encodings(self):
        return self.known_encodings

    def get_persons(self):
        return self.persons

    def add_new_encoding(self, name, encoding):
        id = uuid.uuid4()
        self.persons[id] = name
        self.known_encodings.append({self.person_id_field: id, self.encoding_data_field: encoding})

    def add_person(self, person_id, name, images_paths):
        self.persons[person_id] = name
        self.persons_photos[person_id] = images_paths

    def add_encoding(self, id, encoding):
        self.known_encodings.append({self.person_id_field: id, self.encoding_data_field: encoding})

    def get_name_by_id(self, id):
        return self.persons[id]

    def load_persons_photo(self):
        """
        Фотографии для обучения хранятся в директории ../training_set/<Name>
        Формат файлов: <Name>.jpg
        """
        image_paths = list(paths.list_images('../training_set'))
        dirs = set()
        for (i, image_path) in enumerate(image_paths):
            person_name = image_path.split("/")[-2]
            dirs.add(f'../training_set/{person_name}')

        for image_dir in dirs:
            image_subpaths = list(paths.list_images(image_dir))
            print(image_subpaths)
            person_name = image_dir.split("/")[-1]
            id = str(uuid.uuid4())
            images = []
            for (j, image_subpath) in enumerate(image_subpaths):
                images.append(image_subpath)
            self.add_person(id, person_name, images)

    def get_persons_photo(self):
        return self.persons_photos

    def add_person_photos(self, name, photos):
        person_id = str(uuid.uuid4())
        self.persons[person_id] = name
        if not os.path.exists(f'../training_set/{name}'):
            os.makedirs(f'../training_set/{name}')
        for i, photo in enumerate(photos):
            decoded_photo = base64.b64decode(photo)
            with open(f'../training_set/{name}/{name}{i}.jpg', 'wb') as f:
                f.write(decoded_photo)
            if person_id in self.persons_photos:
                self.persons_photos[person_id].append(f'../training_set/{name}/{name}{i}.jpg')
            else:
                self.persons_photos[person_id] = [f'../training_set/{name}/{name}{i}.jpg']
