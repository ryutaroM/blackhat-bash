#!/bin/bash

KNOWN_HOSTS="172-16-10-hosts.txt"
NETWORK="172.16.10.0/24"
INTERFACE="br_public"

FROM_ADDR="from@example.com"
TO_ADDR="test@example.com"

SMTP_SERVER="localhost"
SMTP_PORT="1025"

while true; do
    echo "Performing an ARP scan against ${NETWORK}..."
    sudo arp-scan -x -I ${INTERFACE} ${NETWORK} | while read -r line; do
        host=$(echo "${line}" | awk '{print $1}')
        if ! grep -q "${host}" "${KNOWN_HOSTS}"; then
            echo "Found a new host: ${host}"
            echo "${host}" >> "${KNOWN_HOSTS}"
            sendmail \
              -f "${FROM_ADDR}" \
              -t "${TO_ADDR}" \
              -u "ARP Scan Notification" \
              -m "A new host was found: ${host}" \
              -s "${SMTP_SERVER}:${SMTP_PORT}"
        fi
    done
    sleep $((RANDOM % 90 + 10))
done
