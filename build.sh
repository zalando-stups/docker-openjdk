#!/bin/bash

VER=$(cat VERSION)
IMG=zalando/openjdk:$VER

echo "Building $IMG .."

docker build  --no-cache=true -t $IMG .

SQUASH_PATH=$(which docker-squash)

if [ -z "$SQUASH_PATH" ]; then
    # install Docker Squash from https://github.com/jwilder/docker-squash
    TGZ=docker-squash-linux-amd64-v0.1.0.tar.gz
    wget https://github.com/jwilder/docker-squash/releases/download/v0.1.0/$TGZ
    sudo tar -C /usr/local/bin -xzvf $TGZ
    rm $TGZ
fi

echo 'Squashing the image to save space..'
docker save $IMG | sudo docker-squash -t $IMG | docker load
