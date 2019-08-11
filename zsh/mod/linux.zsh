# spaceship
SPACESHIP_GOLANG_SHOW=false
SPACESHIP_KUBECONTEXT_SHOW=false

# snap
export PATH=$PATH:/snap/bin

# screem
alias s="screen -qR"
alias sls="screen -ls"

# Python
export PATH=$HOME/anaconda3/bin:$PATH
alias activate="source venv/bin/activate"

mkvenv() {
  python3 -m venv venv
  echo 'source ./venv/bin/activate' >> .envrc
  direnv allow
}

# Node.js
export PATH="./node_modules/.bin:/usr/local/lib/node_modules:$PATH"
alias npm-list="npm list -g --depth 0"
alias yui="yarn upgrade-interactive"
alias npmc="npm-check"

# Go
export GOPATH="$HOME/Repos"
export PATH=$PATH:$GOPATH/bin

# linuxbrew
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"
export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"

# Hyperdash
alias hd="hyperdash run -n"

check_version() {
  cat /proc/driver/nvidia/version
  cat /usr/local/cuda/version.txt
  which python
  python --version
  python -c 'import tensorflow as tf; print("TensorFlow", tf.__version__)'
}