#!/bin/bash

for file in ex_f*; do
    if [[ ${file} == "ex_f1" ]]; then
        echo "Skipping the first one"
        continue
    fi
done
