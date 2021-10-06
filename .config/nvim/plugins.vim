scriptencoding utf8

packadd! i3config.vim
packadd! vim-colon-therapy
packadd! vim-pug
packadd! undotree
packadd! vim-better-whitespace
packadd! yang.vim
packadd! vim-commentary
packadd! vim-qml
packadd! vim-cpp-modern
packadd! readline.vim

packadd! indent-blankline.nvim
lua << EOF
require("indent_blankline").setup {
    char = '▏',
    buftype_exclude = {'tab', 'help'}
}
EOF

let g:no_default_tabular_maps = 1
packadd! tabular

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
command! CR CocRename
command! CS CocList symbols
nnoremap <silent> <c-space> :CocHover<cr>

packadd! vim-dispatch
let g:dispatch_no_maps = 1

" remove netrw banner
let g:netrw_banner = 0
