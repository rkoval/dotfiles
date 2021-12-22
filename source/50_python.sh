#!/usr/bin/env bash
# don't generate .pyc
export PYTHONDONTWRITEBYTECODE=1

# pyenv
if command -v pyenv >> /dev/null; then
  export PYENV_ROOT=/usr/local/var/pyenv
  pathprepend "$PYENV_ROOT/shims:"
fi

# virtualenv
if command -v virtualenv >> /dev/null; then
  export VIRTUAL_ENV=venv
  pathappend "venv/bin"
  alias sba='source venv/bin/activate || source bin/activate'
  alias venvinit='virtualenv venv -p $(which python) && sba && pip install --upgrade pip && pip install -r requirements.txt'
fi

alias pys='py setup.py'
alias pyst='pys test'
