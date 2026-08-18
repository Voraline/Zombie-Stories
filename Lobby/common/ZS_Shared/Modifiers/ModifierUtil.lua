local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.common.ZS_Shared.Data.ModifierData)
local v_u_3 = require(v1.common.ZS_Shared.Data.ModifierGroupData)
local v_u_13 = {
	["GetGroupingIcon"] = function(p4) -- name: GetGroupingIcon
		-- upvalues: (copy) v_u_3
		if p4 then
			return v_u_3[p4]
		else
			return nil
		end
	end,
	["GetModifierIcon"] = function(p5) -- name: GetModifierIcon
		-- upvalues: (copy) v_u_2, (copy) v_u_13
		local v6 = v_u_2[p5]
		if v6 then
			return v6.Icon or v_u_13.GetGroupingIcon(v6.Grouping or v6.Group)
		else
			return nil
		end
	end,
	["GetModifierStatText"] = function(p7) -- name: GetModifierStatText
		-- upvalues: (copy) v_u_2
		local v8 = v_u_2[p7]
		if not v8 then
			return ""
		end
		if v8.StatText then
			return v8.StatText
		end
		if v8.VariableAdditions then
			for v9, v10 in pairs(v8.VariableAdditions) do
				if v9:find("Rate") or (v9:find("Speed") or v9:find("Health")) then
					if v10 > 0 then
						local v11 = v10 * 100
						return "+" .. math.floor(v11) .. "%"
					else
						local v12 = v10 * 100
						return math.floor(v12) .. "%"
					end
				end
			end
		end
		return v8.VariableSets and v8.VariableSets.HeadshotOnly and "HEAD" or ""
	end
}
return v_u_13