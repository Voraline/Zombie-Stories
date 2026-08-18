local v_u_1 = game:GetService("Players")
local v2 = game.ReplicatedStorage.common
local v_u_3 = script.hpbar
local v_u_4 = {
	["Assault"] = "rbxassetid://4458718282",
	["Medic"] = "rbxassetid://2706886795",
	["Sniper"] = "rbxassetid://4458692655",
	["Support"] = "rbxassetid://2706886028",
	["Arcade"] = "rbxassetid://112766246588072"
}
local v_u_5 = {
	["Low"] = Color3.fromRGB(255, 148, 148),
	["Medium"] = Color3.fromRGB(255, 249, 158),
	["High"] = Color3.fromRGB(178, 255, 161)
}
local v_u_6 = require(v2.PlayerHandler)
local v_u_7 = 100
local v_u_8 = {}
local v_u_9 = nil
local v10 = {}
local function v_u_35(p_u_11, p12) -- name: addHealthBar
	-- upvalues: (copy) v_u_8, (ref) v_u_9, (copy) v_u_3, (copy) v_u_4, (copy) v_u_6, (ref) v_u_7, (copy) v_u_5
	local v13 = v_u_8[p_u_11]
	if v13 and p_u_11 ~= v_u_9 then
		local v_u_14 = p12 or p_u_11.Character
		local v15 = p_u_11.Name
		local v16 = workspace:WaitForChild("LoadingStatus")
		local v17 = tick()
		while (not v_u_14 or v_u_14.Parent == nil) and tick() - v17 < 30 do
			v_u_14 = p_u_11.Character
			if not v_u_14 then
				task.wait(0.5)
			end
		end
		if v_u_14 and p_u_11.Character == v_u_14 then
			if v13.currentCharacter == v_u_14 then
				local v18 = v_u_14:WaitForChild("Head", 10)
				if v18 and v18.Parent == v_u_14 then
					local v19 = "Assault"
					local v20 = 0
					local v21 = v16.Players:WaitForChild(v15)
					if v21 then
						local v22 = v21:WaitForChild("Class")
						local v23 = v21:WaitForChild("Level")
						if v22 then
							v19 = v22.Value
						end
						if v23 then
							v20 = v23.Value
						end
					end
					if v_u_14 and (v_u_14.Parent and (v18 and v18.Parent)) then
						local v_u_24 = v_u_3:Clone()
						v_u_24.Parent = v18
						local v25 = v_u_4[v19] or "rbxassetid://4458718282"
						v_u_24.ImageLabel.Image = v25
						v_u_24.Username.Text = "@" .. p_u_11.Name
						v_u_24.DisplayName.Text = p_u_11.DisplayName or p_u_11.Name
						v_u_24.LevelLabel.Text = tostring(v20)
						if p_u_11.MembershipType == Enum.MembershipType.Premium then
							v_u_24.PremiumIcon.Visible = true
							v_u_24.DisplayName.Position = UDim2.new(0.285, 0, 0.1, 0)
							v_u_24.DisplayName.Size = UDim2.new(0.71, 0, 0.5, 0)
						end
						if v20 >= 100 then
							v_u_24.LevelLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
							v_u_24.ImageLabel.ImageColor3 = Color3.fromRGB(255, 215, 0)
						end
						local v26, v_u_27 = pcall(function()
							-- upvalues: (ref) v_u_6, (copy) p_u_11
							return v_u_6:WaitForPlayerState(p_u_11)
						end)
						if v26 and v_u_27 then
							local v_u_34 = v_u_27.HealthChanged:Connect(function(p28, _)
								-- upvalues: (copy) v_u_24, (copy) v_u_27, (ref) v_u_7, (ref) v_u_5
								if v_u_24 and v_u_24.Parent then
									local v29 = v_u_27.MaxHP or 100
									v_u_7 = p28
									local v30
									if p28 <= v29 * 0.4 then
										v30 = v_u_5.Low
									elseif p28 <= v29 * 0.6 then
										v30 = v_u_5.Medium
									else
										v30 = v_u_5.High
									end
									v_u_24.Bar.HPFill.BackgroundColor3 = v30
									local v31 = v_u_24.Bar.HPFill
									local v32 = UDim2.new
									local v33 = p28 / v29
									v31.Size = v32(math.clamp(v33, 0, 1), 0, 1, 0)
								end
							end)
							v_u_14.AncestryChanged:Connect(function()
								-- upvalues: (ref) v_u_14, (copy) v_u_34
								if not v_u_14.Parent then
									v_u_34:Disconnect()
								end
							end)
						else
							warn("HealthBarController: Failed to get player state for", v15)
						end
					else
						warn("HealthBarController: Character or head no longer exists for", v15)
					end
				else
					warn("HealthBarController: Head not found for player", v15)
				end
			else
				return
			end
		else
			warn("HealthBarController: Character not found for player", v15)
			return
		end
	else
		return
	end
end
local function v_u_43(p_u_36) -- name: trackPlayer
	-- upvalues: (ref) v_u_9, (copy) v_u_8, (copy) v_u_35
	if v_u_9 and (p_u_36 ~= v_u_9 and not v_u_8[p_u_36]) then
		local v_u_37 = {}
		local function v40(p_u_38) -- name: onCharacterAdded
			-- upvalues: (copy) v_u_37, (ref) v_u_35, (copy) p_u_36
			v_u_37.currentCharacter = p_u_38
			task.spawn(function()
				-- upvalues: (copy) p_u_38
				local v39 = p_u_38:WaitForChild("Humanoid", 10)
				if v39 then
					v39.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
				end
			end)
			task.spawn(v_u_35, p_u_36, p_u_38)
		end
		v_u_8[p_u_36] = v_u_37
		v_u_37.characterAddedConn = p_u_36.CharacterAdded:Connect(v40)
		if p_u_36.Character then
			local v_u_41 = p_u_36.Character
			v_u_37.currentCharacter = v_u_41
			task.spawn(function()
				-- upvalues: (copy) v_u_41
				local v42 = v_u_41:WaitForChild("Humanoid", 10)
				if v42 then
					v42.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
				end
			end)
			task.spawn(v_u_35, p_u_36, v_u_41)
		end
	end
end
function v10.Init(_, p44) -- name: Init
	-- upvalues: (ref) v_u_9, (copy) v_u_1, (copy) v_u_43, (copy) v_u_8
	v_u_9 = p44
	if not p44.Character then
		p44.CharacterAdded:Wait()
	end
	v_u_1.PlayerAdded:Connect(v_u_43)
	v_u_1.PlayerRemoving:Connect(function(p45)
		-- upvalues: (ref) v_u_8
		local v46 = v_u_8[p45]
		if v46 then
			if v46.characterAddedConn then
				v46.characterAddedConn:Disconnect()
			end
			v_u_8[p45] = nil
		end
	end)
	for _, v47 in v_u_1:GetPlayers() do
		task.defer(v_u_43, v47)
	end
end
return v10