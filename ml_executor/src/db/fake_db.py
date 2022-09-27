import pickle
import uuid

from src.db.abstract_db import AbstractDataBase


class DataBase(AbstractDataBase):
    def __init__(self):

        """
        Имена людей из обучаемой выборки

        MVP: {person_id: name}
        """
        self.persons = {}

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

    def add_person(self, person_id, name):
        self.persons[person_id] = name

    def add_encoding(self, id, encoding):
        self.known_encodings.append({self.person_id_field: id, self.encoding_data_field: encoding})

    def get_name_by_id(self, id):
        return self.persons[id]
