scriptencoding utf-8
" idk why it's NotLikeThis
nnoremap Y y$

" sane line movement
nnoremap j gj
nnoremap k gk
nnoremap H ^
nnoremap L $
xnoremap H ^
xnoremap L g_

" Fast saving. :update only saves if there are changes (it can't be used to
" just update modified time)
nnoremap <A-w> :update!<cr>

" searching with space
nnoremap <space> /

" disable highlight
nnoremap <A-cr> :nohlsearch<cr>:call coc#util#float_hide()<cr>:<BS>

" jump to next merge conflict
nnoremap <silent> <A-c> :silent! keeppatterns /\v^[<\|=>]{7}([^=].+)?$<CR>:nohlsearch<cr>
xnoremap <silent> <A-c> /<C-U>\v^[<\|=>]{7}([^=].+)?$<CR>
onoremap <silent> <A-c> /<C-U>\v^[<\|=>]{7}([^=].+)?$<CR>

" smart way to move between windows
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" close everything with C-q
nnoremap <C-q> :qa<cr>

" ability to move with hjkl in insert mode
inoremap <C-j> <down>
inoremap <C-k> <up>
inoremap <C-h> <left>
inoremap <C-l> <right>

" toggle linenumbers
nnoremap <silent> <A-n> :setlocal number!<cr>

" toggle dark/light bg
nnoremap <silent> <A-b> :let &background = ( &background == "dark"? "light" : "dark" )<CR>

" buffer management
nnoremap <A-d> :bdelete<cr>
nnoremap <A-h> :bprevious<cr>
nnoremap <A-l> :bnext<cr>

" move lines with alt+j,k
nnoremap <A-j> mz:m+<cr>`z
nnoremap <A-k> mz:m-2<cr>`z
xnoremap <A-j> :m'>+<cr>`<my`>mzgv`yo`z
xnoremap <A-k> :m'<-2<cr>`>my`<mzgv`yo`z

" tabs
nnoremap <A-;> gt
nnoremap <A-+> 1gt
nnoremap <A-ě> 2gt
nnoremap <A-š> 3gt
nnoremap <A-č> 4gt
nnoremap <A-ř> 5gt
nnoremap <A-ž> 6gt
nnoremap <A-ý> 7gt
nnoremap <A-á> 8gt
nnoremap <A-í> 9gt
nnoremap <A-é> :tablast<CR>

" map LR arrows to resize, but keep UD arrows for scrolling
nnoremap <Left> :vertical resize -2<CR>
nnoremap <Right> :vertical resize +2<CR>
nnoremap <S-Left> :vertical resize -4<CR>
nnoremap <S-Right> :vertical resize +4<CR>

" accept the suggestion with <cr> or decline it with <esc>
inoremap <silent><expr> <CR>  pumvisible() ? "<C-y>" : "<CR>"

" underscore text object
xnoremap i_ :<C-u>normal! T_vt_<cr>
onoremap i_ :normal vi_<cr>

" buffer text-object
xnoremap i% GoggV
omap i% :<C-u>normal vi%<CR>

" auto complete brace
inoremap {<CR> {<CR>}<Esc>O

" insert current line in cmd mode
cnoremap <C-r><C-l> <C-r>=getline('.')<CR>

noremap <F7> <nop>
inoremap <F7> <nop>

nnoremap <silent> <C-n> :20Lexplore<CR>

" remain in visual after shift
xnoremap > >gv
xnoremap < <gv

" don't jump after identifier search
nnoremap * *N
nnoremap # #N

nnoremap <C-P> "0p
xnoremap <C-P> "0p
inoremap <C-P> <C-R>0

tnoremap <esc> <C-\><C-N>
