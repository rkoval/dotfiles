#!/usr/bin/env bash -e
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

./init/submodules.sh
./link.sh
./init/shell.sh
