#!/bin/bash
name=$1
pwd1=$2
if [ -n "$name" ]; then 
  if [ -n "$pwd1" ]; then
echo ""
else echo "If input username, you should also please input assword for mongodb"
 exit 1
  fi
fi
TMP_NUCLIAS_CONNECT=/usr/local/nuclias_connect
TMP_NUCLIAS_CONNECT_config=/usr/local/nuclias_connect/config
if [ ! -d $TMP_NUCLIAS_CONNECT ];then
  mkdir -p $TMP_NUCLIAS_CONNECT
fi

cd $TMP_NUCLIAS_CONNECT
echo " "

echo -e "\033[36m--- Download config files---\033[0m"
echo " "
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
echo -e "\033[32m--- Download Complete\033[0m"
echo " "

sudo sh init.sh $name $pwd1
