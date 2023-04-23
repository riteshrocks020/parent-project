#!/bin/bash

# Input with multi-line content
input="This is line 1.
This is line 2.
This is line 3.
This is line 4."

# Pattern to search for using grep
pattern="line"

# Use grep to search for pattern in input, and store the output in a variable
output=$(echo "$input" | grep "$pattern")

# Use awk to extract fields from the output, and store them in an array
IFS=$'\n' read -d '' -ra lines <<< "$(echo "$output" | awk '{print $3}')"

echo IFS

