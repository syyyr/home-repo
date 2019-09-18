set termguicolors

" colors
let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default': {
  \       'transparent_background': 0,
  \       'allow_bold': 1,
  \       'allow_italic': 1,
  \     },
  \   },
  \   'language': {
  \     'cpp': {
  \       'highlight_standard_library': 1,
  \     },
  \   },
  \ }

" highlight git merge conflicts
augroup mergeConflict
    autocmd!
    autocmd ColorScheme PaperColor highlight MergeConflict ctermbg=black ctermfg=red
    autocmd Syntax * syn match MergeConflict '\v^[<\|=|>]{7}([^=].+)?$'
augroup END

augroup statusUnderline
    autocmd!
    autocmd ColorScheme PaperColor highlight StatusLineNC cterm=underline,reverse gui=underline,reverse
    autocmd ColorScheme PaperColor highlight StatusLine cterm=underline,reverse,bold gui=underline,reverse,bold
augroup END

augroup cocHighlightColor
    autocmd!
    autocmd ColorScheme PaperColor if &background ==# 'light' | highlight CocHighlightText ctermbg=230 guibg=230 | else | highlight CocHighlightText ctermbg=23 guibg=23 | endif
augroup END

colorscheme PaperColor
