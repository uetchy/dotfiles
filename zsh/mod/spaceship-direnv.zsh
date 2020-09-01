SPACESHIP_DIRENV_SHOW="${SPACESHIP_DIRENV_SHOW=true}"
SPACESHIP_DIRENV_PREFIX="${SPACESHIP_DIRENV_PREFIX=""}"
SPACESHIP_DIRENV_SUFFIX="${SPACESHIP_DIRENV_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_DIRENV_SYMBOL="${SPACESHIP_DIRENV_SYMBOL="↯"}"
SPACESHIP_DIRENV_COLOR="${SPACESHIP_DIRENV_COLOR="green"}"

export DIRENV_LOG_FORMAT=""

spaceship_direnv() {
  [[ $SPACESHIP_DIRENV_SHOW == false ]] && return

  # Check if direnv command is available for execution
  spaceship::exists direnv || return

  # Check if direnv is activated
  [[ ! -z $DIRENV_DIR ]] || return

  if [[ $(direnv status | grep 'Found RC allowed') == "Found RC allowed true" ]]; then
    SPACESHIP_DIRENV_SYMBOL=""
  else
    SPACESHIP_DIRENV_COLOR="red"
  fi 

  # Use quotes around unassigned local variables to prevent
  # getting replaced by global aliases
  # http://zsh.sourceforge.net/Doc/Release/Shell-Grammar.html#Aliasing
  # local 'direnv_status'

  # Display direnv section
  spaceship::section \
    "$SPACESHIP_DIRENV_COLOR" \
    "$SPACESHIP_DIRENV_PREFIX" \
    "$SPACESHIP_DIRENV_SYMBOL" \
    "$SPACESHIP_DIRENV_SUFFIX"
}
