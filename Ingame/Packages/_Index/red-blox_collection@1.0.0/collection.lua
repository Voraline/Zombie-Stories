local v_u_1 = game:GetService("CollectionService")
local v_u_2 = require(script.Parent.Spawn)
return function(p3, p_u_4)
	-- upvalues: (copy) v_u_1, (copy) v_u_2
	local v_u_5 = {}
	for _, v_u_6 in v_u_1:GetTagged(p3) do
		v_u_2(function()
			-- upvalues: (copy) v_u_5, (copy) v_u_6, (copy) p_u_4
			v_u_5[v_u_6] = p_u_4(v_u_6)
		end)
	end
	local v_u_8 = v_u_1:GetInstanceAddedSignal(p3):Connect(function(p7)
		-- upvalues: (copy) v_u_5, (copy) p_u_4
		v_u_5[p7] = p_u_4(p7)
	end)
	local v_u_11 = v_u_1:GetInstanceRemovedSignal(p3):Connect(function(p9)
		-- upvalues: (copy) v_u_5
		local v10 = v_u_5[p9]
		if v10 then
			v_u_5[p9] = nil
			v10()
		end
	end)
	return function()
		-- upvalues: (copy) v_u_8, (copy) v_u_11, (copy) v_u_5, (ref) v_u_2
		v_u_8:Disconnect()
		v_u_11:Disconnect()
		for _, v12 in v_u_5 do
			v_u_2(v12)
		end
	end
end