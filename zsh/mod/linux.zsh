alias stl="systemctl"
alias jnl="journalctl"

# linuxbrew
#export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
#export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"
#export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"

# screem
alias s="screen -qdRR"
alias sls="screen -ls"

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
  sudo apt update
  sudo apt upgrade
  sudo apt dist-upgrade
  brew upgrade
}

show_version() {
  cat /proc/driver/nvidia/version
  cat /usr/local/cuda/version.txt
  which python
  python --version
  python -c 'import tensorflow as tf; print("TensorFlow", tf.__version__)'
}
