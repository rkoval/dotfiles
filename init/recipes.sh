#!/usr/bin/env bash
echo "installing homebrew recipes ..."
recipes=(
  'lastpass-cli --with-pinentry --with-doc'
  'htop --ignore-dependencies'
  ag
  cmake
  ctop
  editorconfig
  fasd
  ghostscript
  git
  git-extras
  htop-osx
  hub
  imagemagick
  jq
  neovim
  nvm
  pyenv
  shellcheck
  ssh-copy-id
  tree
  universal-ctags
  vimpager
  zsh
  fzf
)

for recipe in "${recipes[@]}"; do
  brew install $recipe
done

# custom
brew install --HEAD universal-ctags/universal-ctags/universal-ctags
