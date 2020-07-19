
update() {
  pushd $DOTFILES_DIR && git pull && popd
  reload
  antibody update
  HOMEBREW_INSTALL_CLEANUP=1 brew upgrade
  brew cask upgrade
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
