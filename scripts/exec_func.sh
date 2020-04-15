#!/bin/bash

#STDOUT日志数据
export STDOUT_LOG=$PRO_LOG_PATH/STDOUT_$APP_NAME.log

#检查日志是否存在
if [[ ! -f "$STDOUT_LOG" ]]
then
	touch $STDOUT_LOG
fi
#设置包路径
CLASSPATH=$PRO_PATH/$APP_NAME/
#设置预先加载的jar包
classArray=(${CLASS_LOAD_FIRST//,/ })  
for i in ${classArray[@]}; do
    CLASSPATH=""
done  
for i in ${classArray[@]}; do
    CLASSPATH="$CLASSPATH$PRO_PATH/$APP_NAME/"lib/"$i":
done  
#加载lib里面的包
for i in "$PRO_PATH"/$APP_NAME/lib/*.*; do
	CLASSPATH="$CLASSPATH":"$i"
done

CLASSPATH=$PRO_PATH/$APP_NAME/config:$CLASSPATH

echo "JAVA_OPTS is $JAVA_OPTS"

psid=0

#检查PID
checkpid() {
	javaps=`jps -lv | grep $APP_MAINCLASS |grep "Dapp.port=$APP_PORT"` 
	
	if [ -n "$javaps" ]; then
		psid=`echo $javaps | awk '{print $1}'`
	else
		psid=0
	fi
}

#启动程序
start() {
	checkpid

	if [ $psid -ne 0 ]; then
		echo -n "Application $APP_MAINCLASS"
        echo -e "\033[31m already started! \033[0m"
    else
        echo "Begin to Starting Application $APP_MAINCLASS"
		#echo "nohup $JAVA_HOME/bin/java $JAVA_OPTS -classpath $CLASSPATH $APP_MAINCLASS 2>&1 >> $STDOUT_LOG  &";
        nohup java $JAVA_OPTS -classpath $CLASSPATH $APP_MAINCLASS >>$STDOUT_LOG 2>&1  &
        echo -n "Application is starting ..."
        osType=`uname`
        for ((i = 1; i <= 50; i ++))  
		do  
		    sleep 1s
		    echo -n "..."
		    #通过判断文件修改时间，确定程序是否已结束启动
		    if [ $osType = "Linux" ]; then
				fileDate=`stat -c %Y $STDOUT_LOG`
			else
				fileDate=`stat -f %m -t %Y $STDOUT_LOG`
			fi
			sysDate=`date +%s`       			#获取当前系统的时间 (秒为单位）
			#判断当前时间和文件修改时间差（2秒）
			if [ $i -gt 4 -a $[ $sysDate - $fileDate ] -gt 2 ]; then
				break
			fi
		done  
		echo ""
		#su - $RUNNING_USER -c "$JAVA_CMD"
        checkpid
        if [ $psid -ne 0 ]; then
			echo -n "Start Application (pid=$psid)"
			echo -e "\033[32m [Success] \033[0m"
        else
            echo -n "Start Application"
            echo -e "\033[31m [Failed] You can check the log file [$STDOUT_LOG] \033[0m"
        fi
	fi
}

#停止程序
stop() {
	checkpid

	if [ $psid -ne 0 ]; then
		echo -n "Stopping $APP_MAINCLASS ...(pid=$psid)"
		kill -9 $psid
		if [ $? -eq 0 ]; then
			echo -e "\033[32m [OK] \033[0m"
		else
			echo -e "\033[31m [Failed] [Log Path:$STDOUT_LOG] \033[0m"
		fi

		checkpid
		if [ $psid -ne 0 ]; then
			stop
		fi
	else
		echo -n "$APP_MAINCLASS"
        echo -e "\033[31m is not running! \033[0m"
	fi
}

#查看程序状态
status() {
	checkpid

	if [ $psid -ne 0 ]; then
		echo -n "$APP_MAINCLASS (pid=$psid)"
		echo -e "\033[32m is running! \033[0m"
	else
		echo -n "$APP_MAINCLASS"
        echo -e "\033[31m is not running! [Log Path:$STDOUT_LOG] \033[0m"
	fi
}

#查看系统信息
info() {
	echo -e "\033[31mSystem Information: \033[0m"
    echo "============================================================================================"
	echo `head -n 1 /etc/issue`
	echo `uname -a`
	echo
	echo "JAVA_HOME=$JAVA_HOME"
	echo `java -version`
	echo "APP_HOME=$PRO_PATH"
	echo "APP_MAINCLASS=$APP_MAINCLASS"
    echo "============================================================================================"
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
