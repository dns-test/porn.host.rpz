#!/usr/bin/env bash

# Copyright: https://www.mypdns.org/
# Content: https://www.mypdns.org/p/Spirillen/
# Source: https://github.com/Import-External-Sources/pornhosts
# License: https://www.mypdns.org/w/license
# License Comment: GNU AGPLv3, MODIFIED FOR NON COMMERCIAL USE
#
# License in short:
# You are free to copy and distribute this file for non-commercial uses,
# as long the original URL and attribution is included.
#
# Please forward any additions, corrections or comments by logging an
# issue at https://github.com/mypdns/matrix/issues

# Fail if exit != 0
set -e

# Run script in verbose
# set -x

printf "\n\tRunning GenerateHostFile.sh\n\n"

# ******************
# Set Some Variables
# ******************

now=$(date '+%F %T %z (%Z)')
my_git_tag="build: ${TRAVIS_BUILD_NUMBER}"
activelist="${PYFUNCEBLE_OUTPUT_DIR}/domains/ACTIVE/list"

# *********************************************************************************
# Set the output files
# *********************************************************************************

outDir="${TRAVIS_BUILD_DIR}/download_here" # no trailing / as it would make a double //

# First let us clean out old data in output folders

find "${outDir}" -type f -delete

rpz="${outdir}/rpz/pornhosts.rpz"

# *********************************************************************************
# Generate the raw data list, as we need it for the rest of our work
# *********************************************************************************

rawlist="${outDir}/active_raw_data.txt"
touch "${rawlist}"
grep -vE "^(#|$)" "${activelist}" > "${rawlist}"

bad_referrers=$(wc -l < "${rawlist}")

# *********************************************************************************
# Print some stats
# *********************************************************************************
#printf "\n\tRows in active list: $(wc -l < "${activelist}")\n"
#printf "\n\tRows of raw data: ${bad_referrers}\n"

grep -vE "^($|#)" "${PYFUNCEBLE_OUTPUT_DIR}/logs/percentage/percentage.txt"

# *********************************************************************************
printf "\t\nRPZ and Bind formatted\n"
# *********************************************************************************

printf "\$ORIGIN\tlocalhost.
\$TTL 1800;
@\tIN\tSOA\tlocalhost. hostmaster.mypdns.org. `date +%s`\t; Serial
\t\t\t3600\t\t; refresh
\t\t\t60\t\t; retry
\t\t\t604800\t\t; Expire
\t\t\t60;\t\t; TTL
\t\t\t\)
\t\t\tIN\tNS\tlocalhost\t;out-of-zone no A/AAAA RR required
\n; begin RPZ RR definitions\n\n" > "${rpz}"

awk '{ printf("%s\tCNAME\t.\n*.%s\tCNAME\t.\n",tolower($1),tolower($1)) }' "${rawlist}" >> "${rpz}"

exit ${?}
