#!/usr/bin/env bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ln -s "$SCRIPT_DIR/vim" "$HOME/.vim"

mkdir -p $HOME/.config

function symlinkDirectory() {
  local directory
  directory="$1"
  for file in $directory/.*; do
    if [[ "$file" =~ \.config$ ]] || [[ "$(basename $file)" =~ \.\.?$ ]]; then
      echo "ignoring $file ..."
    else
      # echo "$file ~/$(basename $file)"
      ln -sfv $file ~/$(basename $file)
    fi
  done
}

symlinkDirectory "$SCRIPT_DIR/link"
ln -sFv "$SCRIPT_DIR/link/.config/nvim" ~/.config
ln -sFv "$SCRIPT_DIR/link/.config/lazygit" ~/.config
ln -sFv "$SCRIPT_DIR/prompt_rkoval_setup" ~/.zgen/sorin-ionescu/prezto-master/modules/prompt/functions