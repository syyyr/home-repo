#!/bin/bash
set -euo pipefail

vim -c 'lua vim.o.errorformat =[[%\s%#%m%# %f:%l:%c,%f:%l:%c: %m]]' -c "cfile $1"
