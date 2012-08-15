#!/bin/bash

# NOTES
	# *.pyc files will give a byte error when sed runs them

# This program is for django projects
	# 1.) backup entire project
	# 2.) backup individual apps to the app repo
	# 3.) clean all usernames/passwords from all files
	# 4.) git commit for both the project repo and the django app

# 	PROJECTS THAT ARE VALID!
# Assuming the following directory structure:
#  ~/Documents/production_development/$project/current/$project
# ~/Documents/github/$project
# ~/Documents/github/django_apps

# valid projects that fit the above criteria
valid_projects[0]="rip_it_up_world"


# make sure that a proper app name is input before running the program
if [[ 0 == ${#1} ]]; then
	echo "Invalid option. Please input a project name"
	read project
	echo -e "\n"
else
	project=$1
fi

# project name to be used for the github updates
project_name="${project}"

# make sure the project is a valid project
flag=false
for i in $valid_projects
	do
		if [ $project = $i ]; then
			flag=true
		fi
	done

# if the project is not in the valid list, we quit the program
if ! $flag ; then
	exit 1
fi

# ############# VARIABLES #####################

# PASSWORD INFORMATION FOR HIDING IMPORTANT INFORMATION
username="orehousej09"
username_1="orehouseJ09"
password="oeller12"
password_1="rojans2013"

# PROJECT REPO FOR THIS PARTICULAR PROJECT
project_repo="${HOME}/Documents/github/${project}"

# REPO FOR ALL DJANGO APPS
app_repo="${HOME}/Documents/github/django_apps"

# ENTIRE PROJECT -- WHEN BACKING UP MAKE SURE THAT IT DOESN'T INCLUDE THE PROJECT FOLDER
directory="${HOME}/Documents/production_development/${project}/current"

# THE PROJECT DIRECTORY ONLY -- NO NEED TO BACK UP -- HAS PERSONAL SETTINGS
project="${HOME}/Documents/production_development/${project}/current/${project}" 

folders=$(find  ${directory} -maxdepth 1 -type d)
static="${HOME}/Documents/production_development/${project_name}/current/static"


################### COPY FILES BETWEEN DIRECTORIES AND REPO DIRECTORY ##########


# COPY THE FOLDERS TO THE APP REPO!
# this section is responsible for determining whether or not the directory is an app or not and copying that to the proper directory in github/django etc
for i in ${folders}
	do
		if [[ "$static" != "$i" && "$project" != "$i" && "$directory" != "$i" ]]; then
			cp -r "${i}" "${app_repo}"
		fi
	done


# NOW COPY THE ACTUAL PROJECT TO ITS PROPER GITHUB_REPO!
cp -r "${directory}/" "${project_repo}/"


# ########################## CLEAN FILES BEFORE GOING TO GITHUB #############
# NEXT -- NEED TO REMOVE ANY IMPORTANT INFORMATION FOR SAFETY!

cleanse ()
{
	for folder in ${folders}
		do
			files=`find "${folder}" -type f`
			
			for file in ${files}
				do
					default_username="Username"
					default_password="Password"
					
					if [[ "${file}" != *.pyc ]]; then
						sed -e "s/[a-zA-Z]${username}/${default_username}/g" -e "s/[a-zA-Z]${username_1}/${default_username}/g" -e "s/[a-zA-Z]${password}/${default_password}/g" -e "s/[a-zA-Z]${password_1}/${default_password}/g" "${file}" > /tmp/django.tmp
						mv /tmp/django.tmp $file
					fi
				done
		done
}

# RUN THE PROPER COMMANDS TO ENSURE THAT ALL PROJECTS ARE CLEANSED OF VALUABLE INFORMATION
cd "${app_repo}"
folders=`ls -d *`
cleanse

cd "${project_repo}"
folders=`ls -d *`
cleanse

# ######## GITHUB FUNCTION FOR UPDATING ########

commit ()
{
	cd ${repo}
	git add *

	echo -e "\n\nPlease input a commit message for ${1}"
	read message

	git commit -m "${message}"
	git push -u origin master
	
	echo -e "${1} Updated successfully \n\t"
}

# run git command for the project
repo="${project_repo}"
commit "${project_name}"

# run git command for the django app repo
repo="${app_repo}"
commit "Django App Repo"

# END PROGRAM
