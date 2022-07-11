#!/bin/bash

# The purpose of this script is to list all tmux commands and use fzf in order
# to select one and add arguments

# Save the chosen tmux base command
TmuxCommand=$(tmux list-commands | fzf-tmux)

# Echo back the command so you can see what options are available for the next
# step of adding arguments and options
echo "$TmuxCommand"

# Capture just the base command
TrimmedTmuxCommand=$(echo "$TmuxCommand" | awk '{print $1}')

if [[ -z "$TrimmedTmuxCommand" ]]; then
	echo "No command entered, exiting"
	exit
fi

# Ask if additional flags are wanted
read -rp "Enter additional flags: " Flags

# Send flags only if they are not null
if [[ -z "$Flags" ]]; then
	tmux "$TrimmedTmuxCommand"
else
	tmux "$TrimmedTmuxCommand" "$Flags"
fi
