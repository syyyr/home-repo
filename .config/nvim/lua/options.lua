vim.opt.title = true -- set title to NVIM
vim.opt.showmode = false
vim.opt.cursorline = true

vim.cmd('syntax enable') -- enable syntax highlighting
vim.opt.shiftwidth = 4 -- << >> 4 spaces

-- no esc delay
vim.opt.timeout = true
vim.opt.ttimeout = true
vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 10

-- set 7 lines to the cursor
vim.opt.scrolloff = 7

-- performance hack
vim.opt.lazyredraw = true

-- ignore case when searching, but only for lowercase letters
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- matching brackets
vim.opt.showmatch = true
vim.opt.matchpairs:append('<:>,«:»')

-- incremental commands
vim.opt.inccommand = 'split'

-- always show fold column, good for the margin
vim.opt.foldcolumn = '1'

-- better linebreak
vim.opt.linebreak = true

-- disable swap file
vim.opt.swapfile = false

-- better ex command autocomplete
vim.opt.wildmode = 'list:longest'

-- undo
vim.opt.undofile = true
vim.opt.undolevels = 5000

-- set path for :find
vim.o.path='.'
vim.opt.path:append('$PWD')
vim.opt.path:append('src/**')
vim.opt.path:append('tests/**')
vim.opt.path:append('dist/**')
vim.opt.path:append('public/**')
vim.opt.path:append('include/**')

-- pretty windows split :>
vim.opt.fillchars = 'fold: ,vert:▏'

-- windows are vertically split the other way
vim.opt.splitright = true

-- system clipboard is used along with the unnamed register
vim.opt.clipboard = 'unnamedplus'

-- don't scan tagfiles
vim.opt.complete:remove('t')

-- don't autoload file if it's changed outside of vim
vim.opt.autoread = false

-- the time for CursorHold trigger
vim.opt.updatetime=300

vim.opt.statusline =
    '%#StatusLineNC#' .. -- Set highlight group.
    '%-20.' ..  -- Add padding to the diagnostic to prevent flickering when the diagnostic appears and disappears.
    [[{v:lua.require('syyyr').statusline_diagnostics()}]] .. -- Show diagnostics.
    '%##%' .. -- Reset highlight group.
    [[{&paste? ' [paste]' :''}]] .. -- Show [paste] mode.
    '%=%=' .. -- Separators.
    '%20f' .. -- Show filename.
    '%h' .. -- Show [Help] in help buffers.
    '%m' .. -- Show modified ([+]/[-]) sign.
    '%r' .. -- Show [RO] sign.
    ' ' .. -- A literal space.
    '%-30.' .. -- Add minimal width, so that we don't flicker when diagnostics change.
    '(ln %l col %c%)' .. -- Show line number and column number.
    '%=' .. -- Separator.
    '%#StatusLineNC#' .. -- Set highlight group
    '%{&ft}' .. -- Show filetype
    '%=' -- Separator

-- don't show completion messages
vim.opt.shortmess:append('c')

-- don't show :intro message
vim.opt.shortmess:append('I')

vim.opt.diffopt:append('algorithm:patience')

vim.opt.signcolumn = 'yes'

-- Don't wrap text when it's longer than 'textwidth'
vim.opt.formatoptions:remove('t')
vim.opt.textwidth = 120

vim.opt.makeprg = 'make -C build'

vim.opt.commentstring = '# %s'

vim.opt.mouse = ''

vim.opt.tabstop = 4
