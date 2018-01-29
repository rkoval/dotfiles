#!/usr/bin/env bash
echo "installing homebrew recipes ..."
recipes=(
  'lastpass-cli --with-pinentry --with-doc'
  'macvim --with-lua'
  'htop --ignore-dependencies'
  ag
  cmake
  editorconfig
  fasd
  ghostscript
  git
  git-extras
  htop-osx
  hub
  imagemagick
  jq
  nvm
  pyenv
  shellcheck
  ssh-copy-id
  tree
  universal-ctags
  vimpager
  zsh
)

for recipe in "${recipes[@]}"; do
  brew install $recipe
done

# custom
brew install --HEAD universal-ctags/universal-ctags/universal-ctags
