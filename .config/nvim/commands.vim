command! Trailing :call custom#CleanExtraSpaces()
nnoremap <A-t> :Trailing<cr>

" quick diff
let g:diff = 0
command! DiffToggle :call custom#DiffToggle()
" toggle unsaved changes diff
nnoremap <A-,> :DiffToggle<cr>

command! SumNumbers call custom#SumNumbers()

" end with :Q XD
command! -bang Q q<bang>
command! -bang Qa qa<bang>

command! SynStack echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')

" show registers and prompt for a register name and a command
command! PutReg call custom#PutReg()

command! -nargs=1 SetMakePath set makeprg=make\ -C\ <args>
