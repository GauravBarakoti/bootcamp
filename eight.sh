#!/bin/bash

if [ $# -ne 3 ]; then
  echo "Usage: $0 file_name prepend_str append_str"
  exit 1
fi

file_name=$1
prepend_str=$2
append_str=$3

while read -r line; do
  modified_line="$prepend_str$line$append_str"
  echo "$modified_line" >> "$file_name.tmp"
done < "$file_name"

mv "$file_name.tmp" "$file_name"

