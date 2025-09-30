#!/usr/bin/env bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "installing homebrew casks ..."
casks=(
  alfred
  bettertouchtool
  brave-browser
  cursor
  discord
  docker
  firefox
  font-anonymice-nerd-font
  font-anonymous-pro
  font-lato
  fork
  grandperspective
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
  sublime-text
  tableplus
  the-unarchiver
)

$SCRIPT_DIR/sublime-text.sh

for cask in "${casks[@]}"; do
  brew install "$cask"
done
