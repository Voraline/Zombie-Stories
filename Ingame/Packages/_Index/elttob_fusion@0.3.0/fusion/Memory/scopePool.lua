local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.Memory.poisonScope)
local v_u_3 = require(v1.ExternalDebug)
local v_u_4 = {}
local v_u_5 = 0
return {
	["giveIfEmpty"] = function(p6) -- name: giveIfEmpty
		-- upvalues: (copy) v_u_3, (copy) v_u_2
		if next(p6) ~= nil then
			return p6
		end
		v_u_3.untrackScope(p6)
		v_u_2(p6, "previously passed to the internal scope pool, which indicates a Fusion bug.")
		return nil
	end,
	["clearAndGive"] = function(p7) -- name: clearAndGive
		-- upvalues: (copy) v_u_3, (copy) v_u_2
		v_u_3.untrackScope(p7)
		table.clear(p7)
		v_u_2(p7, "previously passed to the internal scope pool, which indicates a Fusion bug.")
	end,
	["reuseAny"] = function() -- name: reuseAny
		-- upvalues: (ref) v_u_5, (copy) v_u_4
		if v_u_5 == 0 then
			return nil
		end
		local v8 = v_u_4[v_u_5]
		v_u_5 = v_u_5 - 1
		return v8
	end
}