scriptencoding utf8
function! custom#CleanExtraSpaces() abort
    let save_cursor = getpos('.')
    let old_query = getreg('/')
    " this is a warning workaround, apparently :substitute isn't safe, but I don't care
    execute 'silent! %s/\s\+$//e'
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

function! custom#DiffToggle() abort
    if !g:diff
        let g:diff = 1
        execute &diffopt =~# 'horizontal' ? '' : 'vert' 'new | f scratch | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis'
    else
        let g:diff = 0
        execute 'bdelete scratch'
        set wrap
    endif
endfun

" custom function for the modified sign (doesn't show anything on startscreen)
function! custom#MyModified() abort
    if !&modifiable && expand('%') !=# 'VIM'
        return '[-]'
    endif
    if &modified
        return '[+]'
    endif
    return ''
endfun

function! custom#SumNumbers() abort
    normal! mm
    let l:old=@a
    let @a=''
    g/\d\+$/normal! "AygnA+"Aylx
    normal! `mi=a+0
    let @a=l:old
endfunction

function! s:ParseWsGrep(id, data, event) abort
    " By directly accessing the first line of the output, I can save a call to
    " join(). This shouldn't be a problem, as the job output is buffered.
    let b:TrailingNr = substitute(a:data[0], '\d\+\zs.*$', '', '')
endfunction

function! custom#TrailingWsCheck() abort
    let s:id = jobstart(['grep', '-n', '-m', '1', '\s$'], {'on_stdout': function('s:ParseWsGrep'), 'stdout_buffered': 1 })
    call chansend(s:id, getline(1, '$'))
    call chanclose(s:id, 'stdin')
endfun

function! custom#CocCheck(id) abort
    let l:info = CocAction('diagnosticList')
    if len(l:info)
        let l:first = l:info[0]
        if l:first['file'] ==# expand('%:p')
            if l:first['severity'] ==# 'Error'
                let b:CocInfo = 'E: ln ' . l:first['lnum']
            elseif l:first['severity'] ==# 'Warning'
                let b:CocInfo = 'W: ln ' . l:first['lnum']
            endif
        endif
    else
        let b:CocInfo = ''
    endif
endfun

function! custom#StatuslineDiagnostics() abort
    " ALE integration
    let l:problem = ale#statusline#FirstProblem(bufnr('%'), 'error')
    if l:problem != {}
        return l:problem['type'] . ': ln ' . problem['lnum']
    endif

    let l:problem = ale#statusline#FirstProblem(bufnr('%'), 'warning')
    if l:problem != {}
        return l:problem['type'] . ': ln ' . problem['lnum']
    endif

    " coc.nvim integration
    if get(b:, 'CocInfo', 0) !=# ''
        return b:CocInfo
    endif

    if get(b:, 'TrailingNr', 0) && mode() !=? 'i'
        return 'WS: ln ' . b:TrailingNr
    endif

    return ''
endfun

function! custom#PutReg() abort
    registers
    let l:register = input(':normal! "')
    execute 'normal! "' . l:register
endfun

function! custom#FirenvimOneline() abort
    set laststatus=0
    nnoremap <esc> :wq<cr>
    inoremap <cr> <esc>:wq<cr>
    nnoremap <cr> <esc>:wq<cr>
    startinsert
endfun
