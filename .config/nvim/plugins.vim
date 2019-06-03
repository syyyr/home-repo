scriptencoding utf8

packadd! tabular
packadd! vim-superman
packadd! undotree
packadd! vim-better-whitespace
packadd! rust.vim
packadd! HJKL
packadd! yang.vim
packadd! php.vim
packadd! nvim-gdb
packadd! typescript-vim
packadd! vim-commentary

if argc() == 0
    packadd! startscreen.vim
    let g:Startscreen_function = function('custom#DrawStartscreen')
endif

packadd! indentLine
let g:indentLine_char = '▏'

packadd! clever-f.vim
let g:clever_f_smart_case = 1

packadd! ale
let g:ale_linters = {'rust': ['rls'], 'cpp': [], 'typescript': [], 'c': []}
let g:ale_c_parse_compile_commands = 1
" this is still needed for header files
let g:ale_cpp_gcc_options = '-std=c++17 -I src'
let g:ale_tex_chktex_options = '-l .chktexrc'

packadd! goyo.vim
augroup goyoFix
    autocmd!
    autocmd User GoyoEnter nested set eventignore=FocusGained
    autocmd User GoyoLeave nested set eventignore=
augroup END

packadd! vimtex
let g:vimtex_compiler_latexmk = {'build_dir': 'build'}
let g:tex_conceal = 'amgs' " default but don't conceal delimiters

packadd! vim-gutentags
let g:gutentags_exclude_project_root = ['/home/vk']
let g:gutentags_generate_on_missing = 0
let g:gutentags_generate_on_new = 0
let g:gutentags_enabled = 0
let g:gutentags_define_advanced_commands = 1
augroup gutentags
    autocmd!
    autocmd FileType cpp let g:gutentags_enabled = 1
augroup END

packadd! coc.nvim
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

packadd! vim-dispatch
let g:dispatch_no_maps = 1

" remove netrw banner
let g:netrw_banner = 0
