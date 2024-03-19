#!/bin/bash
#
# health check
#

BE_SVC_URL=https://backend.dev.simpos.com.tw/version
DSE_SVC_URL=https://dse.dev.simpos.com.tw/api/ready
DB_HEALTHZ=https://backend.dev.simpos.com.tw/healthz
SOME_SVC_URL=https://dse.dev.simpos.com.tw/api/ready1
URLS=("$BE_SVC_URL" "$DSE_SVC_URL" "$DB_HEALTHZ" "$SOME_SVC_URL")

ERRORS=()

echo "start health checking...."
# 檢查 service 的 health
for index in "${!URLS[@]}"; do
	URL="${URLS[index]}"
	res=$(curl -s -X GET "$URL")
	status=$(echo "$res" | jq -r '.status')
	if [ "$status" != "ok" ]; then
		ERRORS+=("Error: '$URL' is not ok, response: $res")
	fi
done

echo ""

# 印出錯誤
if [ "${#ERRORS[@]}" -gt 0 ]; then
	for ERROR in "${ERRORS[@]}"; do
		echo "$ERROR"
	done
	exit 1
fi
