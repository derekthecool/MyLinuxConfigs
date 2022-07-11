#!/bin/bash

# This script is meant to be a tmux launcher for other scripts
script_to_run=$(find ~/.derek-shell-config/scripts | fzf-tmux -p -h 85% -w 85%)

$script_to_run
