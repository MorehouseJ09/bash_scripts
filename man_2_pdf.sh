#!/bin/bash

app="${1}"

man -t $app | open -f -a /Applications/Preview.app
