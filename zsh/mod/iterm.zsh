
change_title() {
  if [[ $ITERM_SESSION_ID ]]; then
    local title
    local git_root=$(git rev-parse --show-toplevel 2> /dev/null)
    if [[ $git_root ]]; then
      # Check if the parent of the $git_root is "/"
      if [[ $git_root:h == / ]]; then
        trunc_prefix=/
      else
        trunc_prefix=$SPACESHIP_DIR_TRUNC_PREFIX
      fi
      title="$trunc_prefix$git_root:t${${PWD:A}#$~~git_root}"
    else
      if [[ $HOME == $PWD ]]; then
        title="~"
      else
        title="${PWD##*/}"
      fi
    fi
    echo -ne "\\033];${title}\\007"
  fi
}
add-zsh-hook chpwd change_title
echo -ne "\\033];~\\007" # set default title

source "${HOME}/.iterm2_shell_integration.zsh"