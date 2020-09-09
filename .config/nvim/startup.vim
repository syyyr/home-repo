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

augroup statuslineIntegration
    autocmd!
    autocmd BufReadPost,TextChanged,InsertLeave * call custom#TrailingWsCheck()
    autocmd BufReadPost,TextChanged,InsertLeave * call timer_start(1000, 'custom#CocCheck', {'repeat': 0})
augroup END

let g:tex_flavor='tex'
let g:is_bash=1
