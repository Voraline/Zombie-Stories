local v1 = game:GetService("RunService")
local v_u_2 = game:GetService("HttpService")
local v3 = game.ReplicatedStorage.common.RedEvents
local v_u_4 = v1:IsClient()
local v_u_5 = v1:IsServer()
local v_u_6 = require(v3.Framework.GetAttachmentData)
local v7 = {}
local v_u_8 = {}
local v_u_9 = {}
local v_u_10 = 0
function v7.GenerateUID(_) -- name: GenerateUID
	-- upvalues: (copy) v_u_4, (ref) v_u_10
	if not v_u_4 then
		v_u_10 = v_u_10 + 1
		return v_u_10
	end
end
function v7.RegisterGun(p11, p12, p13) -- name: RegisterGun
	-- upvalues: (copy) v_u_9, (copy) v_u_8
	local v14 = p11:GenerateUID()
	if not v_u_9[p13] then
		v_u_9[p13] = {}
	end
	local v15 = v_u_9[p13]
	table.insert(v15, v14)
	v_u_8[tostring(v14)] = p12
	return v14
end
function v7.RetrieveAttachmentData(_, p16, p17) -- name: RetrieveAttachmentData
	-- upvalues: (copy) v_u_5, (copy) v_u_8, (copy) v_u_9, (copy) v_u_6, (copy) v_u_2
	if v_u_5 then
		return v_u_8[tostring(p16)]
	end
	if not v_u_9[p17] then
		v_u_9[p17] = {}
	end
	if not v_u_8[tostring(p16)] then
		local v18, v19 = v_u_6:Call(p16):Await()
		if v18 then
			local v20 = not v19 and {} or v_u_2:JSONDecode(v19[1])
			v_u_8[tostring(p16)] = v20
			local v21 = v_u_9[p17]
			table.insert(v21, p16)
		else
			error("Failed to retrieve attachment data")
		end
	end
	return v_u_8[tostring(p16)]
end
function v7.RemoveGunData(_, p22) -- name: RemoveGunData
	-- upvalues: (copy) v_u_8
	v_u_8[p22] = nil
end
if v_u_5 then
	v_u_6:SetCallback(function(_, p23)
		-- upvalues: (copy) v_u_2, (copy) v_u_8
		return p23 and { v_u_2:JSONEncode(v_u_8[tostring(p23)]) } or nil
	end)
	game.Players.PlayerRemoving:Connect(function(p24)
		-- upvalues: (copy) v_u_9, (copy) v_u_8
		if v_u_9[p24] then
			for _, v25 in v_u_9[p24] do
				v_u_8[v25] = nil
			end
			table.clear(v_u_9[p24])
			v_u_9[p24] = nil
		end
	end)
end
return v7