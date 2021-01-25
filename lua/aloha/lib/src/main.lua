function DoAThing(a, b)
    print("[Lua:Dothing] Entered function DoAThing("..a..", "..b..").")
    print("[Lua:DoAThing] Before calling HostFunction("..a.." + 10 ,"..b.." * 3)")
    c = HostFunction(a + 10, b * 3)
    print("[Lua:DoAThing] DoAThing("..a.." ,"..b..") called, got "..c)
    print("[Lua:DoAThing] "..c.." is returned by HostFunction.")
    return c
end
