local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
local v_u_3 = require(script.Parent.Parent.Future)
local v_u_4 = v1:WaitForChild("ReliableRedEvent")
local v5 = {}
local v_u_6 = 0
local v_u_7 = 0
local function v_u_12(p8) -- name: UInt
	local v9 = string.pack
	local v10 = p8 + 1
	local v11 = math.log(v10, 2) / 8
	return v9(("I%*"):format((math.ceil(v11))), p8)
end
function v5.Shared(p13) -- name: Shared
	-- upvalues: (copy) v_u_3, (copy) v_u_2, (copy) v_u_4, (ref) v_u_6
	return v_u_3.new(function(p_u_14)
		-- upvalues: (ref) v_u_2, (ref) v_u_4, (ref) v_u_6
		if not v_u_2:IsServer() then
			local v15 = task.delay(5, function()
				-- upvalues: (copy) p_u_14
				warn((("Yielded while initializing identifier: %*. It may not exist on the server!"):format(p_u_14)))
			end)
			while not v_u_4:GetAttribute(p_u_14) do
				v_u_4.AttributeChanged:Wait()
			end
			task.cancel(v15)
			return v_u_4:GetAttribute(p_u_14)
		end
		if v_u_4:GetAttribute(p_u_14) then
			return v_u_4:GetAttribute(p_u_14)
		end
		v_u_6 = v_u_6 + 1
		local v16 = v_u_6
		local v17 = string.pack
		local v18 = v16 + 1
		local v19 = math.log(v18, 2) / 8
		local v20 = v17(("I%*"):format((math.ceil(v19))), v16)
		v_u_4:SetAttribute(p_u_14, v20)
		return v20
	end, p13)
end
function v5.Exists(p21) -- name: Exists
	-- upvalues: (copy) v_u_2, (copy) v_u_4
	local v22 = v_u_2:IsServer()
	if v22 then
		v22 = v_u_4:GetAttribute(p21) ~= nil
	end
	return v22
end
function v5.Unique() -- name: Unique
	-- upvalues: (ref) v_u_7, (copy) v_u_12
	v_u_7 = v_u_7 + 1
	if v_u_7 == 65535 then
		v_u_7 = 0
	end
	return v_u_12(v_u_7)
end
return v5