# ~/.zprofile
#
# Only for login shells - This applies on your main login (before e.g. startx) but not in every instance of your terminal emulator

export VISUAL="vim"
export EDITOR="vim"
export TERMINAL="st"

# Freedesktop specifications
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# Other cleanup
export XINITRC="$XDG_CONFIG_HOME/x11/xinitrc"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export PYTHON_HISTORY="$XDG_STATE_HOME/python_history"
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
# Note that LightDM does not allow you to change this variable. If you change it nonetheless, you will not be able to login.
# As per https://wiki.archlinux.org/title/XDG_Base_Directory#Partial
#export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"

export PYTHON_BASIC_REPL="True"   # Set to whatever, I just dont like the new REPL in python 3.13
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc.py"

# Ensure path array only contains unique entries
typeset -U path
# Prepend all .local/bin directories to path
path=($(find -L ~/.local/bin -type d) $path)

# If $DISPLAY is empty string and XDG_VTNR? =1 (Like tty but set by systemd under xorg???)
[[ -z "$DISPLAY" ]] && [[ "$XDG_VTNR" = 1 ]] && exec startx &> /dev/null
