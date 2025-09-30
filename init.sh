#!/usr/bin/env bash
set -e
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ ! -d "$HOME/dotfiles" ]; then
  echo 'cloning dotfiles repo ...'
  git clone git@github.com:rkoval/dotfiles.git "$HOME/dotfiles"
fi

cd "$HOME/dotfiles"
source ./export_homebrew_home.sh

echo 'setting up xcode ...'
# ( set -x ; sudo xcodebuild -license accept )

if [ -e $HOMEBREW_HOME/bin/brew ]; then
  eval "$($HOMEBREW_HOME/bin/brew shellenv)"
fi

if ! command -v brew > /dev/null; then
  echo 'installing homebrew...'
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # arm only, must do after also
  if ! command -v brew > /dev/null ; then
    eval "$($HOMEBREW_HOME/bin/brew shellenv)"
  fi
fi


./init/submodules.sh
./init/recipes.sh
./init/casks.sh
./init/alfred.sh
./link.sh
./init/shell.sh
./init/macos.sh
./init/settings.sh
