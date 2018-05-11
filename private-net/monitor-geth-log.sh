#!/usr/bin/env bash

# ---------------------------------------------
# geth-control: monitor-geth-log.sh
# ---------------------------------------------
# Copyright (c) 2018 PLUSPLUS CO.,LTD.
# Released under the MIT license
# https://www.plusplus.jp/
# ---------------------------------------------

DIR=$(cd $(dirname $0);pwd)
tail -F ${DIR}/geth.log
