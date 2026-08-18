local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = {}
return function(p_u_4) -- name: AttributeChange
	-- upvalues: (copy) v_u_3, (copy) v_u_2
	local v5 = v_u_3[p_u_4]
	if v5 == nil then
		v5 = {
			["type"] = "SpecialKey",
			["kind"] = "AttributeChange",
			["stage"] = "observer",
			["apply"] = nil,
			["apply"] = function(_, p6, p_u_7, p_u_8) -- name: apply
				-- upvalues: (ref) v_u_2, (copy) p_u_4
				if typeof(p_u_7) ~= "function" then
					v_u_2.logError("invalidAttributeChangeHandler", nil, p_u_4)
				end
				local v9 = p_u_8:GetAttributeChangedSignal(p_u_4)
				local function v10()
					-- upvalues: (copy) p_u_7, (copy) p_u_8, (ref) p_u_4
					p_u_7(p_u_8:GetAttribute(p_u_4))
				end
				table.insert(p6, v9:Connect(v10))
			end
		}
		v_u_3[p_u_4] = v5
	end
	return v5
end