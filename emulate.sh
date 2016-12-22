#!/bin/bash

# Functions
function help() {
    echo "Usage: emulator.sh [options] <commands_file>"
    echo
    echo -e "\tOptions:"
    echo -e "\tfast: will run faster and without need for user input"
    echo -e "\thelp: shows help"
}

function prompt() {
    echo -en "${GREEN}"
    echo -n "${PROMPT}"
}

# Check arguments
if [ $# -lt 1 ] || [ $# -gt 2 ] || [ "${!#}" == "help" ]; then
    help
    exit 1
fi

if [ ! -f ${!#} ]; then # ${!#} s the last argument
    echo "File '$1' not found"
    exit 2
fi

# Variables declaration
SRC=${!#}
GREEN="\e[32m"
YELLOW="\e[1;93m"
NO_COLOR="\e[0m"
PROMPT="\$ "
SPEED=15
FAST_RUN=0

# Check if fast run enabled
if [ $# -eq 2 ]; then
    if [ "$1" == "fast" ]; then
        FAST_RUN=1
        SPEED=100
    else
        help
        exit 3
    fi
fi

# Read the file and do the job for me - Thanks!
while read -r line || [[ -n "$line" ]]; do
    prompt
    [ $FAST_RUN -eq 1 ] || read -s input </dev/tty
    echo -en "${YELLOW}"
    echo -n "${line}" | pv -qL ${SPEED}
    [ $FAST_RUN -eq 1 ] && echo -e "\r" || read input </dev/tty
    echo -en "${NO_COLOR}"
    eval ${line} < /dev/null
done < "${SRC}"

# Keep the promp until a key is pressed
prompt
read -s input </dev/tty
echo -en "${NO_COLOR}"
exit 0
