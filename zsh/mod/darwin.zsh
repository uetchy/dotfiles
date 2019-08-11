# mdfind
# https://stackoverflow.com/questions/30271328/how-do-i-get-mdfind-to-include-folder-matches-in-addition-to-files
mdfind-dir() {
  # c - match case-INsensitively
  # d - ignore diacritics
  mdfind -onlyin $HOME "kMDItemKind==\"Folder\" && kMDItemFSName==\"*${1}*\"cd" | grep -v "node_modules"
}

# Wi-Fi
function restart_wifi() {
  sudo ifconfig en0 down
  sudo ifconfig en0 up
}

peco-mdfind() {
  result=$(mdfind-dir $@ | peco)
  if [ -n "$result" ]; then
    pushd $result
    clear
  fi
}
alias ff="peco-mdfind"