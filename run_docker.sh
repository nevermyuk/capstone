#!/usr/bin/env bash


# Build image and add a descriptive tag
docker build -t nevermyuk/capstone:latest .

# List docker images
docker image ls

# Run flask app
docker run -d --name capstone -p 8000:80 nevermyuk/capstone
