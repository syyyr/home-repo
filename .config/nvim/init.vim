" pathogen blya
execute pathogen#infect()
Helptags

runtime basic.vim
runtime mapping.vim
runtime custom_commands.vim
runtime syntax.vim

" startscreen 🤔
let g:Startscreen_function = function('Draw_startscreen')

" set dark theme at night
if empty($NIGHTSTART)
    let $NIGHTSTART = 22
endif
if empty($DAYSTART)
    let $DAYSTART = 8
endif
if str2nr(strftime('%H')) < str2nr($DAYSTART) || str2nr(strftime('%H')) >= str2nr($NIGHTSTART)
    set background=dark
endif

" airline stuff
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.maxlinenr = ' ㏑'
let g:bufferline_echo = 0
let g:airline_theme='papercolor'
let g:airline_powerline_fonts = 1
let g:airline_section_c = '%<%f%{My_modified()} %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%'

" indentline
let g:indentLine_char = '▏'

" clever f/F/t/T
let g:clever_f_smart_case = 1

" vim markdown preview
let vim_markdown_preview_toggle=3
let vim_markdown_preview_pandoc=1

"ale stuff
let g:airline#extensions#ale#enabled = 1
let g:ale_linters = {'rust': ['rls'], 'cpp': ['gcc']}

" kms
if (!empty($HOMEPC))
    let g:dcrpc_autostart = 1
endif

let &makeprg='(cd build && make)'
