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

function s:GetStatusLineColors()
    return &background ==# 'dark' ? 'guifg=#d0d0d0 guibg=#1c1c1c ctermfg=252 ctermbg=234' : 'guifg=#444444 guibg=#eeeeee ctermfg=255 ctermbg=238'
endfunction

" PaperColor overrides
augroup statusUnderline
    autocmd!
    autocmd ColorScheme PaperColor execute 'highlight StatusLineNC' s:GetStatusLineColors()  'cterm=underline gui=underline'
    autocmd ColorScheme PaperColor execute 'highlight StatusLine' s:GetStatusLineColors()  'cterm=underline,bold gui=underline,bold'
augroup END

" TODO: fix this the same way as StatusLine
augroup vertSplit
    autocmd!
    autocmd ColorScheme PaperColor highlight VertSplit guifg=#eeeeee guibg=#444444 ctermfg=255 ctermfg=238
augroup END

augroup endOfBuffer
    autocmd!
    autocmd ColorScheme PaperColor execute 'highlight clear EndOfBuffer | highlight link EndOfBuffer NonText'
augroup END

" highlight git merge conflicts
augroup mergeConflict
    autocmd!
    autocmd ColorScheme PaperColor highlight MergeConflict ctermbg=black ctermfg=red guibg=black guifg=red
    autocmd Syntax * syn match MergeConflict '\v^[<\|=|>]{7}([^=].+)?$'
augroup END

augroup cocHighlightColor
    autocmd!
    autocmd ColorScheme PaperColor if &background ==# 'light' | highlight CocHighlightText ctermbg=230 guibg=230 | else | highlight CocHighlightText ctermbg=23 guibg=23 | endif
augroup END

augroup todoColor
    autocmd!
    autocmd ColorScheme PaperColor hi Todo cterm=bold ctermfg=0 ctermbg=11 gui=bold guifg=#00af5f guibg=default
augroup END

colorscheme PaperColor
