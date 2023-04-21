#!/bin/bash


log_dir="/path/to/logs"


zip_file="logs.zip"


cd $log_dir


find . -name "*.log" -exec zip -r $zip_file {} \;


mv $zip_file /tmp


