#!/usr/bin/env bash
set -e
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ ! -d "$HOME/dotfiles" ]; then
  echo 'cloning dotfiles repo ...'
  git clone git@github.com:rkoval/dotfiles.git "$HOME/dotfiles"
fi

echo 'setting up xcode ...'
( set -x ; sudo xcodebuild -license accept )
( set -x ; sudo chown -R $USER /usr/local )

echo 'installing homebrew...'
command -v brew > /dev/null || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# arm only
if [ -e /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# intel only
if [ -e /usr/local/Cellar ]; then
  sudo chown -R "$(whoami)" /usr/local/Cellar || return $?
fi

cd "$HOME/dotfiles"

./init/submodules.sh
./init/jamf.sh
./init/recipes.sh
./init/casks.sh
./init/alfred.sh
./link.sh
./init/shell.sh
./init/macos.sh
./init/settings.sh
