local v_u_1 = {
	["Offset"] = CFrame.new(0, 0, 500)
}
game.ReplicatedStorage.common:WaitForChild("Remotes"):WaitForChild("Net")
local v_u_2 = game.Players.LocalPlayer
local v_u_3 = nil
local v_u_4 = false
local v_u_5 = false
tick()
local v_u_6 = game:GetService("SoundService")
local v_u_7 = Color3.new(0.384314, 1, 0.94902)
local v_u_8 = nil
function v_u_1.Init() -- name: Init
	-- upvalues: (ref) v_u_3, (copy) v_u_2, (ref) v_u_8, (copy) v_u_7, (ref) v_u_4
	if not workspace:FindFirstChild("Values") or (not workspace.Values:FindFirstChild("IsLobby") or workspace.Values.IsLobby.Value ~= true) then
		for _ = 1, 10 do
			local _, _ = pcall(function()
				-- upvalues: (ref) v_u_3, (ref) v_u_2
				v_u_3 = game:GetService("MarketplaceService"):UserOwnsGamePassAsync(v_u_2.UserId, 6885070) or game:GetService("MarketplaceService"):UserOwnsGamePassAsync(v_u_2.UserId, 10504943)
			end)
			if v_u_3 then
				break
			end
		end
		local v_u_9 = nil
		local _, _ = pcall(function()
			-- upvalues: (ref) v_u_9, (ref) v_u_2
			v_u_9 = v_u_2:GetRankInGroup(3532462)
		end)
		if v_u_9 and v_u_9 >= 254 then
			v_u_3 = true
		end
		v_u_8 = game.Lighting.Ambient
		game.Lighting.Changed:Connect(function()
			-- upvalues: (ref) v_u_7, (ref) v_u_8, (ref) v_u_4
			if game.Lighting.Ambient ~= v_u_7 and game.Lighting.Ambient ~= v_u_8 then
				v_u_8 = game.Lighting.Ambient
				if v_u_4 then
					task.wait()
					if v_u_4 then
						game.Lighting.Ambient = v_u_7
					end
				end
			end
		end)
	end
end
function v_u_1.ToggleActivate() -- name: ToggleActivate
	-- upvalues: (ref) v_u_3, (ref) v_u_4, (ref) v_u_5, (copy) v_u_1, (copy) v_u_6, (copy) v_u_7, (ref) v_u_8
	if v_u_3 then
		if not v_u_4 then
			v_u_5 = true
			task.wait(0.1)
			v_u_1.Offset = CFrame.new()
			v_u_4 = true
			v_u_6:PlayLocalSound(script.Parent.Parent.Resources.Sounds.Cloth)
			task.wait()
			game.Lighting.Ambient = v_u_7
			v_u_1.Offset = CFrame.new(0, 0, 500)
			v_u_6:PlayLocalSound(script.Parent.Parent.Resources.Sounds.Sound)
			v_u_5 = false
			return
		end
		v_u_5 = true
		task.wait(0.1)
		v_u_1.Offset = CFrame.new()
		v_u_4 = false
		game.Lighting.Ambient = v_u_8
		v_u_6:PlayLocalSound(script.Parent.Parent.Resources.Sounds.Cloth)
		task.wait(0.5)
		v_u_1.Offset = CFrame.new(0, 0, 500)
		v_u_5 = false
	end
end
return v_u_1