#!/bin/bash

# Clone the repository as bare repository
git clone --bare git@github.com:derekthecool/MyLinuxConfigs.git ~/.cfg

# Function for less typing for each command
dot() {
	/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME "$@"
}

# Create a backup of existing files
mkdir -p .config-backup
dot checkout
if [ $? = 0 ]; then
	echo "Checked out config."
else
	echo "Backing up pre-existing dot files."
	dot checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi

# Try checkout again in case we needed to try again
dot checkout
dot config status.showUntrackedFiles no
