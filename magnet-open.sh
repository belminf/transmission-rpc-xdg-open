#!/usr/bin/env bash

# Environment variables needed:
: "${TR_HOST:=localhost:9091}"
: "${TR_USER:=transmission}"
: "${TR_PASS:?Need to set RPC password}"
: "${TR_DL_DIR:?Need to set download directory}"

# Make sure magnet link sent
: ${1?"Usage: $0 <magnet link>"}
MAGNET_LINK="$1"

# Get session ID
SESSION_ID=$(curl --silent --user "${TR_USER}:${TR_PASS}" "http://${TR_HOST}/transmission/rpc" | sed 's/.*\(X-Transmission-Session-Id: [[:alnum:]]\+\).*$/\1/')

# Submit Magnet link
RETURN_JSON=$(curl --silent -H "${SESSION_ID}" "http://${TR_HOST}/transmission/rpc" -d '{"method":"torrent-add","arguments":{"paused":false,"download-dir":"'${TR_DL_DIR}'","filename":"'${MAGNET_LINK}'"}}')

# Notify
notify-send --app-name="Transmission" "RPC call" "$(echo "${RETURN_JSON}" | sed 's/{"arguments":{"\([^"]\+\)".*"name":"\([^"]\+\)".*"result":"\([^"]\+\)".*$/\1 (\3): \2/')"
