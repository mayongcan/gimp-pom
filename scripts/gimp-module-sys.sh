#!/bin/bash
SH_DIR=$(dirname $(which $0))

#项目路径
export PRO_PATH="/Users/zzd/Work/ProjectRun/project"
#项目日志路径
export PRO_LOG_PATH="/Users/zzd/Work/ProjectRun/logs"
#项目端口
export APP_PORT=8051
#虚拟机参数设计
export JAVA_OPTS="-Xms256M -Xmx512m -Dapp.port="${APP_PORT}
#项目名称
export APP_NAME=gimp-module-sys-1.0.2
#项目主类
export APP_MAINCLASS=com.gimplatform.module.sys.SystemApplication

. $SH_DIR/exec_func.sh
