#/bin/bash

dir=$(dirname "$0")

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$dir/lib
~/sirve/Ubuntu/vim-dcrpc-master/build/vim_dcrpc_master.exe
