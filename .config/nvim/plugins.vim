scriptencoding utf8

packadd! nvim-lspconfig
lua << EOF
local on_attach = function(client, bufnr)
    vim.keymap.set('n', '<C-Space>', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<C-]>', vim.lsp.buf.definition, bufopts)
end
require('lspconfig').clangd.setup{
    on_attach = on_attach
}

EOF


let g:gitblame_enabled = 0
let g:gitblame_highlight_group = "Question"
let g:gitblame_set_extmark_options = {
            \ 'hl_mode': 'combine',
            \ }
packadd! git-blame.nvim
command! GT GitBlameToggle
command! GSHA GitBlameCopySHA

packadd! i3config.vim
packadd! vim-colon-therapy
packadd! vim-pug
packadd! undotree
packadd! vim-better-whitespace
packadd! yang.vim
packadd! vim-commentary
packadd! vim-qml
packadd! vim-cpp-modern
packadd! readline.vim
packadd! vim-icalendar
packadd! nvim-treesitter
packadd! nvim-treesitter-playground

lua << EOF
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.cpon = {
  install_info = {
    url = "~/git/tree-sitter-cpon", -- local path or git repo
    files = {"src/parser.c"},
    -- optional entries:
    generate_requires_npm = false, -- if stand-alone parser without npm dependencies
    requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
  }
}
require'nvim-treesitter.configs'.setup {
    -- Modules and its options go here
    highlight = {
        enable = true,
        disable = { "cpp" },
    },
    incremental_selection = { enable = true },
    textobjects = { enable = true },
}
EOF

" FIXME: Why can't this be in ftplugin/tex.vim?
let g:vimtex_compiler_latexmk = {'build_dir': 'build'}
let g:tex_conceal = 'amgs' " default but don't conceal delimiters
packadd vimtex

packadd! indent-blankline.nvim
lua << EOF
require("indent_blankline").setup {
    char = '▏',
    buftype_exclude = {'tab', 'help'}
}
EOF

let g:no_default_tabular_maps = 1
packadd! tabular

let g:linuxsty_patterns = ['/linux/']
packadd! vim-linux-coding-style

packadd! clever-f.vim
let g:clever_f_smart_case = 1

packadd! goyo.vim
augroup goyoFix
    autocmd!
    autocmd User GoyoEnter nested set eventignore=FocusGained
    autocmd User GoyoLeave nested set eventignore=
augroup END

" packadd! coc.nvim
" let g:coc_snippet_next = '<Tab>'
" let g:coc_snippet_prev = '<S-Tab>'
" inoremap <silent><expr> <c-space> coc#refresh()
" augroup cocHighlight
"     autocmd!
"     autocmd CursorHold * silent call CocActionAsync('highlight')
" augroup END
" command! CocDefinition call CocActionAsync('jumpDefinition')
" command! CocDeclaration call CocActionAsync('jumpDeclaration')
" command! CocReferences call CocActionAsync('jumpReferences')
" command! CocHover call CocActionAsync('doHover')
" command! CocRename call CocActionAsync('rename')
" command! CocFix call CocActionAsync('codeAction', 'line')
" command! CF CocFix
" command! CR CocRename
" command! CS CocList symbols
" nnoremap <silent> <c-space> :CocHover<cr>
" inoremap <expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"
" inoremap <expr> <C-n> coc#pum#visible() ? coc#pum#next(v:true) : "\<C-n>"
" inoremap <expr> <C-p> coc#pum#visible() ? coc#pum#prev(v:true) : "\<C-R>0"

packadd! vim-dispatch
let g:dispatch_no_maps = 1

" remove netrw banner
let g:netrw_banner = 0
