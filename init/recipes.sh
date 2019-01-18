#!/usr/bin/env bash
echo "installing homebrew recipes ..."
recipes=(
  'lastpass-cli --with-pinentry --with-doc'
  'htop --ignore-dependencies'
  'universal-ctags/universal-ctags/universal-ctags'
  'macvim --with-lua --with-luajit --with-override-system-vim'
  ag
  cmake
  ctop
  editorconfig
  fasd
  ghostscript
  git
  git-extras
  gpg2
  hub
  imagemagick
  jq
  neovim
  nvm
  rbenv
  shellcheck
  ssh-copy-id
  tree
  vimpager
  zsh
  fzf
  coreutils
)

for recipe in "${recipes[@]}"; do
  brew install $recipe
done

# post-install steps
/usr/local/opt/fzf/install --no-bash --key-bindings --completion --update-rc
