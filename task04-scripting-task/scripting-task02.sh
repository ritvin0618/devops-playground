#!/bin/bash


# Input file
FILE="sample.txt"


# Replace all occurrence of the word "give" with "learning" 
awk 'NR<5 {print; next} /welcome/ {gsub("give", "learning")} {print}' "$FILE" > temp.txt

# Replace original file with updated content
mv temp.txt "$FILE"

# Confirmation message
echo "Replacements done from line 5 in '$FILE'."


