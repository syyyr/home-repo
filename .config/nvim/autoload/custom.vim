function! custom#CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

function! custom#DiffToggle()
    if !g:diff
        let g:diff = 1
        execute &diffopt =~# "horizontal" ? "" : "vert" "new | f scratch | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis"
    else
        let g:diff = 0
        execute "bdelete scratch"
        set wrap
    endif
endfun

" custom function for the modified sign (doesn't show anything on startscreen)
function! custom#MyModified()
    if !&modifiable && expand('%') != 'VIM'
        return  '[-]'
    endif
    if &mod
        return '[+]'
    endif
    return ''
endfun

" startscreen_function
function! custom#DrawStartscreen()
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

function! custom#ShiftAndKeepVisualSelection(cmd)
    set nosmartindent
    if mode() =~ '[Vv]'
        return a:cmd . ":set smartindent\<CR>gv"
    else
        return a:cmd . ":set smartindent\<CR>"
    endif
endfunction

" insert mode TAB completion
function! custom#TabOrCompletion(direction)
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

function! custom#SumNumbers()
    normal! mm
    let l:old=@a
    let @a=''
    g/\d\+$/normal! "AygnA+"Aylx
    normal! `mi=a+0
    let @a=l:old
endfunction

" custom function to get current syn group
function! custom#SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun

function! custom#AleIntegration()
    let l:problem = ale#statusline#FirstProblem(bufnr('%'), 'error')
    if l:problem != {}
        return l:problem['type'] . ': ln ' . problem['lnum']
    endif

    " check whitespace if ALE doesn't find anything
    let l:ws = search('\s$', 'nwc')
    if l:ws
        return 'WS: ' . l:ws
    endif

    return ''
endfun
