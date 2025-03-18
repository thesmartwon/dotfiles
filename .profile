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
BUN_INSTALL="$HOME/.bun"
if [ -s "$BUN_INSTALL" ]; then
	source "$BUN_INSTALL/_bun"
	export PATH="$BUN_INSTALL/bin:$PATH"
fi
[ -s "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
[ -d "$HOME/.pyenv" ] && eval "$(pyenv init - zsh)"
if type "dircolors" > /dev/null; then
	eval "$(dircolors -b)"
fi
source $HOME/.secrets
