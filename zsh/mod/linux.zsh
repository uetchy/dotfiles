alias sctl="systemctl"
alias jctl="journalctl"
alias nctl="networkctl"

# Arch
alias pacman-Qe="comm -23 <(yay -Qe | awk '{print \$1}'|sort) <(yay -Sp base-devel --print-format '%n'|sort)"

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
