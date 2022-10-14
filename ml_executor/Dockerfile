FROM python:3.10

RUN apt-get update && apt-get install -y \
    apt-utils\
    ffmpeg \
    libsm6 \
    libxext6 \
    cmake

#    git \
#    unzip \
#    pkg-config \
#    python-dev \
#    python-opencv \
#    libopencv-dev \
#    libav-tools  \
#    libjpeg-dev \
#    libpng-dev \
#    libtiff-dev \
#    libjasper-dev \
#    libgtk2.0-dev \
#    python-numpy \
#    python-pycurl \
#    libatlas-base-dev \
#    gfortran \
#    webp \
#    python-opencv \
#    qt5-default \
#    libvtk6-dev \
#    zlib1g-dev

RUN pip install pipenv

ENV PROJECT_DIR /usr/local/src/webapp

WORKDIR ${PROJECT_DIR}

COPY Pipfile Pipfile.lock ${PROJECT_DIR}/
COPY src ${PROJECT_DIR}/src
COPY test_set ${PROJECT_DIR}/test_set
COPY training_set ${PROJECT_DIR}/training_set

RUN pipenv install --system --deploy