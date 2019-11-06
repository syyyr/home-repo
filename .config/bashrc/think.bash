export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

export PKG_CONFIG_PATH=/opt/libyang/lib64/pkgconfig
export PKG_CONFIG_PATH+=:/opt/sysrepo/lib64/pkgconfig
export PKG_CONFIG_PATH+=:/opt/Netopeer2/lib64/pkgconfig
export PKG_CONFIG_PATH+=:/opt/libnetconf2/lib64/pkgconfig
export LD_LIBRARY_PATH=/opt/docopt.cpp/lib64
export LD_LIBRARY_PATH+=/opt/boost/lib
export LD_LIBRARY_PATH+=:/opt/spdlog/lib64
export LD_LIBRARY_PATH+=:/opt/libyang/lib64
export LD_LIBRARY_PATH+=:/opt/sysrepo/lib64
export LD_LIBRARY_PATH+=:/opt/libredblack/lib
export LD_LIBRARY_PATH+=:/usr/local/lib
export LD_LIBRARY_PATH+=:/opt/replxx/lib
export LD_LIBRARY_PATH+=:/opt/netopeer2/lib64
export LD_LIBRARY_PATH+=:/opt/libnetconf2/lib64
export LIBRARY_PATH=$LD_LIBRARY_PATH

export CPLUS_INCLUDE_PATH=/usr/local/include/catch
export CPLUS_INCLUDE_PATH+=:/opt/boost/include
export CPLUS_INCLUDE_PATH+=:/opt/orangepi/include
export CPLUS_INCLUDE_PATH+=:/opt/sysrepo/include
export CPLUS_INCLUDE_PATH+=:/opt/libyang/include:/opt/docopt.cpp/include/docopt
export CPLUS_INCLUDE_PATH+=:/opt/docopt.cpp/include/docopt
export CPLUS_INCLUDE_PATH+=:/opt/linenoise
export CPLUS_INCLUDE_PATH+=:/opt/replxx/include
export CPLUS_INCLUDE_PATH+=:/opt/netopeer2/include
export CPLUS_INCLUDE_PATH+=:/opt/spdlog/include
export CPLUS_INCLUDE_PATH+=:/opt/trompeloeil/include
export CPLUS_INCLUDE_PATH+=:/opt/Catch/include/catch
export CPLUS_INCLUDE_PATH+=:/opt/Catch/include
export CPLUS_INCLUDE_PATH+=:/opt/libnetconf2/include

export SCREENDIR=$HOME/.screen
stty -ixon
stty susp undef
bind -x '"\C-z":"fg &> /dev/null"'

source $HOME/.completerc
source $HOME/.config/bashrc/alias.bash
source $HOME/.config/bashrc/common.bash
source $HOME/.config/bashrc/env.bash
source $HOME/.config/bashrc/functions.bash

