#!/usr/bin/env bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

SUBLIME_PATH="$(which subl)"
if [ -f "$SUBLIME_PATH" ] && [ ! -f "${SUBLIME_PATH}-raw" ]; then
  echo "creating script wrapper around \"$SUBLIME_PATH\" so that env variables is consistent across sublime opens ..."
  mv "$SUBLIME_PATH" "$SUBLIME_PATH"-raw
  ln -s "${SCRIPT_DIR}/../conf/subl" "$SUBLIME_PATH"
else
  echo "script wrapper already exists for \"$SUBLIME_PATH\". ignoring ..."
fi
