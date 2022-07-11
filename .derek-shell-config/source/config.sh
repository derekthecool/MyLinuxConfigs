# shellcheck shell=bash
# Source the command not found feature (not done by default for zsh like bash)
if [ -e /etc/zsh_command_not_found ]; then
  source /etc/zsh_command_not_found
fi

# Declare vim as the default editor
export EDITOR='nvim'

function OpenFileInNeovim() {
  FileToOpen=$(fzf)
  if [[ -n $FileToOpen ]]; then
    echo "Opening $FileToOpen"
    nvim $FileToOpen
  fi
}

# Add hotkey Ctrl + o for to use fzf to find file and open with neovim
# bindkey -s '^o' 'nvim $(fzf)^M'
bindkey -s '^o' 'OpenFileInNeovim^M'

#Add hotkey for this command to Ctrl + f
bindkey -s '^f' 'vifm^M'

# Set easier mapping for zsh vi mode kj instead of Esc
# Help found here https://superuser.com/questions/351499/how-to-switch-comfortably-to-vi-command-mode-on-the-zsh-command-line
bindkey -M viins 'uu' vi-cmd-mode

# Change fzf default command
export FZF_DEFAULT_COMMAND="find -L"
