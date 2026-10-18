#!/bin/bash

if [[ -z "$1" || -z "$2" ]]; then
    echo "USAGE: missing argument [${0} mysite nostarch.com]"
    exit 1
fi

if ping -c 1 "$2" > /dev/null 2>&1; then
    RESULT="success"
else
    RESULT="failure"
fi

echo "name,domain,result,date" > ping.csv
echo "$1,$2,$RESULT,$(date +"%Y-%m-%d %H:%M:%S")" >> ping.csv
