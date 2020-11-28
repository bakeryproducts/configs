
export ZSH="/home/$USER/.oh-my-zsh"
ZSH_THEME="agnoster"
DISABLE_AUTO_UPDATE="true"
DISABLE_UPDATE_PROMPT="true"
#ENABLE_CORRECTION="true"
plugins=(git extract)
HISTFILE=~/.config/zsh/.zsh_history
source $ZSH/oh-my-zsh.sh

# History
HISTSIZE=100000000
SAVEHIST=100000000
setopt HIST_IGNORE_SPACE
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history # share command history data

# Vi

bindkey -v

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/-N}/(main|viins)/-I}"
    RPS2=$RPS1
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select


sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    [[ $BUFFER != sudo\ * ]] && BUFFER="sudo ${BUFFER% }"
    zle end-of-line
}
zle -N sudo-command-line
bindkey "\es" sudo-command-line



# User configuration
bindkey "^k" history-beginning-search-backward
bindkey "^j" history-beginning-search-forward

export LANG=en_US.UTF-8
export LC_ALL="en_US.UTF-8"
export EDITOR='vim'

alias zshcfg="vim ~/.config/zsh/.zshrc"
alias vimcfg="vim ~/.config/vim/vimrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

export MYVIMRC="~/.config/vim/vimrc"
export VIMINIT=":set runtimepath+=~/.config/vim|:source $MYVIMRC"


if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -f ~/.sec_glebash ]; then
    . ~/.sec_glebash
    git config --global user.name "$GITUSER"
    git config --global user.email "$GITMAIL"
fi

if [ -f ~/.config/zsh/.sh_aliases ]; then
    . ~/.config/zsh/.sh_aliases
fi

#eval "$(fasd --init auto)"
eval "$(fasd --init posix-alias zsh-hook)"
[ -f ~/.config/zsh/.fzf.zsh ] && source ~/.config/zsh/.fzf.zsh 
