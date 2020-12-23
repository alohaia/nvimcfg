local functions = {}

--{{ Tool Functions
function functions.merge(to, from)
	if from ~= nil then
		for k, v in pairs(from) do
			to[k] = v
		end
	end
	return to
end

function functions.len(t)
  local leng=0
  for k, v in pairs(t) do
    leng=leng+1
  end
  return leng;
end
--}}

return functions
