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
PS1='%F{blue}%~%f%F{red}${vcs_info_msg_0_}%f$ '

# Remove trailing newlines from pasted text
bracketed-paste() {
  zle .$WIDGET && LBUFFER=${LBUFFER%$'\n'}
}
zle -N bracketed-paste

# Can't backspace newlines without this
bindkey '^?' backward-delete-char

autoload -Uz compinit
compinit
zstyle ':completion::complete:*' gain-privileges 1
zstyle ':completion:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

alias ls='ls --color=auto'
alias ll='ls -la'
alias la='ls -d .*'

alias fixres="~/fixres.sh"
alias vim="nvim"
alias g="git"
alias ga="git add"
alias gaa="git add --all"
alias gc="git commit"
alias gp="git push"
alias gpsup="git push --set-upstream origin master"

# I trigger this by accident cuz i like spamming escape
bindkey -r "^["
# Use ctrl+arrows to skip words
bindkey '^[[1;5D' backward-word '^[[1;5C' forward-word

if [[ -z $DISPLAY ]] && [[ $(tty) == "/dev/tty1" ]]
then
	#sway --unsupported-gpu
  startx
fi

if command -v fzf &> /dev/null; then
	source /usr/share/fzf/key-bindings.zsh
fi

if command -v kubectl &> /dev/null; then
	source <(kubectl completion zsh)
fi
