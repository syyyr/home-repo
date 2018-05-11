" pathogen blya
execute pathogen#infect()

source ~/.vim/basic.vim
source ~/.vim/mapping.vim
source ~/.vim/custom_commands.vim
source ~/.vim/syntax.vim

" startscreen 🤔
let g:Startscreen_function = function('Draw_startscreen')

" set dark theme at night
if empty($NIGHTSTART)
    let $NIGHTSTART = 23
endif
if empty($DAYSTART)
    let $NIGHTSTART = 8
endif
if str2nr(strftime('%H')) < str2nr($DAYSTART) || str2nr(strftime('%H')) > str2nr($NIGHTSTART)
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

" indent guides
"let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

" indentline
let g:indentLine_char = '▏'

" comfortable motion
let g:comfortable_motion_no_default_key_mappings = 1
let g:comfortable_motion_friction = 800.0
let g:comfortable_motion_air_drag = 0.0
let g:indentLine_setColors = 0

" clever f/F/t/T
let g:clever_f_smart_case = 1

" scratch
let g:scratch_disable = 0

