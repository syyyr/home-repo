#!/bin/bash
set -euo pipefail
shopt -s failglob inherit_errexit

if ! [[ -v 1 ]]; then
    echo You have to specify an executable / a library as the first argument. >&2
    exit 1
fi

BINARY="$1"
shift

EXTRA_ARGS=("$@")

if [[ -v 2 ]]; then
    EXTRA_ARGS+=("$2")
fi

llvm-profdata merge -sparse default.profraw -o default.profdata
llvm-cov show --instr-profile=default.profdata "$BINARY" --format=html --Xdemangler=c++filt --ignore-filename-regex='3rdparty|autogen' "${EXTRA_ARGS[@]}"
