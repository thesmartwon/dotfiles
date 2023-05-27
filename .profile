. "$HOME/.cargo/env"
export PATH="$HOME/.zvm/bin:$HOME/bin:$HOME/.local/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
export ANDROID_SDK_ROOT="/opt/android-sdk"
export EDITOR=nvim
export BROWSER="/usr/bin/brave"
export JULIA_NUM_THREADS=$(nproc)
export FZF_DEFAULT_COMMAND="rg --files --hidden -g !'{.git/*,node_modules/*,target/*,extern/*}'"
export MANPATH="/usr/local/man:$MANPATH"
export MAKEFLAGS="-j$(($(nproc) / 2))"
if type "dircolors" > /dev/null; then
	eval "$(dircolors -b)"
fi
source $HOME/.secrets
