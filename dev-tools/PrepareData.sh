#!/usr/bin/env bash

# https://www.mypdns.org/
# Copyright: Content: https://www.mypdns.org/p/Spirillen/
# Source:Content:
#
# Original attributes and credit
# The credit for the original bash scripts goes to Mitchell Krogza
# Source:Code: https://github.com/mitchellkrogza/Badd-Boyz-Hosts
# You are free to copy and distribute this file for non-commercial uses,
# as long the original URL and attribution is included.

# Please forward any additions, corrections or comments by logging an issue at
# https://www.mypdns.org/maniphest/

set -e #-x

# **********************************
# Setup input bots and referer lists
# **********************************

git_dir="$(git rev-parse --show-toplevel)"

# Type the url of source here
testFile="${git_dir}/PULL_REQUESTS/domains.txt"

# **************************************************************************
# Sort lists alphabetically and remove duplicates before cleaning Dead Hosts
# **************************************************************************
#getNewList () {
#	drill axfr @35.156.219.71 -p 53 porn.host.srv \
#	  | grep -vE "^(;|$|\*)" | sed -e 's/\.porn\.host\.srv\.//g;/^86400$/d;/^adult$/d' \
#	  | awk '{ printf ("%s\n",tolower($1))}' | sed -e '/porn\.host\.srv\./d;/^adult$/d' > "${testFile}"
#	echo -e "\n\tDomains to test: $(wc -l < "${testFile}")\n"
#}

## Testing PyFunceble --rpz

getNewList () {
	truncate -s 0 "${testFile}"
	drill axfr @35.156.219.71 -p 53 porn.host.srv > "${testFile}"
	git add "${testFile}"
}

# ***********************************
# Deletion of all whitelisted domains
# ***********************************
# This following should be replaced by a local whitelist

WhiteList="${git_dir}/whitelist"

#getWhiteList () {
#    wget -qO- 'https://raw.githubusercontent.com/mypdns/matrix/master/source/whitelist/domain.list' \
#    | awk '{ printf("%s\n",tolower($1)) }' >> "${WhiteList}"
#    wget -qO- 'https://raw.githubusercontent.com/mypdns/matrix/master/source/whitelist/wildcard.list' \
#    | awk '{ printf("ALL %s\n",tolower($1)) }' >> "${WhiteList}"
#
#	cat "${git_dir}/submit_here/whitelist" >> "${git_dir}/whitelist"
#
#   sort -u -f "${WhiteList}" -o "${WhiteList}"
#}


# https://github.com/Ultimate-Hosts-Blacklist/whitelist/tree/script-dev

#WhiteListing () {
#	hash uhb_whitelist
#	mv "${testFile}" "${testFile}.tmp.txt"
#
#	uhb_whitelist --hierachical-sorting -wc -m -w "${WhiteList}" \
#	  -f "${testFile}.tmp.txt" -o "${testFile}"
#
#	rm "${testFile}.tmp.txt"
#}

WhiteListing () {
    hash uhb_whitelist

    uhb_whitelist --hierachical-sorting -wc -m -w "${WhiteList}" \
      --all 'https://raw.githubusercontent.com/mypdns/matrix/master/source/whitelist/domains.list' \
      --reg 'https://raw.githubusercontent.com/mypdns/matrix/master/source/whitelist/wildcard.list' \
      -f "${testFile}" --output "${testFile}"

    #mv "${testFile}.tmp.txt" "${testFile}"
}

if [[ "$(git log -1 | tail -1 | xargs)" =~ "Auto Saved" ]]
then
	echo -e "\n\n\tRunning the whitelisting (ONLY)\n\n"
	#getWhiteList && \
	  WhiteListing
else
	echo -e "\n\n\tImporting the RPZ zone\n\n"
	WhiteListing
	  #getWhiteList && \
	  #WhiteListing
fi

echo -e "\n\tNumber of cores available: $(nproc)"

head -n 2 "${testFile}"

exit ${?}
