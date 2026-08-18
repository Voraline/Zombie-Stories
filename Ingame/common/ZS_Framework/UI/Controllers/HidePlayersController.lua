local v1 = game:GetService("CollectionService")
local v2 = game:GetService("RunService")
game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("Players")
local v_u_4 = require("@game/ReplicatedStorage/common/PlayerHandler")
local v_u_5 = require("@game/ReplicatedStorage/common/Settings")
local v_u_6 = require(game:GetService("ReplicatedStorage").Packages.Fusion).peek
local v7 = {}
local v_u_8 = {}
local v_u_9 = v_u_6(v_u_5.Graphics.HideNearbyPlayers)
local v_u_10 = false
local function v_u_13() -- name: makeVisiblePlayers
	-- upvalues: (copy) v_u_8
	for _, v11 in v_u_8 do
		for _, v12 in v11.Character:QueryDescendants("BasePart, Decal") do
			v12.LocalTransparencyModifier = 0
		end
	end
end
v2.Heartbeat:Connect(function()
	-- upvalues: (copy) v_u_6, (copy) v_u_5, (ref) v_u_9, (copy) v_u_3, (copy) v_u_13, (ref) v_u_10, (copy) v_u_8, (copy) v_u_4
	local v14 = v_u_6(v_u_5.Graphics.HideNearbyPlayers)
	local v15 = v_u_9
	v_u_9 = v14
	local v16 = v_u_3.LocalPlayer.Character
	if v14 then
		if v16 then
			v_u_10 = true
			for _, v17 in v_u_8 do
				if v17.Character and v17.Character.PrimaryPart then
					local v18 = v17.LastDistance
					local v19 = (v16.PrimaryPart.Position - v17.Character.PrimaryPart.Position).Magnitude
					v17.LastDistance = v19
					if v18 < 10 or v19 < 10 then
						local v20 = v19 <= 3 and 1 or (v19 >= 6 and 0 or (6 - v19) / 3)
						local v21 = v_u_4:GetPlayerState(v_u_3.LocalPlayer)
						local v22 = v21 and v21.Properties.IsDowned and 0 or v20
						local v23 = v17.PlayerState and (v17.PlayerState.Properties.IsDowned or v17.PlayerState.Properties.IsDead) and 0 or v22
						for _, v24 in v17.Character:QueryDescendants("BasePart, Decal") do
							v24.LocalTransparencyModifier = v23
						end
					end
				end
			end
		else
			if v_u_10 then
				v_u_13()
			end
			v_u_10 = v16 ~= nil
		end
	else
		if v15 then
			v_u_13()
		end
		return
	end
end)
local function v29(p25) -- name: playerAdded
	-- upvalues: (copy) v_u_3, (copy) v_u_4, (copy) v_u_8
	if v_u_3.LocalPlayer.Character ~= p25 then
		local v26 = v_u_3:GetPlayerFromCharacter(p25)
		local v27 = v_u_4:GetPlayerState(v26)
		v_u_8[p25] = {
			["Character"] = nil,
			["LastDistance"] = 100,
			["LastCheck"] = nil,
			["Player"] = nil,
			["PlayerState"] = nil,
			["Character"] = p25,
			["LastCheck"] = os.time(),
			["Player"] = v26,
			["PlayerState"] = v27
		}
		local v28 = not v27 and v_u_4:WaitForPlayerState(v26)
		if v28 then
			v_u_8[p25].PlayerState = v28
		end
	end
end
local function v32(p30) -- name: playerRemoving
	-- upvalues: (copy) v_u_8
	for _, v31 in p30:QueryDescendants("BasePart, Decal") do
		v31.LocalTransparencyModifier = 0
	end
	v_u_8[p30] = nil
end
local function v34(p33) -- name: weaponAdded
	-- upvalues: (copy) v_u_8
	v_u_8[p33] = {
		["Character"] = nil,
		["LastDistance"] = 100,
		["LastCheck"] = nil,
		["Player"] = nil,
		["PlayerState"] = nil,
		["Character"] = p33,
		["LastCheck"] = os.time()
	}
end
local function v37(p35) -- name: weaponRemoving
	-- upvalues: (copy) v_u_8
	for _, v36 in p35:QueryDescendants("BasePart, Decal") do
		v36.LocalTransparencyModifier = 0
	end
	v_u_8[p35] = nil
end
for _, v38 in v1:GetTagged("PlayerCharacter") do
	v29(v38)
end
v1:GetInstanceAddedSignal("PlayerCharacter"):Connect(v29)
v1:GetInstanceRemovedSignal("PlayerCharacter"):Connect(v32)
for _, v39 in v1:GetTagged("WorldWeapon") do
	v_u_8[v39] = {
		["Character"] = nil,
		["LastDistance"] = 100,
		["LastCheck"] = nil,
		["Player"] = nil,
		["PlayerState"] = nil,
		["Character"] = v39,
		["LastCheck"] = os.time()
	}
end
v1:GetInstanceAddedSignal("WorldWeapon"):Connect(v34)
v1:GetInstanceRemovedSignal("WorldWeapon"):Connect(v37)
return v7