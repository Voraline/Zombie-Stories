local v_u_1 = require(script.Parent.Spawn)
return function()
	-- upvalues: (copy) v_u_1
	local v_u_2 = {}
	return function(p3)
		-- upvalues: (copy) v_u_2
		local v4 = v_u_2
		table.insert(v4, p3)
		return p3
	end, function()
		-- upvalues: (copy) v_u_2, (ref) v_u_1
		for _, v5 in v_u_2 do
			if typeof(v5) == "Instance" then
				v5:Destroy()
			elseif typeof(v5) == "RBXScriptConnection" then
				v5:Disconnect()
			elseif typeof(v5) == "function" then
				v_u_1(v5)
			end
		end
		table.clear(v_u_2)
	end
end