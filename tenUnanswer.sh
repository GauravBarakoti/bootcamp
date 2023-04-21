#!/bin/bash

echo "Name      Size"
echo "----      ----"

for file in ~/.*
do
    if [ -f "$file" ]
    then
        size=$(du -h "$file" | cut -f1)
        echo "$(basename $file)     $size"
    fi
done

for file in ~/*
do
    if [ -f "$file" ]
    then
        size=$(du -h "$file" | cut -f1)
        echo "$(basename $file)     $size"
    fi
done

