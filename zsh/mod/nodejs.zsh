
export PATH="node_modules/.bin:/usr/local/lib/node_modules:$PATH"
alias npm-list="npm list -g --depth 0"
alias y="yarn"
alias yu="yarn upgrade"
alias yui="yarn upgrade-interactive"
alias yuil="yarn upgrade-interactive --latest"
alias yuilg="yarn global upgrade-interactive --latest"
alias ya="yarn add"
alias yad="yarn add -D"
alias yw="yarn workspaces"
alias np-precheck="f=\$(npm pack);tar -tf \$f; rm \$f"

export NVM_DIR="$HOME/.nvm"
export NODE_VERSIONS=$NVM_DIR/versions/node
export NODE_VERSION_PREFIX=v

enable_nvm() {
  source "$NVM_DIR/nvm.sh"  # This loads nvm
  source "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}

npm-bootstrap() {
  git-bootstrap

  local name=$(basename $PWD)
  local user=$(git config github.user)
  local gh_repo="https://github.com/$user/$name"
  [ ! -f package.json ] && yarn init -y
  [ "$(npe description)" = "undefined" ] && npe description $name
  [ "$(npe keywords)" = "undefined" ] && npe keywords $name
  [ "$(npe repository.type)" = "undefined" ] && npe repository.type git
  [ "$(npe repository.url)" = "undefined" ] && npe repository.url $gh_repo.git
  [ "$(npe homepage)" = "undefined" ] && npe homepage $gh_repo
  [ "$(npe bugs.url)" = "undefined" ] && npe bugs.url $gh_repo/issues
  [ "$(npe scripts.test)" = "undefined" ] && npe scripts.test "echo \"Error: no test specified\" && exit 1"
  fixpack
  [ ! -f .gitignore ] && gitignore add node

  if ! grep -Fxqs 'layout node' .envrc; then echo 'layout node' >>.envrc; fi
  direnv allow
}