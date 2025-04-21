#!/bin/bash

#create 20 .txt files
for i in {1..20}
do
  touch file$i.txt
done

#Rename the first 5 .txt files to .yml
for i in {1..5}
do
  mv file$i.txt file$i.yml
done

