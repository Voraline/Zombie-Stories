local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("TweenService")
local v_u_3 = game:GetService("Debris")
game:GetService("CollectionService")
local v4 = v1.common
local v5 = workspace:WaitForChild("Ignore")
local v_u_6 = workspace:WaitForChild("Terrain")
local v7 = script:WaitForChild("Resources")
local v_u_8 = v7:WaitForChild("Beam")
local v9 = v7:WaitForChild("ImpactPart")
local v_u_10 = require("@self/BloodVFX")
local v_u_11 = workspace.CurrentCamera
local v_u_12 = {
	[Enum.Material.Asphalt] = true,
	[Enum.Material.Basalt] = true,
	[Enum.Material.Brick] = true,
	[Enum.Material.Cobblestone] = true,
	[Enum.Material.CrackedLava] = true,
	[Enum.Material.Glacier] = true,
	[Enum.Material.Grass] = true,
	[Enum.Material.Ground] = true,
	[Enum.Material.Ice] = true,
	[Enum.Material.LeafyGrass] = true,
	[Enum.Material.Limestone] = true,
	[Enum.Material.Mud] = true,
	[Enum.Material.Pavement] = true,
	[Enum.Material.Rock] = true,
	[Enum.Material.Salt] = true,
	[Enum.Material.Sand] = true,
	[Enum.Material.Sandstone] = true,
	[Enum.Material.Slate] = true,
	[Enum.Material.Snow] = true,
	[Enum.Material.WoodPlanks] = true
}
local v13 = require(v4:WaitForChild("PartCache"))
local v_u_14 = require(v4.Settings)
local v_u_15 = require(game:GetService("ReplicatedStorage").Packages.Fusion).peek
local v_u_16 = require(game.ReplicatedStorage.common:WaitForChild("NPCs_Shared"):WaitForChild("Utils"):WaitForChild("ClassMirror"))
local v_u_17 = require("@game/ReplicatedStorage/common/NPCs_Shared/Utils/Encoder_Util")
local v_u_18 = TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
local v_u_19 = v13.new(v9, 50, v5)
local v_u_20 = v_u_15(v_u_14.Graphics.ParticleQuality)
local v_u_21 = {}
local function v_u_31(p22, p23) -- name: isInView
	-- upvalues: (copy) v_u_11
	local v24 = v_u_11.CFrame.LookVector
	local v25 = p22 - v_u_11.CFrame.Position
	local v26 = v_u_11.FieldOfView + 2
	local v27 = v25.Unit:Angle(v24)
	local v28 = math.deg(v27)
	if math.floor(v28) > v26 then
		return false
	end
	if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character.PrimaryPart then
		v25 = p22 - game.Players.LocalPlayer.Character.PrimaryPart.Position or v25
	end
	local v29 = v25.X
	local v30 = v25.Z
	return Vector3.new(v29, 0, v30).Magnitude <= p23
end
v_u_14.SettingsChanged:Connect(function()
	-- upvalues: (ref) v_u_20, (copy) v_u_15, (copy) v_u_14
	v_u_20 = v_u_15(v_u_14.Graphics.ParticleQuality)
end)
local v_u_86 = {
	["BloodQueue"] = {},
	["BulletTrail"] = function(_, p32, p33, p34) -- name: BulletTrail
		-- upvalues: (copy) v_u_15, (copy) v_u_14, (copy) v_u_8, (copy) v_u_6
		if v_u_15(v_u_14.Graphics.BulletTracers) then
			local v35 = p32 or game.Players.LocalPlayer.Character.Head.FaceFrontAttachment
			local v_u_36
			if p34 then
				if p34.CustomTrailVFX then
					p34.CustomTrailVFX(v35, p33)
					return
				end
				v_u_36 = v_u_8:Clone()
				if p34.Properties then
					for v37, v38 in p34.Properties do
						v_u_36[v37] = v38
					end
				end
			else
				v_u_36 = v_u_8:Clone()
			end
			local v_u_39 = Instance.new("Attachment")
			v_u_39.Parent = v_u_6
			v_u_39.WorldPosition = p33
			v_u_36.Attachment0 = v_u_39
			v_u_36.Attachment1 = v35
			v_u_36.Parent = v_u_6
			task.delay(0.07, function()
				-- upvalues: (ref) v_u_36, (copy) v_u_39
				v_u_36:Destroy()
				v_u_39:Destroy()
			end)
		end
	end,
	["BloodNPC"] = function(_, p40, p41, p42, p43) -- name: BloodNPC
		-- upvalues: (copy) v_u_16, (ref) v_u_20, (copy) v_u_17, (copy) v_u_86
		if not game:GetService("GuiService"):IsTenFootInterface() then
			local v44 = v_u_16:GetObjFromId(p41)
			if v44 then
				if not (v44.UIDTable and v44.UIDTable[p42]) then
					return
				end
				local v45 = v44.UIDTable[p42]
				local v46 = Instance.new("Sound")
				v46.SoundId = "rbxassetid://" .. (p40.HitSFX and (p40.HitSFX.ID or "358942915") or "358942915")
				v46.PlaybackSpeed = (p40.HitSFX and (p40.HitSFX.PlaybackSpeed or 1) or 1) + math.random(-100, 100) * 0.002
				if p40.HitSFX and p40.HitSFX.Volume then
					v46.Volume = p40.HitSFX.Volume
				elseif p40.IsShotgun then
					v46.Volume = 1.5
				else
					v46.Volume = 1.5
				end
				if v45.Parent then
					local v47
					if v45.Name == "Head" then
						v47 = v45.Parent.HumanoidRootPart or v45
					else
						v47 = v45
					end
					v46.Parent = v47
					v46:Play()
				end
				if v_u_20 == 1 then
					return
				end
				if p40.CustomHitVFX then
					local v48
					if p43 then
						local v49, v50, v51 = v_u_17.DecodePositioningData(p43)
						v48 = Vector3.new(v49, v50, v51)
					else
						v48 = nil
					end
					p40.CustomHitVFX(v45, v48)
					return
				end
				local v52
				if p43 then
					local v53, v54, v55 = v_u_17.DecodePositioningData(p43)
					v52 = Vector3.new(v53, v54, v55)
				else
					v52 = nil
				end
				local v56 = v_u_86.BloodQueue
				table.insert(v56, { v45, v52 })
			end
		end
	end,
	["MakeImpact"] = function(_, p57, p58, p59, p60) -- name: MakeImpact
		-- upvalues: (copy) v_u_15, (copy) v_u_14, (copy) v_u_19, (copy) v_u_12, (ref) v_u_20, (copy) v_u_31, (copy) v_u_21, (copy) v_u_2, (copy) v_u_18
		if not p58 or (p58.Instance or p59) then
			local v61 = nil
			local v62, v63
			if p58 then
				v62 = p58.Instance
				if not v62 then
					return
				end
				v61 = p58.Instance.Material
				local v64 = p58.Position
				local v65 = p58.Normal
				v63 = v62.CFrame:ToObjectSpace(CFrame.new(v64, v64 + v65))
			else
				v62 = p59.h
				local v66 = p59.r
				local v67 = p59.p
				local v68 = p59.s
				if not v62 then
					return
				end
				local v69 = RaycastParams.new()
				v69.FilterType = Enum.RaycastFilterType.Whitelist
				v69.FilterDescendantsInstances = { v62 }
				v69.IgnoreWater = true
				if not (v66 or v67) then
					v66 = Vector3.new()
				end
				if v66 then
					v67 = v62.CFrame:ToWorldSpace(CFrame.new(v66)).Position
				end
				local v70 = workspace:Raycast(v68, (v67 - v68).Unit * 1000, v69)
				if not (v70 and v70.Position) then
					return
				end
				local v71 = v70.Position
				local v72 = v70.Normal
				v63 = v62.CFrame:ToObjectSpace(CFrame.new(v71, v71 + v72))
			end
			if not v_u_15(v_u_14.Graphics.BulletHoles) then
				return v63
			end
			local v_u_73 = v_u_19:GetPart()
			v_u_73.Size = Vector3.new(0.05, 0.05, 0.05)
			v_u_73.Decal.Texture = "rbxassetid://64291961"
			v_u_73.Decal.Transparency = 0
			local v_u_74 = nil
			if p60 then
				v_u_73.Anchored = true
				v_u_73.Decal.Transparency = 1
				v_u_73.CFrame = v62.CFrame * v63
			else
				v_u_74 = Instance.new("Weld")
				v_u_74.Part0 = v62
				v_u_74.Part1 = v_u_73
				v_u_74.C0 = v63
				v_u_74.Parent = v_u_73
				v_u_73.Anchored = false
			end
			local v75
			if v62 == workspace.Terrain and (v61 and v_u_12[v61]) then
				v75 = workspace.Terrain:GetMaterialColor(v61):Lerp(Color3.new(1, 1, 1), 0.5)
			else
				v75 = v62.Color:lerp(Color3.new(1, 1, 1), 0.5)
			end
			local v76 = v_u_73.Sound
			if v62 and v62 ~= workspace.Terrain then
				local v77 = v62.Material
				if v77 == Enum.Material.Metal or (v77 == Enum.Material.Neon or (v77 == Enum.Material.CorrodedMetal or v77 == Enum.Material.DiamondPlate)) then
					v76.SoundId = "rbxassetid://142082170"
				elseif v77 == Enum.Material.Wood or v77 == Enum.Material.WoodPlanks then
					v76.SoundId = "rbxassetid://142082171"
				elseif v77 == Enum.Material.Grass or (v77 == Enum.Material.Sand or (v77 == Enum.Material.Pebble or (v77 == Enum.Material.Snow or v77 == Enum.Material.Ground))) then
					v76.SoundId = "rbxassetid://4427231299"
				else
					v76.SoundId = "rbxassetid://142082166"
				end
			else
				v76.SoundId = "rbxassetid://142082166"
			end
			local v78 = v62.Parent
			local v79
			if v78 then
				v79 = v78.Parent
			else
				v79 = nil
			end
			local v80 = nil
			local v81
			if v78 then
				v81 = v78:GetAttribute("ImpactSFX")
				if not v81 and v79 then
					v81 = v79:GetAttribute("ImpactSFX")
				end
				if not p57.isMelee then
					v80 = v78:GetAttribute("ImpactTextureGun")
					if not v80 and v79 then
						v80 = v79:GetAttribute("ImpactTextureGun")
					end
				end
			else
				v81 = nil
			end
			if v81 then
				v76.SoundId = v81
			end
			if v80 then
				v_u_73.Decal.Texture = v80
			end
			if p57.IsMelee then
				v_u_73.Decal.Transparency = 1
			end
			v76:Stop()
			v76:Play()
			v_u_73.Emitter1.Color = ColorSequence.new(v75:lerp(Color3.new(1, 1, 1), 0.5))
			v_u_73.Emitter2.Color = ColorSequence.new(v75)
			local v82 = v_u_20
			local v83 = (game.Players.LocalPlayer:GetAttribute("ClientCPULoad") or 0) >= 25 and 1 or v82
			if v_u_31(v_u_73.Position, 150) then
				local v84 = 0
				if v83 == 4 then
					v84 = math.random(10, 20)
					v_u_73.Emitter2:Emit(v84)
				elseif v83 == 3 then
					v84 = 3
					v_u_73.Emitter2:Emit(v84)
				elseif v83 == 2 then
					v_u_73.Emitter2:Emit(1)
					v84 = 3
				end
				v_u_73.Emitter1:Emit(v84)
			end
			if v83 >= 3 and v_u_74 then
				if not v_u_21[v_u_73] then
					v_u_21[v_u_73] = v_u_2:Create(v_u_73.Decal, v_u_18, {
						["Transparency"] = 1
					})
				end
				v_u_21[v_u_73]:Play()
				local v_u_85 = nil
				v_u_85 = v_u_21[v_u_73].Completed:Connect(function(_)
					-- upvalues: (ref) v_u_74, (copy) v_u_73, (ref) v_u_19, (ref) v_u_85
					v_u_74:Destroy()
					v_u_73.Anchored = true
					v_u_19:ReturnPart(v_u_73)
					v_u_85:Disconnect()
					v_u_85 = nil
				end)
			else
				task.delay(3, function()
					-- upvalues: (ref) v_u_74, (copy) v_u_73, (ref) v_u_19
					if v_u_74 then
						v_u_74:Destroy()
					end
					v_u_73.Anchored = true
					v_u_19:ReturnPart(v_u_73)
				end)
			end
			return v63
		end
	end
}
local v_u_87 = 0
game:GetService("RunService").Heartbeat:Connect(function(_)
	-- upvalues: (copy) v_u_86, (copy) v_u_10, (ref) v_u_87, (ref) v_u_20, (copy) v_u_3
	local v88 = #v_u_86.BloodQueue
	if v88 > 0 then
		local v89 = 0
		for _, v90 in v_u_86.BloodQueue do
			v89 = v89 + 1
			if v89 > 24 then
				break
			end
			table.remove(v_u_86.BloodQueue, 1)
			local v91, v92 = table.unpack(v90)
			local v93 = v_u_10()
			v93.Parent = v91
			v93.Position = v92 or Vector3.new(0, 0, 0)
			v_u_87 = v_u_87 + 1
			v93.Destroying:Once(function()
				-- upvalues: (ref) v_u_87
				v_u_87 = v_u_87 - 1
			end)
			local v94 = v88 + v_u_87
			local v95 = (v94 > 50 and 0.1 or (v94 > 10 and 0.25 or 1)) * (0.25 * v_u_20)
			local v96 = math.random(10, 15) * v95
			local v97 = math.ceil(v96)
			local v98 = math.random(5, 8) * v95
			local v99 = math.ceil(v98)
			v_u_3:AddItem(v93, 2)
			local v100 = v93.Smoke
			local v101 = v93.Dots
			if v_u_20 > 2 then
				v101:Emit(v97)
			end
			v100:Emit(v99)
		end
	end
end)
return v_u_86