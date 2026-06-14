#!/bin/bash

VARIABLE_ONE="nostarch"
VARIABLE_TWO="nostarch"

if [ "${VARIABLE_ONE}" == "${VARIABLE_TWO}" ]; then
    echo "They are equal!"
else
    echo "The variables are not the same"
fi