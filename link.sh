#!/usr/bin/env bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ln -sf "$SCRIPT_DIR/vim" ~/.vim

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
ln -sfv "$SCRIPT_DIR/link/.config/nvim" ~/.config
