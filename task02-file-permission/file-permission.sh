#!/bin/bash

# Name of the file to be created
FILE="/home/demo.txt"

# Check if the file already exists
if [ -e "$FILE" ]; then
	echo "$FILE already exsists."
else
	echo "$FILE does not exsist. Creating the file..."
	sudo touch "$FILE"
	echo "File is created."
fi

# Set permission for the file
sudo chmod 764 "$FILE"
echo "Permission set changed to 764 (Owner:rwx, Group:rw-, Others:r--)"

