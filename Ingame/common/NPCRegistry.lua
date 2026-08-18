local v1 = game.ReplicatedStorage.common
local _ = game.ReplicatedStorage.common.RedEvents
local v_u_2 = nil
local v3 = require(v1.Signal)
local v_u_4 = {}
local v_u_5 = game:GetService("RunService"):IsServer()
local v_u_18 = {
	["NPCAdded"] = v3.new(),
	["NPCRemoved"] = v3.new(),
	["AddNPC"] = function(_, p6) -- name: AddNPC
		-- upvalues: (copy) v_u_4, (copy) v_u_18, (copy) v_u_5, (ref) v_u_2
		local v_u_7 = p6.UID
		if v_u_7 ~= nil then
			v_u_4[v_u_7] = p6
			v_u_18.NPCAdded:Fire(p6)
			if v_u_5 then
				local v_u_8 = nil
				v_u_8 = p6.Destroyed:Connect(function()
					-- upvalues: (ref) v_u_8, (ref) v_u_4, (copy) v_u_7, (ref) v_u_2
					v_u_8:Disconnect()
					v_u_4[v_u_7] = nil
					local v9 = {
						["Type"] = "RemoveNPC",
						["UID"] = nil,
						["UID"] = v_u_7
					}
					v_u_2.NPCRegistryEvent.FireAll(v9)
				end)
			end
		end
	end,
	["GetNPC"] = function(_, p10) -- name: GetNPC
		-- upvalues: (copy) v_u_4
		return v_u_4[p10]
	end,
	["GetAllNPCs"] = function(_) -- name: GetAllNPCs
		-- upvalues: (copy) v_u_4
		return v_u_4
	end,
	["DestroyAll"] = function(_) -- name: DestroyAll
		-- upvalues: (copy) v_u_4
		for _, v11 in v_u_4 do
			if v11.Destroy ~= nil then
				v11:Destroy()
			end
		end
	end,
	["WaitForNPC"] = function(_, p12, p13) -- name: WaitForNPC
		-- upvalues: (copy) v_u_4
		local v14 = p13 == nil and 99999999 or p13
		local v15 = v_u_4[p12]
		if v15 ~= nil then
			return v15
		end
		local v16 = 0
		repeat
			v16 = v16 + task.wait(0.1)
			local v17 = v_u_4[p12]
		until v14 <= v16 or v17 ~= nil
		return v17
	end
}
if v_u_5 then
	game:GetService("ServerScriptService")
	v_u_2 = require("@game/ServerScriptService/common/zap")
end
if not v_u_5 then
	game:GetService("ReplicatedStorage")
	v_u_2 = require("@game/ReplicatedStorage/common/zap")
	v_u_2.NPCRegistryEvent.On(function(p19)
		-- upvalues: (copy) v_u_4, (copy) v_u_18
		local v20 = p19.UID
		if p19.Type == "RemoveNPC" then
			if v_u_4[v20] then
				v_u_18.NPCRemoved:Fire(v_u_4[v20])
				v_u_4[v20] = nil
				return
			end
			local v21 = 0
			while not v_u_4[v20] and v21 < 5 do
				v21 = v21 + 1
				task.wait(2)
			end
			task.wait(3)
			if v_u_4[v20] then
				v_u_18.NPCRemoved:Fire(v_u_4[v20])
				v_u_4[v20] = nil
				return
			end
			warn("NPCRegistry:RemoveNPC - Could not find NPC after 5 tries.")
		end
	end)
end
return v_u_18