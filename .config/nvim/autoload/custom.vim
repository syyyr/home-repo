scriptencoding utf8
function! custom#CleanExtraSpaces() abort
    let save_cursor = getpos('.')
    let old_query = getreg('/')
    " this is a warning workaround, apparently :substitute isn't safe, but I don't care
    execute 'silent! %s/\s\+$//e'
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

function! custom#CleanScreen() abort
    call clever_f#reset()
    " Clears vim lsp floating window. I need to use C-Space thrice here for some reason, otherwise it actually opens a
    " floating windows if none is present
    execute "normal \<C-Space>\<C-Space>\<C-Space>q"
endfun
