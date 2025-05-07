stty stop undef		# Disable ctrl-s to freeze terminal.

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Enable colors and change prompt:
autoload -U colors; colors	# Load colors
# PS1="%B%{$fg[red]%}[%{$fg[gray]%}%n@%m%{$fg[red]%}] %{$fg[cyan]%}%~%  %{$reset_color%}%(!.#.$) "


# Automatically cd into typed directory.
setopt auto_cd
# Allow comments on the commandline
setopt interactive_comments
# Treat the ‘#’, ‘~’ and ‘^’ characters as part of patterns for filename generation, etc. (An initial unquoted ‘~’ always produces named directory expansion.) 
setopt extended_glob
#This option works like APPEND_HISTORY except that new history lines are added to the $HISTFILE incrementally (as soon as they are entered), rather than waiting until the shell exits. The file will still be periodically re-written to trim it when the number of lines grows 20% beyond the value specified by $SAVEHIST (see also the HIST_SAVE_BY_COPY option). 
setopt inc_append_history
# Beep on error in ZLE. 
unsetopt beep


HISTFILE="$XDG_CACHE_HOME/histfile"
HISTSIZE=10000
SAVEHIST=10000

#zstyle :compinstall filename '/home/nckl/.zshrc'
autoload -Uz compinit; compinit
zstyle ':completion:*' menu select rehash true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} ma=0\;33 # colorize cmp menu
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zmodload zsh/complist
_comp_options+=(globdots)		# Include hidden files.


# Make it vim
bindkey -v
# Reduce escapekey timeout to 0.05s
export KEYTIMEOUT=5

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.


source_if_exists() {
    [[ -e "$1" ]] && source "$1"
}

# Add shell aliases
source_if_exists "$XDG_CONFIG_HOME/shell/.shell_alias"

# Add plugins
source_if_exists "$XDG_CONFIG_HOME/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh" 
source_if_exists "$XDG_CONFIG_HOME/zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme" 
source_if_exists "$XDG_CONFIG_HOME/zsh/plugins/fzf/fzf.zsh"
source_if_exists "$XDG_CONFIG_HOME/zsh/plugins/fzf-git/fzf-git.sh"

# Add helper functions
source_if_exists  "$XDG_CONFIG_HOME/zsh/plugins/helper_functions/mkcd"

# Edit line in vim with ctrl-e:

autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M vicmd '^[[P' vi-delete-char
bindkey -M vicmd '^e' edit-command-line
bindkey -M visual '^[[P' vi-delete

(cat ~/.cache/wal/sequences &)


# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh


[[ $(uname) == "Darwin" ]] && source_if_exists "$XDG_CONFIG_HOME/zsh/.zsh_local" || true

