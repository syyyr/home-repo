local c_skeleton = vim.api.nvim_create_augroup('cSkeleton', {clear = true})
vim.api.nvim_create_autocmd('BufNewFile', {
	pattern = 'main.c,main.cpp',
    callback = function ()
		vim.cmd([[execute "normal! iint main(int argc, char* argv[])\n{\nreturn 0;\n}k==k" | call feedkeys('o')]])
    end,
    group = c_skeleton
})

local rs_skeleton = vim.api.nvim_create_augroup('rsSkeleton', {clear = true})
vim.api.nvim_create_autocmd('BufNewFile', {
	pattern = 'main.rs',
    callback = function ()
		vim.cmd([[execute "normal! ifn main()\n{\n}k" | call feedkeys('o')]])
    end,

    group = rs_skeleton
})
