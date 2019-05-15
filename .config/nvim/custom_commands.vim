" extra trailing ws delete
function! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun
command! Trailing :call CleanExtraSpaces()
nmap <A-t> :Trailing<cr>

" quick diff
let g:diff = 0
function! DiffToggle()
    if !g:diff
        let g:diff = 1
        execute &diffopt =~# "horizontal" ? "" : "vert" "new | f scratch | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis"
    else
        let g:diff = 0
        execute "bdelete scratch"
        set wrap
    endif
endfun
command! DiffToggle :call DiffToggle()
" toggle unsaved changes diff
nnoremap <A-,> :DiffToggle<cr>

" custom function for the modified sign (doesn't show anything on startscreen)
function! My_modified()
    if !&modifiable && expand('%') != 'VIM'
        return  '[-]'
    endif
    if &mod
        return '[+]'
    endif
    return ''
endfun

" startscreen_function
function! Draw_startscreen()
    setlocal foldmethod=manual
    IndentLinesDisable
    file VIM
    let random = system('echo $(($RANDOM % 5))')
    if random == 0
        silent! read ~/.local/share/thinking_alt.txt
    else
        silent! read ~/.local/share/thinking.txt
    endif
endfun

" remain in visual after shift
function! ShiftAndKeepVisualSelection(cmd)
    set nosmartindent
    if mode() =~ '[Vv]'
        return a:cmd . ":set smartindent\<CR>gv"
    else
        return a:cmd . ":set smartindent\<CR>"
    endif
endfunction
vmap <expr> > ShiftAndKeepVisualSelection(">")
vmap <expr> < ShiftAndKeepVisualSelection("<")

" insert mode TAB completion
function! TabOrCompletion(direction)
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<TAB>"
    else
        if pumvisible() " when menu is visible, I don't want to select the 1st match
            return "\<C-E>\<C-N>"
        endif
        if a:direction == 'f'
            return "\<C-N>"
        else
            return "\<C-P>"
        endif
    endif
endfunction
inoremap <silent> <TAB> <C-R>=TabOrCompletion('f')<CR>
inoremap <silent> <S-TAB> <C-R>=TabOrCompletion('b')<CR>


function! SumNumbers()
    normal! mm
    let l:old=@a
    let @a=''
    g/\d\+$/normal! "AygnA+"Aylx
    normal! `mi=a+0
    let @a=l:old
endfunction
command SumNumbers call SumNumbers()


" end with :Q XD
command -bang Q q<bang>

" custom function to get current syn group
function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun
