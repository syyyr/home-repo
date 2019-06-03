scriptencoding utf8
" plugiiins
if argc() == 0
    packadd! startscreen.vim
    let g:Startscreen_function = function('custom#DrawStartscreen')
endif

packadd! indentLine
let g:indentLine_char = '▏'

packadd! tabular
packadd! vim-superman
packadd! undotree
packadd! vim-better-whitespace

packadd! clever-f.vim
let g:clever_f_smart_case = 1

call zen#init()
Plugin 'rust-lang/rust.vim'
Plugin 'vim-scripts/HJKL'
Plugin 'w0rp/ale'
Plugin 'nathanalderson/yang.vim'
Plugin 'junegunn/goyo.vim'
Plugin 'StanAngeloff/php.vim'
Plugin 'lervag/vimtex'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'tpope/vim-commentary'
Plugin 'neoclide/coc.nvim'
Plugin 'tpope/vim-dispatch'
Plugin 'sakhnik/nvim-gdb'
Plugin 'leafgarland/typescript-vim'
" end plugiiins

"ale stuff
let g:ale_linters = {'rust': ['rls'], 'cpp': [], 'typescript': [], 'c': []}
let g:ale_c_parse_compile_commands = 1
" this is still needed for header files
let g:ale_cpp_gcc_options = '-std=c++17 -I src'
let g:ale_tex_chktex_options = '-l .chktexrc'

" gutentags
let g:gutentags_exclude_project_root = ['/home/vk']
let g:gutentags_generate_on_missing = 0
let g:gutentags_generate_on_new = 0
let g:gutentags_enabled = 0
let g:gutentags_define_advanced_commands = 1
augroup gutentags
    autocmd!
    autocmd FileType cpp let g:gutentags_enabled = 1
augroup END

" goyo
augroup GoyoFix
    autocmd!
    autocmd User GoyoEnter nested set eventignore=FocusGained
    autocmd User GoyoLeave nested set eventignore=
augroup END

" tex
let g:tex_conceal = 'amgs' " default but don't conceal delimiters
let g:vimtex_compiler_latexmk = {'build_dir': 'build'}

" dispatch
let g:dispatch_no_maps = 1

" coc.nvim
let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'
inoremap <silent><expr> <c-space> coc#refresh()
augroup cocHighlight
    autocmd!
    autocmd CursorHold * silent call CocActionAsync('highlight')
augroup END
command! CocDefinition call CocActionAsync('jumpDefinition')
command! CocDeclaration call CocActionAsync('jumpDeclaration')
command! CocReferences call CocActionAsync('jumpReferences')

" remove netrw banner
let g:netrw_banner = 0
