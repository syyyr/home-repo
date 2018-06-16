" idk why it's NotLikeThis
nnoremap Y y$

" sane line movement
nnoremap j gj
nnoremap k gk
nnoremap H 0
nnoremap L $

" leader
"let mapleader = ","

" Fast saving
noremap <A-w> :w!<cr>

" searching with space 😮
" the second one doesn't work unfortunately
nnoremap <space> /
nnoremap <C-space> ?

" disable highlight
nnoremap <silent> <A-cr> :noh<cr>

" jump to next merge conflict
nnoremap <silent> <A-c> :silent /\v^[<\|=>]{7}([^=].+)?$<CR>:noh<cr>
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
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
" <C-o>h doesn't work at end of line
inoremap <C-h> <A-i>
" <C-o>l doesn't work at end of line
inoremap <C-l> <C-O>:stopinsert<CR>a

" toggle linenumbers
nnoremap <A-n> :setlocal number!<cr> :setlocal relativenumber!<cr>

" toggle dark/light bg
nnoremap <A-b> :let &background = ( &background == "dark"? "light" : "dark" )<CR>

" buffer management
nnoremap <A-d> :bdelete<cr>
nnoremap <A-h> :bprevious<cr>
nnoremap <A-l> :bnext<cr>

" move lines with alt+j,k
nnoremap <A-j> mz:m+<cr>`z
nnoremap <A-k> mz:m-2<cr>`z
vnoremap <A-j> :m'>+<cr>`<my`>mzgv`yo`z
vnoremap <A-k> :m'<-2<cr>`>my`<mzgv`yo`z

" stay in visual after shift
vmap <expr> > ShiftAndKeepVisualSelection(">")
vmap <expr> < ShiftAndKeepVisualSelection("<")

" tabs?
nmap <A-;> gt
nmap <A-+> 1gt
nmap <A-ě> 2gt
nmap <A-š> 3gt
nmap <A-č> 4gt
nmap <A-ř> 5gt
nmap <A-ž> 6gt
nmap <A-ý> 7gt
nmap <A-á> 8gt
nmap <A-é> 9gt
nmap <A-=> :tablast<CR>

" semicolon marks
noremap ; `p
noremap ` mp

" insert mode TAB completion 🤔
inoremap <silent> <TAB> <C-R>=TabOrCompletion('f')<CR>
inoremap <silent> <S-TAB> <C-R>=TabOrCompletion('b')<CR>

" map LR arrows to resize, but keep UD arrows for scrolling
"nnoremap <Up> :resize +2<CR>
"nnoremap <Down> :resize -2<CR>
nnoremap <Left> :vertical resize -2<CR>
nnoremap <Right> :vertical resize +2<CR>

" accept the suggestion with <cr> or decline it with <esc>
inoremap <silent><expr> <CR>  pumvisible() ? "<C-y>" : "<CR>"
" inoremap <silent><expr> <ESC> pumvisible() ? \"<C-e>\" : \"<ESC>";

" fast movement in source files
nnoremap ú ?^.*\n{\\|^struct\\|^class\\|^namespace\\|^fn\\|^pub\\|^private\\|^enum\\|^impl\\|^use\\|^using\\|^extern<CR>:nohl<CR>
nnoremap ) /^.*\n{\\|^struct\\|^class\\|^namespace\\|^fn\\|^pub\\|^private\\|^enum\\|^impl\\|^use\\|^using\\|^extern<CR>:nohl<CR>

nmap <A-t> :Trailing<cr>

" underscore text object
xnoremap i_ :<C-u>normal! T_vt_<cr>
onoremap i_ :normal vi_<cr>

" buffer text-object
xnoremap i% GoggV
omap i% :<C-u>normal vi%<CR>

" auto complete brace
inoremap {<CR> {<CR>}<Esc>O
