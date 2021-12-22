#!/usr/bin/env bash
# History settings

# Entries beginning with space aren't added into history, and duplicate
# entries will be erased (leaving the most recent entry).
export HISTCONTROL="ignorespace:erasedups"
# Give history timestamps.
export HISTTIMEFORMAT="[%F %T] "
# Lots o' history.
export HISTSIZE=10000
export HISTFILESIZE=10000

# Easily re-execute the last history command.
alias r="fc -s"

alias hall='history 1 -1'
alias h='history -30 -1'
alias hg='history 1 -1 | grep '
