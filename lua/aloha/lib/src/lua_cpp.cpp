#include <iostream>


extern "C"
{
#include <lauxlib.h>
#include <lualib.h>
#include <lua.h>
}

int lua_HostFunction(lua_State* L)
{
    // Arguments are pushed on the bottom of the stack when the function in Lua is called.
    float a = float(lua_tonumber(L, 1));
    float b = float(lua_tonumber(L, 2));
    float c = a * b;
    lua_pushnumber(L, c);
    std::cout << "[C++:lua_HostFunction] lua_HostFunction(" << a << ", " << b << ") called, pushed " << c << "." << std::endl;
    // Return the number of values been pushed on the top of the stack.
    return 1;
}

bool CheckLua(lua_State* L, int r)
{
    if (r == LUA_OK)
        return true;
    else
    {
        std::string errormsg = lua_tostring(L, -1);
        std::cerr << errormsg << std::endl;
        return false;
    }
}

int main()
{
    lua_State* L = luaL_newstate();

    lua_register(L, "HostFunction", lua_HostFunction);
    std::cout << "[C++:main] C++ function lua_HostFunction is registered as Lua function HostFunction." << std::endl;
    if (CheckLua(L, luaL_dofile(L, "./settings.lua")))
    {
        lua_getglobal(L, "DoAThing");
        if (lua_isfunction(L, -1))
        {
            lua_pushnumber(L, 5);
            lua_pushnumber(L, 6);

            if (CheckLua(L, lua_pcall(L, 2, 1, 0)))
            {
                float result = lua_tonumber(L, -1);
                std::cout << "[C++:main] " << result << " on virtual machine is also available in Host Program." << std::endl;
            }
        }
    }

    lua_close(L);

    return 0;
}
