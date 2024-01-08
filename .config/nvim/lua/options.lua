vim.opt.autoread = false -- Don't autoload file if it's changed outside of vim
vim.opt.clipboard = 'unnamedplus'
vim.opt.commentstring = '# %s'
vim.opt.complete:remove('t') -- Don't scan tagfiles
vim.opt.cursorline = true
vim.opt.diffopt:append('algorithm:patience')
vim.opt.fillchars = 'fold: ,vert:▏'
vim.opt.foldcolumn = '1'
vim.opt.formatoptions:remove('t') -- Don't wrap text when it's longer than 'textwidth'
vim.opt.inccommand = 'split'
vim.opt.ignorecase = true
vim.opt.lazyredraw = true
vim.opt.linebreak = true
vim.opt.makeprg = 'make -C build'
vim.opt.mouse = ''
vim.opt.scrolloff = 7
vim.opt.shiftwidth = 4
vim.opt.shortmess:append('I') -- Don't show :intro message
vim.opt.shortmess:append('c') -- Don't show completion messages
vim.opt.showmatch = true
vim.opt.showmode = false
vim.opt.signcolumn = 'yes'
vim.opt.smartcase = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.textwidth = 120
vim.opt.title = true
vim.opt.undofile = true
vim.opt.undolevels = 5000
vim.opt.updatetime = 300 -- The time for CursorHold trigger
vim.opt.wildmode = 'list:longest'

vim.opt.path = {
    '.',
    '$PWD',
    'src/**',
    'tests/**',
    'dist/**',
    'public/**',
    'include/**'
}

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
