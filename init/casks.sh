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
  google-chrome
  istat-menus
  iterm2
  java
  path-finder
  postman
  resilio-sync
  simplenote
  slack
  spotify
  steam
  the-unarchiver
  vlc
  vimr
)

for cask in "${casks[@]}"; do
  brew cask install $cask
done

# do config setup
cd ~/Library/Application\ Support
rm -rf Adium\ 2.0
ln -sf ~/Sync/Settings/Adium\ 2.0 Adium\ 2.0
