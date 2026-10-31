#!/bin/bash
OUT="out.csv"
echo "desc,ip,port,timestamp,tool" > "${OUT}"

for ip in "$@"; do
    host_port=$(sudo nmap --open "${ip}" -oG - | awk '/Ports/ {split($5,a,"/");print $2,a[1]}' | tr -d "()")
    port=$(echo "${host_port}" | awk '{print $2}')
    if [[ "${port}" -eq 21 ]]; then
        echo "${ip}:${port} is open"
        echo "Running nuclei to ${ip}:${port}"

        nuclei=$(nuclei -u "${ip}" -tags ftp -silent -j -ts \
                 | jq -r '[.info.description, .timestamp] | @tsv')

        while IFS=$'\t' read -r desc ts; do
            echo "${desc},${ip},${port},${ts},nuclei" >> "${OUT}"
        done <<< "${nuclei}"

        echo "Running a nse script to ${ip}:${port}"
        xml=$(sudo nmap --script=ftp-anon.nse "${ip}" -p "${port}" -oX -)
        desc=$(echo "${xml}" \
          | xmllint --xpath 'string(//script[@id="ftp-anon"]/@output)' - 2>/dev/null \
          | tr '\n' ' ')
        ts=$(date +%Y-%m-%dT%H:%M:%S%z)
        echo "${desc},${ip},${port},${ts},nmap" >> "${OUT}"
    fi
done
