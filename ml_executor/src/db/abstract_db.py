from abc import ABC, abstractmethod


class AbstractDataBase(ABC):

    person_id_field = 'person_id'
    encoding_data_field = 'encoding_data'

    @abstractmethod
    def get_encodings(self):
        pass

    @abstractmethod
    def add_encoding(self, id, encoding):
        pass

    @abstractmethod
    def add_person(self, person_id, name, images_paths):
        pass

    @abstractmethod
    def add_person_photos(self, name, photos):
        pass
