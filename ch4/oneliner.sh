#!/bin/bash

HOSTS="172-16-10-hosts.txt"
RESULT=$(sudo nmap -iL "${HOSTS}" --open -oX - | xmllint --xpath '//port[state/@state="open"]/@portid' -)
echo "${RESULT}"
