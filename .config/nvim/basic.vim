set title " set title to NVIM
set showcmd " show commands
set noshowmode " but not current moce
"set shortmess+=I " dont show launch screen
set cursorline "line highlight

filetype plugin indent on
syntax enable " enable syntax highlighting
set softtabstop=4 " tab is four spaces long
set shiftwidth=4 " << >> 4 spaces
set expandtab " spaces instead of tabs
set smarttab " idk what this does xd

set smartindent " indenting in txt files

" no esc delay
set timeout
set ttimeout
set timeoutlen=1000
set ttimeoutlen=10

" Configure backspace so it acts as it should act
set backspace=eol,start,indent

" colors
colorscheme PaperColor

" set 7 lines to the cursor - when moving vertically using j/k
set scrolloff=7

" interactive tab command completion
set wildmenu

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

" turn off bells etc.
set noerrorbells
set novisualbell
set t_vb=

" search stuff
set incsearch
set hlsearch

" left margin... idk
set foldcolumn=1
set number "seems better
set relativenumber

" better linebreak
set linebreak

" 🤔
set noswapfile

" better ex command autocomplete
set wildmode=list:longest

" undo
set undofile
set undodir=~/.vim/.undo,~/tmp,/tmp
set undolevels=5000

" remember loooots of cmd line history
set history=5000

" folding
set foldmethod=indent
set foldnestmax=1

" fuzzy file search
set path=.
set path=$PWD
set path+=src/**
set path+=tests/**

" pretty windows split :>
set fillchars+=vert:⏐

" windows are vertically split the other way
set splitright

let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

" return to last position in file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" preserve clipboard on leave
autocmd VimLeave * call system('echo ' . shellescape(getreg('+')) . ' | xclip -r -selection clipboard')

