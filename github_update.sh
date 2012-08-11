#!/bin/bash
local_repo_name[1]="prospero"
directory[1]="prospero/current"
name[1]="prospero"

local_repo_name[2]="search_module"
directory[2]="prospero/search_module"
name[2]="search_module"

local_repo_name[3]="cloudroom_design"
directory[3]="cloudroom_design"
name[3]="cloudroom_design"

production_root="${HOME}/Documents/production_development/"
github_root="${HOME}/Documents/github/"

codeigniter_update () 
{
	i=${1}
	project=${local_repo_name[${i}]}
	local_repo="${github_root}${local_repo_name[${i}]}"
	
	# BACKUP UP CODEIGNITER FILES
	
	for z in "application/controllers" "application/models" "application/libraries" "application/views"
		do 
			copy_destination="${local_repo}/application"
			copy_source="${production_root}${directory[${i}]}/${z}"
			cp -r "${copy_source}" "${copy_destination}"


		done;

	# BACK UP STATIC FILES!
	for z in "resources/javascript" "resources/css" "resources/documentation"
		do
			copy_destination="${local_repo}/resources"
			copy_source="${production_root}${directory[${i}]}/${z}"
			cp -r "${copy_source}" "${copy_destination}"

		done;

	echo "Please input commit message for ${name[${i}]}: "
	read commit_message
	
	cd ${local_repo}
}

full_update () 
{
	i=${1}
	project=${local_repo_name[${i}]}
	local_repo="${github_root}${local_repo_name[${i}]}"
	copy_source="${production_root}${directory[${i}]}/"

	cp -r  "${copy_source}" "${local_repo}"
	
	echo "Please input commit message for ${name[${i}]}: "
	read commit_message
	
	cd ${local_repo}
	

}

git_commit () 
{
	git add *
	git commit -m "${commit_message}"
	git push -u origin master
}

# This script is used to commit this project on github using my own personal github folder
# I have all of my github repos in one place ~Documents/github so that I don't have to worry about versioning 
# 	or worrying about the problems that it causes on upload
# Update this file to add anything other than codeigniter.

# configuration for this file:
if [ ${1} ];	then
	project="${1}"
else
	project="DEFAULT"
fi

if [ $project = "prospero" ];	then
	codeigniter_update 1
	git_commit

elif [ $project = "search_module" ];	then
	full_update 2
	git_commit
	
elif [ $project = "cloudroom_design" ];		then
	codeigniter_update 3
	git_commit
	
elif [ $project = "all" ];	then
	# length=${#name[*]}--length of array
	codeigniter_update 1
	git_commit
	full_update 2
	git_commit
else
	echo "Invalid option"
fi
	exit 0
