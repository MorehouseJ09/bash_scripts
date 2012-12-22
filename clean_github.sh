#!/bin/bash

if [[ ${#1} -eq 0 ]]; then
		
	print ""
	exit

fi

git filter-branch --index-filter "git rm --force --cached --ignore-unmatch ${1}" \
  --prune-empty --tag-name-filter cat -- --all