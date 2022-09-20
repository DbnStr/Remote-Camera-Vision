from abc import ABC, abstractmethod


class AbstractDataBase(ABC):

    person_id_field = 'person_id'
    encoding_data_field = 'encoding_data'

    @abstractmethod
    def get_encodings(self):
        pass

    @abstractmethod
    def get_persons(self):
        pass

    @abstractmethod
    def add_new_encoding(self, name, encoding):
        pass

    @abstractmethod
    def add_encoding(self, id, encoding):
        pass
