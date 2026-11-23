#!/bin/bash
OUT="/tmp/auth.out.txt"
while read -r f; do
    match=$(cat "${f}" | grep -o -name "*username*" -o -name "*password*" -type f 2>/dev/null)
    if [[ -n ${match} ]]; then
        echo "${match}" >> "${OUT}"
    fi
done < <(ls -l /tmp)
