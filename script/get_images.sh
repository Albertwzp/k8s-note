#!/bin/bash

USER="admin"
PASS="Harbor"
HURL="http://9.77.77.57:30443"

rtoken=$(curl -k -s  -u ${USER}:${PASS} ${HURL}/service/token?account=${USER}\&service=harbor-registry\&scope=registry:catalog:*|grep "token" |awk -F '"' '{print $4}')

#echo $rtoken

rlist=$(curl -k -s -H "authorization: bearer $rtoken " ${HURL}/v2/_catalog|awk -F '[' '{print $2}'|awk -F ']' '{print $1}'|sed 's/"//g')

echo $rlist|sed 's/,/\n/g'
