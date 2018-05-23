geth (go-ethereum client) control script 
=======================

<!-- TOC -->

- [geth (go-ethereum client) control script ](#geth-go-ethereum-client-control-script)
- [1. Overview / 概要](#1-overview)
- [2. How To Use. / 使用方法](#2-how-to-use)
    - [2.1. config / 初期設定](#21-config)
    - [2.2. create getesis.json / getesis.json を作成](#22-create-getesisjson---getesisjson)
    - [2.3. initialize / 初期化](#23-initialize)
    - [2.4. start private net / プライベートネットの起動](#24-start-private-net)
    - [2.5. stop private net / プライベートネットの停止](#25-stop-private-net)

<!-- /TOC -->

# 1. Overview / 概要

It is a script to handle geth (go-ethereum client) commands easily.
It will work on MacOS.

geth (go-ethereum client) のコマンドを簡単に扱うためのスクリプトです。
MacOSで動作することを確認しています。

# 2. How To Use. / 使用方法

## 2.1. config / 初期設定

If you want to change the port used for communication, create it as `private-net/private-net.cf` from `private-net/sample-private-net.cf` and set the port number.

通信に使用するポートを変更したい場合は、`private-net/sample-private-net.cf` から `private-net/private-net.cf` として作成し、ポート番号を設定します。

- OPT_RPC_PORT (Default: 8545)
    - Specify the port number to be used for rpc connection.
    - rpc 接続で使用するポート番号を指定します。
- OPT_WS_PORT (Default: 8546)
    - Specify the port number to be used for web socket.
    - web socket で使用するポート番号を指定します。
- OPT_GETH_PORT (Default: 30303)
    - Specify the port number that geth uses to communicate with other nodes.
    - gethが他のノードと通信する際に使用するポート番号を指定します。

## 2.2. create getesis.json / getesis.json を作成

First of all, please create `getesis.json`.
`sample-genesis.json` is a sample file. You can use it even if you copy it as it is.

まずはじめに、`getesis.json` を作成してください。
`sample-genesis.json` がサンプルファイルです。そのままコピーしても使えます。

## 2.3. initialize / 初期化

Execute `initialize-private-network.sh` to initialize private nets.
Initialization is done only once.

`initialize-private-network.sh` を実行し、プライベートネットの初期化を行います。
初期化は一度だけ行います。

## 2.4. start private net / プライベートネットの起動

Execute `start-private-net.sh` to start the private net.
If there is an error, it will be displayed on the console.

`start-private-net.sh` を実行し、プライベートネットを起動します。
エラーが有る場合は、コンソールに表示されるでしょう。

## 2.5. stop private net / プライベートネットの停止

If you want to stop the private net, execute `stop-private-net.sh` and stop the process.

プライベートネットを停止させたい場合は、`stop-private-net.sh` を実行します。



