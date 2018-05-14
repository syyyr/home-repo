set title " set title to VIM
set showcmd " show commands
set noshowmode " but not current moce
"set shortmess+=I " dont show launch screen
if empty($HOMEPC)
    set cursorline "line highlight
endif

filetype plugin indent on
syntax enable " enable syntax highlighting
set softtabstop=4 " tab is four spaces long
set shiftwidth=4 " << >> 4 spaces
set expandtab " spaces instead of tabs
set smarttab " idk what this does xd

" no esc delay
set timeout
set ttimeout
set timeoutlen=10
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

" fold everything according to syntax
"set foldmethod=syntax

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

" folding
set foldmethod=indent
set foldnestmax=1

" return to last position in file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" preserve clipboard on leave
autocmd VimLeave * call system('echo ' . shellescape(getreg('+')) . ' | xclip -selection clipboard')

