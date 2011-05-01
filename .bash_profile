umask 022

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# add Lua C lib to path
if [ -d "$HOME/lib/lua" ] ; then
    # concat Lua default CPATH and ~/lib/lua
    export LUA_CPATH="$(lua -e 'print(package.cpath)');$HOME/lib/lua/?.so"
fi

. $HOME/.bashrc
