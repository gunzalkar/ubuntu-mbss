#!/bin/bash
touch tempfiles/92-data.txt
rm tempfiles/92-data.txt
output1="" output2=""
[ -f /etc/bash.bashrc ] && BRC="/etc/bash.bashrc"
for f in "$BRC" /etc/profile /etc/profile.d/*.sh ; do
grep -Pq '^\s*([^#]+\s+)?TMOUT=(900|[1-8][0-9][0-9]|[1-9][0-9]|[1-9])\b' "$f" && grep -Pq '^\s*([^#]+;\s*)?readonly\s+TMOUT(\s+|\s*;|\s*$|=(900|[1-8][0-9][0-9]|[1-9][0-9]|[1-9]))\b' "$f" && grep -Pq '^\s*([^#]+;\s*)?export\s+TMOUT(\s+|\s*;|\s*$|=(900|[1-8][0-9][0-9]|[1-9][0-9]|[1-9]))\b' "$f" && output1="$f"
done
grep -Pq '^\s*([^#]+\s+)?TMOUT=(9[0-9][1-9]|9[1-9][0-9]|0+|[1-9]\d{3,})\b' /etc/profile /etc/profile.d/*.sh "$BRC" && output2=$(grep -Ps '^\s*([^#]+\s+)?TMOUT=(9[0-9][1-9]|9[1-9][0-9]|0+|[1-9]\d{3,})\b' /etc/profile /etc/profile.d/*.sh $BRC)
if [ -n "$output1" ] && [ -z "$output2" ]; then
# echo -e "\nPASSED:\n\nTMOUT is configured in: \"$output1\"\n" >> tempfiles/92-data.txt
echo "92,Ensure default user shell timeout is 900 seconds or less,Compliant" >> $varfilename
else
# [ -z "$output1" ] && echo -e "\nFAILED: TMOUT is not configured.\n" >> tempfiles/92-data.txt
# [ -n "$output2" ] && echo -e "\nFAILED:\n TMOUT is incorrectly configured in: \"$output2\"\n" >> tempfiles/92-data.txt
[ -z "$output1" ] && echo "92,Ensure default user shell timeout is 900 seconds or less,Non-Compliant" >> $varfilename
[ -n "$output2" ] && echo "92,Ensure default user shell timeout is 900 seconds or less,Non-Compliant" >> $varfilename
fi