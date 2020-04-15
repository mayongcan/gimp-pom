#!/bin/bash
SH_DIR=$(dirname $(which $0))

#项目路径
export PRO_PATH="/Users/zzd/Work/ProjectRun/project"
#项目日志路径
export PRO_LOG_PATH="/Users/zzd/Work/ProjectRun/logs"
#项目端口
export APP_PORT=8052
#虚拟机参数设计
export JAVA_OPTS="-Xms256M -Xmx512m -Dapp.port="${APP_PORT}
#加载jar包的优先顺序(在此处填写的jar包将会优先加载，使用逗号分隔)
export CLASS_LOAD_FIRST="gimp-core-1.0.2.jar,gimp-module-workflow-1.0.2.jar"
#项目名称
export APP_NAME=gimp-module-workflow-1.0.2
#项目主类
export APP_MAINCLASS=com.gimplatform.module.workflow.WorkflowApplication

. $SH_DIR/exec_func.sh
