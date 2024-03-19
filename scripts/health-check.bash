#!/bin/bash
#
#

BE_SVC_URL=https://backend.dev.simpos.com.tw/
DB_HEALTHZ=https://backend.dev.simpos.com.tw/healthz

BE_STATUS=$(curl -s -X GET "$BE_SVC_URL" | jq -r '.status')
DB_STATUS=$(curl -s -X GET "$DB_HEALTHZ" | jq -r '.status')

STATUSES=("$DB_STATUS" "$BE_STATUS")

# 檢查每個狀態，如果其中一個不是 "true"，則輸出相應的錯誤消息
for index in "${!STATUSES[@]}"; do
	STATUS="${STATUSES[index]}"
	if [ "$STATUS" != "ok" ]; then
		echo ""
		echo "Error: STATUSES[$index] is not ok"
		echo ""
		exit 1
	fi
done
