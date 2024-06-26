# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
# Initialization code may require console input (password prompts, [y/n] confirmations, etc.) 
# must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export PATH=~/repos/cpip/bin:$PATH:~/.local/bin

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Start vim with the root conda env
export CONDA_DEFAULT_ENV="root"

# set vim config home
export XDG_CONFIG_HOME="$HOME/.config"

# set path for latex conversion needed to convert to pdf
export PATH=/Library/TeX/texbin:$PATH

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git z docker
)

source $ZSH/oh-my-zsh.sh
source $ZSH/custom/themes/powerlevel10k/powerlevel10k.zsh-theme

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='nvim'
 else
   export EDITOR='nvim'
 fi

alias vi="nvim"
alias vim="nvim"
alias vi_swap="cd ~/.local/share/nvim/swap"
# alias zshconfig="mate ~/.zshrc"
# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# needed for using selenium
export PATH=$HOME/gekodriver/:$PATH

# bindkeys to vi
bindkey -v
bindkey -M vicmd 'k' history-beginning-search-backward
bindkey -M vicmd 'j' history-beginning-search-forward
bindkey -M viins 'kj' vi-cmd-mode
bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward


POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_CUSTOM_MYPROMPT="echo ♛"
POWERLEVEL9K_CUSTOM_MYPROMPT_BACKGROUND="008"
POWERLEVEL9K_CUSTOM_MYPROMPT_FOREGROUND="174"
POWERLEVEL9K_TIME_BACKGROUND="008"
POWERLEVEL9K_TIME_FOREGROUND="174"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon background_jobs dir vcs newline time host)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(disk_usage load ram command_execution_time )
POWERLEVEL9K_RAM_BACKGROUND="cyan"
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_SHORTEN_DIR_LENGTH=4
POWERLEVEL9K_SHORTEN_MIN_LENGTH=12
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=10

# manually load themes
#
function theme_power
{
    source $ZSH/fav_themes/powerlevel9k/powerlevel9k.zsh-theme
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
alias config='/usr/bin/git --git-dir=$HOME/.myconfig/ --work-tree=$HOME'

eval "$(thefuck --alias)"
eval $(thefuck --alias)

alias dir_tree="ls -R | grep ':' | sed -e 's/://' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'"
export PATH="/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/3.0.0/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/cariza2/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/cariza2/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/cariza2/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/cariza2/google-cloud-sdk/completion.zsh.inc'; fi

# Dark and light themes change with daylight for iTerm2 and git diff. See the automation
# script ~/Library/Application\ Support/iTerm2/Scripts/AutoLaunch/auto_darkmode.py

# Jupyer Lab
#export JUPYTER_PREFER_ENV_PATH=1

# added by Snowflake SnowSQL installer v1.2
export PATH=/Applications/SnowSQL.app/Contents/MacOS:$PATH
alias snowsql=/Applications/SnowSQL.app/Contents/MacOS/snowsql

export DATABRICKS_CONFIG_FILE="$HOME/.databrickscfg"
export DATABRICKS_CONFIG_PROFILE="DEFAULT" #"MDS01"

# Google Cloud
export CLOUDSDK_PYTHON="$HOME/anaconda3/bin/python"
export CLOUDSDK_PYTHON_SITEPACKAGES=1
export PROJECTID2=clorox-datalake-dev
#alias gsutil= 'gsutil -o "GSUtil:parallel_process_count=1"'

export PYTORCH_MPS_HIGH_WATERMARK_RATIO=0.0

# source secrets and api_keys from a file (not version control)
if [ -f ~/.secrets.sh ]; then
    source ~/.secrets.sh
fi

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
