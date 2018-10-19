#!/usr/bin/env bash

set -e

PROGRAM="com.vim.MacVim"
file_types=(
  "public.plain-text"
  "net.daringfireball.markdown"
  "public.shell-script"
  "org.vim.yaml-file"
  "com.netscape.javascript-source"
  "public.data"
)

for file_type in "${file_types[@]}"; do
  echo "$file_type"
  duti -s "$PROGRAM" "$file_type" all
done
