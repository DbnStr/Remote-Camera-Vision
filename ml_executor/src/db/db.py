import base64
import os
import pickle
import uuid

import firebase_admin
import numpy
from firebase_admin import credentials
from firebase_admin import firestore, storage

from db.abstract_db import AbstractDataBase
from imutils import paths

PROJECT_ID = 'remote-camera-vision'


class FirebaseDataBase(AbstractDataBase):
    def __init__(self):

        cred = credentials.Certificate('remote-camera-vision-firebase-adminsdk-64xr1-4d7d0bd185.json')
        app = firebase_admin.initialize_app(cred, {
            'projectId': PROJECT_ID,
            'storageBucket': 'remote-camera-vision.appspot.com'
        })

        self.firebase_client = firestore.client()
        self.storage = storage.bucket()

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
        doc = self.firebase_client.collection(u'persons').document(u'face_encodings').get()
        if doc.exists:
            self.known_encodings = doc.to_dict()['encodings']

    def save_recognition_notification(self, camera_id, notification):
        image_name = str(uuid.uuid4())
        image_path = f"recognition_notifications/{image_name}.png"
        blob = self.storage.blob(f'recognition_notifications/{image_name}.png')
        blob.upload_from_string(base64.b64decode(notification['image']), content_type='image/png')

        doc_ref = self.firebase_client.collection(u'cameras').document(u'{}'.format(camera_id))
        doc_ref.set({u'notifications': firestore.ArrayUnion([{
            u'persons': notification['persons'],
            u'view': image_path,
            u'viewDateTime': notification['viewDateTime']
        }])}, merge=True)

    def get_encodings(self):
        return self.known_encodings

    def known_person_amount(self):
        return len(self.firebase_client.collection(u'persons').document(u'images').get().to_dict()['paths'])

    def delete_all_names(self):
        doc_ref = self.firebase_client.collection(u'persons').document(u'names')
        doc_ref.set()

    def add_person_name(self, person_id, name):
        doc_ref = self.firebase_client.collection(u'persons').document(u'names')
        doc_ref.set({person_id: name}, merge=True)

    def set_persons(self, persons):
        doc_ref = self.firebase_client.collection(u'persons').document(u'names')
        doc_ref.set(persons)

    def add_person(self, person_id, name, images_paths):
        self.add_person_name(person_id, name)
        doc_ref = self.firebase_client.collection(u'persons').document(u'images')
        doc_ref.set({u'paths': {name: images_paths}}, merge=True)

    def add_encoding(self, encodings):
        """
        Перезаписывает энкодинги
        """
        self.known_encodings = numpy.array(encodings)
        doc_ref = self.firebase_client.collection(u'persons').document(u'face_encodings')
        doc_ref.set({u'encodings': encodings})

    def get_name_by_id(self, id):
        doc_ref = self.firebase_client.collection(u'persons').document(u'names')
        return doc_ref.get()[id]

    def create_id(self, name) -> str:
        id = str(uuid.uuid4())
        return id

    def get_persons_photo(self):
        doc_ref = self.firebase_client.collection(u'persons').document(u'images')
        images = doc_ref.get().to_dict()['paths']

        photos = {}
        for person_name, images_path in images.items():
            a = []
            for image_path in images_path:
                a.append(self.storage.blob(image_path).download_as_string())
            photos[person_name] = a
        return photos

    def add_person_photos(self, name, photos):
        person_id = str(uuid.uuid4())

        paths = []
        for i, photo in enumerate(photos):
            decoded_photo = base64.b64decode(photo)
            blob = self.storage.blob(f'training_set/{name}{i}.png')
            blob.upload_from_string(decoded_photo, content_type='image/png')
            paths.append(f"training_set/{name}{i}.png")

        self.add_person(person_id, name, paths)
