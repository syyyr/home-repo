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
