set title " set title to NVIM
set noshowmode " but not current moce
set cursorline "line highlight

filetype plugin indent on
syntax enable " enable syntax highlighting
set softtabstop=4 " tab is four spaces long
set shiftwidth=4 " << >> 4 spaces
set expandtab " spaces instead of tabs

" indenting in txt files
set smartindent

" no esc delay
set timeout
set ttimeout
set timeoutlen=1000
set ttimeoutlen=10

" set 7 lines to the cursor - when moving vertically using j/k
set scrolloff=7

" sane opening new files
set hidden

" performance hack
set lazyredraw

" ignore case when searching, but only for lowercase letters
set ignorecase
set smartcase

" matching brackets
set showmatch
set matchpairs+=<:>,«:»

" incremental commands
set inccommand=split

" left margin... idk
set foldcolumn=1
set number "seems better
set relativenumber

" better linebreak
set linebreak

" disable swap file
set noswapfile

" better ex command autocomplete
set wildmode=list:longest

" undo
set undofile
set undolevels=5000

" folding
set foldmethod=indent
set foldnestmax=1

" fuzzy file search
set path=.
set path=$PWD
set path+=src/**
set path+=tests/**

" pretty windows split :>
let &fillchars='fold: ,vert:⏐'

" windows are vertically split the other way
set splitright

" system clipboard is used along with the unnamed register
set clipboard=unnamedplus

" longest = only complete longest match
" menu = show menu, but not when one item would be listed
set completeopt=longest,menu

" default scans tagfiles
set complete=.,w,b,u

" don't autoload file if it's changed outside of vim
set noautoread

" don't use ignorecase in insert mode (because of completion mainly)
au InsertEnter * set noignorecase
au InsertLeave * set ignorecase