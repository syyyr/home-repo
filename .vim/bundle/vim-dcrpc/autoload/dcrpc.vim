let s:rpc_file = '/home/vk/sirve/Ubuntu/tmp/dcrpc'
let s:file_dir = expand('<sfile>:p:h')

func dcrpc#WriteTmp(timer)
    call writefile(['Line ' . line('.') . ' of ' . line('$'), 'Editing ' . expand('%:t')], s:rpc_file)
endfunc

func dcrpc#StartDcrpc()
    call system('bash ' . s:file_dir . '/../dcrpc.sh &')
    let s:dcrptimer = timer_start(5000, 'dcrpc#WriteTmp', {'repeat': -1})
endfunc

func dcrpc#StopDcrpc()
    call system('taskkill -f vim_dcrpc.exe')
    call timer_stop(s:dcrptimer)
endfunc
