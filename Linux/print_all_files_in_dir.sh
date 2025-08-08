#!/bin/bash
# cd /c/Users/Dell/Pictures
date=$(date +%Y%m%d)
archive="var_backup_$date.tar.gz"

# Create an array to store files
files=()
for f in *; do
    # Only process regular files and skip the archive file
    if [ -f "$f" ] && [ "$f" != "$archive" ]; then
        files+=("$f")
    fi
done

# Create archive only if there are files to add
if [ ${#files[@]} -gt 0 ]; then
    arc_f=$(tar -cvzf "$archive" "${files[@]}")

fi