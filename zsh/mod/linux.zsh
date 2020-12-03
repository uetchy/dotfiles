alias stl="systemctl"
alias jnl="journalctl"

# Node.js
#export PATH="/usr/local/lib/node_modules:$PATH"

# Python
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if [ -f $HOME/.pyenv/bin/pyenv ]; then
  eval "$(pyenv init -)"
fi

check_version() {
  cat /proc/driver/nvidia/version
  cat /usr/local/cuda/version.txt
  which python
  python --version
  python -c 'import tensorflow as tf; print("TensorFlow", tf.__version__)'
}

update() {
  pushd $DOTFILES_DIR && git pull && popd
  reload
  yay -Syu
  yay -c
}