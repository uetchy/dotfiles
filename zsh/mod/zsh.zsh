antibody bundle zsh-users/zsh-syntax-highlighting
antibody bundle uetchy/zsh-background-notify

autoload -Uz add-zsh-hook # enable zsh hooks

# create cache and reload settings
function reload() {
  zcompile $HOME/.zshrc
  for f in $MOD_DIR/*.zsh; zcompile $f
  exec $SHELL
}

function editrc() {
  if [[ -z $1 ]]; then
    vim $HOME/.zshrc
  else
    vim $MOD_DIR/$1.zsh
  fi
  reload
}

# default keybind
bindkey -e

# notification
setopt nobeep # no beep sound

# zsh-autosuggestions
# antibody bundle zsh-users/zsh-autosuggestions # enable fish-like autosuggestions
# ZSH_AUTOSUGGEST_USE_ASYNC=true # async fetch suggestions
# ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
# ZSH_AUTOSUGGEST_STRATEGY=(history completion)
# bindkey '^ ' autosuggest-accept

# dir
setopt nonomatch # no glob expansion for *, ?, [ and ]
setopt auto_cd   # cd without cd
setopt autopushd # push dir automatically
setopt pushd_ignore_dups # do not push duplicated dir
setopt correct   # spelling correction for commands
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=2000 # maximum number of in-memory history
SAVEHIST=5000 # maximum number of records in $HISTFILE
setopt share_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks

select-history() {
  BUFFER=$(fc -l -n 1 | sed '1!G;h;$!d' | awk '!a[$0]++' | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle redisplay
}
zle -N select-history # register as widget
bindkey '^h' select-history # assign key bind

# Completion
antibody bundle zsh-users/zsh-completions # additional completions
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # case-insensitive
zstyle ':completion:*' use-cache on # completion caches
# zstyle ':completion:*:functions' ignored-patterns '_*' # ignore completion for non-existant commands
# zstyle ':completion:*:cd:*' ignore-parents parent pwd # cd will never select the parent directory
zstyle ':completion:*:approximate:*' max-errors 3 numeric # fuzzy completion
zstyle ':completion:*' file-patterns '^package-lock.json:source-files' '*:all-files' # ignore `package-lock.json` from completion
zstyle ':completion:*:default' menu select=1 # highlight selection

## ff (fast file locate using `find`)
ff() {
  local filepath=$(fd -d 5 | fzy)
  if [[ -n $filepath ]]; then
    BUFFER=$LBUFFER\"$filepath\"\ $RBUFFER
  else
    BUFFER=$LBUFFER$RBUFFER
  fi
  CURSOR=$#LBUFFER
  zle redisplay
}
zle -N ff
bindkey '^f' ff

# title
change_title() {
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
}
add-zsh-hook chpwd change_title
change_title
