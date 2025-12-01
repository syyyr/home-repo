#!/bin/bash
set -euo pipefail
shopt -s failglob inherit_errexit

BASH_COLOR_BOLD=$'\033''[1m'
BASH_COLOR_NORMAL=$'\033''[0m'
BASH_COLOR_RED=$'\033''[31m'
BASH_COLOR_BLUE=$'\033''[34m'

print_var()
{
    local name="$1"
    declare -n contents="$name"
    if [[ "$(declare -p "$name")" =~ "declare -a" ]]; then
        echo "  $name=(" "${contents[@]@Q}" ")"
    else
        echo "  $name=${contents@Q}"
    fi
}

CACHE=1
GRAPHVIZ=0
MOLD=1
LTO=1
CLANG=1
CFLAGS="${CFLAGS:-}"
CXXFLAGS="${CXXFLAGS:-}"
LDFLAGS="${LDFLAGS:-}"
CMAKE_FLAGS=( '-DCMAKE_EXPORT_COMPILE_COMMANDS=ON' )
BUILD_TYPE="Debug"
CMAKE="cmake"

if ! [[ "$(basename "$(pwd)")" =~ ^build ]]; then
    echo -n "${BASH_COLOR_BLUE}${BASH_COLOR_BOLD}You are building in a directory called '$(pwd)', which doesn't look like a build directory. Is that okay? [y/n] ${BASH_COLOR_NORMAL}"
    if ! read -r -t 10; then
        echo
        echo 'No reply. Aborting just to be safe.'
        exit 1
    fi
    if [[ "$REPLY" != "y" ]]; then
        echo 'Aborting.'
        exit 1
    fi
fi

for arg in "$@"; do
    case "$arg" in
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
            CFLAGS="-O0 -fno-optimize-sibling-calls -fno-omit-frame-pointer -fsanitize=memory -fsanitize-recover=memory -fsanitize-memory-track-origins=2 ${CFLAGS}"
            CXXFLAGS="-O0 -fno-optimize-sibling-calls -fno-omit-frame-pointer -fsanitize=memory -fsanitize-recover=memory -fsanitize-memory-track-origins=2 -stdlib=libc++ ${CXXFLAGS}"
            LDFLAGS="-fsanitize=memory -fsanitize-recover=memory -stdlib=libc++ ${LDFLAGS}"
            CMAKE_FLAGS=( -DCMAKE_POSITION_INDEPENDENT_CODE=ON "${CMAKE_FLAGS[@]}" )
            shift
            ;;
        tsan)
            echo "Enabling TSAN."
            CFLAGS="-O0 -fno-optimize-sibling-calls -fno-omit-frame-pointer -fsanitize=thread ${CFLAGS}"
            CXXFLAGS="-O0 -fno-optimize-sibling-calls -fno-omit-frame-pointer -fsanitize=thread ${CXXFLAGS}"
            LDFLAGS="-fsanitize=thread ${LDFLAGS}"
            CMAKE_FLAGS=( -DCMAKE_POSITION_INDEPENDENT_CODE=ON "${CMAKE_FLAGS[@]}" )
            shift
            ;;
        assertions)
            CFLAGS="-D_FORTIFY_SOURCE=3 $CFLAGS"
            CXXFLAGS="-D_GLIBCXX_ASSERTIONS=1 -D_FORTIFY_SOURCE=3 $CXXFLAGS"
            shift
            ;;
        gcc)
            echo "Enabling GCC."
            CLANG=0
            shift
            ;;
        time)
            echo "Enabling time trace."
            CFLAGS="-ftime-trace ${CXXFLAGS}"
            CXXFLAGS="-ftime-trace ${CXXFLAGS}"
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
            CLANG=0
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
        android)
            echo "Enabling android."
            CMAKE="$HOME/qt/6.6.3/android_arm64_v8a/bin/qt-cmake"
            CMAKE_FLAGS=( -DQT_HOST_PATH=/home/vk/qt/6.6.3/gcc_64 -DANDROID_SDK_ROOT=/opt/android-sdk -DANDROID_NDK_ROOT=/opt/android-sdk/ndk/25.1.8937393 "${CMAKE_FLAGS[@]}" )
            MOLD=0
            LTO=0
            CLANG=0
            shift
            ;;
        no-mold)
            echo "Disabling mold."
            MOLD=0
            shift
            ;;
        no-lto)
            echo "Disabling lto."
            LTO=0
            shift
            ;;
        mingw)
            QT_VERSION=6.10.1
            echo "Enabling MingW."
            CMAKE=x86_64-w64-mingw32-cmake
            CMAKE_FLAGS=(-DQT_HOST_PATH="$HOME/qt/$QT_VERSION/gcc_64" -DCMAKE_FIND_ROOT_PATH="$HOME/qt/$QT_VERSION/mingw_64")
            MOLD=0
            LTO=0
            CLANG=0
            shift
            ;;
        wasm)
            QT_VERSION=6.10.1
            echo "Enabling wasm."
            CMAKE="$HOME/qt/$QT_VERSION/wasm_singlethread/bin/qt-cmake"
            CMAKE_FLAGS=( "-DQT_HOST_PATH=/home/vk/qt/$QT_VERSION/gcc_64" -DBUILD_SHARED_LIBS=OFF "${CMAKE_FLAGS[@]}" )
            shift
            ;;
        cmake=*)
            echo -n "Setting CMAKE to "
            CMAKE="${arg#cmake=}"
            echo "${CMAKE@Q}"
            shift
            ;;
        install=*)
            INSTALL_PREFIX="${arg#install=}"
            echo "Setting CMAKE_INSTALL_PREFIX to ${INSTALL_PREFIX@Q}"
            CMAKE_FLAGS=( -DCMAKE_INSTALL_PREFIX="$INSTALL_PREFIX" "${CMAKE_FLAGS[@]}" )
            shift
            ;;
        d=*)
            OPTION="${arg#d=}"
            echo "Setting $OPTION to ON."
            CMAKE_FLAGS=( "-D$OPTION=ON" "${CMAKE_FLAGS[@]}" )
            unset OPTION
            shift
            ;;
        *)
            break
            ;;
    esac
done

EXTRA_ARGS=( "$@" )

if [[ "${#EXTRA_ARGS[@]}" = 0 ]]; then
    echo "${BASH_COLOR_RED}${BASH_COLOR_BOLD}Warning: no arguments supplied. CMake needs at least the source directory.${BASH_COLOR_NORMAL}"
    echo "${BASH_COLOR_RED}${BASH_COLOR_BOLD}CMake will probably error out.${BASH_COLOR_NORMAL}"
fi

if [[ "$CLANG" = 1 ]]; then
    CC="clang"
    CXX="clang++"
    LD="clang"
else
    CC=""
    CXX=""
    LD=""
fi

if [[ "$CACHE" = 1 ]]; then
    CMAKE_FLAGS=( '-DCMAKE_C_COMPILER_LAUNCHER=ccache' '-DCMAKE_CXX_COMPILER_LAUNCHER=ccache' "${CMAKE_FLAGS[@]}" )
fi

if [[ "$MOLD" = 1 ]]; then
    LDFLAGS="-fuse-ld=mold ${LDFLAGS:-}"
fi

if [[ "$LTO" = 1 ]]; then
    CMAKE_FLAGS=('-DCMAKE_INTERPROCEDURAL_OPTIMIZATION=ON' "${CMAKE_FLAGS[@]}")
fi

CMAKE_FLAGS=( "-DCMAKE_BUILD_TYPE=$BUILD_TYPE" "${CMAKE_FLAGS[@]}" )

if [[ "${CXX}" = clang++ ]]; then
    CXXFLAGS="-ferror-limit=0 ${CXXFLAGS}"
fi

print_var CACHE
print_var GRAPHVIZ
print_var MOLD
print_var LTO
print_var CC
print_var CXX
print_var LD
print_var CFLAGS
print_var CXXFLAGS
print_var LDFLAGS
print_var CMAKE_FLAGS
print_var BUILD_TYPE
print_var CMAKE
print_var EXTRA_ARGS

COMMAND=(
    env
    CC="${CC}"
    CXX="${CXX}"
    LD="${LD}"
    CFLAGS="${CFLAGS}"
    CXXFLAGS="${CXXFLAGS}"
    LDFLAGS="${LDFLAGS}"
    "$CMAKE"
    "${CMAKE_FLAGS[@]}"
    "${EXTRA_ARGS[@]}"
)
echo "${COMMAND[@]@Q}"
"${COMMAND[@]}"

if [[ "$GRAPHVIZ" = 1 ]]; then
    dot -Tpng deps.dot -o deps.png
    echo Dependency graph saved as deps.png.
fi
