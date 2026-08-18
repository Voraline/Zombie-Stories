local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.Memory.checkLifetime)
local v_u_3 = require(v1.Graph.Observer)
local v_u_4 = require(v1.State.castToState)
local v_u_5 = require(v1.State.peek)
local v_u_6 = {}
return function(p_u_7) -- name: Attribute
	-- upvalues: (copy) v_u_6, (copy) v_u_4, (copy) v_u_2, (copy) v_u_3, (copy) v_u_5
	local v8 = v_u_6[p_u_7]
	if v8 == nil then
		v8 = {
			["type"] = "SpecialKey",
			["kind"] = "Attribute",
			["stage"] = "self",
			["apply"] = nil,
			["apply"] = function(_, p9, p_u_10, p_u_11) -- name: apply
				-- upvalues: (ref) v_u_4, (ref) v_u_2, (copy) p_u_7, (ref) v_u_3, (ref) v_u_5
				if v_u_4(p_u_10) then
					v_u_2.bOutlivesA(p9, p_u_11, p_u_10.scope, p_u_10.oldestTask, v_u_2.formatters.boundAttribute, p_u_7)
					v_u_3(p9, p_u_10):onBind(function()
						-- upvalues: (copy) p_u_11, (ref) p_u_7, (ref) v_u_5, (copy) p_u_10
						p_u_11:SetAttribute(p_u_7, v_u_5(p_u_10))
					end)
				else
					p_u_11:SetAttribute(p_u_7, p_u_10)
				end
			end
		}
		v_u_6[p_u_7] = v8
	end
	return v8
end