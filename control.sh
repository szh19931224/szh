#!/bin/bash
#chkconfig:2345 80 05 --指定在哪几个级别执行，0一般指关机，6指的是重启，其他为正常启动。80为启动的优先级，05为关闭的优先机
#description:gocron-node service
RETVAL=0
start(){
     GocronPid=`ps -ef|grep "/usr/local/gocron-node/gocron-node"|grep -v grep|awk -F " " '{print $2}'`
     if [[ -z ${GocronPid} ]];then
         echo "gocron-node serive ..."
         su edit -c "nohup /usr/local/gocron-node/gocron-node >> /usr/local/gocron-node/node.log &"
         echo  "gocron-node start successful!"
     else
         echo "gocron-node is already running...."
     fi
}
 
stop(){
     GocronPid=`ps -ef|grep "/usr/local/gocron-node/gocron-node"|grep -v grep|awk -F " " '{print $2}'`
     #echo ${GocronPid}
     if [[ -z ${GocronPid} ]];then
         echo  "gocron-node is not running!!!"
     else
         echo "gocron-node service is stoped..."
         kill -9 ${GocronPid}
         echo "gocron-node service stoped successful!"
     fi
}
 
status(){
     processNum=0
     processNum=`ps aux|grep "/usr/local/gocron-node/gocron-node"|grep -v grep|wc -l`
     if [[ ${processNum} == 1 ]];then
         echo "gocron-node is already running...${processNum}"
     else
         echo "gocron-node is not running .... $processNum}"
     fi
}
 
 
case $1 in
    start)
        start
        ;;
    stop)
        stop
        ;;
    status)
        status
        ;;
    restart)
        stop
        start
        ;;
    *)
        echo $"Usage: $0 {start|stop|status|restart}"
        exit 2
esac
exit $RETVAL

# https://www.cnblogs.com/xzlive/p/14040821.html
