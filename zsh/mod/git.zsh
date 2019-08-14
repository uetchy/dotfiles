export GH="https://github.com/uetchy"
export GHQ_ROOT="$HOME/Repos/src"

alias git="hub"
alias st="git status"
alias br="git branches"
alias remotes="git remotes"
alias pull="git pull --rebase"
alias push="git push"
alias gd="git diff"
alias recent="git recent"
alias stashall="git stash -u"
alias unstash="git stash pop"
alias gh="github"
alias gt="gittower ."
alias lg="lazygit"
alias delete-merged-branch='git branch --merged|egrep -v ''\*|master''|xargs git branch -d'
alias set-upstream="git branch -u"
alias set-upstream-origin-master="git branch --set-upstream-to=origin/master master"
alias push-origin-master="git push -u origin master"


sync-origin() {
  git remote set-url origin $(git config github.user)/$(basename $PWD)
}

git-update-upstream() {
  git fetch upstream
  git rebase upstream/master
}

gu() {
  local gtPrivateKeyPath=$(git config remote.origin.gtPrivateKeyPath)
  local privateKeyPath=${gtPrivateKeyPath:-$HOME/.ssh/id_rsa}
  local gitUser=$(git config user.name)
  local gitEmail=$(git config user.email)
  echo "Name: ${gitUser}"
  echo "Email: ${gitEmail}"
  echo "Key: ${privateKeyPath}"
  echo ""
  GIT_SSH_COMMAND="ssh -i ${privateKeyPath} -oIdentitiesOnly=yes" $@
}

git-bootstrap() {
  [ ! -d .git ] && git init
  license
  [ ! -f README.md ] && mkreadme
}

alias git-contributors="git shortlog -sn | awk -F '\t' 'BEGIN {print \"list of contributors, generated by \`git shortlog -sn\`.\n\"} {print \"- \" \$2}' | grep -Ev 'dependabot|travis|Greenkeeper'"

# GitHub
alias gh-repo="echo \${PWD#*\.*/}"
alias get="ghq get"

gh-readme() {
  hub api search/repositories?q=$1 | jq -r '.items[0].html_url' | fetch-readme | mdcat
}

gh-open() {
  git api search/repositories?q=$1 | jq -r '.items[0].html_url' | xargs open
}

gh-clone() {
  git api search/repositories?q=$1 | jq -r '.items[0].html_url' | xargs ghq get
}

gh-purge() {
  curl -s -X PURGE $1 | jq .
}

# or `rel` would also works
releases() {
  local result=$(git api repos/$(gh-repo)/releases)
  jq -r '.[] | "[\(.tag_name)]\n\(.html_url)\n"' <<<"${result}"
}

## Release
alias release-it="release-it --git.tagName='v\${version}'"

# ghq
function peco-src() {
  local selected_dir=$(ghq list | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd \"${GHQ_ROOT}/${selected_dir}\" && clear"
    zle accept-line
  fi
}
zle -N peco-src
bindkey '^r' peco-src
