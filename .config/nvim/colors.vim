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
highlight MergeConflict ctermbg=black ctermfg=red
augroup mergeConflict
    autocmd!
    autocmd ColorScheme PaperColor highlight MergeConflict ctermbg=black ctermfg=red
    autocmd Syntax * syn match MergeConflict '\v^[<\|=|>]{7}([^=].+)?$'
augroup END

augroup statusUnderline
    autocmd!
    autocmd ColorScheme PaperColor highlight StatusLineNC cterm=underline,reverse
    autocmd ColorScheme PaperColor highlight StatusLine cterm=underline,reverse,bold
augroup END

colorscheme PaperColor
