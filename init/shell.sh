#!/usr/bin/env bash
# Make ZSH default
if [[ "$SHELL" != "/bin/zsh" ]]; then
  echo "Making /bin/zsh your default shell"
  sudo chsh -s "/bin/zsh" "$USER" >/dev/null 2>&1
  echo "Please exit and restart all your shells."
fi
