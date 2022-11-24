vim.o.title = true -- set title to NVIM
vim.o.showmode = false
vim.o.cursorline = true

vim.cmd('syntax enable') -- enable syntax highlighting
vim.o.shiftwidth = 4 -- << >> 4 spaces

-- no esc delay
vim.o.timeout = true
vim.o.ttimeout = true
vim.o.timeoutlen = 1000
vim.o.ttimeoutlen = 10

-- set 7 lines to the cursor
vim.o.scrolloff = 7

-- sane opening new files
vim.o.hidden = true

-- performance hack
vim.o.lazyredraw = true

-- ignore case when searching, but only for lowercase letters
vim.o.ignorecase = true
vim.o.smartcase = true

-- matching brackets
vim.o.showmatch = true
vim.opt.matchpairs:append('<:>,«:»')

-- incremental commands
vim.o.inccommand = 'split'

-- always show fold column, good for the margin
vim.o.foldcolumn = '1'

-- better linebreak
vim.o.linebreak = true

-- disable swap file
vim.o.swapfile = false

-- better ex command autocomplete
vim.o.wildmode = 'list:longest'

-- undo
vim.o.undofile = true
vim.o.undolevels = 5000

-- set path for :find
vim.o.path='.'
vim.opt.path:append('$PWD')
vim.opt.path:append('src/**')
vim.opt.path:append('tests/**')
vim.opt.path:append('dist/**')
vim.opt.path:append('public/**')
vim.opt.path:append('include/**')

-- pretty windows split :>
vim.o.fillchars = 'fold: ,vert:▏'

-- windows are vertically split the other way
vim.o.splitright = true

-- system clipboard is used along with the unnamed register
vim.o.clipboard = 'unnamedplus'

-- don't scan tagfiles
vim.opt.complete:remove('t')

-- don't autoload file if it's changed outside of vim
vim.o.autoread = false

-- the time for CursorHold trigger
vim.o.updatetime=300

vim.o.statusline =
    '%#StatusLineNC#' .. -- Set highlight group.
    '%-20.' ..  -- Add padding to the diagnostic to prevent flickering when the diagnostic appears and disappears.
    '{v:lua.Custom.statusline_diagnostics()}' .. -- Show diagnostics.
    '%##%' .. -- Reset highlight group.
    [[{&paste? ' [paste]' :''}]] .. -- Show [paste] mode.
    '%=%=' .. -- Separators.
    '%20f' .. -- Show filename.
    '%h' .. -- Show [Help] in help buffers.
    '%m' .. -- Show modified ([+]/[-]) sign.
    '%r' .. -- Show [RO] sign.
    ' ' .. -- A literal space.
    '%-30.' .. -- Add minimal width, so that we don't flicker when diagnostics change.
    '(ln %l col %c%)' .. -- Show line number and column numbers.
    '%=' .. -- Separator.
    '%#StatusLineNC#' .. -- Set highlight group
    '%{&ft}' .. -- Show filetype
    '%=' -- Separator

-- don't show completion messages
vim.opt.shortmess:append('c')

-- don't show :intro message
vim.opt.shortmess:append('I')

vim.opt.diffopt:append('algorithm:patience')

vim.o.signcolumn = 'yes'

vim.o.textwidth = 120

vim.opt.formatoptions:remove('t')

vim.o.pastetoggle = '<F6>'

vim.o.makeprg = 'make -C build'

vim.o.commentstring = '# %s'

vim.o.mouse = ''
