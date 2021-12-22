#!/usr/bin/env bash
if [ -e "/opt/homebrew" ]; then
  # arm
  HOMEBREW_HOME='/opt/homebrew'
else
  # intel
  HOMEBREW_HOME='/usr/local'
fi
export HOMEBREW_HOME