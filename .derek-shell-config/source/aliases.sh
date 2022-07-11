# shellcheck shell=bash
# Dotfile tracking aliases for easy source control
# Both of these are bare git repositories for more details on how to use these https://www.atlassian.com/git/tutorials/dotfiles
alias wdot='/usr/bin/git --git-dir=/mnt/c/Users/Derek\ Lomax/.vsvimtracking --work-tree=/mnt/c/Users/Derek\ Lomax/'
alias dot='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Git aliases
alias cdr='cd $(git rev-parse --show-toplevel)'

# Windows aliases for use within WSL
alias adb=adb.exe
alias exp="explorer.exe ."
alias pos=powershell.exe

# Cmake aliases
alias cmb='cmake -Bbuild -S .'  # Cmake build
alias cmr='cmake --build build' # Use Cmake to run build system build

#Vim/Neovim
alias vim=nvim
alias v=nvim

# Use exa instead of ls
alias ls='exa --reverse --sort=size --long --git --all'

#termbin: easily share terminal output with this tool, pipe anything into netcat and upload to termbin.com port 9999 and it will return a 30 day url to share that text
alias tb="nc termbin.com 9999"
