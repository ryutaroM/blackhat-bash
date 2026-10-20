#!/bin/bash
DOMAIN="${1}"
FILE="${2}"

while read -r subdomain; do
    echo "${subdomain}.${DOMAIN}"
done < "${FILE}"
