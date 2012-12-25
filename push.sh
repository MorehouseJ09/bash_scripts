#!/bin/bash

if [[ ${#1} -eq 0 ]]; then

	git push -u origin master

elif [[  ]]; then
	git push -u ${1} ${2}
fi
