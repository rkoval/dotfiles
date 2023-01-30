#!/usr/bin/env bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "installing homebrew casks ..."
casks=(
  alfred
  bettertouchtool
  discord
  disk-inventory-x
  docker
  firefox
  fork
  font-lato
  font-anonymous-pro
  font-anonymice-nerd-font
  google-chrome
  istat-menus
  iterm2
  karabiner-elements
  linearmouse
  postman
  resilio-sync
  spotify
  vimr
  steam
  sublime-text
  tableplus
  the-unarchiver
  vlc
)

./sublime-text.sh

brew tap homebrew/cask-fonts

for cask in "${casks[@]}"; do
  brew install "$cask"
done
