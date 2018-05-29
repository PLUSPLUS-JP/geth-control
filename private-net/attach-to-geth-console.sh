#!/usr/bin/env bash

# ---------------------------------------------
# geth-control: attach-to-geth-console.sh
# ---------------------------------------------
# Copyright (c) 2018 PLUSPLUS CO.,LTD.
# Released under the MIT license
# https://www.plusplus.jp/
# ---------------------------------------------

DIR=$(cd $(dirname $0);pwd)

source ${DIR}/_function.sh

geth attach ${DIR}/geth.ipc && OK || NG

