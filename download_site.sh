#!/bin/bash

url="${1}"
wget --recursive --no-clobber --page-requisites --html-extension --convert-links --no-parent "${url}"
