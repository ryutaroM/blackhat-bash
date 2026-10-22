#!/bin/bash

HOSTS="172-16-10-hosts.txt"
RESULT=$(sudo nmap -iL "${HOSTS}" --open -oG -)

while read -r line; do
    echo "${line}" | awk '
    /Ports/{
        ip = $2
        for (i=5; i<=NF; i++) {
            if ($i ~ /\/open\//) {
                split($i, a, "/")
                print ip, a[1]
            }
        }
    }'
done <<< "${RESULT}" | while read -r ip port; do
    echo "${ip}" >> "port-${port}.txt"
done
