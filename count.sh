#!/bin/bash
words=0
lines=0

qt ()
{
	directories[0]="implementation/"
	directories[1]="header/"

	for i in `ls *.*`
	do
		if [[ -f $i ]]; then

			let "words=$words + `wc -l < $i`"
			let "lines=$words + `wc -w < $i`"

		fi
	done

	for directory in "${directories[@]}"
	do
		if [[ -d $directory ]]; then

			for file in `find $directory -type f`
			do
				let "words=$words + `wc -l < $file`"
				let "lines=$words + `wc -w < $file`"
			done
		fi
	done

}


codeigniter ()
{
	directory[0]="application/libraries/"
	directory[1]="application/controllers/"
	directory[2]="application/models/"
	directory[3]="application/views/"
	directory[4]="resources/javascript/modules/"
	directory[5]="resources/javascript/local/"
	directory[6]="resources/css/live/"
	directory[7]="resources/css/local/"

	for i in "${directory[@]}"
	do
		for z in `find $i -name \*.*`
		
		do
			if [[ -f ${z} ]]; then

				file_lines=`wc -l < $z`
				file_words=`wc -w < $z`
				let "words+=$file_words"
				let "lines+=$file_lines"
				
			fi
		done
	done
}

all ()
{
	for file in $(find . -type f -name "*.*")
		do
			# check if file exists
			if [[ -f ${file} ]]; then
				file_lines=`wc -l < "${file}"` #get the lines for the current file
				file_words=$(wc -w < "${file}") #get the words for the current file

				let "words+=$file_words" #add the words
				let "lines+=$file_lines" #add the lines
			fi
		done
}

if [[ ${1} == "codeigniter" || ${1} == "code_igniter" ]]; then
	codeigniter

elif [[ $1 == "qt" ]]; then
	qt

else	
	all
fi


echo -e "Lines: $lines \nWords: $words"

