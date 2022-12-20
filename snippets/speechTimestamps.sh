#!/usr/bin/env sh

python vad.py "$AUDIO_EXTRACT" > ${OUTPUTS}audio_timecodes.txt
cat ${OUTPUTS}audio_timecodes.txt | awk '{gsub(/[:\47]/,"");print $0}' | awk '{gsub(/.{end /,"");print $0}' | awk '{gsub(/ start /,"");print $0}' | awk '{gsub(/}./,"");print $0}' | awk -F',' '{ print $2 "," $1}' | awk '{gsub(/,/,"\n");print $0}' | while read -r line; do date -d@$line -u '+%T.%2N'; done | paste -d " "  - - | sed 's/ / ---> /g' > ${OUTPUTS}audio_timestamps.txt
