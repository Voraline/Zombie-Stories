local v_u_1 = game:GetService("RunService")
local v_u_2 = require(script.Parent.Parent.Future)
local v_u_3 = require(script.Parent.Parent.Spawn)
local v_u_4 = require(script.Parent.Net)
local v_u_5 = require(script.Parent.Identifier)
local function v_u_14(p_u_6, p_u_7) -- name: SetCallback
	-- upvalues: (copy) v_u_1, (copy) v_u_4, (copy) v_u_3
	local v8 = v_u_1:IsServer()
	assert(v8, "Cannot set callback to function on client")
	v_u_4.Server.SetListener(p_u_6.Id, function(p9, p10)
		-- upvalues: (ref) v_u_3, (copy) p_u_6, (ref) v_u_4, (copy) p_u_7
		local v11 = table.remove(p10, 1)
		if type(v11) == "string" then
			v_u_3(function(p12, p13, ...)
				-- upvalues: (ref) p_u_6, (ref) v_u_4, (ref) p_u_7
				if pcall(p_u_6.Validate, ...) then
					v_u_4.Server.SendCallReturn(p12, p13, table.pack(pcall(p_u_7, p12, ...)))
				end
			end, p9, v11, unpack(p10))
		end
	end)
end
local function v_u_20(p_u_15, ...) -- name: Call
	-- upvalues: (copy) v_u_2, (copy) v_u_5, (copy) v_u_4
	return v_u_2.new(function(...)
		-- upvalues: (ref) v_u_5, (ref) v_u_4, (copy) p_u_15
		local v16 = v_u_5.Unique()
		local v17 = v_u_4.Client.CallAsync
		local v18 = p_u_15.Id
		local v19 = table.pack
		return unpack(v17(v18, v19(v16, ...)))
	end, ...)
end
return function(p21, p22, _) -- name: Function
	-- upvalues: (copy) v_u_5, (copy) v_u_14, (copy) v_u_20
	local v23 = not v_u_5.Exists(p21)
	assert(v23, "Cannot use same name twice")
	return {
		["Id"] = v_u_5.Shared(p21):Await(),
		["Validate"] = p22,
		["SetCallback"] = v_u_14,
		["Call"] = v_u_20
	}
end