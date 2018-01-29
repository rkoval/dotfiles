#!/usr/bin/env bash
echo "installing homebrew casks ..."
casks=(
  # Applications
  adium
  alfred
  atom
  battle-net
  bettertouchtool
  caskroom/homebrew-versions/java6
  cloudapp
  disk-inventory-x
  docker
  dropbox
  firefox
  flux
  google-chrome
  gpg2
  intellij-idea
  istat-menus
  iterm2
  java
  joinme
  path-finder
  postman
  resilio-sync
  simplenote
  slack
  sourcetree
  spotify
  steam
  the-unarchiver
  virtualbox
  vlc
  yakyak
)

for cask in "${casks[@]}"; do
  brew cask install $cask
done
