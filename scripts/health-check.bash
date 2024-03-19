#!/bin/bash
#
#

BE_SVC_URL=https://backend.dev.simpos.com.tw/

RESPONSE=$(curl -s -X GET "$BE_SVC_URL")
echo $RESPONSE
if [ "$RESPONSE" = "Hello World!" ]; then
	echo 'get Hello World!'
	exit 1
fi
