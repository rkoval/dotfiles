#!/usr/bin/env bash
echo "installing homebrew recipes ..."
recipes=(
  'htop --ignore-dependencies'
  ripgrep
  fd
  cmake
  colordiff
  coreutils
  ctop
  direnv
  editorconfig
  fzf
  gpg2
  php # for alfred workflows
  hub
  imagemagick
  jq
  mitchellh/gon/gon # for notarizing mac apps
  neovim
  lua-language-server
  rbenv
  wakeonlan
  shellcheck
  exiftool
  wget
  stylua
  ssh-copy-id
  lazygit
  go
  golangci-lint
  vimpager
  difftastic
  rust
)

for recipe in "${recipes[@]}"; do
  brew install $recipe
done

# post-install steps
"$HOMEBREW_HOME/opt/fzf/install" --no-bash --key-bindings --completion --update-rc

# install nvm; not supported via homebrew anymore
command -v nvm >> /dev/null || curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
