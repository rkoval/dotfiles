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

brew tap homebrew/cask-fonts

for cask in "${casks[@]}"; do
  brew cask install $cask
done

# do config setup
cd ~/Library/Application\ Support
rm -rf Adium\ 2.0
ln -sf ~/Sync/Settings/Adium\ 2.0 Adium\ 2.0
