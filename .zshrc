#! /bin/zsh
SHELL=$(which zsh || echo '/bin/zsh')

setopt autocd              # change directory just by typing its name
setopt interactivecomments # allow comments in interactive mode
setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
setopt nonomatch           # hide error message if there is no match for the pattern
setopt notify              # report the status of background jobs immediately
setopt numericglobsort     # sort filenames numerically when it makes sense
setopt promptsubst         # enable command substitution in prompt
setopt MENU_COMPLETE       # Automatically highlight first element of completion menu
setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD    # Complete from both ends of a word.

# enable completion features
autoload -Uz compinit
compinit -i

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # case insensitive tab completion

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.config/zsh/.zcompcache"

# Define completers
zstyle ':completion:*' completer _extensions _complete _approximate

zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %D %d --%f'
zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'

zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Only display some tags for the command cd
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories

# path
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/go/bin"
case `uname` in
    Darwin)
        export PATH="$PATH:/usr/local/opt/openjdk@17/bin"
    ;;
esac

# env
export VISUAL=nvim;
export EDITOR=nvim;
export SUDO_PROMPT="[sudo] %p : "

# History configurations
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=20000
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data

# source plugins
case `uname` in
    Darwin)
        source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
        source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    ;;
    Linux)
        source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
        source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    ;;
esac

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#484E5B,underline"

# tty
if [ "$TERM" = "linux" ] ; then
    echo -en "\e]P0232323"
fi

# zsh keybinds
bindkey "^[[1~"    beginning-of-line
bindkey "^[[4~"    end-of-line
bindkey "^[[3~"   delete-char
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

# alias
alias sr='source ~/.zshrc'
alias ls="exa --color=auto --icons"
alias l="ls -l"
alias la="l -a"
alias lla="ls -la"
alias lt="ls --tree"
alias pwsh="pwsh -nologo"
alias history="history 1"
alias sail='[ -f sail ] && sh sail || sh vendor/bin/sail'

# asdf init
case `uname` in
    Darwin)
        . /usr/local/opt/asdf/libexec/asdf.sh
    ;;
    Linux)
        . /opt/asdf-vm/asdf.sh
    ;;
esac

# asdf fpath
fpath=(${ASDF_DIR}/completions $fpath)

# init starship
eval "$(starship init zsh)"

# setup starship custom prompt
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
