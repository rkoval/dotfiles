#!/usr/bin/env bash
if [[ ! -d "$HOME/Work Sync" ]]; then
  echo "$HOME/Work Sync does not exist; settings unable to be copied (rerun this once you've copied this folder)"
  exit 1
fi

setup_karabiner() {
  directory="$HOME/.config/karabiner"
  rm -rf "$directory"
  ln -s "$HOME/Work Sync/Settings/karabiner" "$directory"
}

setup_linear_mouse() {
  directory="$HOME/.config/linearmouse"
  rm -rf "$directory"
  ln -s "$HOME/Work Sync/Settings/linearmouse" "$directory"
}

setup_karabiner
setup_linear_mouse