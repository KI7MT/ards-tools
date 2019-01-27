#!/usr/bin/env bash

# Temporary fix for multiple issues with the downloaded test file.
# The line number values may change at any time, and would ned updating.
# The sed commands simply removes the suspect lines.

# Download the file
url="http://www.eqsl.cc/qslcard/DownloadedFiles/AGMemberListDated.txt"
curl -o eqsl/AGMemberListDated.txt $url

# Remove spacing between columns
awk -F '[[:space:]]*,[[:space:]]*' '{$1=$1}1' OFS=, eqsl/AGMemberListDated.txt > eqsl/tmp.txt

# Add faux dates to fix invalid date values
sed -i -e 's/0000\-00\-00/1900\-01\-01/' eqsl/tmp.txt

# Fix UTF8 issues
iconv -f latin1 -t utf-8 <eqsl/tmp.txt >eqsl/tmp.txt.utf8
mv eqsl/tmp.txt.utf8 eqsl/tmp.txt

# Note these should be sent back to eQSL for adjustment.
sed -i -e '11517d' eqsl/tmp.txt
sed -i -e '84981d' eqsl/tmp.txt
sed -i -e '86975d' eqsl/tmp.txt
sed -i -e '88382d' eqsl/tmp.txt
sed -i -e '117279d' eqsl/tmp.txt

# Finally run the psql command
psql -v ON_ERROR_STOP=1 -U ki7mt -f eqsl.pgsql
