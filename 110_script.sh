#!/usr/bin/bash
touch tempfiles/110-data.txt
rm tempfiles/110-data.txt

cut -d: -f3 /etc/group | sort | uniq -d | while read x ; do
echo "Duplicate GID ($x) in /etc/group" >> tempfiles/110-data.txt
done
