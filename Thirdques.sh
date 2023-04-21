#!/bin/bash

if [ "$1" -eq 0 -o "$1" -ne 0 ] >/dev/null 2>&1; then
    printf "integer: %s\n" "$1"
else
    printf "not an integer\n"
fi



if [ "$2" -eq 0 -o "$2" -ne 0 ] >/dev/null 2>&1; then
    printf "integer: %s\n" "$2"
else
    printf "not an integer\n"
fi

