#!/bin/bash

print_var()
{
    local name="$1"
    echo "  $name='${!name}'"
}

CC="clang"
CXX="clang++"
LD="clang"
CFLAGS=""
CXXFLAGS=""
LDFLAGS=""
CMAKE_FLAGS=( '-DCMAKE_EXPORT_COMPILE_COMMANDS=ON' )
CACHE=1
BUILD_TYPE="Debug"

while true; do
    case "$1" in
        asan)
            echo "Enabling ASAN/UBSAN."
            CFLAGS="-O0 -fno-optimize-sibling-calls -fno-omit-frame-pointer -fsanitize=address,undefined ${CFLAGS}"
            CXXFLAGS="-O0 -fno-optimize-sibling-calls -fno-omit-frame-pointer -fsanitize=address,undefined ${CXXFLAGS}"
            LDFLAGS="-fsanitize=address,undefined ${LDFLAGS}"
            CMAKE_FLAGS=( -DCMAKE_POSITION_INDEPENDENT_CODE=ON "${CMAKE_FLAGS[@]}" )
            shift
            ;;
        msan)
            echo "Enabling MSAN."
            CFLAGS="-O0 -fno-optimize-sibling-calls -fno-omit-frame-pointer -fsanitize=memory -fsanitize-memory-track-origins=2 ${CFLAGS}"
            CXXFLAGS="-O0 -fno-optimize-sibling-calls -fno-omit-frame-pointer -fsanitize=memory -fsanitize-memory-track-origins=2 ${CXXFLAGS}"
            LDFLAGS="-fsanitize=memory ${LDFLAGS}"
            CMAKE_FLAGS=( -DCMAKE_POSITION_INDEPENDENT_CODE=ON "${CMAKE_FLAGS[@]}" )
            shift
            ;;
        gcc)
            echo "Enabling GCC."
            CC="gcc"
            CXX="g++"
            LD=""
            shift
            ;;
        time)
            echo "Enabling time trace."
            CFLAGS="-ftime-trace ${CXXFLAGS}"
            CXXFLAGS="-ftime-trace ${CXXFLAGS}"
            shift
            ;;
        templight)
            echo "Enabling templight."
            CXX="templight++"
            shift
            ;;
        cov)
            echo "Enabling code coverage."
            CFLAGS="-fprofile-instr-generate -fcoverage-mapping ${CFLAGS}"
            CXXFLAGS="-fprofile-instr-generate -fcoverage-mapping ${CXXFLAGS}"
            shift
            ;;
        no-cache)
            echo "Disabling ccache."
            CACHE=0
            shift
            ;;
        optimize)
            echo "Enabling optimizations."
            CFLAGS="-O2 ${CFLAGS}"
            CXXFLAGS="-O2 ${CXXFLAGS}"
            shift
            ;;
        release)
            echo "Enabling Release mode."
            BUILD_TYPE="Release"
            shift
            ;;
        release-di)
            echo "Enabling RelWithDebInfo mode."
            BUILD_TYPE="RelWithDebInfo"
            shift
            ;;
        werror)
            echo "Enabling Werror."
            CFLAGS="-Werror ${CFLAGS}"
            CXXFLAGS="-Werror ${CXXFLAGS}"
            shift
            ;;
        gcc-analyzer)
            echo "Enabling GCC static analyzer."
            CC="gcc"
            CXX="g++"
            LD=""
            CFLAGS="-fanalyzer ${CFLAGS}"
            CXXFLAGS="-fanalyzer ${CXXFLAGS}"
            shift
            ;;
        graph)
            echo "Enabling graphviz."
            CMAKE_FLAGS=( "--graphviz=deps.dot" "${CMAKE_FLAGS[@]}" )
            GRAPHVIZ=1
            shift
            ;;
        *)
            break
            ;;
    esac
done

if [[ $CACHE = 1 ]]; then
    CMAKE_FLAGS=( '-DCMAKE_C_COMPILER_LAUNCHER=ccache' '-DCMAKE_CXX_COMPILER_LAUNCHER=ccache' "${CMAKE_FLAGS[@]}" )
fi

CMAKE_FLAGS=( "-DCMAKE_BUILD_TYPE=$BUILD_TYPE" "${CMAKE_FLAGS[@]}" )

if [[ "${CXX}" = clang++ ]]; then
    CXXFLAGS="-ferror-limit=0 ${CXXFLAGS}"
fi

print_var CC
print_var CXX
print_var LD
print_var CFLAGS
print_var CXXFLAGS
print_var LDFLAGS

echo \
    CC=${CC} \
    CXX=${CXX} \
    LD="${LD}" \
    CFLAGS="${CFLAGS}" \
    CXXFLAGS="${CXXFLAGS}" \
    LDFLAGS="${LDFLAGS}" \
    cmake "${CMAKE_FLAGS[@]}" "$@"

CC=${CC} \
CXX=${CXX} \
LD=${LD} \
CFLAGS=${CFLAGS} \
CXXFLAGS=${CXXFLAGS} \
LDFLAGS=${LDFLAGS} \
cmake "${CMAKE_FLAGS[@]}" "$@"

if [[ $GRAPHVIZ = 1 ]]; then
    dot -Tpng deps.dot -o deps.png
    echo Dependency graph saved as deps.png.
fi
