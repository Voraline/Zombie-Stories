local v1 = game.ReplicatedStorage.common
local v_u_2 = require(v1:WaitForChild("BridgeNet2"))
local v_u_7 = {
	["_cache"] = {},
	["GetBridge"] = function(p3) -- name: GetBridge
		-- upvalues: (copy) v_u_7, (copy) v_u_2
		local v4 = v_u_7._cache[p3]
		if v4 then
			return v4
		end
		local v5 = v_u_2.ReferenceBridge(p3)
		v_u_7._cache[p3] = v5
		return v5
	end,
	["ReferenceBridge"] = function(p6) -- name: ReferenceBridge
		-- upvalues: (copy) v_u_2
		return v_u_2.ReferenceBridge(p6)
	end
}
return v_u_7