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

if [ -e "${DIR}/private-net.cf" ]; then
    source ${DIR}/private-net.cf
fi

# for RPC connection
DEFAULT_RPC_PORT=8545
RPC_PORT=${OPT_RPC_PORT:-${DEFAULT_RPC_PORT}}

# for web socket
DEFAULT_WS_PORT=8546
WS_PORT=${OPT_WS_PORT:-${DEFAULT_WS_PORT}}

# for geth
DEFAULT_GETH_PORT=30303
GETH_PORT=${OPT_GETH_PORT:-${DEFAULT_GETH_PORT}}

#echo RPC_PORT: ${RPC_PORT}
#echo WS_PORT: ${WS_PORT}
#echo GETH_PORT: ${GETH_PORT}

# Get epoch second at startup
if [ ! -e ${DIR}/networkid.txt ]; then
    perl -e 'print time' > ${DIR}/networkid.txt
fi

# Network-ID
NET_ID=`cat ${DIR}/networkid.txt`

# Proess-ID
PID_FILE="$DIR/geth.pid"

if [ -e ${PID_FILE} ]; then

    PID=`cat ${PID_FILE}`

    # Check if the process ID actually exists
    kill -0 ${PID} > /dev/null 2>&1

    if [ $? = 0 ]; then

        # exist
        echo -e "\033[1;32m*** You are already connected to a private-net (there is a PID file) ***\033[0;39m"
        echo

        ls -l ${PID_FILE}
        echo

        echo -e "\033[1;32m*** Running process ***\033[0;39m"
        echo

        ps u -p ${PID}
        echo

        exit;

    else
        # not exist
        rm ${PID_FILE};
    fi
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




