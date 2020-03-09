
alias sak="ssh-add -K"
remote() {
  ssh $1 -t 'screen -qR'
}

forward() {
  ssh -L ${1}:localhost:${1} -N ${2}
}
alias forward-vnc="forward 5900"
alias forward-jupyter="forward 18888"

# remote worker scripts
export WORKER=com
export SYNC_ROOT=Jobs

sk() {
  echo 🚀 Syncing to $WORKER
  rsync -C --filter=":- .gitignore" --exclude=".git*" -avz . "${WORKER}:${SYNC_ROOT}/$(basename $PWD)"
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

docsync() {
  rsync -arv ${1} ${WORKER}/Documents/${2}
}