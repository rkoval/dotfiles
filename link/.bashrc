# Where the magic happens.
export DOTFILES=~/dotfiles

function is_osx() {
  [[ "$OSTYPE" =~ ^darwin ]] || return 1
}

# Source all files in "source"
function src() {
  local file
  if [[ -n "${1}" ]]; then
    source "$DOTFILES/source/$1.sh"
  else
    for file in $DOTFILES/source/*; do
      source "$file"
    done
  fi
}

src

. "$HOME/.local/bin/env"
