#!/bin/bash
set -euo pipefail
shopt -s inherit_errexit

llvm-profdata merge -sparse default.profraw -o default.profdata
llvm-cov show --instr-profile=default.profdata "$1" --format=html --ignore-filename-regex='3rdparty|autogen'

