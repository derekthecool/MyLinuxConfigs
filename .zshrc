#    ____                 __                       __             
#   / __ \___  ________  / /_______    ____  _____/ /_  __________
#  / / / / _ \/ ___/ _ \/ //_/ ___/   /_  / / ___/ __ \/ ___/ ___/
# / /_/ /  __/ /  /  __/ ,< (__  )   _ / /_(__  ) / / / /  / /__  
#/_____/\___/_/   \___/_/|_/____/   (_)___/____/_/ /_/_/   \___/  
#                                                                 
# Goals of this configuration
# 1. Remain simple and source files fourd in ~/.derek-shell-config
# 2. Setup ZSH with Oh-My-Zsh chosen plugins

# Uncomment zprof to see a zsh startup diagnostic
# zmodload zsh/zprof

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
if [ -e /etc/zsh_command_not_found ]; then source /etc/zsh_command_not_found; fi

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="powerlevel10k/powerlevel10k"
HYPHEN_INSENSITIVE="true"
DISABLE_UPDATE_PROMPT="true"
COMPLETION_WAITING_DOTS="false"

plugins=(
  git 
  gitignore 
  vi-mode
  zsh-syntax-highlighting
  magic-enter
)
#   ______            _____          _____                                
#  / ____/___  ____  / __(_)___ _   / ___/____  __  _______________  _____
# / /   / __ \/ __ \/ /_/ / __ `/   \__ \/ __ \/ / / / ___/ ___/ _ \/ ___/
#/ /___/ /_/ / / / / __/ / /_/ /   ___/ / /_/ / /_/ / /  / /__/  __(__  ) 
#\____/\____/_/ /_/_/ /_/\__, /   /____/\____/\__,_/_/   \___/\___/____/  
#                       /____/                                            
# This is where the majority of settings are applied. Functions, aliases, etc...
for ConfigFiles in $HOME/.derek-shell-config/source/*; do source $ConfigFiles; done

# Add a path to my scripts
export PATH="$PATH:$HOME/.derek-shell-config/scripts"

#WSL Specific Setup
if [[ $(uname -r) == *"microsoft"* ]]; then
  # Needed for WSL2 display setup
  export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
  export LIBGL_ALWAYS_INDIRECT=1


  # WSL Specific scripts and programs
  export PATH="$PATH:$HOME/.derek-shell-config/scripts/distro_specific/wsl"

  # Dotnet 6 preview
  # export PATH="$PATH:$HOME/dotnet"
  # export DOTNET_ROOT="$HOME/dotnet"
fi

#Raspberry PI Specific Setup
if [[ $(uname -a) == *"armv7l"* ]]; then
  # ESP-IDF path setup
  #export PATH="$HOME/esp/xtensa-esp32-elf/bin:$PATH"
  export IDF_PATH=~/esp/esp-idf
  alias get_idf='. $HOME/esp/esp-idf/export.sh'

  #Adding speical clangd-9 path since it was not available in Raspbian repos
  export PATH=/usr/local/clang_9.0.0/bin:$PATH
  export LD_LIBRARY_PATH=/usr/local/clang_9.0.0/lib:$LD_LIBRARY_PATH
fi

# Final command to run: source $ZSH/oh-my-zsh.sh
source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --ignore-vcs -g "!{.git,build}"'
export FZF_DEFAULT_OPTS='--layout=reverse --info=inline'
export FZF_TMUX_OPTS='-p -h 85% -w 85%'

MAGIC_ENTER_GIT_COMMAND='git status'
MAGIC_ENTER_OTHER_COMMAND='exa --reverse --sort=size --long --git --all'

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# export PATH="$PATH:$HOME/.rvm/bin"

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Setup starship prompt
eval "$(starship init zsh)"

# "bat" as manpager
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Set options for less pager, most important is j12 which helps center searches
export LESS=-iMFRj12
# Setup path for cargo builds
export PATH=/$HOME/.cargo/bin:$PATH
# Set PATH for python pip downloads
export PATH=/$HOME/.local/bin:$PATH
# Set PATH for yarn global binaries
export PATH=/$HOME/.yarn/bin:$PATH
# Set path for dotnet tools
export PATH=/$HOME/.dotnet/tools:$PATH

# bookmark file for xplr
touch ~/bookmarks

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
