
update() {
  pushd $DOTFILES_DIR && git pull && popd
  reload
  HOMEBREW_INSTALL_CLEANUP=1 brew upgrade
  pip3-update
  brew cask upgrade
  mas upgrade
  yarn global upgrade-interactive
  npm-check -gy
}

cleanCache() {
  gem cleanup
  npm cache verify
  yarn cache clean
  pnpm store prune
  brew cleanup
  brew doctor
  docker system prune
}

clearQLCache() {
  qlmanage -r
  qlmanage -r cache
}
