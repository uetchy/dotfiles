alias stl="systemctl"
alias jnl="journalctl"

# Python
export PYENV_ROOT="$HOME/.pyenv"
if [ -d $HOME/.pyenv ]; then
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
  yay -Syu
  yay -c
  pushd $DOTFILES_DIR && git pull --rebase && popd
  reload
 }
