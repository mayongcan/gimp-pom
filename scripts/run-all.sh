#!/bin/bash

#需要启动的程序脚本
# APP_SHELL="gimp-discovery.sh,gimp-api-gateway.sh,gimp-auth-server.sh,gimp-resource-server.sh"
APP_SHELL="gimp-discovery.sh,gimp-api-gateway.sh,gimp-auth-server.sh,gimp-resource-server.sh,gimp-module-sys.sh,gimp-module-workflow.sh"

function start() {
	echo "-------------------------------------------- BEGIN --------------------------------------------"
	appArray=(${APP_SHELL//,/ })  
	for i in ${appArray[@]}; do
		echo -e "\033[34mexecute shell cmd: ./$i start \033[0m"   
	    ./$i start
		echo
	done  
	echo "-------------------------------------------- END --------------------------------------------"
}

function stop() {
	echo "-------------------------------------------- BEGIN --------------------------------------------"
	appArray=(${APP_SHELL//,/ })  
	for i in ${appArray[@]}; do
		echo -e "\033[34mexecute shell cmd: ./$i stop \033[0m"   
	    ./$i stop
		echo
	done  
	echo "-------------------------------------------- END --------------------------------------------"
}

function status() {
	echo "-------------------------------------------- BEGIN --------------------------------------------"
	appArray=(${APP_SHELL//,/ })  
	for i in ${appArray[@]}; do
		echo -e "\033[34mexecute shell cmd: ./$i status \033[0m"   
	    ./$i status
		echo
	done  
	echo "-------------------------------------------- END --------------------------------------------"
}

function info() {
	echo "-------------------------------------------- BEGIN --------------------------------------------"
	appArray=(${APP_SHELL//,/ })  
	for i in ${appArray[@]}; do
		echo -e "\033[34mexecute shell cmd: ./$i info \033[0m"  
	    ./$i info
		echo
	done  
	echo "-------------------------------------------- END --------------------------------------------"
}

case "$1" in
	'start')
		start
		;;
	'stop')
		stop
		;;
	'restart')
		stop
		start
		;;
	'status')
		status
		;;
	'info')
		info
		;;
	*)
		echo "Usage: $0 {start|stop|restart|status|info}"
		exit 1
esac
exit 0
