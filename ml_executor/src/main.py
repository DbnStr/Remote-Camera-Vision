import logging
import os
import pickle
import re
import cv2
import face_recognition

from imutils import paths

logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger('ml_executor')

cascPathface = os.path.dirname(
 cv2.__file__) + "/data/haarcascade_frontalface_alt2.xml"
faceCascade = cv2.CascadeClassifier(cascPathface)

known_encodings = []
names = []


def train():
    """
    Фотографии для обучения хранятся в директории training_set
    Имя файла: <ФИО>.jpg
    """
    image_paths = list(paths.list_images('../training_set'))
    for (i, image_path) in enumerate(image_paths):
        logger.info("image_path: {}".format(image_path))
        file_name = image_path.split("/")[-1]
        logger.info("file_name: {}".format(file_name))
        person_name = re.match(r'(?P<name>[^.]*).jpg', file_name).group('name')
        logger.debug("person_name: {}".format(person_name))

        image = cv2.imread(image_path)
        rgb = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)

        boxes = face_recognition.face_locations(rgb, model='hog')
        encodings = face_recognition.face_encodings(rgb, boxes)
        for encoding in encodings:
            known_encodings.append(encoding)
            names.append(person_name)

    data = {"encodings": known_encodings, "names": names}
    with open("face_enc", "wb") as file:
        file.write(pickle.dumps(data))


def face_recognize(image, data):
    rgb = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
    encodings = face_recognition.face_encodings(rgb)
    persons = []
    for encoding in encodings:
        matches = face_recognition.compare_faces(data["encodings"], encoding)
        name = "Неизвестный"
        if True in matches:
            matched_ids = [i for (i, b) in enumerate(matches) if b]
            counts = {}
            for i in matched_ids:
                name = data["names"][i]
                counts[name] = counts.get(name, 0) + 1
            name = max(counts, key=counts.get)
        persons.append(name)
    return persons


def read_test_set():
    image_paths = list(paths.list_images('../test_set'))
    images = {}
    for (i, image_path) in enumerate(image_paths):
        file_name = image_path.split("/")[-1]

        images[file_name] = cv2.imread(image_path)
    return images


if __name__ == '__main__':
    train()
    data = pickle.loads(open('face_enc', "rb").read())
    test_images = read_test_set()
    for (test_name, test_image) in test_images.items():
        results = face_recognize(test_image, data)
        logger.info("На фото {} распознаны {}".format(test_name, results))
