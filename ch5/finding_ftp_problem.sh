#!/bin/bash

for ip in "$@"; do
    host_port=$(sudo nmap --open "${ip}" -oG - | awk '/Ports/ {split($5,a,"/");print $2,a[1]}' | tr -d "()")
    port=$(echo "${host_port}" | awk '{print $2}')
    if [[ "${port}" -eq 21 ]]; then
        nuclei=$(nuclei -u "${ip}" -tags ftp -silent -j -ts| jq '.description,.timestamp' )
        echo "${nuclei}"
    fi
done
