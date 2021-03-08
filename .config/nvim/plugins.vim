scriptencoding utf8

packadd! i3config.vim
packadd! vim-colon-therapy
packadd! vim-pug
packadd! vim-cmake-completion
packadd! tabular
packadd! vim-superman
packadd! undotree
packadd! vim-better-whitespace
packadd! yang.vim
packadd! vim-commentary
packadd! vim-qml

packadd! indentLine
packadd! indent-blankline.nvim
let g:indentLine_char = '▏'
let g:indentLine_fileTypeExclude = ['tab', 'help']
let g:indent_blankline_debug = v:true

let g:linuxsty_patterns = ['/linux/']
packadd! vim-linux-coding-style

packadd! clever-f.vim
let g:clever_f_smart_case = 1

packadd! goyo.vim
augroup goyoFix
    autocmd!
    autocmd User GoyoEnter nested set eventignore=FocusGained
    autocmd User GoyoLeave nested set eventignore=
augroup END

packadd! vimtex
let g:vimtex_compiler_latexmk = {'build_dir': 'build'}
let g:tex_conceal = 'amgs' " default but don't conceal delimiters

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
command! CF CocFix
nnoremap <silent> <c-space> :CocHover<cr>

packadd! vim-dispatch
let g:dispatch_no_maps = 1

" remove netrw banner
let g:netrw_banner = 0
