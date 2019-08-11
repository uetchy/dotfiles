antibody bundle zsh-users/zsh-syntax-highlighting
antibody bundle uetchy/zsh-background-notify

autoload -Uz add-zsh-hook # enable zsh hooks

alias editrc="vim $HOME/.zshrc"

function reload() {
  zcompile $HOME/.zshrc
  for f in $MOD_DIR/*.zsh; zcompile $f
  source $HOME/.zshrc
}

# zsh-autosuggestions
antibody bundle zsh-users/zsh-autosuggestions
ZSH_AUTOSUGGEST_USE_ASYNC=true
bindkey '^ ' autosuggest-accept

# dir
setopt nonomatch # no glob expansion for *, ?, [ and ]
setopt auto_cd   # cd without cd
setopt autopushd # push dir automatically
setopt pushd_ignore_dups # do not push duplicated dir
setopt correct   # spelling correction for commands
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=1000
SAVEHIST=2000
setopt share_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks

peco-select-history() {
  BUFFER=$(fc -l -n 1 | tail -r | awk '!a[$0]++' | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle redisplay
}
zle -N peco-select-history
bindkey '^h' peco-select-history

# Completion
antibody bundle zsh-users/zsh-completions
# insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# completion caches
# zstyle ':completion:*' use-cache on
# # Ignore completion for non-existant commands
# zstyle ':completion:*:functions' ignored-patterns '_*'
# # cd will never select the parent directory
# zstyle ':completion:*:cd:*' ignore-parents parent pwd
# # Fuzzy completion
# zstyle ':completion:*:approximate:*' max-errors 3 numeric
# # ignore package-lock.json when completing
# zstyle ':completion:*' file-patterns '^package-lock.json:source-files' '*:all-files'
