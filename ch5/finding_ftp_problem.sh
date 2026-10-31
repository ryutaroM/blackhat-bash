#!/bin/bash

for ip in "$@"; do
    host_port=$(sudo nmap --open "${ip}" -oG - | awk '/Ports/ {split($5,a,"/");print $2,a[1]}' | tr -d "()")
    port=$(echo "${host_port}" | awk '{print $2}')
    if [[ "${port}" -eq 21 ]]; then
        echo "${ip}:{$port} is open"
        echo "Running nuclei to ${ip}:{$port}"
        nuclei=$(nuclei -u "${ip}" -tags ftp -silent -j -ts| jq '.info.description,.timestamp' )
        echo "${nuclei}"

        echo "Running a nse script to ${ip}:${port}"
        nse=$(sudo nmap --script=ftp-anon.nse "${ip}:${port}")
        echo "${nse}"
    fi
done
