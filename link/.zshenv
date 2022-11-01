#
# Defines environment variables.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

# homebrew
source "$HOME/dotfiles/export_homebrew_home.sh"
if [[ -e "$HOMEBREW_HOME/bin/brew" && ! $(command -v brew >> /dev/null) ]]; then
  eval "$($HOMEBREW_HOME/bin/brew shellenv)"
fi

