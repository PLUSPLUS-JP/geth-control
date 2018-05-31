#!/usr/bin/env bash

# ---------------------------------------------
# geth-control: attach-to-geth-console.sh
# ---------------------------------------------
# Copyright (c) 2018 PLUSPLUS CO.,LTD.
# Released under the MIT license
# https://www.plusplus.jp/
# ---------------------------------------------

DIR=$(cd $(dirname $0);pwd)
PID_FILE="${DIR}/geth.pid"

if [ ! -e ${PID_FILE} ]; then
    echo -e "\033[1;32m*** Not connected to a private network (PID file is not found) ***\033[0;39m"
    echo

    exit;
fi

source ${DIR}/_function.sh

geth attach ${DIR}/geth.ipc && OK || NG

