
export PATH="/usr/local/opt/ruby/bin:$PATH"
alias be="bundle exec"
alias bi="bundle install --without production:staging --path vendor/bundle --binstubs vendor/bundle/bin"

gem-versions() {
  gem list --remote --all --pre "^${1}$"
}
