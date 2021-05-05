#!/usr/bin/env sh
# Mark directory.

logerrq() {
    printf "[ERROR]: %s\n" "$*"
    exit 1
}

[ "$#" -eq 0 ] && logerrq "No mark given, exiting."
[ "$#" -ne 1 ] && logerrq "Only one mark is accepted, exiting."

markfl="$(getfl mrk)" || {
    printf "[ERROR]: getloc failed, aborting.\n"
    exit 1
}

mark="$1"

printf "%s\n" "$mark" | grep -qs "\s" && logerrq "Mark cannot contain whitespace, exiting."

if [ -n "$2" ]
then
    val="$(realpath "$2")"
else
    val="$PWD"
fi

grep -Eq "^$mark\s" "$markfl" && { 
    cm "$mark" "$val"
    exit 0
}

printf "%s %s\n" "$mark" "$val" >> "$markfl"
