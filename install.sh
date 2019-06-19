#!/bin/bash

TMP_NUCLIAS_CONNECT=/tmp/nuclias_connect
TMP_NUCLIAS_CONNECT_config=/tmp/nuclias_connect/config
if [ ! -d $TMP_NUCLIAS_CONNECT ];then
  mkdir -p $TMP_NUCLIAS_CONNECT
fi

cd $TMP_NUCLIAS_CONNECT
curl -o init.sh https://raw.githubusercontent.com/nuclias-connect/connect/dev/init.sh
curl -o docker-compose.yml https://raw.githubusercontent.com/nuclias-connect/connect/dev/docker-compose.yml
curl -o entrypoint-initdb.sh https://raw.githubusercontent.com/nuclias-connect/connect/dev/entrypoint-initdb.sh
curl -o appconfig.json https://raw.githubusercontent.com/nuclias-connect/connect/dev/appconfig.json
if [ ! -d $TMP_NUCLIAS_CONNECT_config ];then
  mkdir -p $TMP_NUCLIAS_CONNECT_config
fi
cd $TMP_NUCLIAS_CONNECT_config
curl -o systemconfig.json https://raw.githubusercontent.com/nuclias-connect/connect/dev/config/systemconfig.json
cd $TMP_NUCLIAS_CONNECT

sudo sh $TMP_NUCLIAS_CONNECT"/init.sh"