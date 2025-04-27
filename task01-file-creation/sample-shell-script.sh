#!/bin/bash

# Create a directory
mkdir -p my_folder
cd my_folder || exit

# Create files with some text
echo "This is my_file.txt" > my_file.txt
echo "This is another_file.txt" > another_file.txt

# Concatenate another_file.txt content into my_file.txt
cat another_file.txt >> my_file.txt

# Display updated content of my_file.txt
cat my_file.txt

# List all files and directories
ls -l

# Create 20 text files
for i in {1..20}
do
    touch "file${i}.txt"
done

# Rename the first 5 .txt files to .yml
for i in {1..5}
do
    mv "file${i}.txt" "file${i}.yml"
done

# Print the latest created top 5 files
echo "Latest 5 files:"
ls -lt | head -n 5



