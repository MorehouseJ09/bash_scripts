#!/bin/bash

# THIS PROGRAM IS TO UPDATE THE DROPBOX FOLDER
# Working now but we need to update it so that it only finds the newer files and only copies those over
# loop through each folder
# compare each file
# output each full file name


folders[0]="general_development"
folders[1]="production_development"
folders[2]="resources"
folders[3]="personal"
folders[4]="work"
folders[5]="start_ups"



dropbox="${HOME}/DropBox"
documents="${HOME}/Documents"

cd ${documents}
range=${#folders[@]}

for i in "${folders[@]}"
	do
		copy_source="${documents}/${i}"
		cp -r "${copy_source}" "${dropbox}"
	done

