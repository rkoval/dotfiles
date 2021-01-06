#!/usr/bin/env bash
echo "installing homebrew recipes ..."
recipes=(
  'lastpass-cli --with-pinentry --with-doc'
  'htop --ignore-dependencies'
  '--HEAD universal-ctags/universal-ctags/universal-ctags'
  ag
  cmake
  coreutils
  ctop
  editorconfig
  fasd
  fzf
  ghostscript
  git
  git-extras
  gpg2
  hub
  imagemagick
  jq
  lsd
  macvim
  neovim
  nvm
  rbenv
  shellcheck
  ssh-copy-id
  tree
  vimpager
  zsh
  git-delta
)

for recipe in "${recipes[@]}"; do
  brew install $recipe
done

# post-install steps
/usr/local/opt/fzf/install --no-bash --key-bindings --completion --update-rc
