vim.cmd('packadd! bufdelete.nvim')
vim.cmd('packadd! cfilter')
vim.cmd('packadd fluent.vim')
vim.cmd('packadd! i3config.vim')
vim.cmd('packadd! inc-rename.nvim')
vim.cmd('packadd! readline.vim')
vim.cmd('packadd! undotree')
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

vim.cmd('packadd! blame.nvim')
require('blame').setup({
    date_format = "%Y/%m/%d %H:%M",
    merge_consecutive = false,
    virtual_style = "float"
})

vim.api.nvim_create_user_command('GT', 'BlameToggle virtual', {nargs = 0})

vim.cmd('packadd! git-blame.nvim')
require('gitblame').setup {
    enabled = false,
	highlight_group = 'Question',
	set_extmark_options = {hl_mode = 'combine'}
}

vim.api.nvim_create_user_command('GSHA', 'GitBlameCopySHA', {nargs = 0})
vim.api.nvim_create_user_command('GURL', 'GitBlameOpenCommitURL', {nargs = 0})

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
vim.filetype.get_option = function(filetype, option)
	return option == "commentstring"
		and require("ts_context_commentstring.internal").calculate_commentstring()
		or get_option(filetype, option)
end
