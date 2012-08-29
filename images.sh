#!/bin/bash

# 1.) Declare extension
# 2.) read in new extension
# 3.) Check extension
# 4.) List compatible images
# 5.) LIst all images in the current directory into a variable
# 6.) Loop variable and convert each image

new_extension="png" #default png type

if [[ ${#1} > 0 ]]; then #the user has specified a particular image format
	
	new_extension="${1}"
fi

#COMPATIBLE IMAGES!

image_extensions[0]="png"
image_extensions[1]="jpg"
image_extensions[2]="jpeg"
image_extensions[3]="gif"
image_extensions[4]="psd"

images=$(ls)
counter=0

for image in $images
	do
		file_name=${image%.*} #corresponds to the name of the file
		file_extension=${image#*.} #corresponds to the extension
		flag=false #useful to see if this is a valid image
		
		# loop through each image extension to ensure that it is of proper type 
		for extension in "${image_extensions[@]}"
			do
				
				if [[ "$extension" == "$file_extension" ]]; then
					flag=true
				fi
				
			done
		
		# IMAGE is a valid type, need to ensure that we resize/rename etc it
		if [ $flag == true ]; then
		
			counter=$((counter + 1))
			new_file_name="${counter}.${new_extension}"
			sips -s format "$new_extension" "$image" --out "$new_file_name"

			if [[ "$new_file_name" != "$image" ]]; then #make sure that the files don't have the same name
				
				rm "$image"
				
			fi
		fi

	done



# VERSION 2.0 -- add capability to resize images

# 1.) get the pixels and initiate this only if they are input
# 2.) Check to see whether or not they specified height
# 3.) Go through and loop through all imagesi n the directory
# 4.) do the conversion

dimension="Width"

if [[ "${#2}" > 0 ]]; then #should be a number
	
	pixels=${2} #number of pixels to set each too
	
	if [[ "${#3}" > 0 ]]; then #we are assuming they want to specify x/y
		
		input=${3}
		
		
		if [[ "${input}" == "height" || "${input}" == "Height" ]]; then
			
			dimension="Height"
			
		fi #end of valid dimension input
	fi #end of dimension input
	
	for image in ${images}
		
		do

			if [[ "${image#*.}" == "$new_extension" ]]; then
				
				sips "--resample${dimension}" "$pixels" "$image"
				
			fi
		done
fi #end of resize if


