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
# issue at https://www.mypdns.org/maniphest/
#
# Original attributes and credit
# This hosts file for DD-WRT Routers with DNSMasq is brought to you by Mitchell Krog
# Copyright:Code: https://github.com/mitchellkrogza
# Source:Code: https://github.com/mitchellkrogza/Badd-Boyz-Hosts
# The credit for the original bash scripts goes to Mitchell Krogza

# ***********************************************************
# echo Remove our inactive and invalid domains from PULL_REQUESTS
# ***********************************************************
set -e #-x -v

printf "\n\tRunning FinalCommit.sh\n"

if [ -f "${PYFUNCEBLE_OUTPUT_DIR}/domains/INACTIVE/list" ]
then
	rm "${PYFUNCEBLE_OUTPUT_DIR}/apparently_inactive.txt"
	grep -vE "^($|#)" "${PYFUNCEBLE_OUTPUT_DIR}/domains/INACTIVE/list" \
	  > "${PYFUNCEBLE_OUTPUT_DIR}/apparently_inactive.txt"
fi

#exit 0

## fail the pyfunceble test if any submissions are invalid
if [ -f "${PYFUNCEBLE_OUTPUT_DIR}/domains/INVALID/list" ]
then
	printf "The following are invalid  $(cat "${PYFUNCEBLE_OUTPUT_DIR}/domains/INVALID/list")\n"
	exit 99
fi

# ***************************************************************************
printf "\n\tGenerate our host file\n"
# ***************************************************************************

#exit 0

bash "${TRAVIS_BUILD_DIR}/dev-tools/GenerateHostsFile.sh"

# *************************************************************
# Travis now moves to the before_deploy: section of .travis.yml
# *************************************************************

exit ${?}
