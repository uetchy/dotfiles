
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
  npm cache verify
  gem cleanup
  brew cleanup
  brew doctor
}

clearQLCache() {
  qlmanage -r
  qlmanage -r cache
}