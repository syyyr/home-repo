scriptencoding utf8
set title " set title to NVIM
set noshowmode
set cursorline "line highlight

filetype plugin indent on
syntax enable " enable syntax highlighting
set shiftwidth=4 " << >> 4 spaces

" no esc delay
set timeout
set ttimeout
set timeoutlen=1000
set ttimeoutlen=10

" set 7 lines to the cursor
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

" always show fold column, good for the margin
set foldcolumn=1

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

" set path for :find
set path=.
set path=$PWD
set path+=src/**
set path+=tests/**
set path+=dist/**
set path+=public/**
set path+=include/**

" pretty windows split :>
set fillchars=fold:\ ,vert:⏐

" windows are vertically split the other way
set splitright

" system clipboard is used along with the unnamed register
set clipboard=unnamedplus

" longest = only complete longest match
" menu = show menu, but not when one item would be listed
set completeopt=longest,menu

" default, but doesn't scan tagfiles
set complete=.,w,b,u

" don't autoload file if it's changed outside of vim
set noautoread

" the time for CursorHold trigger
set updatetime=300

" double space before [paste] is needed, but I don't know why
set statusline=%#StatusLineNC#%{custom#StatuslineDiagnostics()}%##%{&paste?'\ \ [paste]':''}%=%=%20f%h%m%r\ %-30.(ln\ %l\ col\ %c%)%=%#StatusLineNC#%{&ft}%=

" don't show completion messages
set shortmess+=c

" don't show :intro message
set shortmess+=I

set diffopt+=algorithm:patience

set signcolumn=yes

set noruler

set textwidth=120
set formatoptions-=t

set pastetoggle=<F6>

set makeprg=make\ -C\ build

set commentstring=#\ %s

set mouse=
