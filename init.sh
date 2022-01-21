#!/usr/bin/env sh
name=$1
pwd1=$2
web_port=30001
core_port=8443
SHELL_FOLDER=$(cd "$(dirname "$0")";pwd)
                                                                                                                        
                                                                                                                        
echo "                                                                                                                        

                                                                                                                        
                                                                                                                        
           !@@@@@@@@@@@@@@@~                                                                                            
          !@@@@@@@@@@@@@@@@@@             #@@@@@@@@@@@@@        =@@@@                         !@@@@@,                   
          @@@@@@@@@@@@@@@@@@@@            @@@@@@@@@@@@@!       ;@@@@@@                      @@@@@@@@,                   
            @@@@@@@@   =@@@@@@@             @@@@@@@@!,        @@@@@@@                     ,@@@@@@@@.                   
            @@@@@@@@    @@@@@@@!             @@@@@@@           @@@@@@:                        @@@@@@.                   
            @@@@@@@@     @@@@@@@             @@@@@@@          ;@@@@@.                         @@@@@@.                   
            @@@@@@@@     :@@@@@@@            @@@@@@@                                          @@@@@@.                   
            @@@@@@@@      @@@@@@@~           @@@@@@@              !@@       @@!     ;@@!      @@@@@@.    #@@@@@@,       
            @@@@@@@@      .@@@@@@@           @@@@@@@          .@@@@@@    @@@@@@   @@@@@@@     @@@@@@.   @@@@@@@:        
            @@@@@@@@       @@@@@@@;          @@@@@@@          @@@@@@@   @@@@@@@-@@@@@@@@@     @@@@@@   @@@@@@           
            @@@@@@@@        @@@@@@@ @@@@@@@  @@@@@@@          .@@@@@@   ,@@@@@@@@@@@@@@@@     @@@@@@. @@@@@@            
            @@@@@@@@       .@@@@@@@ @@@@@@@  @@@@@@@            @@@@@    @@@@@@@.  .@@@@@     @@@@@@.@@@@@@.            
            @@@@@@@@       @@@@@@@  @@@@@@@  @@@@@@@            @@@@@    @@@@@@     @@@@@     @@@@@@@@@@@@!             
            @@@@@@@@       @@@@@@@  #######  @@@@@@@      ;@$   @@@@@    @@@@@@     @@@@@     @@@@@@@@@@@@!             
            @@@@@@@@      @@@@@@@.           @@@@@@@      @@$   @@@@@    @@@@@@     @@@@@     @@@@@@@@@@@@@-            
            @@@@@@@@     #@@@@@@@            @@@@@@@     @@@$   @@@@@    @@@@@@     @@@@@     @@@@@@-@@@@@@@            
            @@@@@@@@    ~@@@@@@@             @@@@@@@     @@@$   @@@@@    @@@@@@     @@@@@     @@@@@@, @@@@@@@           
            @@@@@@@@    @@@@@@@@             @@@@@@@     @@@$   @@@@@    @@@@@@     @@@@@     @@@@@@,  @@@@@@@.         
          -@@@@@@@@@@@@@@@@@@@@              @@@@@@@@*!@@@@@$  /@@@@@@   @@@@@@.    @@@@@@    @@@@@@@-  @@@@@@@@-       
          @@@@@@@@@@@@@@@@@@@@~           @@@@@@@@@@@@@@@@@@$ @@@@@@@@@ @@@@@@@@@   @@@@@@@ @@@@@@@@@@   @@@@@@@@@      
         ;@@@@@@@@@@@@@@@@@@.            @@@@@@@@@@@@@@@@@@@/ @@@@@@@@@ @@@@@@@@@    #@@@@# @@@@@@@@@@    :@@@@@@.      
                                                                                                                        
                                                                                                                        "

echo "########## Welcome use Nuclias Connect ###############"
echo "                     --                           "
echo "                     --                           "
echo "                     --                           "
sleep 3s
echo -e "\033[36m(1/8)---- check your system type ----\033[0m"
if [ "$(uname)" = "Darwin" ]
	then SYS="OS X"
elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
	SYS="Linux"
    if grep -Eqii "CentOS" /etc/issue || grep -Eq "CentOS" /etc/*-release; then
        DISTRO='CentOS'
        firewall-cmd --zone=public --add-port=$web_port/tcp --permanent
        firewall-cmd --zone=public --add-port=$core_port/tcp --permanent
        firewall-cmd --reload
    elif grep -Eqi "Red Hat Enterprise Linux Server" /etc/issue || grep -Eq "Red Hat Enterprise Linux Server" /etc/*-release; then
        DISTRO='RHEL'
    elif grep -Eqi "Aliyun" /etc/issue || grep -Eq "Aliyun" /etc/*-release; then
        DISTRO='Aliyun'
    elif grep -Eqi "Fedora" /etc/issue || grep -Eq "Fedora" /etc/*-release; then
        DISTRO='Fedora'
    elif grep -Eqi "Debian" /etc/issue || grep -Eq "Debian" /etc/*-release; then
        DISTRO='Debian'
        iptables -A INPUT -p tcp --dport $web_port -j ACCEPT
        iptables -A INPUT -p tcp --dport $core_port -j ACCEPT
    elif grep -Eqi "Ubuntu" /etc/issue || grep -Eq "Ubuntu" /etc/*-release; then
        DISTRO='Ubuntu'
        Check_Versions=`sudo cat /etc/*-release |grep DISTRIB_RELEASE |cut -c 17-21`
		if [ `echo "$Check_Versions < 20.04" |bc` -eq 1 ]
			then
				echo -e "\033[32mThe current version is lower than version 20.04: Please update to the specified version and above and try again.[y/n] \033[0m"
				read k
				if [ "$k" = "y" ]
					then
					exit 1	
				fi
		fi
        ufw allow $web_port/tcp
        ufw allow $core_port/tcp
        ufw reload
    elif grep -Eqi "Raspbian" /etc/issue || grep -Eq "Raspbian" /etc/*-release; then
        DISTRO='Raspbian'
    else
        DISTRO='unknow'
    fi
elif [ "$(expr substr $(uname -s) 1 10)" = "MINGW32_NT" ]; then
	SYS="WIN"
fi
echo "SYSTEM：$SYS $DISTRO"
echo -e "\033[32mcheck system finished\033[0m"


echo -e "\033[36m(2/8)---- check docker ----\033[0m"
check_docker=`docker -v`
if [ "$check_docker" ] 
	then echo "$check_docker"
else
	echo "no find docker !"
	# @todo install docker 
	if [ "$SYS" = "OS X" ]
		then echo -e "\033[31mno found docker. please install docker-for-mac before\033[0m"
		exit 1
	elif [ "$DISTRO" = "Ubuntu" ]; then	
		echo -e "\033[32mDo you want to install docker?[y/n]\033[0m"
		read k
		if [ "$k" = "y" ]
			then
			sudo apt-get update
			sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
			sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
			sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
			sudo apt-get update
			sudo apt-get install docker-ce docker-ce-cli containerd.io	
			sudo systemctl enable docker
			check_docker=`docker -v`
			if [ "$check_docker" ] 
				then 
				echo -e "\033[32mdocker installation is complete\033[0m"
				echo -e "\033[32m$check_docker\033[0m"
			fi
		else
			exit 1
		fi
	elif [ "$SYS" = "Linux" ]; then
		echo -e "\033[31mno found docker. please install docker before\033[0m"
		exit 1
		# echo "try installing docker "
		# curl -fsSL -o /dev/null "https://get.docker.com/"

	elif [ "$SYS" = "WIN" ]; then
		echo -e "\033[31mnot found docker. please install docker-for-windows before\033[0m"
		exit 1
	fi
fi
echo -e "\033[32mdocker installed\033[0m"

echo -e "\033[36m(3/8)---- check　docker-compose ----\033[0m"
check_docker_compose=`docker-compose -v`
if [ "$check_docker_compose" ]
	then echo "$check_docker_compose"
else
	# echo "start install docker-compose"
	echo "not found docker-compose"
	echo -e "\033[32mDo you want to install docker-compose?[y/n]\033[0m"
	read k
		if [ "$k" = "y" ]
			then
			sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
			sudo chmod +x /usr/local/bin/docker-compose
			docker-compose --version
			check_docker_compose=`docker-compose -v`
			if [ "$check_docker_compose" ]
				then 
				echo -e "\033[32mdocker-compose installation is complete\033[0m"
				echo -e "\033[32m$check_docker_compose\033[0m"
			fi			
		else
			exit 1
		fi	# @ todo install docker compose
fi
echo -e "\033[32mdocker-compose installed\033[0m"

echo -e "\033[36m(4/8)---- check docker status ----\033[0m"
check_docker_status=`ps -fe | grep dockerd | wc -l`
echo "message: $check_docker_status"
if [ $check_docker_status -eq 1 ]
	# then echo "start run docker service"
	then echo "docker service not running"
	exit 1
	# @ todo start docker
fi
echo -e "docker sevice is running\033[0m"

echo -e "\033[36m(5/8)---- check web_port ----\033[0m"
check_web_port_free=`lsof -i:$web_port | wc -l`
echo "message: $check_web_port_free"
if [ $check_web_port_free -eq 0 ]
	then echo -e "\033[32mweb_port is free"
else
	echo -e "\033[31mweb_port:$web_port is used\033[0m" 
	exit 1
fi

echo -e "\033[36m(6/8)---- check core_port ----\033[0m"
check_core_port_free=`lsof -i:$core_port | wc -l`
echo "message: $check_core_port_free"
if [ $check_core_port_free -eq 0 ]
	then echo -e "\033[32mcore_port is free\033[0m"
else
	echo -e "\033[31mweb_port:$core_port is used\033[0m" 
	exit 1
fi

echo -e "\033[36m(7/8)---- check mongo_port ----\033[0m"
for port in 27010 27017
do
	check_mongo_port_free=`lsof -i:$port | wc -l`
	echo "message: $check_mongo_port_free"
	if [ $check_mongo_port_free -eq 0 ]
		then echo -e "\033[32mmongo_port $port is free\033[0m"
	else
		echo -e "\033[31mmongo_port $port is used\033[0m" 
		exit 1
	fi
done

echo -e "\033[36m(8/8)---- check file and directory ----\033[0m"
if [ ! -f $SHELL_FOLDER"/docker-compose.yml" ]
	then echo -e "\033[31m not found docker-compose.yml\033[0m"
	exit 1
elif [ ! -f $SHELL_FOLDER"/appconfig.json" ]; then
	echo -e "\033[31mnot found appconfig.json\033[0m"
	exit 1
elif [ ! -f $SHELL_FOLDER"/config/systemconfig.json" ]; then
	echo -e "\033[31mnot found /config/systemconfig.json\033[0m"
	exit 1
elif [ ! -f $SHELL_FOLDER"/entrypoint-initdb.sh" ]; then
	echo -e "\033[31mnot found entrypoint-initdb.sh\033[0m"
	exit 1
fi
if [ ! -d $SHELL_FOLDER"/customer" ]; then
	mkdir $SHELL_FOLDER"/customer"
fi
# if [[ ! -d $SHELL_FOLDER"/data" ]]; then
# 	mkdir $SHELL_FOLDER"/data"
# fi
if [ ! -d $SHELL_FOLDER"/log/core/logs" ]; then
		if [ ! -d $SHELL_FOLDER"/log" ]; then
			mkdir $SHELL_FOLDER"/log"
		fi
		if [ ! -d $SHELL_FOLDER"/log/core" ]; then
			mkdir $SHELL_FOLDER"/log/core"
		fi
		if [ ! -d $SHELL_FOLDER"/log/core/logFiles" ]; then
			mkdir $SHELL_FOLDER"/log/core/logFiles"
		fi
fi
if [ ! -d $SHELL_FOLDER"/log/web/logs" ]; then
		if [ ! -d $SHELL_FOLDER"/log/web" ]; then
			mkdir $SHELL_FOLDER"/log/web"
		fi
		if [ ! -d $SHELL_FOLDER"/log/web/logFiles" ]; then
			mkdir $SHELL_FOLDER"/log/web/logFiles"
		fi
fi
sed -i "3c \  \"nucliasPath\":\""$SHELL_FOLDER"\"," $SHELL_FOLDER"/config/systemconfig.json"
echo -e "\033[32mcheck file finished\033[0m"
echo -e "\033[32mall check_job finished\033[0m"
echo ""
echo -e "\033[36mNow initial set the database administrator account for Nuclias Connect\033[0m"

if [ -n "$name" ]; then 
  if [ -n "$pwd1" ]; then
	sed -i "5c db.createUser({user:'"$name"', pwd:'"$pwd1"', roles:[{role:'root',db:'admin'}]});" $SHELL_FOLDER"/entrypoint-initdb.sh"
	sed -i "6c db.auth('"$name"','"$pwd1"');" $SHELL_FOLDER"/entrypoint-initdb.sh"
  fi
fi

docker-compose up -d
echo -e "\033[32mNuclias Connect services are running...\033[0m"
echo ""
echo "-- commands list -----------------------"
echo "|                                       |"
echo -e "|  start: \033[32mdocker-compose up -d\033[0m          |"
echo -e "|  stop:: \033[32mdocker-compose down\033[0m           |"
echo "|                                       |"
echo " ----------------------------------------"
exit 0





