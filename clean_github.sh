#!/bin/bash

<<<<<<< HEAD

=======
>>>>>>> 35f0d6337047ee727616e0ea9654cbc33e2a686f
if [[ ${#1} -eq 0 ]]; then
		
	print ""
	exit

fi

git filter-branch -f --index-filter "git rm --force --cached --ignore-unmatch ${1}" \
  --prune-empty --tag-name-filter cat -- --all