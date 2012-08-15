#!/bin/bash

# this executable is primarily for working on production_test to archive my projects with one line. Archive.zip is for allowing for the ssh upload!
archive=true
if [[ ${#1} > 0 ]]; then
	archive=false
fi

file_name=$(date +"%m_%d_%H_%I".zip); #month_day_hour_minute.zip

permanent_archive="../archive/code_base/$file_name";
temp_archive="Archive.zip";

# rm Archive.zip;
if [[ archive ]]; then
	zip -r $temp_archive *;
fi

zip -r $permanent_archive *; 

if [[ archive ]]; then
	echo -e "\n\tTemporary archive created."
fi

echo -e "\n\tPermanent archive created at {$permanent_archive}"


