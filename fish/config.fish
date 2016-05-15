# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

# Theme
set fish_theme robbyrussell

# All built-in plugins can be found at ~/.oh-my-fish/plugins/
# Custom plugins may be added to ~/.oh-my-fish/custom/plugins/
set fish_plugins theme

# Path to your custom folder (default path is ~/.oh-my-fish/custom)
#set fish_custom $HOME/dotfiles/oh-my-fish

# Fish
set -e fish_greeting
setenv CDPATH . ~ ~/Repos

# POSIX
alias lt='ls -t'
alias la='ls -a'

# hub
alias git='hub'

# Tower
alias tower='gittower'
alias ts='gittower .'

# Ruby
# status --is-interactive; and . (rbenv init -|psub)
setenv PATH "$HOME/.rbenv/shims" $PATH
setenv RBENV_SHELL fish
. '/usr/local/opt/rbenv/completions/rbenv.fish'
# rbenv rehash 2>/dev/null
function rbenv
  set command $argv[1]
  set -e argv[1]

  switch "$command"
  case rehash shell
    eval (rbenv "sh-$command" $argv)
  case '*'
    command rbenv "$command" $argv
  end
end

alias be="bundle exec"
alias bi="bundle install --without production:staging --path vendor/bundle --binstubs vendor/bundle/bin -j4"

# Python
# status --is-interactive; and . (pyenv init -|psub)
setenv PATH "$HOME/.pyenv/shims" $PATH
setenv PYENV_SHELL fish
. '/usr/local/opt/pyenv/completions/pyenv.fish'
# pyenv rehash 2>/dev/null
function pyenv
  set command $argv[1]
  set -e argv[1]

  switch "$command"
  case rehash shell
    eval (pyenv "sh-$command" $argv)
  case '*'
    command pyenv "$command" $argv
  end
end

# Middleman
alias mm="middleman"

# Sublime Text
alias sl="subl"

# Docker
# if pgrep -f boot2docker-vm
#   . (boot2docker shellinit -|psub)
# end
setenv DOCKER_TLS_VERIFY 1
setenv DOCKER_HOST "tcp://192.168.59.103:2376"
setenv DOCKER_CERT_PATH "$HOME/.boot2docker/certs/boot2docker-vm"

alias d="docker"
alias da="docker ps -a"
alias di="docker images"
alias dlq="docker ps -lq"
alias drm="docker rm -f (docker ps -aq)"
alias b2d="boot2docker"

# Node.js
setenv PATH "/usr/local/lib/node_modules" $PATH

# nw.js
alias nw="/Applications/nwjs.app/Contents/MacOS/nwjs"

# Go
setenv GOPATH "$HOME/.go"

# Heroku
setenv PATH "/usr/local/heroku/bin" $PATH

function glar
  gem list -ar "^$argv[1]\$"
end

# Load oh-my-fish configuration.
. $fish_path/oh-my-fish.fish
