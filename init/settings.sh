#!/usr/bin/env bash
if [[ ! -d "$HOME/Sync" ]]; then
  echo "$HOME/Sync does not exist; settings unable to be copied (rerun this once you've copied this folder)"
  exit 1
fi

setup_karabiner() {
  directory="$HOME/.config/karabiner"
  rm -rf "$directory"
  ln -s "$HOME/Sync/Settings/karabiner" "$directory"
}

setup_karabiner
