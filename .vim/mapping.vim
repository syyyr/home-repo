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
noremap <ESC>w :w!<cr>

" searching with space 😮
" the second one doesn't work unfortunately
nnoremap <space> /
nnoremap <C-space> ?

" disable highlight
nnoremap <silent> <ESC><cr> :noh<cr>

" jump to next merge conflict
nnoremap <silent> <ESC>c :silent /\v^[<\|=>]{7}([^=].+)?$<CR>:noh<cr>

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
inoremap <C-h> <ESC>i
" <C-o>l doesn't work at end of line
inoremap <C-l> <C-O>:stopinsert<CR>a

" toggle linenumbers
nnoremap <ESC>n :setlocal number!<cr>

" toggle dark/light bg
nnoremap <ESC>b :let &background = ( &background == "dark"? "light" : "dark" )<CR>

" buffer management
nnoremap <ESC>d :bdelete<cr>
nnoremap <ESC>h :bprevious<cr>
nnoremap <ESC>l :bnext<cr>

" move lines with alt+j,k
nnoremap <ESC>j mz:m+<cr>`z
nnoremap <ESC>k mz:m-2<cr>`z
vnoremap <ESC>j :m'>+<cr>`<my`>mzgv`yo`z
vnoremap <ESC>k :m'<-2<cr>`>my`<mzgv`yo`z

" stay in visual after shift
vmap <expr> > ShiftAndKeepVisualSelection(">")
vmap <expr> < ShiftAndKeepVisualSelection("<")

" tabs?
nmap <ESC>; gt
nmap <ESC>+ 1gt
nmap <ESC>ě 2gt
nmap <ESC>š 3gt
nmap <ESC>č 4gt
nmap <ESC>ř 5gt
nmap <ESC>ž 6gt
nmap <ESC>ý 7gt
nmap <ESC>á 8gt
nmap <ESC>é 9gt
nmap <ESC>= :tablast<CR>

" semicolon marks
noremap ; `p
noremap ` mp

" insert mode TAB completion 🤔
inoremap <TAB> <C-N>
