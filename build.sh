#!/bin/bash

VER=8u40-b09-1

docker build -t zalando/openjdk:$VER .

SQUASH_PATH=$(which docker-squash)

if [ -z "$SQUASH_PATH" ]; then
    # install Docker Squash from https://github.com/jwilder/docker-squash
    TGZ=docker-squash-linux-amd64-v0.0.11.tar.gz
    wget https://github.com/jwilder/docker-squash/releases/download/v0.0.11/$TGZ
    sudo tar -C /usr/local/bin -xzvf $TGZ
    rm $TGZ
fi

echo 'Squashing the image to save space..'
docker save zalando/openjdk:$VER | sudo docker-squash -t zalando/openjdk:$VER | docker load
