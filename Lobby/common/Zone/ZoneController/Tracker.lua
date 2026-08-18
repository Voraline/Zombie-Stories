local v_u_1 = game:GetService("Players")
local _ = game:GetService("RunService").Heartbeat
local v2 = require("../Signal")
local v_u_3 = require("../Janitor")
local v_u_4 = {}
v_u_4.__index = v_u_4
local v_u_5 = {}
v_u_4.trackers = v_u_5
v_u_4.itemAdded = v2.new()
v_u_4.itemRemoved = v2.new()
v_u_4.bodyPartsToIgnore = {
	["UpperTorso"] = true,
	["LowerTorso"] = true,
	["Torso"] = true,
	["LeftHand"] = true,
	["RightHand"] = true,
	["LeftFoot"] = true,
	["RightFoot"] = true
}
function v_u_4.getCombinedTotalVolumes() -- name: getCombinedTotalVolumes
	-- upvalues: (copy) v_u_5
	local v6 = 0
	for v7, _ in pairs(v_u_5) do
		v6 = v6 + v7.totalVolume
	end
	return v6
end
function v_u_4.getCharacterSize(p8) -- name: getCharacterSize
	local v9
	if p8 then
		v9 = p8:FindFirstChild("Head")
	else
		v9 = p8
	end
	if p8 then
		p8 = p8:FindFirstChild("HumanoidRootPart")
	end
	if not (p8 and v9) then
		return nil
	end
	if not v9:IsA("BasePart") then
		v9 = p8
	end
	local v10 = v9.Size.Y
	local v11 = p8.Size
	return v11 * Vector3.new(2, 2, 1) + Vector3.new(0, v10, 0), p8.CFrame * CFrame.new(0, v10 / 2 - v11.Y / 2, 0)
end
function v_u_4.new(p12) -- name: new
	-- upvalues: (copy) v_u_4, (copy) v_u_3, (copy) v_u_1, (copy) v_u_5
	local v_u_13 = {}
	local v14 = v_u_4
	setmetatable(v_u_13, v14)
	v_u_13.name = p12
	v_u_13.totalVolume = 0
	v_u_13.parts = {}
	v_u_13.partToItem = {}
	v_u_13.items = {}
	v_u_13.whitelistParams = nil
	v_u_13.characters = {}
	v_u_13.baseParts = {}
	v_u_13.exitDetections = {}
	v_u_13.janitor = v_u_3.new()
	if p12 == "player" then
		local function v_u_18() -- name: updatePlayerCharacters
			-- upvalues: (ref) v_u_1, (copy) v_u_13
			local v15 = {}
			for _, v16 in pairs(v_u_1:GetPlayers()) do
				local v17 = v16.Character
				if v17 then
					v15[v17] = true
				end
			end
			v_u_13.characters = v15
		end
		local function v25(p19) -- name: playerAdded
			-- upvalues: (copy) v_u_18, (copy) v_u_13
			local function v23(p20) -- name: charAdded
				-- upvalues: (ref) v_u_18, (ref) v_u_13
				local v21 = p20:WaitForChild("Humanoid", 3)
				if v21 then
					v_u_18()
					v_u_13:update()
					for _, v22 in pairs(v21:GetChildren()) do
						if v22:IsA("NumberValue") then
							v22.Changed:Connect(function()
								-- upvalues: (ref) v_u_13
								v_u_13:update()
							end)
						end
					end
				end
			end
			if p19.Character then
				v23(p19.Character)
			end
			p19.CharacterAdded:Connect(v23)
			p19.CharacterRemoving:Connect(function(p24)
				-- upvalues: (ref) v_u_13
				v_u_13.exitDetections[p24] = nil
			end)
		end
		v_u_1.PlayerAdded:Connect(v25)
		for _, v26 in pairs(v_u_1:GetPlayers()) do
			v25(v26)
		end
		v_u_1.PlayerRemoving:Connect(function(_)
			-- upvalues: (copy) v_u_18, (copy) v_u_13
			v_u_18()
			v_u_13:update()
		end)
	elseif p12 == "item" then
		v_u_4.itemAdded:Connect(function(p27)
			-- upvalues: (copy) v_u_13
			if p27.isCharacter then
				v_u_13.characters[p27.item] = true
			elseif p27.isBasePart then
				v_u_13.baseParts[p27.item] = true
			end
			v_u_13:update()
		end)
		v_u_4.itemRemoved:Connect(function(p28)
			-- upvalues: (copy) v_u_13
			v_u_13.exitDetections[p28.item] = nil
			if p28.isCharacter then
				v_u_13.characters[p28.item] = nil
			elseif p28.isBasePart then
				v_u_13.baseParts[p28.item] = nil
			end
			v_u_13:update()
		end)
	end
	v_u_5[v_u_13] = true
	task.defer(v_u_13.update, v_u_13)
	return v_u_13
end
function v_u_4._preventMultiFrameUpdates(p_u_29, p_u_30, ...) -- name: _preventMultiFrameUpdates
	p_u_29._preventMultiDetails = p_u_29._preventMultiDetails or {}
	local v_u_31 = p_u_29._preventMultiDetails[p_u_30]
	if not v_u_31 then
		v_u_31 = {
			["calling"] = false,
			["callsThisFrame"] = 0,
			["updatedThisFrame"] = false
		}
		p_u_29._preventMultiDetails[p_u_30] = v_u_31
	end
	v_u_31.callsThisFrame = v_u_31.callsThisFrame + 1
	if v_u_31.callsThisFrame ~= 1 then
		return true
	end
	local v_u_32 = table.pack(...)
	task.defer(function()
		-- upvalues: (ref) v_u_31, (copy) p_u_29, (copy) p_u_30, (copy) v_u_32
		local v33 = v_u_31.callsThisFrame
		v_u_31.callsThisFrame = 0
		if v33 > 1 then
			local v34 = v_u_32
			p_u_29[p_u_30](p_u_29, unpack(v34))
		end
	end)
	return false
end
function v_u_4.update(p_u_35) -- name: update
	-- upvalues: (copy) v_u_4, (copy) v_u_3
	if not p_u_35:_preventMultiFrameUpdates("update") then
		p_u_35.totalVolume = 0
		p_u_35.parts = {}
		p_u_35.partToItem = {}
		p_u_35.items = {}
		for v_u_36, _ in pairs(p_u_35.characters) do
			local v37 = v_u_4.getCharacterSize(v_u_36)
			if v37 then
				local v38 = v37.X * v37.Y * v37.Z
				p_u_35.totalVolume = p_u_35.totalVolume + v38
				local v39 = p_u_35.janitor:add(v_u_3.new(), "destroy", "trackCharacterParts-" .. p_u_35.name)
				local v_u_40 = v39
				for _, v_u_41 in pairs(v_u_36:GetChildren()) do
					if v_u_41:IsA("BasePart") and not v_u_4.bodyPartsToIgnore[v_u_41.Name] then
						p_u_35.partToItem[v_u_41] = v_u_36
						local v42 = p_u_35.parts
						table.insert(v42, v_u_41)
						v_u_40:add(v_u_41.AncestryChanged:Connect(function()
							-- upvalues: (copy) v_u_41, (ref) v_u_40, (copy) p_u_35
							if not v_u_41:IsDescendantOf(game) and (v_u_41.Parent == nil and v_u_40 ~= nil) then
								v_u_40:destroy()
								v_u_40 = nil
								p_u_35:update()
							end
						end), "Disconnect")
					end
				end
				v_u_40:add(v_u_36.AncestryChanged:Connect(function()
					-- upvalues: (copy) v_u_36, (ref) v_u_40, (copy) p_u_35
					if not v_u_36:IsDescendantOf(game) and (v_u_36.Parent == nil and v_u_40 ~= nil) then
						v_u_40:destroy()
						v_u_40 = nil
						p_u_35:update()
					end
				end), "Disconnect")
				local v43 = p_u_35.items
				table.insert(v43, v_u_36)
			end
		end
		for v44, _ in pairs(p_u_35.baseParts) do
			local v45 = v44.Size
			local v46 = v45.X * v45.Y * v45.Z
			p_u_35.totalVolume = p_u_35.totalVolume + v46
			p_u_35.partToItem[v44] = v44
			local v47 = p_u_35.parts
			table.insert(v47, v44)
			local v48 = p_u_35.items
			table.insert(v48, v44)
		end
		p_u_35.whitelistParams = OverlapParams.new()
		p_u_35.whitelistParams.FilterType = Enum.RaycastFilterType.Whitelist
		p_u_35.whitelistParams.MaxParts = #p_u_35.parts
		p_u_35.whitelistParams.FilterDescendantsInstances = p_u_35.parts
	end
end
return v_u_4