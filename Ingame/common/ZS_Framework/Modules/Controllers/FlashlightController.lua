local v1 = game.ReplicatedStorage.common
local v2 = game.ReplicatedStorage.common.RedEvents
local v_u_3 = require("./LocalPlayerController")
local v_u_4 = require(v1.PlayerHandler)
local v_u_5 = require(v2.Framework.FlashlightEvent)
local v_u_6 = {}
local v_u_7 = {}
local v_u_8 = {}
local v_u_9 = {}
local v_u_10 = {}
local v_u_11 = game.Players.LocalPlayer
local v_u_30 = {
	["SetFlashlightEnabled"] = function(_, p12, p13, p14) -- name: SetFlashlightEnabled
		-- upvalues: (copy) v_u_11, (copy) v_u_8, (copy) v_u_6, (copy) v_u_7, (copy) v_u_9, (copy) v_u_5
		local v15 = p13 or v_u_11
		local v16 = v_u_8[v15] ~= nil and true or not p12
		local v17 = v15.Name
		assert(v16, ("Player \'%s\' has no flashlight folder"):format(v17))
		local v18 = v_u_6[v15]
		v_u_6[v15] = p12
		if not p14 then
			v_u_7[v15] = p12
		end
		local v19 = v_u_9[v15]
		if p12 then
			if v18 then
				removeFlashlight(v15)
				v19 = nil
			end
			if not v19 then
				v19 = createFlashlight(v15)
				v_u_9[v15] = v19
			end
		end
		if v19 then
			for _, v20 in v19:GetChildren() do
				if v20:IsA("Light") then
					v20.Enabled = p12
				end
			end
		end
		if v15 == v_u_11 then
			v_u_5:FireServer({
				["Type"] = "SetEnabled",
				["Enabled"] = nil,
				["Enabled"] = p12
			})
		end
	end,
	["SetFlashlightFolder"] = function(_, p21, p22) -- name: SetFlashlightFolder
		-- upvalues: (copy) v_u_11, (copy) v_u_8, (copy) v_u_9, (copy) v_u_6, (copy) v_u_5
		local v23 = p22 or v_u_11
		local v24 = p21:IsA("Folder")
		assert(v24, "Must pass a folder with lights")
		v_u_8[v23] = p21
		if v_u_9[v23] then
			removeFlashlight(v23)
		end
		v_u_9[v23] = createFlashlight(v23, v_u_6[v23])
		if v23 == v_u_11 then
			v_u_5:FireServer({
				["Type"] = "SetFolder",
				["Folder"] = nil,
				["Folder"] = p21
			})
		else
			createFlashlightConstraints(v23)
		end
	end,
	["UpdatePlayerLookDirection"] = function(_, p25, p26) -- name: UpdatePlayerLookDirection
		-- upvalues: (copy) v_u_9, (copy) v_u_11, (copy) v_u_10, (copy) v_u_3
		local v27 = v_u_9[p26]
		if v27 then
			if p26 == v_u_11 then
				if v_u_3.ThirdPerson and v_u_11.character then
					v27.CFrame = workspace.CurrentCamera.CFrame.Rotation + v_u_3.head.Position
					return
				end
				v27.CFrame = workspace.CurrentCamera.CFrame
			elseif v27 then
				local v28 = v_u_10[p26]
				if v28 and v28.HRPAttachment.Parent then
					local v29 = v28.HRPAttachment.Parent
					v28.HRPAttachment.CFrame = v29.CFrame.Rotation:ToObjectSpace(CFrame.new(Vector3.new(0, 0, 0), p25))
					return
				end
			end
		end
	end
}
function createFlashlight(p_u_31, p32) -- name: createFlashlight
	-- upvalues: (copy) v_u_8, (copy) v_u_11, (copy) v_u_9
	local v33 = v_u_8[p_u_31]
	local v34 = v33 ~= nil
	local v35 = p_u_31.Name
	assert(v34, ("Player \'%s\' has no flashlight folder"):format(v35))
	local v36 = Instance.new("Part")
	v36.Name = p_u_31.Name .. "Flashlight"
	v36.Anchored = true
	v36.CanCollide = false
	v36.CanQuery = false
	v36.CanTouch = false
	v36.Transparency = 1
	v36.Massless = true
	for _, v37 in v33:QueryDescendants("Light") do
		local v38 = v37:Clone()
		v38.Parent = v36
		if p32 ~= nil then
			v38.Enabled = p32
		end
	end
	v36.Parent = workspace.Ignore
	if p_u_31 ~= v_u_11 then
		createFlashlightConstraints(p_u_31)
	end
	v36.Destroying:Connect(function()
		-- upvalues: (ref) v_u_9, (copy) p_u_31
		v_u_9[p_u_31] = nil
	end)
	return v36
end
function removeFlashlight(p39) -- name: removeFlashlight
	-- upvalues: (copy) v_u_9, (copy) v_u_10
	local v40 = v_u_9[p39]
	local v41 = v_u_10[p39]
	if v40 then
		v40:Destroy()
		v_u_9[p39] = nil
	end
	if v41 then
		for _, v42 in v41 do
			v42:Destroy()
		end
	end
end
function createFlashlightConstraints(p43) -- name: createFlashlightConstraints
	-- upvalues: (copy) v_u_9, (copy) v_u_10
	local v44 = v_u_9[p43]
	local v45 = v_u_10[p43]
	if v45 then
		for _, v46 in v45 do
			v46:Destroy()
		end
		v_u_10[p43] = nil
	end
	if v44 and (p43.Character and (p43.Character:FindFirstChild("HumanoidRootPart") and p43.Character:FindFirstChild("Head"))) then
		local v47 = p43.Character.HumanoidRootPart
		local v48 = p43.Character.Head
		v44.Anchored = false
		local v49 = Instance.new("Attachment")
		v49.Parent = v44
		local v50 = Instance.new("Attachment")
		v50.Parent = v48
		v50.Name = "FlashlightHeadAttachment"
		local v51 = Instance.new("Attachment")
		v51.Parent = v47
		v51.Name = "FlashlightHRPAttachment"
		local v52 = Instance.new("AlignPosition")
		v52.Attachment0 = v49
		v52.Attachment1 = v50
		v52.Responsiveness = 200
		v52.MaxForce = (1 / 0)
		v52.Parent = v44
		local v53 = Instance.new("AlignOrientation")
		v53.Attachment0 = v49
		v53.Attachment1 = v51
		v53.Responsiveness = 100
		v53.Parent = v44
		v_u_10[p43] = {
			["FlashlightAttachment"] = v49,
			["HeadAttachment"] = v50,
			["HRPAttachment"] = v51,
			["AlignPosition"] = v52,
			["AlignOrientation"] = v53
		}
	end
end
local v_u_54 = {}
v_u_5:SetClientListener(function(p55)
	-- upvalues: (copy) v_u_8, (copy) v_u_30, (copy) v_u_54
	if p55 then
		if p55.Type == "SetEnabled" then
			if v_u_8[p55.Player] then
				v_u_30:SetFlashlightEnabled(p55.Enabled, p55.Player)
			else
				v_u_54[p55.Player] = p55.Enabled
			end
		end
		if p55.Type == "SetFolder" then
			v_u_30:SetFlashlightFolder(p55.Folder, p55.Player)
			if v_u_54[p55.Player] then
				v_u_30:SetFlashlightEnabled(v_u_54[p55.Player], p55.Player)
				v_u_54[p55.Player] = nil
			end
		end
	end
end)
local function v61(p_u_56) -- name: setupPlayer
	-- upvalues: (copy) v_u_30, (copy) v_u_11, (copy) v_u_9, (copy) v_u_4, (copy) v_u_7
	v_u_30:SetFlashlightEnabled(false, p_u_56)
	p_u_56.CharacterAdded:Connect(function(p57)
		-- upvalues: (copy) p_u_56, (ref) v_u_11, (ref) v_u_9
		if p_u_56 ~= v_u_11 and v_u_9[p_u_56] then
			p57:WaitForChild("HumanoidRootPart")
			createFlashlightConstraints(p_u_56)
		end
	end)
	local v58 = v_u_4:WaitForPlayerState(p_u_56)
	if v58 then
		local function v60(p59) -- name: updateFlashlight
			-- upvalues: (ref) v_u_30, (copy) p_u_56, (ref) v_u_7
			if p59 then
				v_u_30:SetFlashlightEnabled(false, p_u_56, true)
			elseif v_u_7[p_u_56] then
				v_u_30:SetFlashlightEnabled(true, p_u_56, true)
			end
		end
		v58:GetPropertyChangedSignal("IsDead"):Connect(v60)
		if v58.IsDead then
			v_u_30:SetFlashlightEnabled(false, p_u_56, true)
			return
		end
		if v_u_7[p_u_56] then
			v_u_30:SetFlashlightEnabled(true, p_u_56, true)
		end
	end
end
game.Players.PlayerAdded:Connect(v61)
for _, v62 in game.Players:GetPlayers() do
	v61(v62)
end
v_u_5:FireServer()
return v_u_30