@echo off

echo start check docker...
for /f "delims=:" %%t in ('docker -v ^| find /C /I "Docker version"') do set hasdocker=%%t
if %hasdocker% equ 1 (
	echo docker had installed
	) else (
	echo not found docker. please install docker before
	goto end
	)

echo start check docker-compose...
for /f "delims=:" %%t in ('docker-compose -v ^| find /C /I "docker-compose version"') do set hascompose=%%t
if %hasdocker% equ 1 (
	echo docker-compose had installed
	) else (
	echo not found docker-compose.  please install docker-compose before
	goto end
	)

echo start check docker status...
for /f "delims=:" %%t in ('docker ps ^| find /C /I "CONTAINER ID"') do set isruning=%%t
if %isruning% equ 1 (
	echo docker is running well
	) else (
	echo not found docker service. please start dokcer before.
	goto end
	)
echo start check images...
for /f "delims=:" %%t in ('docker images dlink/cwm-core:latest ^| find /C /I "dlink/cwm-core"') do set hascore=%%t
if %hascore% equ 1 (
	echo core image is existed
	) else (
		if exist %~dp0\images\core.tar (
		docker load < %~dp0\images\core.tar
		) else (
		echo not found core image. please check \images\core.tar is exist
		goto end
		)
	)

for /f "delims=:" %%t in ('docker images dlink/cwm-web:latest ^| find /C /I "dlink/cwm-web"') do set hasweb=%%t
if %hasweb% equ 1 (
	echo web image is existed
	) else (
		if exist %~dp0\images\web.tar (
		docker load < %~dp0\images\web.tar
		) else (
		echo not found web image. please check \images\web.tar is exist
		goto end
		)
	)

for /f "delims=:" %%t in ('docker images mongo:latest ^| find /C /I "mongo"') do set hasmongo=%%t
if %hasmongo% equ 1 (
	echo mongo image is existed
	) else (
		if exist %~dp0\images\mongo.tar (
		docker load < %~dp0\images\mongo.tar
		) else (
		echo not found moongo image. please check \images\mongo.tar is exist
		goto end
		)
	)
echo check images finished !

echo start check port
for /f "delims=:" %%t in ('netstat -an ^| find /C /I "0.0.0.0:30001"') do set portfree=%%t
if %portfree% equ 1 (
	echo 30001 port is busy. please check it
	goto end
	)


for /f "delims=:" %%t in ('netstat -an ^| find /C /I "0.0.0.0:8443"') do set portfree=%%t
if %portfree% equ 1 (
	echo 8443 port is busy. please check it 
	goto end
	)
echo check port finished

echo start check file and directory...
if not exist %~dp0\docker-compose.yml (
	echo docker-compose.yml not found . please check your workdir
	goto end
	)

if not exist %~dp0\appconfig.js (
	echo appconfig.js not found . please check your workdir
	goto end
	)

if not exist %~dp0\config/systemconfig.json (
	echo \config\systemconfig.json not found . please check your workdir
	goto end
	)
if not exist %~dp0\dbConfig.js (
	echo docker-compose.yml not found
	goto end
	)
if not exist %~dp0\customer (
	md customer
	)
if not exist %~dp0\log\web\logFiles (
	md log\web\logFiles
	)
if not exist %~dp0\log\core\logFiles (
	md log\core\logFiles
	)
echo check file and directory finished
echo -----
echo ----
echo ---
echo --
echo -
echo all is ready. start run cwm-service

docker-compose up -d

echo welcome use CWM server. 
echo                you can availabe on https://localhost:30001
echo -- command list -------------------
echo ^|                                  ^|     
echo ^|    start: docker-compose up -d   ^|
echo ^|    stop : docker-compose down    ^|
echo ^|                                  ^|
echo -----------------------------------   

:end
pause
