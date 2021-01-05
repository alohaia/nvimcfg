# README



## async.lua

Wrapper for functions that do not take a callback to make async functions

```lua
sync = wrap(step)
```

Alias for yielding to await the result of an async function

```lua
wait
```

Await the completion of a full set of async functions

```lua
wait_all
```

Await the completion of a full set of async functions, with a limit on how many functions can
run simultaneously

```lua
wait_pool
```

Like wait_pool, but additionally checks at every function completion to see if a condition is
met indicating that it should keep running the remaining tasks

```lua
interruptible_wait_pool
```

Wrapper for functions that do take a callback to make async functions

```lua
wrap
```

Convenience function to ensure a function runs on the main "thread" (i.e. for functions which
use Neovim functions, etc.)

```lua
main
```

### Coroutine

```lua
co = coroutine.create(function ()
       print("hi")
     end)

print(co)   --> thread: 0x8071d98
```

state:
- suspended（初始状态）
- running
- dead

```lua
print(coroutine.status(co))   --> suspended
```

```lua
coroutine.resume(co)   --> hi

print(coroutine.status(co))   --> dead
```

`yield`函数：挂起正在运行的协程

```lua
co = coroutine.create(function ()
       for i=1,10 do
         print("co", i)
         coroutine.yield()
       end
     end)
coroutine.resume(co)    --> co   1
print(coroutine.status(co))   --> suspended
coroutine.resume(co)    --> co   2
coroutine.resume(co)    --> co   3
-- ...
coroutine.resume(co)    --> co   10
coroutine.resume(co)    -- prints nothing
print(coroutine.resume(co)) --> false   cannot resume dead coroutine
```

> <mark>Note</mark> Resume runs in protected mode. Therefore, if there is any error inside a coroutine, Lua will not show the error message, but instead will return it to the resume call.

- `coroutine.create` 会将多余的参数传递给协程函数第一个 `resume` 调用
- `coroutine.yield` 在协程函数内部可使用此函数，将此函数的参数作为 `resume` 调用的返回值

```lua
co = coroutine.create(function (a,b)
       print("co", a+b, a-b)
     end)
coroutine.resume(co, 20, 10)    --> co      30      10

co = coroutine.create(function (a,b)
       coroutine.yield(a+b, a-b)
     end)
print('yd', coroutine.resume(co, 20, 10))  --> yd      true    30      10
print(coroutine.status(co))                --> suspended
print(coroutine.resume(co))                --> true
```
