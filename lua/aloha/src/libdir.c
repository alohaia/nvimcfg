#include <dirent.h>
#include <errno.h>
#include <string.h>

#include <lua.h>
#include <lauxlib.h>

static int l_dir(lua_State *L) {
    DIR *dir;
    struct dirent *entry;
    const char *path = luaL_checkstring(L, 1);

    // 打开目录
    dir = opendir(path);
    if (dir == NULL) {
        lua_pushnil(L);
        lua_pushstring(L, strerror(errno));
        return -1;
    }

    lua_newtable(L);
    int i = 1;
    while ((entry = readdir(dir)) != NULL) {
        lua_pushinteger(L, i++);
        lua_pushstring(L, entry->d_name);
        lua_settable(L, -3);
    }

    closedir(dir);
    return 0;
}

static const struct luaL_Reg _lib_reg[] = {
    {"dir", l_dir},
    {NULL, NULL} // 哨兵
};

// 入口函数，不加 static，lua_open<libname>
int luaopen_libdir(lua_State *L) {
    luaL_newlib(L, _lib_reg);
    return 1;
}

