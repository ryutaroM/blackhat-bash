#!/bin/bash

S="String"
I=100

if [[ $S == "String" ]]; then
    echo "String is String"
else
    echo "String is not String"
fi

if [[ $I -eq 101 ]]; then
    echo "I is 101"
else
    echo "I is not 101"
fi

if [ 1 -ne 1 ]; then
    echo "1 is not equal to 1"
else
    echo "1 is equal to 1"
fi