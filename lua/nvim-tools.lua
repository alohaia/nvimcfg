-- -- Create a timer handle (implementation detail: uv_timer_t).
local timer = vim.loop.new_timer()
local i = 0
-- Waits 1000ms, then repeats every 750ms until timer:close().
timer:start(1000, 750, function()
  print('timer invoked! i='..tostring(i))
  if i > 4 then
    timer:close()  -- Always close handles to avoid leaks.
  end
  i = i + 1
end)
print('sleeping');

-- local function create_server(host, port, on_connection)
--   local server = vim.loop.new_tcp()
--   server:bind(host, port)
--   server:listen(128, function(err)
--     assert(not err, err)  -- Check for errors.
--     local sock = vim.loop.new_tcp()
--     server:accept(sock)  -- Accept client connection.
--     on_connection(sock)  -- Start reading messages.
--   end)
--   return server
-- end
-- local server = create_server('0.0.0.0', 0, function(sock)
--   sock:read_start(function(err, chunk)
--     assert(not err, err)  -- Check for errors.
--     if chunk then
--       sock:write(chunk)  -- Echo received messages to the channel.
--     else  -- EOF (stream closed).
--       sock:close()  -- Always close handles to avoid leaks.
--     end
--   end)
-- end)
-- print('TCP echo-server listening on port: '..server:getsockname().port)

for v in vim.gsplit(":aa::b:", ":") do
  print(v)
end
