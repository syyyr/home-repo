let s:rpc_file = '/home/vk/sirve/Ubuntu/tmp/dcrpc'

autocmd VimLeave * call system('rm -f ' . s:rpc_file)
autocmd VimLeave * call system('taskkill -f vim_dcrpc.exe &')

command! StartDcrpc :call dcrpc#StartDcrpc()
command! StopDcrpc :call dcrpc#StopDcrpc()

if exists("g:dcrpc_autostart")
    if g:dcrpc_autostart == 1
        StartDcrpc
    endif
endif
