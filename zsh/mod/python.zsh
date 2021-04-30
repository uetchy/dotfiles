
alias pipreq="pip3 list --format=freeze --not-required > requirements.txt"
alias pip3-update="pip3 list --outdated --format=json | jq '.[].name' | xargs pip3 install -U"
alias pip-update="pip list --outdated --format=json | jq '.[].name' | xargs pip install -U"
alias pip3-list="pip3 list --not-required"
alias pip-list="pip list --not-required"
alias py="python"
alias py3="python3"

# pyenv
export PYENV_SHELL=zsh
export PYENV_ROOT="$HOME/.pyenv"

enable-pyenv() {
  eval "$(pyenv init -)"
}

[[ -n $isLinux ]] && enable-pyenv

# poetry
# https://poetry.eustace.io/docs/
[[ -d "$HOME/.poetry" ]] && export PATH="$HOME/.poetry/bin:$PATH"
alias poet="poetry"
alias mkpoet="poetry init -n"

pypi-versions() {
  curl -sL https://pypi.org/pypi/$1/json | jq -r '.releases|keys[]' | xargs semver
}

select-pyenv-version() {
  pyenv versions --bare | fzy
}

mkvenv() {
  # select python version
  local python_version=${1:-$(select-pyenv-version)}
  [[ -z $python_version ]] && return
  local pyenv_python=$(pyenv root)/versions/${python_version}/bin/python

  # direnv (pyenv + virtualenv/venv)
  if grep -Fqs 'use pyenv' .envrc; then
    sed -iEe "s/^use pyenv.*/use pyenv ${python_version}/" ./.envrc
  else
    echo "use pyenv ${python_version}" >> .envrc
  fi
  direnv allow

  $pyenv_python -m venv .venv
}

rmvenv() {
  [[ -f .envrc ]] && sed -i '/use pyenv/d' .envrc
  direnv allow
  rm -rf .venv
}

verify-python-env() {
  echo [nvidia]
  cat /proc/driver/nvidia/version
  echo [cuda]
  cat /opt/cuda*/version.txt
  echo [python]
  python --version
  which python
  echo [tensorflow]
  python -c 'import tensorflow as tf; print("TensorFlow", tf.__version__)'
}
