#!/bin/bash

# Vars
SRC=commands.txt
GREEN="\e[32m"
YELLOW="\e[1;93m"
NO_COLOR="\e[0m"

# Read the file and do the job for me - Thanks!
while read -r line || [[ -n "$line" ]]; do
    echo -en "$GREEN\$ "
    read -s input </dev/tty
    echo -en "$YELLOW$line" | pv -qL 9
    read input </dev/tty
    echo -en "$NO_COLOR"
    $line
done < "$SRC"

exit 0
