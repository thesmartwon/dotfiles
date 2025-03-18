if [ -f $HOME/.cargo/env ]; then
	source $HOME/.cargo/env
fi
NCPU=$(nproc 2>/dev/null || sysctl -n hw.logicalcpu)
export PATH="$HOME/bin:$HOME/.local/bin:$HOME/scripts:$PATH"
export NVM_DIR="$HOME/.nvm"
export ANDROID_SDK_ROOT="/opt/android-sdk"
export EDITOR=nvim
export BROWSER="/usr/bin/brave"
export JULIA_NUM_THREADS=$NCPU
export FZF_DEFAULT_COMMAND="rg --files --hidden -g !'{.git/*,node_modules/*,target/*,extern/*}'"
export MANPATH="/usr/local/man:$MANPATH"
export MAKEFLAGS="-j$(($NCPU / 2))"
if type "dircolors" > /dev/null; then
	eval "$(dircolors -b)"
fi
source $HOME/.secrets
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
[ -s "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
[ -d "$HOME/.pyenv" ] && eval "$(pyenv init - zsh)"
