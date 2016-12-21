#!/bin/bash

# Check argument
if [ $# -ne 1 ] 
then
    echo "Usage: emulator.sh <commands_file>"
    exit 1
fi

if [ ! -f $1 ]
then
    echo "File '$1' not found"
    exit 2
fi


# Variables declaration
SRC=$1
GREEN="\e[32m"
YELLOW="\e[1;93m"
NO_COLOR="\e[0m"
PROMPT="\$ "
SPEED=15


# Read the file and do the job for me - Thanks!
while read -r line || [[ -n "$line" ]]; do
    echo -en "${GREEN}${PROMPT}"
    read -s input </dev/tty
    echo -en "${YELLOW}${line}" | pv -qL ${SPEED}
    read input </dev/tty
    echo -en "${NO_COLOR}"
    eval ${line}
done < "${SRC}"

exit 0
