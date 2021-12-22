#!/usr/bin/env bash
echo "installing homebrew recipes ..."
recipes=(
  'htop --ignore-dependencies'
  '--HEAD universal-ctags/universal-ctags/universal-ctags'
  ag
  cmake
  coreutils
  ctop
  editorconfig
  fasd
  fzf
  git
  gpg2
  hub
  imagemagick
  jq
  neovim
  nvm
  rbenv
  shellcheck
  ssh-copy-id
  vimpager
  git-delta
)

for recipe in "${recipes[@]}"; do
  brew install $recipe
done

# post-install steps
/usr/local/opt/fzf/install --no-bash --key-bindings --completion --update-rc
