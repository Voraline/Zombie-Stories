local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
local v3 = require(script.Parent.Parent.Parent.Guard)
local v_u_4 = v1:WaitForChild("ReliableRedEvent")
local v_u_5 = v1:WaitForChild("UnreliableRedEvent")
local v_u_6 = v3.Check(v3.Map(v3.String, v3.List(v3.Any)))
local v_u_7 = v3.Check(v3.Map(v3.String, v3.List(v3.Any)))
local v_u_8 = {}
local v_u_9 = {}
local function v_u_13(p10, p11, p12) -- name: SendCallReturn
	-- upvalues: (copy) v_u_9
	if not v_u_9[p10] then
		v_u_9[p10] = {
			["Reliable"] = {},
			["CallReturn"] = {}
		}
	end
	v_u_9[p10].CallReturn[p11] = p12
end
return {
	["SendReliableEvent"] = function(p14, p15, p16) -- name: SendReliableEvent
		-- upvalues: (copy) v_u_9
		if not v_u_9[p14] then
			v_u_9[p14] = {
				["Reliable"] = {},
				["CallReturn"] = {}
			}
		end
		if not v_u_9[p14].Reliable[p15] then
			v_u_9[p14].Reliable[p15] = {}
		end
		local v17 = v_u_9[p14].Reliable[p15]
		table.insert(v17, p16)
	end,
	["SendUnreliableEvent"] = function(p18, p19, p20) -- name: SendUnreliableEvent
		-- upvalues: (copy) v_u_5
		v_u_5:FireClient(p18, p19, p20)
	end,
	["SetListener"] = function(p21, p22) -- name: SetListener
		-- upvalues: (copy) v_u_8
		v_u_8[p21] = p22
	end,
	["SendCallReturn"] = v_u_13,
	["Start"] = function() -- name: Start
		-- upvalues: (copy) v_u_4, (copy) v_u_6, (copy) v_u_8, (copy) v_u_7, (copy) v_u_13, (copy) v_u_5, (copy) v_u_2, (copy) v_u_9
		v_u_4.OnServerEvent:Connect(function(p23, p24, p25)
			-- upvalues: (ref) v_u_6, (ref) v_u_8, (ref) v_u_7, (ref) v_u_13
			local v26, v27 = v_u_6(p24)
			if v26 then
				for v28, v29 in v27 do
					local v30 = v_u_8[v28]
					if v30 then
						for _, v31 in v29 do
							v30(p23, v31)
						end
					end
				end
			end
			local v32, v33 = v_u_7(p25)
			if v32 then
				for v34, v35 in v33 do
					local v36 = v_u_8[v34]
					if v36 then
						for _, v37 in v35 do
							v36(p23, v37)
						end
					else
						for _, v38 in v35 do
							v_u_13(p23, v38[1], { false, "Event has no listener." })
						end
					end
				end
			end
		end)
		v_u_5.OnServerEvent:Connect(function(p39, p40, p41)
			-- upvalues: (ref) v_u_8
			local v42 = type(p40) == "string" and (type(p41) == "table" and v_u_8[p40])
			if v42 then
				v42(p39, p41)
			end
		end)
		v_u_2.Heartbeat:Connect(function()
			-- upvalues: (ref) v_u_9, (ref) v_u_4
			for v43, v44 in v_u_9 do
				if next(v44.Reliable) or next(v44.CallReturn) then
					v_u_4:FireClient(v43, v44.Reliable, v44.CallReturn)
				end
				v_u_9[v43] = nil
			end
		end)
	end
}