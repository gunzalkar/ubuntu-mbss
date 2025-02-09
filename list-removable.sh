#!/usr/bin/bash
touch tempfiles/removables.txt
rm tempfiles/removables.txt

while read -r name; do
  if [ "$(<${name/dev/sys\/block}/removable)" -eq "1" ]; then 
    # echo "$name - removable"
    echo "$name" >> tempfiles/removables.txt
  # else
    # echo "$name - non-removable"
  fi
done < <(awk '/^\/dev\/sd/ {sub(/[0-9]+$/,"",$1); print $1}' /proc/mounts | uniq)