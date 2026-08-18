local v1 = script.Parent.Parent
local v_u_2 = require(v1.External)
return function(p3, p4, ...) -- name: merge
	-- upvalues: (copy) v_u_2
	local v5 = { ... }
	if #v5 < 1 then
		return p4
	end
	for _, v6 in v5 do
		for v7, v8 in v6 do
			if p4[v7] == nil then
				p4[v7] = v8
			elseif not p3 then
				v_u_2.logError("mergeConflict", nil, (tostring(v7)))
			end
		end
	end
	return p4
end