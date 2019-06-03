#!/bin/bash

TMP_NUCLIAS_CONNECT=/tmp/nuclias-connect

if [ ! -d $TMP_NUCLIAS_CONNECT ];then
  mkdir -p $TMP_NUCLIAS_CONNECT
fi

cd $TMP_NUCLIAS_CONNECT

curl -o docker-compose.yml https://raw.githubusercontent.com/nuclias-connect/connect/master/docker-compose.yml

docker-compose up