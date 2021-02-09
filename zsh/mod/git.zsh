export GHQ_ROOT="$HOME/Repos/src"
if [[ -n $isLinux ]]; then
  export GHQ_ROOT="$HOME/repos/src"
fi

alias git="hub"
alias lg="lazygit"
alias st="git status"
alias br="git branches"
alias pull="git stash -k && git pull --rebase --prune && git stash pop"
alias push="git push"
alias remotes="git remotes"
alias grm="ghq list | fzy | xargs gst remove -f"
alias gif="git diff"
alias pr="gh pr"
alias issue="gh issue"
alias stash="git stash -ku"
alias unstash="git stash pop"
alias set-upstream="git branch --set-upstream-to=origin/master master"
alias get="ghq get"

clone() {
  ghq get -u -l $(git api search/repositories?q=$1 | jq -r '.items[].full_name' | fzy)
}

gig() {
  git ignore $1 >> .gitignore
}

# Monorepo
alias gd="cd \$(git rev-parse --show-toplevel)"

select-monorepo() {
  cd $(lerna list --json | jq .[].name -r | fzy | xargs -I{} lerna exec pwd --scope {})
}
alias gm="select-monorepo"

git-sync-origin-url() {
  git remote set-url origin $(git config github.user)/$(basename $PWD)
}

git-update-upstream() {
  if [[ `git remote | grep upstream` ]]; then
    echo "Getting update from upstream"
    git fetch --all --prune --tags
    git rebase origin/master master
    git rebase upstream/master master
    git push --set-upstream origin master
  elif [[ `git remote | grep uetchy` ]]; then
    echo "Getting update from origin"
    git fetch --all --prune --tags
    git rebase uetchy/master master
    git rebase origin/master master
    git push --set-upstream uetchy master
  fi
}

git-cleanup() {
  git fetch --all --prune --tags
  git branch --merged | grep -v '*' | xargs git branch --delete
  git-delete-squashed
  git branch -a
}

# https://github.com/not-an-aardvark/git-delete-squashed
git-delete-squashed() {
  git checkout -q master && git for-each-ref refs/heads/ "--format=%(refname:short)" | while read branch; do mergeBase=$(git merge-base master $branch) && [[ $(git cherry master $(git commit-tree $(git rev-parse $branch^{tree}) -p $mergeBase -m _)) == "-"* ]] && git branch -D $branch; done
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

init-git() {
  [ ! -d .git ] && git init
  touch README.md
  touch CONTRIBUTING.md

  mkdir -p .github/workflows
  [ ! -f .github/CODEOWNERS ] && echo '* @uetchy' > .github/CODEOWNERS

  license apache
}

# GitHub
alias gh-repo="echo \${PWD#*\.*/}"

gh-open() {
  git api search/repositories?q=$1 | jq -r '.items[].html_url' | fzy | xargs open
}


gh-purge() {
  curl -s -X PURGE $1 | jq .
}

# or `rel` would also works
gh-releases() {
  local result=$(git api repos/$(gh-repo)/releases)
  jq -r '.[] | "[\(.tag_name)]\n\(.html_url)\n"' <<<"${result}"
}

## Release
alias release-it="release-it --git.tagName='v\${version}'"

# ghq
function select-repo() {
  local repo_dirs=$(ghq list)
  if [[ -z $repo_dirs ]]; then
    echo "No repos found"
    return
  fi

  local selected_dir=$(echo $repo_dirs | fzy -p "❯ ")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd \"${GHQ_ROOT}/${selected_dir}\" && clear"
    zle accept-line
  fi
}
zle -N select-repo
bindkey '^r' select-repo

function select-branch() {
  local branch=$(git branch -a --format '%(refname:short)' | fzy)
  BUFFER=$LBUFFER$branch$RBUFFER
  CURSOR=$#BUFFER
  zle redisplay
}
zle -N select-branch
bindkey '^b' select-branch

git-rename() {
  read OLD_EMAIL"?Your Old Email: "
  read CORRECT_NAME"?Your Correct Name: "
  read CORRECT_EMAIL"?Your Correct Email: "

  git filter-branch -f --env-filter "
  if [ "\$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
  then
      export GIT_COMMITTER_NAME="$CORRECT_NAME"
      export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
  fi
  if [ "\$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
  then
      export GIT_AUTHOR_NAME="$CORRECT_NAME"
      export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
  fi
  " --tag-name-filter cat -- --branches --tags
}

# gst
function new() {
  cd $(gst new $1) && clear
}