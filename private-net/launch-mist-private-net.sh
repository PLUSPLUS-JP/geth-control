#!/usr/bin/env bash

# ---------------------------------------------
# geth-control: launch-mist-private-net.sh
# ---------------------------------------------
# Copyright (c) 2018 PLUSPLUS CO.,LTD.
# Released under the MIT license
# https://www.plusplus.jp/
# ---------------------------------------------

# For Mist, please click here.
# Mist. Browse and use Ðapps on the Ethereum network. http://ethereum.org
# https://github.com/ethereum/mist

DIR=$(cd $(dirname $0);pwd)
source ${DIR}/_function.sh

if [ ! -e ${PID_FILE} ]; then
    echo -e "\033[1;32m*** Not connected to a private network (PID file is not found) ***\033[0;39m"
    echo

    exit;
fi

if [ "$(uname)" == 'Darwin' ]; then
    open -a /Applications/Mist.app --args --rpc ${DIR}/geth.ipc && OK || NG
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
    MIST_CMD=`which mist`
    ${MIST_CMD} --rpc ${DIR}/geth.ipc && OK || NG
else
    echo "Your platform ($(uname -a)) is not supported."
    exit 1
fi
