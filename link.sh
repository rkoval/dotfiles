#!/usr/bin/env bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ln -sf "$SCRIPT_DIR/vim" ~/.vim

for file in $SCRIPT_DIR/link/.*; do
  echo "symlinking $file ..."
  ln -sf $file ~/$(basename $file)
done
