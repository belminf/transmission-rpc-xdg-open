#!/usr/bin/env bash

# Environment variables needed:
: "${TRANSMISSION_RPC_URL:?Need to set RPC URL (http://<ip>:<port>/transmission/rpc)}"
: "${TRANSMISSION_USER:?Need to set RPC username}"
: "${TRANSMISSION_PASS:?Need to set RPC password}"
: "${TRANSMISSION_DL_DIR:?Need to set download directory}"

# Make sure magnet link sent
: ${1?"Usage: $0 <magnet link>"}
MAGNET_LINK="$1"

# Get session ID
SESSION_ID=$(curl --silent --user "${TRANSMISSION_USER}:${TRANSMISSION_PASS}" "${TRANSMISSION_RPC_URL}" | sed 's/.*\(X-Transmission-Session-Id: [[:alnum:]]\+\).*$/\1/')

# Submit Magnet link
curl --silent -H "${SESSION_ID}" "${TRANSMISSION_RPC_URL}" -d '{"method":"torrent-add","arguments":{"paused":false,"download-dir":"'${TRANSMISSION_DL_DIR}'","filename":"'${MAGNET_LINK}'"}}'

