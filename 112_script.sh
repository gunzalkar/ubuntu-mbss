#!/usr/bin/bash
touch tempfiles/112-data.txt
rm tempfiles/112-data.txt
cut -d: -f1 /etc/group | sort | uniq -d | while read -r x; do
    echo "Duplicate group name $x in /etc/group" >> tempfiles/112-data.txt
done
