#!/bin/bash

#The purpose of this script is to easily add files to my git bare repository
#For example if I add a new file to .config/nvim/general I will not be notified
#This script will fix that problem for most folders
dot(){
  /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME "$@"
}

#Folders and files to add

#Repo README and CHANGELOG
dot add ~/README.md
dot add ~/CHANGELOG.md

#Neovim https://github.com/derekthecool/stimpack
#moved to this repo, it is too important and needs to be cross platform

#.config items
dot add ~/.config/vifm/vifmrc       # VIFM file manager
dot add ~/.config/neomutt/colors    # Neomutt email
dot add ~/.config/neomutt/neomuttrc
dot add ~/.config/neomutt/mappings
dot add ~/.config/neomutt/macros
dot add ~/.config/neomutt/templates
dot add ~/.config/asciinema/config  # ASCIINEMA
dot add ~/.config/starship.toml     # Prompt Theme
dot add ~/.config/zathura
dot add ~/.config/tmuxinator        # Tmux(inator) session templates
dot add ~/.config/lftp


#TMUX
dot add ~/.tmux.conf
dot add ~/.derek-shell-config/tmux

#Shell Setup Configurations
dot add ~/.zshrc                                              # ZSH
dot add ~/.config/fish/config.fish                            # FISH
dot add ~/.bashrc                                             # BASH
dot add ~/.config/powershell/Microsoft.PowerShell_profile.ps1 # PWSH

#Other shell config items
dot add ~/.derek-shell-config
dot add ~/.vimspector.json

#Show the status
dot status

#Check if dotfiles have even been changed before proceeding
gitstatus=$(dot status --porcelain)
if [[ -z "$gitstatus" ]]; then
  # Nothing to commit, don't ask if we want to update
  exit 0
fi

#Now check if we want to proceed with the commit
echo "Proceed with the commit? y/n"
read REPLY

if [[ $REPLY =~ ^[yY] ]]; then
  #Start the commit adding any changed files, it will use vim to type message
  dot commit -a

  #Push the commit
  dot push
else 
  echo "Quitting"
  exit 1
fi
