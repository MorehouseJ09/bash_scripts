#!/bin/bash

# A SIMPLE PROGRAM FOR OPENING UP ALL WEB DEVELOPMENT PROGRAMS ON MAC FOR PROGRAMMERS!
browsers[0]="Safari"
browsers[1]="Google Chrome"
browsers[2]="Firefox"

base_programs[3]="TextMate"
base_programs[4]="Activity Monitor"
base_programs[5]="Mail"


other_programs[0]="Adobe Photoshop CS5"
# other_programs[1]="Opera"


if [[ ${#1} == 0 || "${1}" == "a" ]]; then #use the url
	url="http://localhost:8000"
else	
	url="${1}" #initiate the url to what the user gave us
fi

if [[ "${1}" == "-a" || "${1}" == "a" || "${1}" == "--a" ]]; then
	all=true
	
else
	all=false
fi

for program in "${base_programs[@]}"
	do
		open -a "$program"
	done
	
for program in "${browsers[@]}"
	do
		open -a "$program" $url
	done
	

if ${all:=true}; then
	
	for program in "${other_programs[@]}"
		do
			open -a "$program"
		done
fi
