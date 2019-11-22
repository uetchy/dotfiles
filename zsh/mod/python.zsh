
alias pipreq="pip3 list --format=freeze --not-required > requirements.txt"
alias pip-update="pip3 list --outdated --format=json | jq '.[].name' | xargs pip3 install -U"
alias pip-list="pip3 list --not-required"
alias py="python3"

# unversioned symlinks
#export PATH=/usr/local/opt/python/libexec/bin:$PATH

# pyenv
#export PATH="$HOME/.pyenv/shims:${PATH}"
export PYENV_SHELL=zsh

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

  # direnv (pyenv + virtualenv/venv)
  if ! grep -Fqs 'use pyenv' .envrc; then
    echo "use pyenv ${python_version}" >> .envrc
  fi
  direnv allow
}

rmvenv() {
  sed -i '' '/use pyenv/d' ./.envrc
  direnv allow
  rm -rf .venv
}
