
update() {
  pushd $DOTFILES_DIR && git pull && popd
  reload
  HOMEBREW_INSTALL_CLEANUP=1 brew upgrade
  pip-update
  brew cask upgrade
  mas upgrade
  yarn global upgrade-interactive
  #npm-check -gu
}

clearCache() {
  gem cleanup
  brew cleanup
  brew doctor
  docker system prune
}

clearQLCache() {
  qlmanage -r
  qlmanage -r cache
}
