#!/usr/bin/env bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "installing homebrew casks ..."
casks=(
  alfred
  bettertouchtool
  brave-browser
  discord
  disk-inventory-x
  docker
  firefox
  font-anonymice-nerd-font
  font-anonymous-pro
  font-lato
  fork
  google-chrome
  istat-menus
  iterm2
  karabiner-elements
  ngrok
  linearmouse
  neovide
  postman
  raycast
  resilio-sync
  spotify
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
