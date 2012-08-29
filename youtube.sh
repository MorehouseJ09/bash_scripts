#!/bin/bash

# this program will take in the video name, the artist and finally the new name for the song

# default folder will be Greatest Hits Dub
default_folder="${HOME}/Music/House/"

# make sure that parameters were given

	echo "Please enter a url"
	read url

	echo "Please enter a filename"
	read name

# check that 3rd parameter is given
if [[ ${#3} == 0 ]]; then
	folder="${default_folder}"

# 3rd parameter is given -- now check that it exists
else
	folder="$HOME/Music/$3"

	# check to make sure that the folder exists
	if [ ! -d "${folder}" ]; then
		folder="$default_folder"
	fi
fi

# check the folder has a trailing slash before adding the file name!
if [ "`echo "${folder}" | tail -c 2`" != "/" ]; then
	folder="$folder/"
fi

if [[ "${name#*.}" != "mp3" ]]; then
	name="$name.mp3"
fi

# We are going to store a "temp file in the ~/.music downloads"
cd ~/.music_downloads
name="$folder$name"
temp_name="$(ls | wc -l).mp3"
temp_name="test.mp3"

youtube-dl --extract-audio --audio-format mp3 -o test.mp3  "${url}"

# cp $temp_name "${name}"
# open -a itunes $file_name

