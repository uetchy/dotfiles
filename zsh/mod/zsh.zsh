antibody bundle zsh-users/zsh-syntax-highlighting
antibody bundle uetchy/zsh-background-notify

autoload -Uz add-zsh-hook # enable zsh hooks

function editrc() {
  if [[ -z $1 ]]; then
    vim $HOME/.zshrc
  else
    vim $MOD_DIR/$1.zsh
  fi
}

# create cache and reload settings
function reload() {
  zcompile $HOME/.zshrc
  for f in $MOD_DIR/*.zsh; zcompile $f
  source $HOME/.zshrc
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
HISTSIZE=5000 # maximum number of in-memory history
SAVEHIST=5000 # maximum number of records in $HISTFILE
setopt share_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks

select-history() {
  BUFFER=$(fc -l -n 1 | tail -r | awk '!a[$0]++' | peco --query "$LBUFFER")
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

## commnads
alias list-commands="compgen -ac | grep '^[^_]'"

## ls
alias f="open ."
alias ls="exa --time-style iso"
alias la="ls -lag --git"
alias lt="ls -ltchanged"
alias tree="exa --tree -I node_modules"

## cut
sel() {
  cut -d"${2:-' '}" -f"${1:-1}"
}

## du
alias volumestat="du -m -x -d 3 $HOME/Repos/src | awk '\$1 >= 500{print}'"

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

## pushd
pds() {
  local pushd_number=$(dirs -v | fzy | perl -anE 'say $F[0]')
  [[ -z $pushd_number ]] && return 1
  pushd +$pushd_number
}

## micro
alias mi="micro"
