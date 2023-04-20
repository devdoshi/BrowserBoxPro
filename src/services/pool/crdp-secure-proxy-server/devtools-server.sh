#!/usr/bin/env bash

node=$(which node)

source $1

cookie=$COOKIE_VALUE
token=$LOGIN_TOKEN
port=$DEVTOOLS_PORT

cd devtools/

$node index.js $port $cookie $token
