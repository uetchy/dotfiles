
update() {
  pushd $DOTFILES_DIR && git pull && popd
  reload
  HOMEBREW_INSTALL_CLEANUP=1 brew upgrade
  pip3-update
  brew cask upgrade
  mas upgrade
  ncu -gu
  yarn global upgrade-interactive
}

clearCache() {
  gem cleanup
  yarn cache clean
  brew cleanup
  brew doctor
  docker system prune
}

clearQLCache() {
  qlmanage -r
  qlmanage -r cache
}
