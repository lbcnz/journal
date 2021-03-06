#!/bin/bash
# Unitary tests for Journal
# We can't write unit tests for interactive behaviour interacting with external software.
# But we can compare commands strings for a range of inputs to see if they match with what we expect.

#-----#
# LIB #
#-----#
export journalTesting="true"

reset='\e[0m'
bold='\e[1m'
italic='\e[3m'
dim='\e[2m'
blink='\e[5m'
red='\e[1;31m'
green='\e[1;32m'

_diff() {
# Diff two strings
# variables are passed by reference
    # use delta if available
    if command -v delta &>/dev/null; then
        delta <(echo "$exp") <(echo "$obs")
    else
        # FIXME: Working on shell but not on script (maybe zsh only)
        # diff --color=always -d <(<<< "$exp") <(<<< "$obs")
        diff --color=always -d <(echo "$exp") <(echo "$obs")
    fi
}

_report() {
# Print a report of the test
# variables are passed by reference
    local status="$1"
    if [ "$status" -eq 0 ]; then
        hits+=1
        printf "[${green}PASS${reset}]: %s\n" "'$cmd'"
    elif [ "$status" -eq 1 ]; then
        misses+=1
        printf "[${red}FAIL${reset}]: %s\n" "'$cmd'"
        _diff
    else
        printf "${red}ERROR: Wrong status code for %s.${reset}\n" "$cmd"
    fi
}

_test() {
# Check if observations pass expectations
# variables are passed by reference
    if [ "$obs" = "$exp" ]; then
        _report 0
    else
        _report 1
    fi
}

#-------#
# TASKS #
#-------#
# PRINT
testPrint() {
    local cmd; local exp; local obs
    cmd="journal print -a"
    exp="$(< "test/print.txt")" # read contents of file to variable
    # shellcheck disable=SC2086
    obs="$(./$cmd)" # read stdout of command to variable
    _test
}

# SHOW
testShow() {
    local cmd; local exp; local obs
    cmd="journal show -a"
    exp="$(< "test/show.txt")" # read contents of file to variable
    # shellcheck disable=SC2086
    obs="$(./$cmd)" # read stdout of command to variable
    _test
}

# FIND
testFind() {
    local cmd; local exp; local obs
    cmd="journal find -a"
    exp="$(< "test/find.txt")" # read contents of file to variable
    # shellcheck disable=SC2086
    obs="$(./$cmd)" # read stdout of command to variable
    _test
}

# COMMIT (TODO)

#-----#
# LOG #
#-----#
# WRITE (TODO)

# READ (TODO)

# ROTATE (TODO)

#---------#
# TESTING #
#---------#
declare -i hits     # integer
hits=0
declare -i misses
misses=0
declare -i total
total=0

printf "${italic}%s${blink}%s${reset}\n\n" "Running tests" "..."

testPrint
testShow
testFind

# Show summary
total="$(( hits + misses ))"
printf "\nHIT: ${green}%i${reset} of %i\n" "$hits" "$total"
printf "MISS: ${red}%i${reset} of %i\n" "$misses" "$total"

# Exit w/ error if there are any misses
if [ $misses -gt 0 ]; then
    exit 1
fi
