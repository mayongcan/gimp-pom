#!/bin/bash
SH_DIR=$(dirname $(which $0))

#项目路径
export PRO_PATH="/Users/zzd/Work/ProjectRun/project"
#项目日志路径
export PRO_LOG_PATH="/Users/zzd/Work/ProjectRun/logs"
#项目端口
export APP_PORT=8053
#虚拟机参数设计
export JAVA_OPTS="-Xms64M -Xmx128m -Dapp.port="${APP_PORT}
#项目名称
export APP_NAME=gimp-resource-server-1.0.2
#项目主类
export APP_MAINCLASS=com.gimplatform.resserver.ResServer

. $SH_DIR/exec_func.sh
