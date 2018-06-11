#/bin/bash

dir=$(dirname "$0")

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$dir/lib
~/sirve/Ubuntu/bin/vim_dcrpc.exe
