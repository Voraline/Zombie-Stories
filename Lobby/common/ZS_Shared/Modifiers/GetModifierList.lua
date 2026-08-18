local v1 = game:GetService("ReplicatedStorage")
require(v1.Packages.Fusion)
local v_u_2 = require(v1.common.ZS_Shared.Data.ModifierData)
local v_u_3 = require(v1.common.ZS_Shared.Data.GameState)
local v_u_4 = require(v1.common.ZS_Shared.Util.deepCopy)
return function(_, _, p5)
	-- upvalues: (copy) v_u_4, (copy) v_u_3, (copy) v_u_2
	local v_u_6 = {}
	v_u_4(v_u_3.Data)
	local function v_u_11(p7) -- name: turnOnModifier
		-- upvalues: (ref) v_u_2, (copy) v_u_6
		local v8 = v_u_2[p7]
		for v9, v10 in v_u_6 do
			if v_u_2[v9].Grouping == v8.Grouping then
				v10.IsActive:set(false)
			end
		end
		v_u_6[p7].IsActive:set(true)
	end
	for v12, _ in v_u_2 do
		v_u_6[v12] = {
			["IsLocked"] = p5:Value(false),
			["IsActive"] = p5:Value(false)
		}
	end
	return {
		["ModifierList"] = v_u_6,
		["ActivateModifier"] = function(p13) -- name: activateModifier
			-- upvalues: (copy) v_u_11
			v_u_11(p13)
		end,
		["DeactivateModifier"] = function(p14) -- name: deactivateModifier
			-- upvalues: (copy) v_u_6
			v_u_6[p14].IsActive:set(false)
		end
	}
end