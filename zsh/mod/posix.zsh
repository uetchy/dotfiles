
# ls
alias f="open ."
alias ls="exa --time-style iso"
alias la="ls -lag --git"
alias lt="ls -ltchanged"
alias tree="exa --tree -I node_modules"

# cut
sel() {
  cut -d"${2:-' '}" -f"${1:-1}"
}

# du
alias volumestat="du -m -x -d 3 $HOME/Repos/src | awk '\$1 >= 500{print}'"

# ff (fast file locate using `find`)
ff() {
  local filepath=$(fd | fzy)
  BUFFER=$LBUFFER\"$filepath\"\ $RBUFFER
  CURSOR=$#RBUFFER
  zle redisplay
}
zle -N ff
bindkey '^f' ff

# pushd
pds() {
  local pushd_number=$(dirs -v | fzy | perl -anE 'say $F[0]')
  [[ -z $pushd_number ]] && return 1
  pushd +$pushd_number
}
