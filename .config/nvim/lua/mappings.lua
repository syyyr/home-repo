-- idk why it's NotLikeThis
Custom.nnoremap('Y', 'y$')

-- sane line movement
Custom.nnoremap('j', 'gj')
Custom.nnoremap('k', 'gk')
Custom.nnoremap('H', '^')
Custom.nnoremap('L', '$')
Custom.xnoremap('H', '^')
Custom.xnoremap('L', 'g_')

-- Fast saving. :update only saves if there are changes (it can't be used to
-- just update modified time)
Custom.nnoremap('<A-w>', ':update!<cr>')

-- searching with space
Custom.nnoremap('<space>', '/')
Custom.xnoremap('<space>', '/')

-- disable highlight
Custom.nnoremap('<A-cr>', ':lua Custom.clean_screen()<CR>:nohlsearch<CR>:<BS>')

-- jump to next merge conflict
Custom.nnoremap('<A-c>', [[:silent! keeppatterns /\v^[<|=>]{7}([^=].+)?$<CR>:nohlsearch<cr>]])
Custom.xnoremap('<A-c>', [[/<C-U>\v^[<|=>]{7}([^=].+)?$<CR><esc>:nohlsearch<cr>gv]])
Custom.onoremap('<A-c>', [[/<C-U>\v^[<|=>]{7}([^=].+)?$<CR>]])

-- smart way to move between windows
Custom.nnoremap('<C-j>', '<C-W>j')
Custom.nnoremap('<C-k>', '<C-W>k')
Custom.nnoremap('<C-h>', '<C-W>h')
Custom.nnoremap('<C-l>', '<C-W>l')

-- close everything with C-q
Custom.nnoremap('<C-q>', ':qa<cr>')

-- ability to move with hjkl in insert mode
Custom.inoremap('<C-j>', '<down>')
Custom.inoremap('<C-k>', '<up>')
Custom.inoremap('<C-h>', '<left>')
Custom.inoremap('<C-l>', '<right>')

-- toggle linenumbers
Custom.nnoremap('<A-n>', ':setlocal number!<cr>')

-- toggle dark/light bg
Custom.nnoremap('<A-b>', ':let &background = ( &background == "dark"? "light" : "dark" )<CR>')

-- buffer management
Custom.nnoremap('<A-d>', ':bdelete<cr>')
Custom.nnoremap('<A-h>', ':bprevious<cr>')
Custom.nnoremap('<A-l>', ':bnext<cr>')

-- move lines with alt+j,k
Custom.nnoremap('<A-j>', 'mz:m+<cr>`z')
Custom.nnoremap('<A-k>', 'mz:m-2<cr>`z')
Custom.xnoremap('<A-j>', [[:m'>+<cr>`<my`>mzgv`yo`z]])
Custom.xnoremap('<A-k>', [[:m'<-2<cr>`>my`<mzgv`yo`z]])

-- tabs
Custom.nnoremap('<A-;>', 'gt')
Custom.nnoremap('<A-+>', '1gt')
Custom.nnoremap('<A-ě>', '2gt')
Custom.nnoremap('<A-š>', '3gt')
Custom.nnoremap('<A-č>', '4gt')
Custom.nnoremap('<A-ř>', '5gt')
Custom.nnoremap('<A-ž>', '6gt')
Custom.nnoremap('<A-ý>', '7gt')
Custom.nnoremap('<A-á>', '8gt')
Custom.nnoremap('<A-í>', '9gt')
Custom.nnoremap('<A-é>', ':tablast<CR>')

-- map LR arrows to resize, but keep UD arrows for scrolling
Custom.nnoremap('<Left>', ':vertical resize -2<CR>')
Custom.nnoremap('<Right>', ':vertical resize +2<CR>')
Custom.nnoremap('<S-Left>', ':vertical resize -4<CR>')
Custom.nnoremap('<S-Right>', ':vertical resize +4<CR>')

-- underscore text object
Custom.xnoremap('i_', ':<C-u>normal! T_vt_<cr>')
Custom.onoremap('i_', ':normal vi_<cr>')

-- buffer text-object
Custom.xnoremap('i%', 'GoggV')
Custom.omap('i%', ':<C-u>normal vi%<CR>')

-- auto complete brace
Custom.inoremap('{<CR>', '{<CR>}<Esc>O')

-- insert current line in cmd mode
Custom.cnoremap('<C-r><C-l>', [[<C-r>=getline('.')<CR>]])

Custom.noremap('<F7>', '<nop>')
Custom.inoremap('<F7>', '<nop>')
Custom.cnoremap('<F7>', '<nop>')

Custom.nnoremap('<C-n>', ':20Lexplore<CR>')

-- remain in visual after shift
Custom.xnoremap('>', '>gv')
Custom.xnoremap('<', '<gv')

-- don't jump after identifier search
Custom.nnoremap('*', '*N')
Custom.nnoremap('#', '#N')

Custom.nnoremap('<C-P>', '"0p')
Custom.xnoremap('<C-P>', '"0p')

Custom.tnoremap('<esc>', '<C-><C-N>')

Custom.nmap('úc', ':cprev<cr>zo')
Custom.nmap(')c', ':cnext<cr>zo')

Custom.nnoremap('Q', '<nop>')

Custom.nnoremap('q:', '<nop>')
Custom.cnoremap('CR', 'CR ')

Custom.nnoremap('zr', 'zr<cmd>IndentBlanklineRefresh<cr>')
Custom.nnoremap('zo', 'zo<cmd>IndentBlanklineRefresh<cr>')
