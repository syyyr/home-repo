vim.opt.title = true
vim.opt.showmode = false
vim.opt.cursorline = true

vim.cmd('syntax enable')
vim.opt.shiftwidth = 4

vim.opt.timeout = true
vim.opt.ttimeout = true
vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 10

vim.opt.scrolloff = 7

vim.opt.lazyredraw = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.showmatch = true
vim.opt.matchpairs:append('<:>,«:»')

vim.opt.inccommand = 'split'

-- Always show fold column, good for the margin
vim.opt.foldcolumn = '1'

vim.opt.linebreak = true

vim.opt.swapfile = false

vim.opt.wildmode = 'list:longest'

vim.opt.undofile = true
vim.opt.undolevels = 5000

-- For :find.
vim.opt.path = {
    '.',
    '$PWD',
    'src/**',
    'tests/**',
    'dist/**',
    'public/**',
    'include/**'
}

vim.opt.fillchars = 'fold: ,vert:▏'

vim.opt.splitright = true

vim.opt.clipboard = 'unnamedplus'

-- Don't scan tagfiles
vim.opt.complete:remove('t')

-- Don't autoload file if it's changed outside of vim
vim.opt.autoread = false

-- The time for CursorHold trigger
vim.opt.updatetime = 300

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

-- Don't show completion messages
vim.opt.shortmess:append('c')

-- Don't show :intro message
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
