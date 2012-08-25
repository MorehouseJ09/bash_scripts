#!/bin/bash

# this program will take in the video name, the artist and finally the new name for the song

url=${1}
name=${2}
# default folder will be Greatest Hits Dub
default_folder="${HOME}/Music/Greatest Hits-Dub/"

# make sure that parameters were given

if [[ ${#1} == 0 ]]; then
	echo "Please enter a url"
	read url
fi
	
if [[ ${#2} == 0 ]]; then
	echo "Please enter a file name"
	read name
fi


# check that 3rd parameter is given
if [[ ${#3} == 0 ]]; then
	folder="${default_folder}"

# 3rd parameter is given -- now check that it exists
else
	folder="${HOME}/Music/${3}"

	# check to make sure that the folder exists
	if [ ! -d "${folder}" ]; then
		folder="${default_folder}"
	fi
fi

# check the folder has a trailing slash before adding the file name!

if [ "`echo "${folder}" | tail -c 2`" != "/" ]; then
	folder="${folder}/"
fi


# check to make sure the file name is .mp3
if [ "`echo "${name}" | tail -c 5`" != ".mp3" ]; then
	name="${name}.mp3"
fi

echo "${name}"

# final file name
file_name="${folder}${name}"

youtube-dl --extract-audio --audio-format mp3 -o "${file_name}" $url
open -a iTunes "${file_name}"
