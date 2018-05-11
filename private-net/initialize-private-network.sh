#!/usr/bin/env bash

# ---------------------------------------------
# geth-control: initialize-private-network.sh
# ---------------------------------------------
# Copyright (c) 2018 PLUSPLUS CO.,LTD.
# Released under the MIT license
# https://www.plusplus.jp/
# ---------------------------------------------

DIR=$(cd $(dirname $0);pwd)

source ${DIR}/_function.sh

if [ ! -e ${DIR}/networkid.txt ]; then
    echo -ne "\033[1;32;40mWould you like to issue a network ID? [YES/*] \033[0;39m"
else
    echo -ne "\033[1;31;40mDo you want to reissue the network ID? (Initialize private network data) [YES/*] \033[0;39m"
fi
read answer

function RUN () {

    perl -e 'print time' > ${DIR}/networkid.txt

    # Network-ID
    NET_ID=`cat ${DIR}/networkid.txt`
    echo -e "\033[1;32m>>> Created as network ID: ${NET_ID}\033[0;39m"

    cd ${DIR}

    rm -fr geth/ && OK || NG

    echo
    echo -e "\033[1;36m>>> [HINT] Do you want to see more logs?\033[0;39m"
    echo -e "\033[1;36m>>>        Please try use ${DIR}/start-private-net.sh\033[0;39m"
    echo
}

case $answer in
    YES)
        RUN
        ;;
    *)
        ;;
esac