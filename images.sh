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
			sips -s format "$new_extension" "$image" --out "${counter}.${new_extension}" #convert the image
			rm "${image}"
			
		fi
	done




