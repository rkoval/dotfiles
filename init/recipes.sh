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
  mitchellh/gon/gon # for notarizing mac apps
  neovim
  lua-language-server
  nvm
  rbenv
  shellcheck
  exiftool
  wget
  stylua
  ssh-copy-id
  lazygit
  go
  golangci-lint
  vimpager
  git-delta
  rust
)

for recipe in "${recipes[@]}"; do
  brew install $recipe
done

# post-install steps
"$HOMEBREW_HOME/opt/fzf/install" --no-bash --key-bindings --completion --update-rc
