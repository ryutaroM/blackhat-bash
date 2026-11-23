#!/bin/bash
OUT="/tmp/auth.out.txt"
while read -r f; do
    match=$(cat "${f}" | grep -oE "username|password" 2>/dev/null)
    if [[ -n ${match} ]]; then
        echo "${match}" >> "${OUT}"
    fi
done < <(find /tmp -maxdepth 1 -type f ! -name "$(basename "${OUT}")")
