#!/bin/bash

echo "Enter the path to the source directory:"
read src_dir


echo "Enter the path to the destination directory for files:"
read dest_file_dir
echo "Enter the path to the destination directory for directories:"
read dest_dir_dir

for item in "$src_dir"/*
do
    if [ -d "$item" ]
    then
        # Item is a directory
        mv "$item" "$dest_dir_dir"
    else
        # Item is a file
        mv "$item" "$dest_file_dir"
    fi
done

echo "All files and directories have been successfully moved."

