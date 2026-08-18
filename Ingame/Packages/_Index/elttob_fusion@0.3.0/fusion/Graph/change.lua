local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = require(v1.Graph.evaluate)
return function(p4) -- name: change
	-- upvalues: (copy) v_u_2, (copy) v_u_3
	if p4.validity == "busy" then
		return v_u_2.logError("infiniteLoop")
	end
	if v_u_3(p4, true) then
		local v5 = os.clock() + 1 * v_u_2.safetyTimerMultiplier
		local v6 = { p4 }
		local v7 = {}
		local v8 = {}
		while v5 >= os.clock() do
			local v9 = true
			for _, v10 in v6 do
				for v11 in v10.dependentSet do
					if v11.validity == "valid" then
						table.insert(v7, v11)
						table.insert(v8, v11)
						v9 = false
					elseif v11.validity == "busy" then
						return v_u_2.logError("infiniteLoop")
					end
				end
			end
			table.clear(v6)
			if v9 then
				local v12 = {}
				for _, v13 in v7 do
					v13.validity = "invalid"
					if v13.timeliness == "eager" then
						table.insert(v12, v13)
					end
				end
				table.sort(v12, function(p14, p15)
					return p14.createdAt < p15.createdAt
				end)
				for _, v16 in v12 do
					v_u_3(v16, false)
				end
				return
			end
			local v17 = v8
			v8 = v6
			v6 = v17
		end
		return v_u_2.logError("infiniteLoop")
	end
end