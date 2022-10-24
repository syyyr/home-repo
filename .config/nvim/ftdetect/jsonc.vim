augroup jsoncDetection
    autocmd BufRead,BufNewFile tsconfig.json set filetype=jsonc
    autocmd BufNewFile,BufRead *.cjson setlocal filetype=jsonc
augroup END
