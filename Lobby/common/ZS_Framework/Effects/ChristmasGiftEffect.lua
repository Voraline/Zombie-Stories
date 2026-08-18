local v1 = game:GetService("CollectionService")
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("Debris")
local v_u_4 = game:GetService("RunService")
local v_u_5 = game:GetService("Players")
local v6 = require("@game/ReplicatedStorage/common/zap")
local v_u_7 = require(v_u_2.Packages.Bin)
local v_u_8 = {}
local v_u_9 = { "rbxassetid://9117204119", "rbxassetid://6337264445" }
local v_u_10 = {
	{ Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 255, 0), Color3.fromRGB(0, 0, 255) },
	{ Color3.fromRGB(143, 95, 255), Color3.fromRGB(159, 85, 255), Color3.fromRGB(130, 245, 245) },
	{ Color3.fromRGB(25, 0, 255), Color3.fromRGB(47, 102, 255), Color3.fromRGB(0, 17, 255) },
	{ Color3.fromRGB(255, 0, 0), Color3.fromRGB(209, 52, 52), Color3.fromRGB(224, 69, 69) },
	{ Color3.fromRGB(230, 227, 77), Color3.fromRGB(255, 255, 0), Color3.fromRGB(206, 236, 69) },
	{ Color3.fromRGB(219, 73, 122), Color3.fromRGB(230, 58, 109), Color3.fromRGB(219, 76, 136) }
}
local function v44(p_u_11) -- name: giftAdded
	-- upvalues: (copy) v_u_7, (copy) v_u_8, (copy) v_u_10, (copy) v_u_2, (copy) v_u_9, (copy) v_u_4, (copy) v_u_5
	local v12, v13 = v_u_7()
	v_u_8[p_u_11] = v13
	local v14 = p_u_11.CFrame.Position
	local v15 = v14.X
	local v16 = math.floor(v15)
	local v17 = v14.Y
	local v18 = v16 + math.floor(v17)
	local v19 = v14.Z
	local v20 = v18 + math.floor(v19)
	local v21 = Random.new(v20)
	local v22 = v_u_10[v21:NextInteger(1, #v_u_10)]
	local v23 = v22[v21:NextInteger(1, #v22)]
	local v24 = v22[v21:NextInteger(1, #v22)]
	local v25 = v22[v21:NextInteger(1, #v22)]
	local v26 = v22[v21:NextInteger(1, #v22)]
	local v_u_27 = v12(v_u_2.common.SharedResources.Assets.ChristmasGift:Clone())
	local v28 = v12(v_u_2.common.SharedResources.Assets.ChristmasGiftOpenSparkle:Clone())
	v28.CFrame = p_u_11.CFrame
	v28.Parent = v_u_27.PrimaryPart
	local v_u_29 = 0.01
	v_u_27.PrimaryPart = v_u_27.Base
	v_u_27:ScaleTo(v_u_29)
	v_u_27:SetPrimaryPartCFrame(p_u_11.CFrame)
	for _, v30 in v_u_9 do
		local v31 = v12(Instance.new("Sound"))
		v31.SoundId = v30
		v31.Parent = v_u_27
	end
	for _, v32 in v_u_27:QueryDescendants("BasePart") do
		if v32.Name == "Ribbon" then
			v32.Color = v23
		elseif v32.Name == "Bow" then
			v32.Color = v25
		elseif v32.Name == "Base" then
			v32.Color = v24
		else
			v32.Color = v26
		end
	end
	v_u_27.Parent = workspace
	v12(v_u_4.Heartbeat:Connect(function(p33)
		-- upvalues: (copy) v_u_27, (ref) v_u_29
		local v34 = v_u_27.PrimaryPart.CFrame
		local v35 = CFrame.Angles
		local v36 = p33 * 60
		v_u_27:SetPrimaryPartCFrame(v34 * v35(0, math.rad(v36), 0))
		if v_u_29 < 1 then
			local v37 = v_u_29 + p33 * 1.5
			v_u_29 = math.clamp(v37, 0, 1)
			v_u_27:ScaleTo(v_u_29)
		end
	end))
	local v_u_38 = false
	v12(p_u_11.Touched:Connect(function(p39)
		-- upvalues: (ref) v_u_5, (ref) v_u_38, (copy) p_u_11, (copy) v_u_27
		local v40 = p39.Parent
		if v40 then
			if v40:FindFirstChild("Humanoid") then
				local v41 = v_u_5:GetPlayerFromCharacter(v40)
				if v41 then
					if v41 == v_u_5.LocalPlayer then
						if not v_u_38 then
							v_u_38 = true
							local _ = p_u_11.CFrame
							local v42 = Instance.new("Sound")
							v42.SoundId = "rbxassetid://9117204119"
							v42.Volume = 1
							v42.Parent = workspace
							v42.PlayOnRemove = true
							v42:Destroy()
							for _, v43 in v_u_27:QueryDescendants("BasePart") do
								v43.Transparency = 1
							end
						end
					else
						return
					end
				else
					return
				end
			else
				return
			end
		else
			return
		end
	end))
end
local function v46(p45) -- name: giftRemoved
	-- upvalues: (copy) v_u_8
	if v_u_8[p45] then
		v_u_8[p45]()
		v_u_8[p45] = nil
	end
end
local function v_u_51(p47, p48) -- name: collectedEffect
	-- upvalues: (copy) v_u_5, (copy) v_u_2, (copy) v_u_3
	if p47 == v_u_5.LocalPlayer then
		local v49 = Instance.new("Sound")
		v49.SoundId = "rbxassetid://6337264445"
		v49.Volume = 2
		v49.Parent = workspace
		v49.PlayOnRemove = true
		v49:Destroy()
	end
	local v50 = v_u_2.common.SharedResources.Assets.ChristmasGiftOpenSparkle:Clone()
	v50.CFrame = p48
	v50.Parent = workspace
	v50.Attachment.ParticleEmitter:Emit(1)
	v_u_3:AddItem(v50, 5)
end
local v52 = {}
for _, v53 in v1:GetTagged("ChristmasGift") do
	v44(v53)
end
v1:GetInstanceAddedSignal("ChristmasGift"):Connect(v44)
v1:GetInstanceRemovedSignal("ChristmasGift"):Connect(v46)
v6.ChristmasGiftCollected.On(function(p54)
	-- upvalues: (copy) v_u_51
	if p54.Player:IsA("Player") then
		v_u_51(p54.Player, p54.Gift)
	end
end)
return v52