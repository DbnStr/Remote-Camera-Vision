#!/bin/bash

docker build . -t lockfile:local
docker run -it --device=/dev/video0:/dev/video0 lockfile:local bash