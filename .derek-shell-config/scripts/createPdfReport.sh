#!/bin/bash

# Author:
# Derek Lomax

# Dependencies:
# pandoc, optionally zathura to open pdf

# Script Purpose:
# Create a pdf report from a markdown document

if [[ -z $(which pandoc) ]]; then
	echo "Pandoc not found, this script requires it"
	exit 1
fi

for inputMarkdown in *.md; do
	# Create the pdf file name from the markdown name and print
	outputPdf="$(basename "$inputMarkdown" .md)_$(date +"%Y-%m-%d").pdf"
	echo "Output filename: $outputPdf"

	# Create the report using the eisvogel template
	pandoc "$inputMarkdown" -o "$outputPdf" \
		--from markdown \
		--template eisvogel \
		--listings \
		-V logo:"$(find ./ -maxdepth 1 -name '*.png' -or -name '*jpg' | fzf -1)" \
		-V titlepage:true

	# Open the pdf in zathura in the background if the program is installed
	if [[ $(which zathura) ]]; then
		zathura ./"$outputPdf" &
	fi
done
