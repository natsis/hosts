#!/bin/bash
## created on 2021-01-11

#### enter description here

echo "i am $0 who the hell are you"
TIC=$(date +"%s")
## start coding




sleep 1




## end coding
TAC=$(date +"%s"); dura="$( echo "scale=6; ($TAC-$TIC)/60" | bc)"
printf "%s %-10s %-10s %-50s %f\n" "$(date +"%F %H:%M:%S")" "$HOSTNAME" "$USER" "$(basename $0)" "$dura"
exit 0 
