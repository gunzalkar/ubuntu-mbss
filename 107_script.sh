#!/usr/bin/bash
touch tempfiles/107-data.txt
rm tempfiles/107-data.txt

for i in $(cut -s -d: -f4 /etc/passwd | sort -u ); do
    grep -q -P "^.*?:[^:]*:$i:" /etc/group
    if [ $? -ne 0 ]; then
        echo "Group $i is referenced by /etc/passwd but does not exist in /etc/group" >> tempfiles/107-data.txt
    fi
done