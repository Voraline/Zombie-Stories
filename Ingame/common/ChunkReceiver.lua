local v1 = {}
local v2 = {
	["Players"] = game:GetService("Players"),
	["ReplicatedStorage"] = game:GetService("ReplicatedStorage")
}
v2.ReplicatedStorage.common:WaitForChild("SharedResources")
local v_u_3 = v2.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("ReplicationTarget")
local v_u_4 = require("@game/ReplicatedStorage/common/RedEvents/NPC/ChunkReceived"):Client()
require(game.ReplicatedStorage.common:WaitForChild("HUDService"))
local v_u_5 = nil
local function v_u_17(p6) -- name: HandleReplication
	-- upvalues: (copy) v_u_4
	local v7 = p6:WaitForChild("NumberOfDescendants", 30)
	if v7 then
		local v8 = v7.Value
		local v9 = workspace:GetServerTimeNow()
		while #p6:GetDescendants() < v8 do
			p6.DescendantAdded:Wait()
			if workspace:GetServerTimeNow() - v9 > 30 then
				warn("[ChunkReceiver] Timed out waiting for descendants on: " .. p6.Name .. " (got " .. #p6:GetDescendants() .. "/" .. v8 .. ")")
				p6:Destroy()
				return
			end
		end
		for _, v10 in p6:QueryDescendants("Model") do
			local v11 = v10:WaitForChild("ThePrimaryPart", 30)
			if not v11 then
				warn("[ChunkReceiver] Timed out waiting for ThePrimaryPart on model: " .. v10.Name)
				p6:Destroy()
				return
			end
			v10.PrimaryPart = v11.Value
			v11:Destroy()
		end
		for _, v12 in p6:QueryDescendants("Weld, Motor6D") do
			if v12.Name ~= "NULL" and (v12.Name ~= "Grip" and (v12.Part0 == nil or v12.Part1 == nil)) then
				local v13 = workspace:GetServerTimeNow()
				while v12.Part1 == nil or v12.Part0 == nil do
					task.wait()
					if workspace:GetServerTimeNow() - v13 > 30 then
						warn("[ChunkReceiver] Timed out waiting for joint parts on: " .. v12:GetFullName())
						p6:Destroy()
						return
					end
				end
			end
		end
		local v14 = p6:Clone()
		local v15 = v14:WaitForChild("ToParent", 30)
		if v15 then
			local v16 = v15.Value
			v15:Destroy()
			v14.Parent = v16
			v_u_4:Fire(p6)
		else
			warn("[ChunkReceiver] Timed out waiting for ToParent on clone: " .. v14.Name)
			v14:Destroy()
		end
	else
		warn("[ChunkReceiver] Timed out waiting for NumberOfDescendants on: " .. p6.Name)
		p6:Destroy()
		return
	end
end
function v1.Main() -- name: Main
	-- upvalues: (ref) v_u_5, (copy) v_u_3, (copy) v_u_17
	if not v_u_5 then
		v_u_5 = true
		local v18 = v_u_3:GetChildren()
		for _, v19 in pairs(v18) do
			v_u_17(v19)
		end
		v_u_3.ChildAdded:Connect(v_u_17)
	end
end
return v1