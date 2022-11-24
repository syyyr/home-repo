local skeletons = vim.api.nvim_create_augroup('Skeletons', {clear = true})
vim.api.nvim_create_autocmd('BufNewFile', {
	pattern = 'main.c,main.cpp',
    callback = function()
		vim.cmd([[execute "normal! iint main(int argc, char* argv[])\n{\nreturn 0;\n}k==k"]])
		vim.fn.feedkeys('o')
    end,
    group = skeletons
})

vim.api.nvim_create_autocmd('BufNewFile', {
	pattern = 'main.rs',
    callback = function()
		vim.cmd([[execute "normal! ifn main()\n{\n}k"]])
		vim.fn.feedkeys('o')
    end,
    group = skeletons
})
