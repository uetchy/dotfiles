# mdfind
# https://stackoverflow.com/questions/30271328/how-do-i-get-mdfind-to-include-folder-matches-in-addition-to-files
mdfind-home-dir() {
  # c - match case-INsensitively
  # d - ignore diacritics
  mdfind -onlyin $HOME "kMDItemKind==\"Folder\" && kMDItemFSName==\"*${1}*\"cd" | grep -v "node_modules"
}

# Wi-Fi
function restart_wifi() {
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

# iBooks
export Books="$HOME/Library/Mobile Documents/iCloud~com~apple~iBooks/Documents"