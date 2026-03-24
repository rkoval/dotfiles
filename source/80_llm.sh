#!/usr/bin/env bash

DOTFILES_SANDBOX_DIR="${DOTFILES:-$HOME/dotfiles}/claude/sandbox"

dsrc() (
  set -e
  local sandbox="claude-$(basename "$PWD")"
  local image="dotfiles-sandbox"

  local new_hash
  new_hash=$(find "$DOTFILES_SANDBOX_DIR" -type f -exec shasum -a 256 {} + | sort | shasum -a 256 | cut -d' ' -f1)

  docker build --build-arg HOST_HOME="$HOME" --label "dsrc.hash=$new_hash" --tag "$image" "$DOTFILES_SANDBOX_DIR"

  local current_hash
  current_hash=$(docker image inspect "${image}:${sandbox}" --format '{{index .Config.Labels "dsrc.hash"}}' 2>/dev/null || echo "")

  local running=false
  docker sandbox exec "$sandbox" true 2>/dev/null && running=true

  if $running && [ "$new_hash" = "$current_hash" ]; then
    docker sandbox exec --interactive --tty "$sandbox" claude
    return
  fi

  if [ "$new_hash" != "$current_hash" ]; then
    echo "Build context changed: ${current_hash:-<none>} -> $new_hash" >&2
    if $running; then
      if docker sandbox exec "$sandbox" pgrep --full claude >/dev/null 2>&1; then
        echo "Image updated but Claude sessions are active in '$sandbox'." >&2
        echo "Kill existing sessions and re-run dsrc:" >&2
        echo "  docker sandbox rm $sandbox && dsrc" >&2
        return 1
      fi
    fi
    docker sandbox rm "$sandbox" 2>/dev/null || true
    docker tag "$image" "${image}:${sandbox}"
  fi

  docker sandbox run --name "$sandbox" --template "$image" claude . ~/.claude ~/dotfiles/claude
)