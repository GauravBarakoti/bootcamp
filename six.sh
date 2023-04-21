#!/bin/bash

uid_sum=0
gid_sum=0

while read line
do

    uid=$(echo $line | cut -d: -f3)
    gid=$(echo $line | cut -d: -f4)


    uid_sum=$((uid_sum + uid))
    gid_sum=$((gid_sum + gid))
done < "/etc/passwd"

echo "Sum of UIDs: $uid_sum"
echo "Sum of GIDs: $gid_sum"

if [ $uid_sum -gt $gid_sum ]
then
    echo "Sum of UIDs is greater."
elif [ $uid_sum -lt $gid_sum ]
then
    echo "Sum of GIDs is greater."
else
    echo "Sum of UIDs and GIDs are equal."
fi

~
