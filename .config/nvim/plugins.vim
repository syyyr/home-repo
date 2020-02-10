scriptencoding utf8

" I won't load plugins for firenvim to speed up launch
" TODO: check which plugins I could load
if get(g:, 'is_headless')
    packadd! firenvim
    finish
endif

packadd! vim-pug
packadd! vim-cmake-completion
packadd! tabular
packadd! vim-superman
packadd! undotree
packadd! vim-better-whitespace
packadd! yang.vim
packadd! nvim-gdb
packadd! vim-commentary

if argc() == 0
    packadd! startscreen.vim
    let g:Startscreen_function = function('setbufvar', [0, '&filetype', 'startscreen'])
endif

packadd! indentLine
let g:indentLine_char = '▏'

packadd! clever-f.vim
let g:clever_f_smart_case = 1

packadd! ale
let g:ale_linters = {'python': [], 'rust': [], 'cpp': [], 'javascript': [], 'typescript': [], 'c': [], 'vim': [], 'sh': []}
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
command! CocHover call CocActionAsync('doHover')
command! CocRename call CocActionAsync('rename')
nnoremap <silent> <c-space> :CocHover<cr>

packadd! vim-dispatch
let g:dispatch_no_maps = 1

" remove netrw banner
let g:netrw_banner = 0
