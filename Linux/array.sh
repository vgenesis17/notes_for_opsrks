#!/bin/bash

cd /c/Users/Dell/Opswerks-internship/notes_for_opsrks/sampdir
file=()

for fi in *; do

# echo "$fi":
file+=("$fi")


done

echo "${file[@]}"
