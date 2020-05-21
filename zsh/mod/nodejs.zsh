export PATH="$HOME/.pnpm/bin:$PATH"

alias y="yarn"
alias yu="yarn upgrade"
alias yui="yarn upgrade-interactive"
alias yuil="yarn upgrade-interactive --latest"
alias yuilg="yarn global upgrade-interactive --latest"
alias ya="yarn add"
alias yad="yarn add -D"
alias yw="yarn workspaces"
alias yr="yarn run"
alias dev="yarn dev || yarn start || yarn watch || yarn develop"
alias mkberry="yarn set version berry && yarn set version latest"
alias npm-list="pnpm ls -g"
alias npm-precheck="f=\$(npm pack);tar -tf \$f; rm \$f"
alias fp="fixpack"

export NVM_DIR="$HOME/.nvm"
export NODE_VERSIONS=$NVM_DIR/versions/node
export NODE_VERSION_PREFIX=v

nvm-activate() {
  source "$NVM_DIR/nvm.sh"  # This loads nvm
  source "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}

npm-bootstrap() {
  git-bootstrap

  if ! grep -Fxqs 'layout node' .envrc; then echo 'layout node' >>.envrc; fi
  direnv allow

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
  [ "$(npe main)" = "undefined" ] && npe main "src/index.js"
  yarn add -D @babel/core @babel/cli
  fixpack
  [ ! -f .gitignore ] && gitignore add node
  mkdir src
  touch src/index.js
}
