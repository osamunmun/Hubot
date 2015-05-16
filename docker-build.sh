#!/bin/sh
set -xe

if [ -e ~/cache/hubot.tar ] && [ $(md5sum Dockerfile | cut -d' ' -f1) = $(cat ~/cache/dockerfile.digest) ]
then
  docker load < ~/cache/hubot.tar
else
  mkdir -p ~/cache
  docker build -t hubot/slack .
  md5sum Dockerfile | cut -d' ' -f1 > ~/cache/dockerfile.digest
  docker save hubot/slack > ~/cache/hubot.tar
fi
