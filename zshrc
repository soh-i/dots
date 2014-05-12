# zaw.zsh
#autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
#add-zsh-hook chpwd chpwd_recent_dirs
#zstyle ':chpwd:*' recent-dirs-max 500
#zstyle ':chpwd:*' recent-dirs-default yes
#zstyle ':completion:*' recent-dirs-insert both

#source /home/soh.i/.zsh/zaw/zaw.zsh
#zstyle ':filter-select' case-insensitive yes
#zstyle ':filter-select' max-lines 10 
#zstyle ':filter-select' extended-search yes

#bindkey '^@' zaw-cdr

if [ -f ~/.zsh_conf ]; then
    source ~/.zsh_conf
fi

setopt transient_rprompt
autoload -Uz add-zsh-hook

setopt auto_pushd
setopt pushd_minus
setopt pushd_ignore_dups

kill-emacsclient() {
  emacsclient -e '(kill-emacs)'
}

kill-all-process() {
    /bin/kill -9 -1
}


man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        man "$@"
}

VISUAL='emacs'

# terminal Title
case "${TERM}" in
    kterm*|xterm)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}\007"
    }
    ;;
esac

# shell prompt
setopt prompt_subst
setopt PRINT_EIGHT_BIT
FACE="@yukke->"
PROMPT="%F{cyan}$FACE%m %F{green}>> %f"
RPROMPT="%F{magenta}[%/]%f"
autoload -Uz vcs_info
# for git
#zstyle ':vcs_info:*' formats '(%b)'
#zstyle ':vcs_info:*' actionformats '[%b|%a]'
#precmd () {
#    psvar=()
#    LANG=en_US.UTF-8 vcs_info
#    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
#}
#RPROMPT="%1(v|%F{green}%1v%F{magenta}[%/]|%F{magenta}[%/]%f)"


# Keybiand emacs
bindkey -e

#allow tab completion in the middle of a word
setopt COMPLETE_IN_WORD

#keep background processes at full speed
setopt NOBGNICE

# Core size
limit coredumpsize 0

# restart running processes on exit
setopt nohup
setopt nocheckjobs

## never ever beep ever
setopt NO_BEEP

## automatically decide when to page a list of completions
LISTMAX=0
autoload -U colors

## Add comment onto one-liner
setopt interactive_comments

setopt no_clobber

## History
HISTFILE=~/.zsh_history
HISTSIZE=10000000
SAVEHIST=$HISTSIZE
setopt extended_history #add time 
setopt inc_append_history
setopt hist_verify
setopt share_history
setopt hist_ignore_dups

bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward

## () completion
setopt auto_param_keys

## comletion
setopt always_last_prompt
setopt magic_equal_subst
setopt auto_list
setopt list_types
setopt auto_menu
setopt auto_param_keys
setopt auto_param_slash
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' list-colors di=34 fi=0
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
setopt list_packed
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' use-cache true
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*' list-separator '-->'
bindkey "^[[Z" reverse-menu-complete


## logout
setopt ignore_eof
unset autologout

# for iris
## control version of emacs

#if [ ${hostname} = 'iris' ] || [ ${hostname} = 'cs0' ] || [ ${hostname} = 'cacao' ]; then 
#    old_emacs='/usr/bin/emacs'
#    alias emacs="${old_emacs}"
    #alias emacs='emacsclient -nw -a "" '
#else
#    new_emacs="$HOME/bin/bin/emacs-23.4"
#    alias emacs="${new_emacs}"
    #alias emacs='emacsclient -nw -a "" '
#fi

## less ( lv is running on iris because of shered library )
hostname=`hostname`
if [ ${hostname} = 'iris' ] ; then
    alias lv='less -M'
fi

if [ ${hostname} = 'smith7' ] ; then
    alias top='top -M'
fi

setopt auto_cd
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
setopt auto_pushd
setopt pushd_ignore_dups

## initialize
autoload -U compinit
compinit -u

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
