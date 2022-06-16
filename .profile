export PATH="/opt/lutris-ge-7.0-1-lol-x86_64/bin:$HOME/Jts:$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
# export JAVA_HOME="/usr/lib/jvm/zulu-8"
export NVM_DIR="$HOME/.nvm"
export ANDROID_SDK_ROOT="/opt/android-sdk"
export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/library/
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export EDITOR=nvim
export BROWSER="/usr/bin/brave"
export JULIA_NUM_THREADS=$(nproc)
export FZF_DEFAULT_COMMAND='rg --files --hidden -g "!{node_modules/*,.git/*,target/*}"'
