#!/usr/bin/env bash

# **********************
# Run PyFunceble Testing
# **********************
# Created by: Mitchell Krog (mitchellkrog@gmail.com)
# Copyright: Mitchell Krog - https://github.com/mitchellkrogza

# ****************************************************************
# This uses the awesome PyFunceble script created by Nissar Chababy
# Find PyFunceble at: https://github.com/funilrys/PyFunceble
# ****************************************************************

# **********************
# Setting date variables
# **********************

version=$(date +%Y.%m)

# ******************
# Set our Input File
# ******************
git_dir="$(git rev-parse --show-toplevel)"

testFile="${git_dir}/PULL_REQUESTS/domains.txt"
#testFile="${git_dir}/dev-tools/debug.list"

## Testing PyFunceble --rpz
# echo "Getting fresh RPZ zone"

# getNewList () {
# 	truncate -s 0 "${testFile}"
# 	drill axfr @35.156.219.71 -p 53 porn.host.srv > "${testFile}"
# 	# git add "${testFile}"
#   # git commit -m "test files updated ${version}" -a
# }
# getNewList

echo "Print the head -n 5 of test files"

head -n 5 "${testFile}"

echo "Run PyFunceble"

RunPyFunceble () {

    #yeartag="$(date +%Y)"
    #monthtag="$(date +%m)"

    #ulimit -u
    cd "${git_dir}/dev-tools" || exit 1

    hash PyFunceble

	printf "\n\tYou are running with RunPyFunceble\n\n"

	pyfunceble --ci \
		-q \
		--dots \
		--ci-max-minutes 45 \
		--hierarchical \
		-ex \
		--ci-end-command "bash ${git_dir}/dev-tools/FinalCommit.sh" \
		-f "${testFile}"
}
RunPyFunceble

exit ${?}

# 127.0.0.1:5300
# -m -p "$(nproc --ignore=1)"
