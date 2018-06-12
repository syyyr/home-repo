let s:rpc_file = '/home/vk/sirve/Ubuntu/tmp/dcrpc'
let s:file_dir = expand('<sfile>:p:h')

func dcrpc#WriteTmp(timer)
    if (g:dcrpc_showline)
        call writefile(['㏑' . line('.') . '/' . line('$') . ': ' . expand('%:t'), 'The best editor on Earth.'], s:rpc_file)
    else
        call writefile([expand('%:t'), 'The best editor on Earth.'], s:rpc_file)
    endif
endfunc

func dcrpc#StartDcrpc()
    if !exists("g:dcrpc_showline")
        let g:dcrpc_showline = 1
    endif
    call system('bash ' . s:file_dir . '/../dcrpc.sh &')
    let s:dcrptimer = timer_start(5000, 'dcrpc#WriteTmp', {'repeat': -1})
endfunc

func dcrpc#StopDcrpc()
    call system('taskkill -f vim_dcrpc.exe')
    call timer_stop(s:dcrptimer)
endfunc
