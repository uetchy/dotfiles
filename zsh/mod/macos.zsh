# Homebrew
export PATH="/usr/local/sbin:$PATH"

# iTerm
source $MOD_DIR/iterm.zsh .

# Fork
alias fs="fork status"

# mdfind
# https://stackoverflow.com/questions/30271328/how-do-i-get-mdfind-to-include-folder-matches-in-addition-to-files
mdfind-home-dir() {
  # c - match case-INsensitively
  # d - ignore diacritics
  mdfind -onlyin $HOME "kMDItemKind==\"Folder\" && kMDItemFSName==\"*${1}*\"cd" | grep -v "node_modules"
}

# vscode
vs() {
  if [ -z "$1" ]; then
    code .
  else
    if [[ "$1" == md:* ]]; then
      mdfind-dir "${1#md:}" | head -n1 | xargs code
    elif [[ "$1" == ghq:* ]]; then
      fast-ghq-list -p | grep ${1#ghq:} | head -n1 | xargs code
    else
      code $1
    fi
  fi
}

# Wi-Fi
function restart-wifi() {
  sudo ifconfig en0 down
  sudo ifconfig en0 up
}

warp() {
  result=$(mdfind-home-dir $@ | fzy)
  if [ -n "$result" ]; then
    pushd $result
    clear
  fi
}
alias search="warp"

quit() {
  osascript -e "quit app '${1}'"
}

# Books
export Books="$HOME/Library/Mobile Documents/iCloud~com~apple~iBooks/Documents"

update() {
  pushd $DOTFILES_DIR && git pull && popd
  reload
  antibody update
  HOMEBREW_INSTALL_CLEANUP=1 brew upgrade
  brew upgrade --cask
  pip3-update
  opam update
  opam upgrade -y
  rustup update
  cargo install-update --all
  mas upgrade
  yarn global upgrade-interactive
  npm-check -gy
  gcloud components update
}

clean-cache() {
  gem cleanup
  npm cache verify
  yarn cache clean
  pnpm store prune
  brew cleanup
  brew doctor
  docker system prune
  rm -rf "/Users/uetchy/Library/Group Containers/G69SCX94XU.duck/Library/Application Support/duck/Cache"
}

clean-qlcache() {
  qlmanage -r
  qlmanage -r cache
}
