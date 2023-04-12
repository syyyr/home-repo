vim.cmd('packadd! cfilter')
vim.cmd('packadd! i3config.vim')
vim.cmd('packadd! inc-rename.nvim')
vim.cmd('packadd! readline.vim')
vim.cmd('packadd! undotree')
vim.cmd('packadd! vim-better-whitespace')
vim.cmd('packadd! vim-colon-therapy')
vim.cmd('packadd! vim-commentary')
vim.cmd('packadd! vim-cpp-modern')
vim.cmd('packadd! vim-icalendar')
vim.cmd('packadd vim-kitty')
vim.cmd('packadd! vim-pug')
vim.cmd('packadd! vim-qml')
vim.cmd('packadd! yang.vim')

require('inc_rename').setup({
    cmd_name = 'CR'
})

vim.cmd('packadd! indent-blankline.nvim')
require('indent_blankline').setup({
    char = '▏',
    buftype_exclude = {'tab', 'help'}
})

vim.cmd('packadd! git-blame.nvim')
vim.g.gitblame_enabled = 0
vim.g.gitblame_highlight_group = 'Question'
vim.g.gitblame_set_extmark_options = {hl_mode = 'combine'}

vim.api.nvim_create_user_command('GT', 'GitBlameToggle', {nargs = 0})
vim.api.nvim_create_user_command('GSHA', 'GitBlameCopySHA', {nargs = 0})
vim.api.nvim_create_user_command('GURL', 'GitBlameOpenCommitURL', {nargs = 0})

vim.cmd('packadd vimtex')
vim.g.vimtex_compiler_latexmk = {build_dir = 'build'}
vim.g.tex_conceal = 'amgs' -- default but don't conceal delimiters

-- FIXME: tabstop gets overriden by the autocommand in startup.vim
vim.cmd('packadd! vim-linux-coding-style')
vim.g.linuxsty_patterns = {'/linux/'}

vim.cmd('packadd! clever-f.vim')
vim.g.clever_f_smart_case = 1

vim.cmd('packadd! vim-dispatch')
vim.g.dispatch_no_maps = 1

vim.cmd('packadd! guess-indent.nvim')
require('guess-indent').setup({})
