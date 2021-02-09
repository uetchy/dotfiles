alias sctl="systemctl"
alias jctl="journalctl"
alias nctl="networkctl"

# Arch
alias pacman-Qe="comm -23 <(yay -Qe | awk '{print \$1}'|sort) <(yay -Sp base-devel --print-format '%n'|sort)"

# Network
nswatch="watch -n1 -d 'netstat -an | grep ESTABLISHED'"

update() {
  yay -Syu
  pushd $DOTFILES_DIR && git pull --rebase && popd
  reload
}
