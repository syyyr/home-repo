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
nmap <ESC>w :w!<cr>

" searching with space 😮
" the second one doesn't work unfortunately
map <space> /
map <C-space> ?

" disable highlight
map <silent> <ESC><cr> :noh<cr>

" jump to next merge conflict
nnoremap <silent> <ESC>c :silent /\v^[<\|=>]{7}([^=].+)?$<CR>:noh<cr>

" smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" toggle linenumbers
nnoremap <ESC>n :setlocal number!<cr>

" toggle dark/light bg
nnoremap <ESC>b :let &background = ( &background == "dark"? "light" : "dark" )<CR>

" buffer management
map <ESC>d :bdelete<cr>
map <ESC>h :bprevious<cr>
map <ESC>l :bnext<cr>

" move lines with alt+j,k
nmap <ESC>j mz:m+<cr>`z
nmap <ESC>k mz:m-2<cr>`z
vmap <ESC>j :m'>+<cr>`<my`>mzgv`yo`z
vmap <ESC>k :m'<-2<cr>`>my`<mzgv`yo`z
