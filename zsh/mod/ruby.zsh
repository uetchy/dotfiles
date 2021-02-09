
export PATH="/usr/local/opt/ruby/bin:$PATH"

alias be="bundle exec"
alias bi="bundle install && bundle binstubs --all"

gem-init() {
  cat <<EOD > Gemfile
source 'https://rubygems.org'

EOD
}

gem-versions() {
  gem list --remote --all --pre "^${1}$"
}
