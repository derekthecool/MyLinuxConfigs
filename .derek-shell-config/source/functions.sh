# shellcheck shell=bash
# Helpful functions

#Source .zshrc easily
function rc() {
	source ~/.zshrc
}

#Run adb though powershell.exe on wsl
function adbs() {
	powershell.exe adb shell
}

#Get BelleX adb device log and set filetype to the errlogpool syntax I created
function epool() {
	adb shell "cat /data/freeus_app/errlogpool.txt" | nvim -R +":set ft=errlogpool" -
}

#Run powershell.exe from wsl
function pws() {
	powershell.exe "$1"
}

#Launch vimwiki functions
function diary() {
	echo "Usage: "
	echo "wiki [index] --- wiki 2"
	nvim -c "$1VimwikiMakeDiaryNote"
}
function wiki() {
	if [[ $@ -ne 1 ]]; then
		echo "Usage: "
		echo "wiki [index] --- wiki 2"
	fi
	nvim -c "$1VimwikiIndex"
}

# Compare the differences if 2 zip files
function zipdiff() {
	diff -W200 -u <(unzip -vql "$1" | sort -k8) <(unzip -vql "$2" | sort -k8)
}

# vifm function to change to directory that you ended with
vifm() {
	local dst
	dst="$(command vifm --choose-dir - "$@")"
	if [ -z "$dst" ]; then
		echo 'Directory picking cancelled/failed'
		return 1
	fi
	cd "$dst" || exit
}

### ARCHIVE EXTRACTION
# usage: ex <file>
ex() {
	ARGS="$@"
	echo "$@"

	if [[ -z "$ARGS" ]]; then
		ARGS=*
	fi

	echo ARGS = "$ARGS"

	for archive in *; do

		if [ -f $archive ]; then
			echo Processing -- $archive
			case $archive in
			*.tar.bz2) tar xjf $archive ;;
			*.tar.gz)
				foldertoextractto=$(basename $archive .tar.gz)
				pwd
				mkdir -p $foldertoextractto
				echo $foldertoextractto
				tar xzf $archive -C $foldertoextractto
				;;
			*.bz2) bunzip2 $archive ;;
			*.rar) unrar x $archive ;;
			*.gz) gunzip $archive ;;
			*.tar) tar xf $archive ;;
			*.tbz2) tar xjf $archive ;;
			*.tgz) tar xzf $archive ;;
			*.zip)
				foldertoextractto=$(basename $archive .zip)
				pwd
				mkdir -p $foldertoextractto
				echo $foldertoextractto
				unzip $archive -d $foldertoextractto
				;;
			*.Z) uncompress $archive ;;
			*.7z) 7z x $archive ;;
			*.deb) ar x $archive ;;
			*.tar.xz) tar xf $archive ;;
			*.tar.zst) unzstd $archive ;;
			*) echo "'$archive' cannot be extracted via ex()" ;;
			esac
		else
			echo "'$archive' is not a valid file"
		fi
	done
}

GetLatestGithubRelease() {
	# Split input on '/' and make sure it is a valid argument
	fieldCheck=$(echo "$1" | awk -F'/' '{print NF}')
	if [[ $fieldCheck -ne 2 ]]; then
		echo "Improper github repo input. Expected format username/reponame"
		exit 1
	fi

	# Keep track of loop iterations
	StartNum=0

	# Set IFS to only look at lines not words from spaces and tabs
	IFS=$'\n'

	# Loop over all releases
	for release in $(curl --silent "https://api.github.com/repos/$1/releases/latest" | jq -r '.assets[].browser_download_url'); do
		echo "[$StartNum]: $release"
		let StartNum++
	done

	# Now prompt for an input of which one to download
	echo "Enter a release to download"
	read REPLY

	# Download the specified release
	curl --silent "https://api.github.com/repos/$1/releases/latest" | jq -r ".assets[$REPLY].browser_download_url" | xargs wget
}

# This function is to make the end of the work day more fun, sync my dotfiles and vimwiki repo and then start something fun
alldone() {
	# Run the interactive vimwiki sync script
	echo "Running dotcommit.sh to sync config files"
	dotcommit.sh

	# Run the automatic vimwiki sync script
	echo "Running .wiki-helper-tools/UpdateAndSync.sh to sync wiki"
	[[ -f ~/.mywiki/.wiki-helper-tools/UpdateAndSync.sh ]] && ~/.mywiki/.wiki-helper-tools/UpdateAndSync.sh

	# Start asciiquarium if it exists
	[[ -f /usr/local/bin/asciiquarium ]] && /usr/local/bin/asciiquarium
}

# This function is to view man pages in vim
viman() {
	text=$(man "$@") && echo "$text" | nvim -R +":set ft=man" -
}

doto() {
	# TODO save directory first
	pushd

	# Move to the home directory
	cd ~/ || exit

	# Get the file we want to open
	homeChar='~/'
	fileToOpen="$homeChar$(dot ls-tree HEAD -r --full-name --full-tree | awk '{print $4}' | fzf)"
	echo "$fileToOpen"

	# Open the file
	nvim "$fileToOpen"

	# Return to start location
	popd
}

# Show fortune with cowsay every 30 seconds
cowsay-repeat() {
	[[ $(which cowsay) ]] || exit
	[[ $(which fortune) ]] || exit
	while true; do
		clear
		fortune | cowsay -f elephant
		sleep 30
	done
}

# Play sl (steam locomotive) on repeat
sl-repeat() {
	while true; do
		clear
		# Exit loop if control C was pressed
		sl -e || break
	done
}
