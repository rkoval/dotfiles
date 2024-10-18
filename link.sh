#!/usr/bin/env bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

mkdir -p "$HOME/.config"
NVIM_PLUGINS_DIRECTORY="$HOME/.local/share/nvim/site/pack/packer/start"
mkdir -p "$NVIM_PLUGINS_DIRECTORY"

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
ln -sFv "$SCRIPT_DIR/link/.config/lazygit" ~/.config
ln -sFv "$SCRIPT_DIR/link/.config/direnv" ~/.config
ln -sFv "$SCRIPT_DIR/nvim" ~/.config
ln -sFv "$SCRIPT_DIR/submodules/packer.nvim" "$NVIM_PLUGINS_DIRECTORY"
ln -sFv "$SCRIPT_DIR/prompt_rkoval_setup" ~/.zgen/sorin-ionescu/prezto-master/modules/prompt/functions

mkdir -p ~/.cursor/extensions
mkdir -p ~/.vscode/extensions
ln -sFv "$SCRIPT_DIR/vscode/extension/rkoval.rkoval-0.0.1" ~/.cursor/extensions
ln -sFv "$SCRIPT_DIR/vscode/extension/rkoval.rkoval-0.0.1" ~/.vscode/extensions
