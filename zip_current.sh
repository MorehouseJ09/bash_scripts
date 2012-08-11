#!/bin/bash

# this executable is primarily for working on production_test to archive my projects with one line. Archive.zip is for allowing for the ssh upload!

file_name=$(date +"%m_%d_%H_%I".zip); #month_day_hour_minute.zip

permanent_archive="../archive/code_base/$file_name";
temp_archive="Archive.zip";

rm Archive.zip;
zip -r $temp_archive *;
zip -r $permanent_archive *; 



