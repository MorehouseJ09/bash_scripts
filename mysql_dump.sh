#!/bin/bash


# notes -- change mysql command to be a program that will just login unless passed commands
	# if only a database logged in then will just login there
	# otherwise will send the results

command=${1}
username="Default Username"
password="Default Password"
mysqldump=$(which mysqldump)
time_stamp=$(date +"%m_%d_%H_%I")
name="${HOME}/Documents/general_development/backups/${time_stamp}.zip"

login="${mysqldump} -u${username} -p${password}"

${login} --all-databases > "${name}"

echo -e "\nAll databases were backed up to:\n${name}\n"



