" colors
let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default': {
  \       'transparent_background': 1,
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

colorscheme PaperColor
let g:airline_theme='papercolor'

" highlight git merge conflicts
highlight MergeConflict ctermbg=black ctermfg=red
autocmd ColorScheme PaperColor highlight MergeConflict ctermbg=black ctermfg=red
autocmd Syntax * syn match MergeConflict '\v^[<\|=|>]{7}([^=].+)?$'