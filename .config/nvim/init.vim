" plugiiins
call zen#init()
Plugin 'Carpetsmoker/startscreen.vim'
Plugin 'JamshedVesuna/vim-markdown-preview'
Plugin 'Yggdroot/indentLine'
Plugin 'godlygeek/tabular'
Plugin 'jez/vim-superman'
Plugin 'mbbill/undotree'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'rhysd/clever-f.vim'
Plugin 'rust-lang/rust.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-scripts/HJKL'
Plugin 'w0rp/ale'
Plugin 'nathanalderson/yang.vim'
Plugin 'haya14busa/vim-signjk-motion'
Plugin 'junegunn/goyo.vim'
Plugin 'StanAngeloff/php.vim'
Plugin 'lervag/vimtex'
Plugin 'ludovicchabant/vim-gutentags'
set runtimepath+=/home/vk/.local/share/nvim/plugged/indentLine/after
set runtimepath+=/home/vk/.config/nvim/vim-dcrpc
" end plugiiins

runtime basic.vim
runtime mapping.vim
runtime custom_commands.vim
runtime syntax.vim

" startscreen 🤔
let g:Startscreen_function = function('Draw_startscreen')

" set dark theme at night
if empty($NIGHTSTART)
    let $NIGHTSTART = 22
endif
if empty($DAYSTART)
    let $DAYSTART = 8
endif
if str2nr(strftime('%H')) < str2nr($DAYSTART) || str2nr(strftime('%H')) >= str2nr($NIGHTSTART)
    set background=dark
else
    set background=light
endif

" airline stuff
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.maxlinenr = ' ㏑'
let g:bufferline_echo = 0
let g:airline_theme='papercolor'
let g:airline_powerline_fonts = 1
let g:airline_section_c = '%<%f%{My_modified()} %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%'

" indentline
let g:indentLine_char = '▏'

" clever f/F/t/T
let g:clever_f_smart_case = 1

" vim markdown preview
"let vim_markdown_preview_toggle=3
let vim_markdown_preview_pandoc=1

"ale stuff
let g:airline#extensions#ale#enabled = 1
let g:ale_linters = {'rust': ['rls'], 'cpp': ['gcc']}
let g:ale_cpp_gcc_options = "-std=c++17"

" kms
if (!empty($HOMEPC))
    let g:dcrpc_autostart = 1
endif

let &makeprg='(cd build && make -j4)'

" sign-jk-motion
map ů <Plug>(signjk-j)
map § <Plug>(signjk-k)

" gutentags
let g:gutentags_generate_on_missing = 0
let g:gutentags_enabled = 0
let g:gutentags_define_advanced_commands = 1
autocmd FileType cpp GutentagsToggleEnabled
