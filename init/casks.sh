#!/usr/bin/env bash
echo "installing homebrew casks ..."
casks=(
  alfred
  bettertouchtool
  discord
  disk-inventory-x
  firefox
  fork
  font-lato
  font-anonymous-pro
  font-anonymouspro-nerd-font-mono
  google-chrome
  istat-menus
  iterm2
  karabiner-elements
  postman
  resilio-sync
  simplenote
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
  brew install $cask
done