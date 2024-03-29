# remote compute worker
export WORKER=takos
export SYNC_ROOT=~/jobs

## create and download backup
bkup() {
  local SHOST=root@$WORKER
  ssh $SHOST -- bkup/bkup
  scp $SHOST:backup.tar.gz.age .
  ssh $SHOST -- rm backup.tar.gz.age
}

alias sak="ssh-add -K"

# tmux
alias sls="tmux ls"

## prefer attach if exists
s() {
  local list=$(tmux ls)
  if [[ "$list" =~ "no server" || -z "$list" ]]; then
    tmux new -s0
  else
    tmux attach -t $(echo $list | peco --select-1 | awk -F: '{printf $1}')
  fi
}

## force new session
sn() {
  local sessName=${1:-$(basename $PWD)}
  tmux new -As $sessName
}

sp() {
  ssh ${1:-$WORKER}
}

mp() {
  mosh ${1:-$WORKER} -- tmux new -As0
}

forward() {
  ssh -L ${1}:localhost:${1} -N ${2}
}
alias forward-vnc="forward 5900"
alias forward-jupyter="forward 18888"

sk() {
  echo 🚀 Syncing to $WORKER
  #rsync -C --filter=":- .gitignore" --exclude=".git*" -avz . "${WORKER}:${SYNC_ROOT}/$(basename $PWD)"
  rsync -C --exclude=".git*" -avz . "${WORKER}:${SYNC_ROOT}/$(basename $PWD)"
}

receive() {
  rsync -C --exclude=".git*" -avz "${WORKER}:${SYNC_ROOT}/$(basename $PWD)/$1" "./$1"
  echo "📞 Receiving \"$1\" on $WORKER"
}

run() {
  ssh -t $WORKER "cd \"${SYNC_ROOT}/$(basename $PWD)\"; zsh -ic \"$@\"" 2>/dev/null
  echo "🏃 Running \"$@\" on $WORKER"
}

skrun() {
  sk && echo '' && run $@
}

dive() {
  ssh -t $WORKER "cd \"${SYNC_ROOT}/$(basename $PWD)\"; zsh"
  echo "🎯 Dive into ${SYNC_ROOT}/$(basename "$PWD") on $WORKER"
}

sshrun() {
  local param=("${(@s/:/)1}")
  local server=$param[1]
  local baseDir=${param[2]:-.}
  local commands=${@:2}
  ssh -t $server "cd \"${baseDir}\"; zsh -ic \"${commands}\"" 2>/dev/null
}
