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

./init/submodules.sh
./init/jamf.sh
./init/fonts.sh
./init/recipes.sh
./init/casks.sh
./init/alfred.sh
./link.sh
./init/shell.sh

cd /usr/local/bin
# sourcetree requires that the command is named gpg2, so symlink the command
ln -fs gpg gpg2
