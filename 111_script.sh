#!/usr/bin/bash
touch tempfiles/111-data.txt
rm tempfiles/111-data.txt

cut -d: -f1 /etc/passwd | sort | uniq -d | while read -r x; do
    echo "Duplicate login name $x in /etc/passwd" >> tempfiles/111-data.txt
done