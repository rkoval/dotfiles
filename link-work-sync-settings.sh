#!/usr/bin/env bash

mkdir -p "$HOME/.config"
WORK_SYNC_DIR="$HOME/Work Sync/Settings"

rm -rf "$HOME/.config/karabiner"
ln -sFv "$WORK_SYNC_DIR/karabiner" ~/.config/karabiner

rm -rf "$HOME/.config/linearmouse"
ln -sFv "$WORK_SYNC_DIR/linearmouse" ~/.config/linearmouse
echo "you must manually reload config in linearmouse General settings for this to update"

rm -f "$HOME/Library/Application Support/com.mitchellh.ghostty/config"
rm -rf "$HOME/.config/ghostty"
ln -sFv "$WORK_SYNC_DIR/ghostty" ~/.config/ghostty

ln -sFv "$WORK_SYNC_DIR/Cursor/settings.json" "$HOME/Library/Application\ Support/Cursor/User/settings.json"
ln -sFv "$WORK_SYNC_DIR/Cursor/keybindings.json" "$HOME/Library/Application\ Support/Cursor/User/keybindings.json"