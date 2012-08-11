#!/bin/bash
echo "Input directory: "

read directory

cd $directory

mkdir "application"
mkdir "resources"

for i in "application/controllers" "application/models" "application/libraries" "application/views" "resources/javascript" "resources/css" "resources/documentation"
	do
		mkdir $i
done
