#!/bin/bash

echo "Enter filename: "
read filename

basename=$(basename -- "$filename")
extension="${basename##*.}"

if [[ $basename =~ ^([[:alpha:]]+)([[:digit:]]+)\.$extension$ ]]; then
    filename_without_id="${BASH_REMATCH[1]}.$extension"
    id="${BASH_REMATCH[2]}"
    echo "$filename_without_id, Id=$id"
else
    echo "$filename"
fi

