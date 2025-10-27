#!/bin/bash
set -euo pipefail
shopt -s failglob inherit_errexit

"${EDITOR:-vim}" -c 'lua vim.o.errorformat =[[%\s%#%m%# %f:%l:%c,%f:%l:%c: %m]]' -c "cfile $1"
