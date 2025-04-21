# ~/.bash_profile
#
# Only for login shells - This applies on your main login (before e.g. startx) but not in every instance of your terminal emulator

# Add all directories in .local/bin to user path. 
PATH="$PATH:$(find ~/.local/bin -type d | paste -sd ':' -)"


# If running bash (BASH_VERSION is not null) and bashrc exists source it
[[ -n "$BASH_VERSION" ]] && [[ -f ~/.bashrc ]] && . ~/.bashrc

# If $DISPLAY is empty string and XDG_VTNR? =1 (Like tty but set by systemd under xorg???)
# [[ -z "$DISPLAY" ]] && [[ "$XDG_VTNR" = 1 ]] && exec startx

# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# Homebrew specifics?
#export HOMEBREW_PREFIX="/opt/homebrew";
#export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
#export HOMEBREW_REPOSITORY="/opt/homebrew";
#export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
#[ -z "${MANPATH-}" ] || export MANPATH=":${MANPATH#:}";
#export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";

# Something you need to set in mac
# export BASH_SILENCE_DEPRECATION_WARNING=1

