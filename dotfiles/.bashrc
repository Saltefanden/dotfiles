# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
color_prompt=yes
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

source ~/.git-prompt.sh
source ~/.git-completion.bash

PROMPT_DIRTRIM=1
if [ "$color_prompt" = yes ]; then
    # PS1='${debian_chroot:+($debian_chroot)}\[\033[00;32m\]\u@\h\[\033[00m\]:\[\033[00;34m\]\w\[\033[00m\]\$ '
    # https://www.reddit.com/r/linux/comments/2uf5uu/this_is_my_bash_prompt_which_is_your_favorite/
# \e[05;32m $hjerte \e[00m
    PS1="\[\e[01;31m\][\[\e[00m\]\[\e[02;37m\]\u \A\[\e[00m\]\[\e[01;31m\]]\[\e[00m\] \[\e[02;36m\]\w \[\e[00m\]\$ "
# PS1="\[\e]0;\u@\h \w\a\]${debian_chroot:+($debian_chroot)}[\[\033[02;36;40m\]\u \A \#\[\033[00m\]] \[\033[03;34m\]\w/ \[\033[00m\]\$ "
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

build_prompt(){
    PS1="\[\e[01;31m\][\[\e[00m\]\[\e[02;37m\]\u \A\[\e[00m\]\[\e[01;31m\]]\[\e[00m\] \[\e[02;36m\]\w\[\e[00m\]"
    export GIT_PS1_SHOWDIRTYSTATE=1
    git_info=$(__git_ps1 " (%s)")
    if [[ $git_info ]]; then
        PS1+="$git_info "
    else
        PS1+=" "
    fi
    if [[ $VIRTUAL_ENV_PROMPT ]]; then
        PS1+="$VIRTUAL_ENV_PROMPT"
    elif [[ $VIRTUAL_ENV ]]; then
        # Should not be proud of this...
        PS1="${PS1:-}(`basename $VIRTUAL_ENV`) "
    fi
    PS1+="\$ "
}
PROMPT_COMMAND=build_prompt
# PROMPT_COMMAND='__git_ps1'
# # If this is an xterm set the title to user@host:dir
# case "$TERM" in
# xterm*|rxvt*)
#     PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#     ;;
# *)
#     ;;
# esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
alias la='ls -lA'
#alias l='ls -CF'
alias tmux='tmux -f $HOME/.config/tmux/tmux.conf' 
# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias cal='ncal -b' 
alias jup='jupyter-notebook'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if [ -f ~/.bash_local ]; then
    . ~/.bash_local
fi

## Put this in bash_local
# DOCKER_DISTRO="Debian"  
# DOCKER_DIR=/mnt/wsl/shared-docker  
# DOCKER_SOCK="$DOCKER_DIR/docker.sock"  
# export DOCKER_HOST="unix://$DOCKER_SOCK"  
# if [ ! -S "$DOCKER_SOCK" ]; then  
#     mkdir -pm o=,ug=rwx "$DOCKER_DIR"  
#     chgrp docker "$DOCKER_DIR"  
#     /mnt/c/Windows/System32/wsl.exe -d $DOCKER_DISTRO sh -c "nohup sudo -b dockerd < /dev/null > $DOCKER_DIR/dockerd.log 2>&1"  
# fi

bind 'TAB:menu-complete'

mkcd(){
  mkdir "$1" && cd "$1"
}
## Put this in bash_local
# chrome(){
#   /mnt/c/Users/nimu/AppData/Local/Google/Chrome/Application/chrome.exe "$(wslpath -w $(pwd)/$1)"
# }

# chropen(){
#   /mnt/c/Users/nimu/AppData/Local/Google/Chrome/Application/chrome.exe "$1"
# }

# chrome(){
#   if [[ -e "$1" ]]
#   then
#     /mnt/c/Users/nimu/AppData/Local/Google/Chrome/Application/chrome.exe "$(wslpath -w $(pwd)/$1)"
#   else 
#     /mnt/c/Users/nimu/AppData/Local/Google/Chrome/Application/chrome.exe "$1"
#   fi
# }

export EDITOR=vim;
export VISUAL=vim;
export BROWSER=firefox;


# Put this is bash_local?
#explorer.exe(){
#	for var in "$@"
#	do
#	/mnt/c/Windows/explorer.exe "$(wslpath -w "$var")"
#	done
#}
#
#export -f explorer.exe
#
#clip.exe(){
#	iconv -f UTF-8 -t IBM850 | /mnt/c/Windows/system32/clip.exe
#}
#
#export -f clip.exe

#chrome(){
#  for var in "$@"
#  do 
#      if [[ -e "$var" ]]
#      then
#        "/mnt/c/Program Files (x86)/Google/Chrome/Application/chrome.exe" "$(wslpath -w $(pwd)/$var)"
#      else 
#        "/mnt/c/Program Files (x86)/Google/Chrome/Application/chrome.exe" "$var"
#      fi
#  done
#}


export GPG_TTY=$(tty)

[[ -z "$TMUX" ]] && { tmux new; exit; } 
