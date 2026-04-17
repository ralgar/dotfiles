##########################
###   INITIALIZATION   ###
##########################

# Install zinit plugin manager
#if [[ ! -f "$ZDOTDIR/plugins/zinit/zinit.zsh" ]] ; then
#  git clone https://github.com/zdharma-continuum/zinit.git "$ZDOTDIR/plugins/zinit"
#  . "$ZDOTDIR/plugins/zinit/zinit.zsh"
#  zinit self-update
#fi
#. "$ZDOTDIR/plugins/zinit/zinit.zsh"

# Load P10K Theme, and P10K Instant Prompt
if [[ -f /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme ]] ; then
    source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
fi

[[ ! -f $ZDOTDIR/.p10k.zsh ]] || source $ZDOTDIR/.p10k.zsh

if [[ -f "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Create zsh cache dir for history / completions
if [[ ! -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh" ]] ; then
    mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
fi

# Load completions and zinit
zstyle :compinstall filename "$ZDOTDIR/.zshrc"
autoload -Uz compinit
compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/compdump"

# Load autosuggestions plugin
if [[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] ; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Load syntax highlighting plugin
if [[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] ; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

####################
###   SETTINGS   ###
####################

# Basic Settings
unsetopt beep
bindkey -e

# History
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
HISTSIZE=10000
SAVEHIST=10000
setopt inc_append_history
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_space

# Source aliases and functions
. "$ZDOTDIR/aliases"
. "$ZDOTDIR/command-not-found.zsh"
. "$ZDOTDIR/cd-ls.zsh"
. "$ZDOTDIR/trap-rehash.zsh"

# Set OpenAI API key
if [[ -f "$XDG_CONFIG_HOME/openai/config" ]] ; then
    export OPENAI_API_KEY="$(<$XDG_CONFIG_HOME/openai/config)"
fi
