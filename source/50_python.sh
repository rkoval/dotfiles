# don't generate .pyc
export PYTHONDONTWRITEBYTECODE=1

# pyenv
export PYENV_ROOT=/usr/local/var/pyenv
export PATH="$PYENV_ROOT/shims:$PATH:/usr/local/bin"
export VIRTUAL_ENV=venv

alias pys='py setup.py'
alias pyst='pys test'

# python
PATH="$PATH:venv/bin"
export PATH

alias sba='source venv/bin/activate || source bin/activate'
alias venvinit='virtualenv venv -p $(which python) && sba && pip install --upgrade pip && pip install -r requirements.txt'
