#!/usr/bin/env bash
echo "installing homebrew recipes ..."
recipes=(
  'htop --ignore-dependencies'
  ripgrep
  fd
  cmake
  coreutils
  ctop
  editorconfig
  fasd
  fzf
  gpg2
  php # for alfred workflows
  hub
  imagemagick
  jq
  neovim
  nvm
  rbenv
  shellcheck
  wget
  stylua
  ssh-copy-id
  lazygit
  vimpager
  git-delta
)

for recipe in "${recipes[@]}"; do
  brew install $recipe
done

# post-install steps
"$HOMEBREW_HOME/opt/fzf/install" --no-bash --key-bindings --completion --update-rc
