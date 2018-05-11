#!/usr/bin/env bash

# ---------------------------------------------
# geth-control: start-private-network.sh
# ---------------------------------------------
# Copyright (c) 2018 PLUSPLUS CO.,LTD.
# Released under the MIT license
# https://www.plusplus.jp/
# ---------------------------------------------

DIR=$(cd $(dirname $0);pwd)

source ${DIR}/_function.sh
source ${DIR}/private-net.cf

# Get epoch second at startup
if [ ! -e ${DIR}/networkid.txt ]; then
    perl -e 'print time' > ${DIR}/networkid.txt
fi

# Network-ID
NET_ID=`cat ${DIR}/networkid.txt`

# Proess-ID
PID_FILE="$DIR/geth.pid"

if [ -e ${PID_FILE} ]; then
    echo -e "\033[1;32m*** You are already connected to a private-net (there is a PID file) ***\033[0;39m"
    echo

    ls -l ${PID_FILE}
    echo

    exit;
fi

echo -ne "\033[1;32;40mConnect to private net? [YES/*] \033[0;39m"
read answer

function RUN () {

    if [ ! -d ${DIR}/geth ]; then
        echo
        echo -e "\033[1;36m>>> Initialize the network\033[0;39m"
        echo

        geth --datadir ${DIR} init ${DIR}/genesis.json && OK || NG
    fi

    #
    # start
    #
    nohup geth --networkid ${NET_ID} --nodiscover --maxpeers 0 --datadir ${DIR} \
        --rpc --rpcaddr "0.0.0.0" --rpcport=${RPC_PORT} --rpccorsdomain "*" \
        --ws  --wsaddr "0.0.0.0"  --wsport=${WS_PORT}  --wsorigins="*" \
        --port ${GETH_PORT} \
        --rpcapi "admin,db,eth,debug,miner,net,shh,txpool,personal,web3" \
        --verbosity 6 2>> ${DIR}/geth.log &
    PID=$!
    sleep 1

    PID2=`pgrep -f "geth --networkid ${NET_ID}"`

    if [ "${PID}" = "${PID2}" ]; then
        #
        # OK
        #
        echo
        echo -e "\033[1;36m>>> Startup success, enjoy with private net :-)\033[0;39m"
        echo
        tail ${DIR}/geth.log

        OK

        echo
        echo -e "\033[1;36m>>> [HINT] Do you want to see more logs?\033[0;39m"
        echo -e "\033[1;36m>>>        Please try use ${DIR}/monitor-geth-log.sh\033[0;39m"
        echo

        echo ${PID} > ${PID_FILE}
    else
        #
        # Not OK
        #
        NG

        echo
        echo -e "\033[1;31m>>> Failed to start.\033[0;39m"
        echo -e "\033[1;31m>>> Please check the log\033[0;39m"
        echo
        tail ${DIR}/geth.log
    fi
}

case $answer in
    YES)
        RUN
        ;;
    *)
        ;;
esac




