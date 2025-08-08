#!/bin/bash

# Check if the file exists
if [ ! -f "temp.txt" ]; then
    echo "Error: File 'temp.txt' not found."
    exit 1
fi

# Convert text in "temp.txt" to uppercase and save the result to a temporary file
awk '{print toupper($0)}' temp.txt > temp_uppercase.txt

# Replace the original file with the temporary file
mv temp_uppercase.txt temp.txt

# Check if the conversion was successful
if [ $? -eq 0 ]; then
    echo "Text in 'temp.txt' converted to uppercase successfully."
else
    echo "Failed to convert text in 'temp.txt' to uppercase."
fi
