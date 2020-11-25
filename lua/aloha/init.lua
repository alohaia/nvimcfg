-- require('zephyr').get_zephyr_color()
-- print(vim.api.nvim_eval('1+1'))
function _G.dump(...)
  local objects = vim.tbl_map(vim.inspect, {...})
  print(unpack(objects))
end

local M = {}

function M.createdir()
  local data_dir = {
    global.cache_dir..'backup',
    global.cache_dir..'session',
    global.cache_dir..'swap',
    global.cache_dir..'tags',
    global.cache_dir..'undo'
  }
  -- There only check once that If cache_dir exists
  -- Then I don't want to check subs dir exists
  if not fs.isdir(global.cache_dir) then
    os.execute("mkdir -p " .. global.cache_dir)
    for _,v in pairs(data_dir) do
      if not global.isdir(v) then
        os.execute("mkdir -p " .. v)
      end
    end
  end
end

------------------------------ set options ------------------------------
_G.mappings = {
  ttyfast = true;
  -- ...
}
function M.setopts()
  
end

------------------------------ set mappings ------------------------------
function M.setmapings()

end

function M.load_config()
  M.createdir()
  M.setopts()
  M.setmapings()
end
M.load_config()
