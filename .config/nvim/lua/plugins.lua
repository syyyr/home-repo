vim.cmd('packadd! bufdelete.nvim')
vim.cmd('packadd! cfilter')
vim.cmd('packadd! inc-rename.nvim')
vim.cmd('packadd! readline.vim')
vim.cmd('packadd! vim-better-whitespace')
vim.cmd('packadd! vim-colon-therapy')
vim.cmd('packadd! vim-icalendar')
vim.cmd('packadd vim-kitty')
vim.cmd('packadd! vim-pug')
vim.cmd('packadd! yang.vim')

vim.cmd('packadd! nvim-dap')
require('inc_rename').setup({
    cmd_name = 'CR'
})

vim.cmd('packadd! indent-blankline.nvim')
require('ibl').setup({
    scope = {
        enabled = false
    },
    indent = {
        char = '▏',
    },
    exclude = {
        buftypes = {'tab', 'help'}
    }
})

vim.api.nvim_create_user_command('GT', function ()
    vim.g.gitblame_enabled = 0
    vim.cmd('packadd! blame.nvim')
    require('blame').setup({
        date_format = "%Y/%m/%d %H:%M",
        merge_consecutive = false,
        virtual_style = "float"
    })
    vim.cmd('BlameToggle virtual')
end, {nargs = 0})

local ll = require('syyyr').lazy_load
vim.api.nvim_create_user_command('GSHA', ll('git-blame.nvim', 'GitBlameCopySHA'), {nargs = 0})
vim.api.nvim_create_user_command('GURL', ll('git-blame.nvim', 'GitBlameOpenCommitURL'), {nargs = 0})

vim.cmd('packadd vimtex')
vim.g.vimtex_compiler_latexmk = {build_dir = 'build'}
vim.g.tex_conceal = 'amgs' -- default but don't conceal delimiters

vim.cmd('packadd! vim-linux-coding-style')
vim.g.linuxsty_patterns = {'/linux/'}

vim.cmd('packadd! clever-f.vim')
vim.g.clever_f_smart_case = 1

vim.cmd('packadd! vim-dispatch')
vim.g.dispatch_no_maps = 1

vim.cmd('packadd! guess-indent.nvim')
require('guess-indent').setup({})

vim.cmd('packadd! nvim-ts-context-commentstring')
require('ts_context_commentstring').setup {
  enable_autocmd = false,
}

local get_option = vim.filetype.get_option
---@diagnostic disable-next-line: duplicate-set-field
vim.filetype.get_option = function(filetype, option)
    return option == "commentstring"
        and require("ts_context_commentstring.internal").calculate_commentstring()
        or get_option(filetype, option)
end
