# Time zsh startup
# exec 3>&2 2> >(tee /tmp/sample-time.$$.log |
#                  sed -u 's/^.*$/now/' |
#                  date -f - +%s.%N >/tmp/sample-time.$$.tim)
# set -x
source ~/.profile

HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000
setopt appendhistory

autoload -Uz vcs_info
precmd () { vcs_info } # load before displaying prompt
zstyle ':vcs_info:git:*' formats '(%b)'
setopt prompt_subst
# https://github.com/zsh-users/zsh/blob/master/Misc/vcs_info-examples
CWD='%F{blue}%~%f'
VCS='%F{magenta}${vcs_info_msg_0_}%f'
RET="%(?.%F{white}.%F{red})$%f"
PS1="${CWD}${VCS}${RET} "

# Remove trailing newlines from pasted text
bracketed-paste() {
  zle .$WIDGET && LBUFFER=${LBUFFER%$'\n'}
}
zle -N bracketed-paste

# Simple keybinds
zmodload zsh/complist
bindkey -M menuselect '^[[Z' reverse-menu-complete
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^?' backward-delete-char
bindkey '^H' backward-kill-word
# I trigger this by accident cuz i like spamming escape
bindkey -r "^["
# Use ctrl+arrows to skip words
bindkey '^[[1;5D' backward-word '^[[1;5C' forward-word
# Nice history search
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# Completion https://thevaluable.dev/zsh-completion-guide-examples/
autoload -Uz compinit
compinit
_comp_options+=(globdots) # With hidden files

setopt MENU_COMPLETE        # Automatically highlight first element of completion menu
setopt AUTO_LIST            # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD     # Complete from both ends of a word.

# https://github.com/sorin-ionescu/prezto/blob/master/modules/completion/init.zsh
# Defaults.
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:default' list-prompt '%S%M matches%s'

# Group matches and describe.
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes

# Fuzzy match mistyped completions.
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
unsetopt CASE_GLOB
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
# Increase the number of errors based on the length of the typed word. But make
# sure to cap at 4 the max-errors to avoid hanging.
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3>7?4:($#PREFIX+$#SUFFIX)/3))numeric)'

# Directories
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
zstyle ':completion:*' squeeze-slashes true

# History
zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes

# Environment Variables
zstyle ':completion::*:(-command-|export):*' fake-parameters ${${${_comps[(I)-value-*]#*,}%%,*}:#-*-}

# Kill
zstyle ':completion:*:*:*:*:processes' command 'ps -u $LOGNAME -o pid,user,command -w'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*' insert-ids single

# Man
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true

alias ls='ls --color=auto'
alias ll='ls -la'
alias la='ls -d .*'
alias l="ls"

alias fixres="~/fixres.sh"
alias vim="nvim"

# The git prompt's git commands are read-only and should not interfere with
# other processes. This environment variable is equivalent to running with `git
# --no-optional-locks`, but falls back gracefully for older versions of git.
# See git(1) for and git-status(1) for a description of that flag.
#
# We wrap in a local function instead of exporting the variable directly in
# order to avoid interfering with manually-run git commands by the user.
function __git_prompt_git() {
  GIT_OPTIONAL_LOCKS=0 command git "$@"
}
# Outputs the name of the current branch
# Usage example: git pull origin $(git_current_branch)
# Using '--quiet' with 'symbolic-ref' will not cause a fatal error (128) if
# it's not a symbolic ref, but in a Git repo.
function git_current_branch() {
  local ref
  ref=$(__git_prompt_git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$(__git_prompt_git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
}
alias g="git"
alias ga="git add"
alias gaa="git add --all"
alias gc="git commit"
alias gcb="git checkout -b"
alias gp="git push"
alias gl="git pull"
alias gf="git fetch"
alias gpsup='git push --set-upstream origin $(git_current_branch)'

if [[ -z $DISPLAY ]] && [[ $(tty) == "/dev/tty1" ]]
then
	#sway --unsupported-gpu
  startx
fi
