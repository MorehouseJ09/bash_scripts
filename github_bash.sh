#!/bin/bash

# this program will update the bash scripts that I currently have and place them on github
#  1.) copy all bash scripts that have been changed to the github directory
#  2.) change all usernames/passwords in the github directory
#  3.) push to github repo for bash_scripts

counter=0 #count the files changed

username="orehousej09"
username_1="orehouseJ09"
password="oeller12"
password_1="rojans2013"

repo="${HOME}/Documents/github/bash_scripts"
directory="${HOME}/Documents/general_development/helper_programs/bash"

cd ${directory} # go to the actual local directory -- makes it easier to just grab the name and compare it between directories
files=`ls *.sh` # get all the files -- change this to all if your directory looks a little different

bad_extensions[0]=".pyc"
bad_extensions[1]=".jpg"
bad_extensions[2]=".psd"
bad_extensions[3]=".png"
bad_extensions[4]=".ttf"
bad_extensions[5]=".gif"
bad_extensions[6]=".jpeg"


# FOLLOWING SECTION IS TO FIND ALL THE SHELL FILES IN THE DIRECTORY AND THEN UPDATE THEM!
for file in ${files}
	do
		# now check each file and see the diff!
		local_file="${directory}/${file}"
		repo_file="${repo}/${file}"
		
		if [[ -f ${repo_file} ]]; then

			diff=$(diff ${local_file} ${repo_file})	#find the difference between the two
		
			if [[ ${#diff} != 0 ]]; then #files are different -- need to copy the local to the github_repo for committing
				cp "${local_file}" "${repo_file}" #copy command
				echo -e "${file} updated"
				let counter+=1
			fi
			
		else #file doesn't even exist in the github_repo so we need to add it!
			cp "${local_file}" "${repo_file}" #copy command
			echo -e "${file} updated"
			let counter+=1
		fi
	
	done

# NOW DO A GREP REPLACE ON ALL FILES -- WANT TO HIDE ANY PASSWORDS
cd ${repo}
files=`ls` #find files

for file in ${files}
	do
		default_username="Default Username" #what to replace username with
		default_password="Default Password" #what to replace password with
		
		# sed grabs from the file into the stream. Converts it with case-insensitive (I), globally (g), use e for multiple commands
		# note the two different passwords -- they are the variables at the top 
		# mac osx doesn't support -i flag for sed so used the [] to grab all first characters. 

		file_extension=${file#*.} #file extension
		flag=true

		for ext in "${bad_extensions[@]}"
			do
				if [[ "$file_extension" == "$ext" ]]; then
					flag=false
				fi
			done
			
			if [ ${var:=true} ]; then #the extension is valid
				sed -e "s/[a-zA-Z]${username_1}/${default_username}/g" -e "s/[a-zA-Z]${username}/${default_username}/g" -e "s/[a-zA-Z]${password}/${default_password}/g" -e "s/[a-zA-Z]${password_1}/${default_password}/g" $file > /tmp/tempfile.tmp
			fi
			# move the tempfile back to the original file -- remember that sed only takes it to the stream!

		mv /tmp/tempfile.tmp $file

	done
	
# UPDATE GITHUB

cd ${repo}
git add *

echo "Please input a commit message"
read message

git commit -m "${message}"
git push -u origin master
