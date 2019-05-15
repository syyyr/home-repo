command! Trailing :call custom#CleanExtraSpaces()
nmap <A-t> :Trailing<cr>

" quick diff
let g:diff = 0
command! DiffToggle :call custom#DiffToggle()
" toggle unsaved changes diff
nnoremap <A-,> :DiffToggle<cr>

" remain in visual after shift
vmap <expr> > custom#ShiftAndKeepVisualSelection(">")
vmap <expr> < custom#ShiftAndKeepVisualSelection("<")

inoremap <silent> <TAB> <C-R>=custom#TabOrCompletion('f')<CR>
inoremap <silent> <S-TAB> <C-R>=custom#TabOrCompletion('b')<CR>


command! SumNumbers call custom#SumNumbers()

" end with :Q XD
command! -bang Q q<bang>
