local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
return function(p3, p_u_4) -- name: poisonScope
	-- upvalues: (copy) v_u_2
	local v5 = getmetatable(p3)
	if typeof(v5) ~= "table" or not v5._FUSION_POISONED then
		table.clear(p3)
		local v6 = {
			["_FUSION_POISONED"] = true,
			["__index"] = nil,
			["__newindex"] = nil,
			["__index"] = function() -- name: __index
				-- upvalues: (ref) v_u_2, (copy) p_u_4
				v_u_2.logError("poisonedScope", nil, p_u_4)
			end,
			["__newindex"] = function() -- name: __newindex
				-- upvalues: (ref) v_u_2, (copy) p_u_4
				v_u_2.logError("poisonedScope", nil, p_u_4)
			end
		}
		setmetatable(p3, v6)
	end
end