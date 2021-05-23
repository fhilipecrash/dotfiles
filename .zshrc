# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="/home/fhilipe/.oh-my-zsh"

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

## Spaceship configuration
# LS_COLORS=$LS_COLORS:'ow=01;34:' ; export LS_COLORS

# SPACESHIP_PROMPT_ORDER=(
#   user          # Username section
#   host          # Hostname section
#   dir           # Current directory section
#   git           # Git section (git_branch + git_status)
#   hg            # Mercurial section (hg_branch  + hg_status)
#   exec_time     # Execution time
#   line_sep      # Line break
#   vi_mode       # Vi-mode indicator
#   jobs          # Background jobs indicator
#   exit_code     # Exit code section
#   char          # Prompt character
# )

# SPACESHIP_USER_SHOW="always" # Shows System user name before directory name
# SPACESHIP_HOST_SHOW="always" # Shows System user name before directory name

# SPACESHIP_PROMPT_ADD_NEWLINE=false
# # SPACESHIP_PROMPT_SEPARATE_LINE=false # Make the prompt span across two lines
# # SPACESHIP_DIR_TRUNC=1 # Shows only the last directory folder name

# SPACESHIP_CHAR_SYMBOL="➜"
# SPACESHIP_CHAR_SUFFIX=" "

# Example aliases
# alias zshconfig="mate ~/.zshrc"
alias mysql="/opt/lampp/bin/mysql"
alias spotify="flatpak run com.spotify.Client"

# Default editor
export EDITOR=nvim

# Node Version Manager export
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Yarn global path
export PATH="$PATH:$(yarn global bin)"

# Android SDK paths
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk/
export ANDROID_HOME=~/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:~/android-studio/bin

unsetopt PROMPT_SP

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
