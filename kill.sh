#!/bin/bash

# THIS WILL BE A PROGRAM USEFUL FOR KILLING PROGRAMS

option=${1}

if [[ "${#option}" < 1 ]]; then
	
	echo "Please enter an option"
	read option

fi

programs[0]="Adobe Photoshop CS5"
programs[1]="Mail"
programs[2]="Google Chrome"
programs[3]="Safari"
programs[4]="iTunes"
programs[5]="Preview"


function to_lower {
	
	clean_program=$(echo "$clean_program" | tr '[A-Z]' '[a-z]')
	clean_option=$(echo "$option" | tr '[A-Z]' '[a-z]')
}

flag=false

clean_option=$option
to_lower

echo -e "\n"

for program in "${programs[@]}"
	do
		clean_program=$program
		to_lower

		if [[ "$clean_program" == "$clean_option" || "$clean_option" == "all" ]]; then #remember that the clean option is what the user puts in
			
			exists=$(pidof "$program")

			if [[ "${#exists}" > 0  ]]; then
				
				kill `pidof "$program"`
				echo -e "$program was terminated"
			fi
		fi
	done
	
