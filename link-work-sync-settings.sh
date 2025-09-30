#!/usr/bin/env bash

mkdir -p "$HOME/.config"
WORK_SYNC_DIR="$HOME/Work Sync/Settings"

rm -rf "$HOME/.config/karabiner"
ln -sFv "$WORK_SYNC_DIR/karabiner" ~/.config/karabiner

rm -rf "$HOME/.config/linearmouse"
ln -sFv "$WORK_SYNC_DIR/linearmouse" ~/.config/linearmouse
echo "you must manually reload config in linearmouse General settings for this to update"
