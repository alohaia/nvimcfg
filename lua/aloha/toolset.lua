local toolset = {}

local basicfunc = {}

function basicfunc.split()
  local dLen = string.len(delimiter)
  local newDeli = ''
  for i=1,dLen,1 do
      newDeli = newDeli .. "["..string.sub(delimiter,i,i).."]"
  end

  local locaStart,locaEnd = string.find(str,newDeli)
  local arr = {}
  local n = 1
  while locaStart ~= nil
  do
      if locaStart>0 then
          arr[n] = string.sub(str,1,locaStart-1)
          n = n + 1
      end

      str = string.sub(str,locaEnd+1,string.len(str))
      locaStart,locaEnd = string.find(str,newDeli)
  end
  if str ~= nil then
      arr[n] = str
  end
  return arr
end

function colorcolumn_bg_backup()
end

return toolset, basicfunc
