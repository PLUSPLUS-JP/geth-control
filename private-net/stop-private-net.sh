#!/usr/bin/env bash

# ---------------------------------------------
# geth-control: stop-private-network.sh
# ---------------------------------------------
# Copyright (c) 2018 PLUSPLUS CO.,LTD.
# Released under the MIT license
# https://www.plusplus.jp/
# ---------------------------------------------

DIR=$(cd $(dirname $0);pwd)

source ${DIR}/_function.sh
PID_FILE="${DIR}/geth.pid"

if [ ! -e ${PID_FILE} ]; then
    echo -e "\033[1;32m*** Not connected to a private network (PID file is not found) ***\033[0;39m"
    echo

    exit;
fi

echo -ne "\033[1;32;40mStop the private network? [YES/*] \033[0;39m"
read answer

function RUN () {

    PID=`cat ${PID_FILE}`

    kill -0 ${PID} > /dev/null 2>&1

    if [ $? = 0 ]; then
        kill ${PID} & OK || NG
    fi

    rm ${PID_FILE}
}

case $answer in
    YES)
        RUN
        ;;
    *)
        ;;
esac
