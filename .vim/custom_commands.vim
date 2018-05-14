" :W sudo save
command Sudow w !sudo tee % > /dev/null

" extra trailing ws delete
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun
command Trailing :call CleanExtraSpaces()
nmap <ESC>t :Trailing<cr>

" quick diff
let g:diff = 0
fun! DiffToggle()
    if !g:diff
        let g:diff = 1
        execute "vert new | f scratch | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis"
    else
        let g:diff = 0
        execute "bdelete scratch"
    endif
endfun
command DiffToggle :call DiffToggle()
map <ESC>, :DiffToggle<cr>

" like %m but leaveout the startscreen
fun! My_modified()
    if !&modifiable && expand('%') != 'VIM'
        return  '[-]'
    endif
    if &mod
        return '[+]'
    endif
    return ''
endfun

" startscreen_function
fun! Draw_startscreen()
    setlocal foldmethod=manual
    execute 'IndentLinesDisable'
    file VIM
    silent! read ~/.local/share/thinking.txt
    echo
endfun

" remain in visual after shift
function! ShiftAndKeepVisualSelection(cmd, mode)
    set nosmartindent
    if mode() =~ '[Vv]'
        return a:cmd . ":set smartindent\<CR>gv"
    else
        return a:cmd . ":set smartindent\<CR>"
    endif
endfunction
