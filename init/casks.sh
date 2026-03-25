#!/usr/bin/env bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "installing homebrew casks ..."
casks=(
  alfred
  bettertouchtool
  brave-browser
  cleanshot
  cursor
  discord
  docker
  firefox
  font-anonymice-nerd-font
  font-anonymous-pro
  font-lato
  fork
  ghostty
  google-chrome
  grandperspective
  istat-menus
  karabiner-elements
  linearmouse
  neovide
  ngrok
  postman
  raycast
  resilio-sync
  spotify
  sublime-text
  tableplus
  the-unarchiver
)

$SCRIPT_DIR/sublime-text.sh

for cask in "${casks[@]}"; do
  brew install "$cask"
done
