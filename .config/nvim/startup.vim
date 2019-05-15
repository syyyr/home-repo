" set dark theme at night
if empty($NIGHTSTART)
    let $NIGHTSTART = 22
endif
if empty($DAYSTART)
    let $DAYSTART = 8
endif
if str2nr(strftime('%H')) < str2nr($DAYSTART) || str2nr(strftime('%H')) >= str2nr($NIGHTSTART)
    set background=dark
else
    set background=light
endif

" return to last position in file
augroup lastPostion
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END
