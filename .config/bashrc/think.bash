export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

export CPLUS_INCLUDE_PATH=/usr/local/include/catch
export CPLUS_INCLUDE_PATH+=:/opt/cesnet/boost/include
export CPLUS_INCLUDE_PATH+=:/opt/cesnet/orangepi/include
export CPLUS_INCLUDE_PATH+=:/opt/cesnet/sysrepo/include
export CPLUS_INCLUDE_PATH+=:/opt/cesnet/libyang/include
export CPLUS_INCLUDE_PATH+=:/opt/cesnet/docopt.cpp/include/docopt
export CPLUS_INCLUDE_PATH+=:/opt/cesnet/linenoise
export CPLUS_INCLUDE_PATH+=:/opt/cesnet/replxx/include
export CPLUS_INCLUDE_PATH+=:/opt/cesnet/netopeer2/include
export CPLUS_INCLUDE_PATH+=:/opt/cesnet/spdlog/include
export CPLUS_INCLUDE_PATH+=:/opt/cesnet/trompeloeil/include
export CPLUS_INCLUDE_PATH+=:/opt/cesnet/Catch/include/catch
export CPLUS_INCLUDE_PATH+=:/opt/cesnet/Catch/include
export CPLUS_INCLUDE_PATH+=:/opt/cesnet/libnetconf2/include

export SCREENDIR=$HOME/.screen
stty -ixon
stty susp undef
bind -x '"\C-z":"fg &> /dev/null"'

source $HOME/.config/bashrc/alias.bash
source $HOME/.config/bashrc/common.bash
source $HOME/.config/bashrc/env.bash
source $HOME/.config/bashrc/functions.bash

