#!/usr/bin/env bash
echo "installing homebrew casks ..."
casks=(
  # Applications
  adium
  alfred
  battle-net
  bettertouchtool
  cloudapp
  discord
  disk-inventory-x
  docker
  dropbox
  firefox
  fork
  google-chrome
  istat-menus
  iterm2
  karabiner-elements
  java
  path-finder
  postman
  resilio-sync
  simplenote
  slack
  spotify
  steam
  sublime-text
  tableplus
  the-unarchiver
  vlc
)

for cask in "${casks[@]}"; do
  brew cask install $cask
done

# do config setup
cd ~/Library/Application\ Support
rm -rf Adium\ 2.0
ln -sf ~/Sync/Settings/Adium\ 2.0 Adium\ 2.0
