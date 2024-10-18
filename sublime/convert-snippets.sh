#!/usr/bin/env bash
set -e
npm install

for dir in ./snippets/*/; do
  if [ -d "$dir" ]; then
    dirname=$(basename "$dir")
    echo "Processing directory: $dirname"
    ./node_modules/.bin/snippetToVsCode -s "$dir" -o "../vscode/extension/rkoval/snippets/$dirname.code-snippets"
    # Remove leading and trailing newline characters from the 'body' key using jq
    jq 'map_values(.body |= if type == "array" then map(sub("^\n"; "") | sub("\n$"; "")) else sub("^\n"; "") | sub("\n$"; "") end)' "../vscode/extension/rkoval/snippets/$dirname.code-snippets" > temp.json && mv temp.json "../vscode/extension/rkoval/snippets/$dirname.code-snippets"

    prettier --write "../vscode/extension/rkoval/snippets/$dirname.code-snippets"
  fi
done