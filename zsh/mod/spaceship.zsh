antibody bundle denysdovhan/spaceship-prompt

# spaceship
SPACESHIP_PROMPT_ORDER=(
  dir # Current directory section
  host # hostname
  git # Git section (git_branch + git_status)
  package # Package version
  # node          # Node.js section
  # ruby # Ruby section
  # xcode # Xcode section
  # swift # Swift section
  # golang        # Go section
  rust # Rust section
  # docker      # Docker section (Disabled)
  # aws # Amazon Web Services section
  # conda         # conda virtualenv section
  pyenv         # Pyenv section
  # direnv # direnv
  # venv # virtualenv section
  # kubecontext   # Kubectl context section
  # exec_time # Execution time
  line_sep # Line break
  # jobs # Background jobs indicator
  exit_code # Exit code section
  char # Prompt character
)
#SPACESHIP_CHAR_SYMBOL="❯ "
#SPACESHIP_CHAR_SYMBOL="▶ "
SPACESHIP_CHAR_SYMBOL="👉 "
SPACESHIP_PROMPT_ADD_NEWLINE=true
#source "${MOD_DIR}/spaceship-direnv.zsh" .
