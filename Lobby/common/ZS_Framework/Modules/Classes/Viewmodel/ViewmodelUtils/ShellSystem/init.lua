local v1 = {}
local v_u_2 = {}
local v_u_3 = 0
local v_u_4 = script.SFX:GetChildren()
local v_u_5 = script.SFX_Shell:GetChildren()
local v_u_6 = game:GetService("TweenService")
local v_u_7 = require("@game/ReplicatedStorage/common/PartCache")
local v_u_8 = require("@game/ReplicatedStorage/common/Settings")
local v_u_9 = require("@game/ReplicatedStorage/Packages/Fusion").peek
local v_u_10 = nil
local v_u_11 = nil
local v_u_12 = nil
local v_u_13 = {}
function v1.Eject(_, p14) -- name: Eject
	-- upvalues: (copy) v_u_9, (copy) v_u_8, (ref) v_u_10, (copy) v_u_13, (copy) v_u_7, (ref) v_u_12, (copy) v_u_5, (copy) v_u_4, (copy) v_u_6, (copy) v_u_2
	if p14.EjectionAttachment then
		if v_u_9(v_u_8.Graphics.BulletShells) then
			local v15 = p14.EjectionAttachment
			v_u_10 = v15
			local v_u_16 = p14.Weapon.Config.BulletCasing or "rifle"
			if not v_u_13[v_u_16] then
				v_u_13[v_u_16] = v_u_7.new(game.ReplicatedStorage.common.SharedResources.Shells[v_u_16], 30, workspace.Ignore)
			end
			local v_u_17 = v_u_13[v_u_16]:GetPart()
			v_u_17.Name = v_u_16
			v_u_17.Anchored = true
			v_u_17.CFrame = v15.WorldCFrame
			v_u_17.Size = game.ReplicatedStorage.common.SharedResources.Shells[v_u_16].Size * (p14.Weapon.Config.WorldScaleValue or 1)
			v_u_17.Transparency = 0
			v_u_17.Parent = workspace.Ignore
			local v18 = {
				["Shell"] = nil,
				["Attachment"] = nil,
				["Lifetime"] = 0,
				["InitialCFrame"] = nil,
				["InitialVelocity"] = nil,
				["YPos"] = nil,
				["InitRotation"] = nil,
				["Shell"] = v_u_17,
				["Attachment"] = v15,
				["InitialCFrame"] = v_u_17.CFrame,
				["InitialVelocity"] = v15.WorldCFrame.RightVector.Unit * math.random(11, 17) * (1 + (v_u_12 or 1)),
				["YPos"] = 6 - math.random(-5, 5),
				["InitRotation"] = math.random(-360, 360)
			}
			task.delay(0.4 + math.random(100, 500) * 0.001, function()
				-- upvalues: (copy) v_u_17, (copy) v_u_16, (ref) v_u_5, (ref) v_u_4, (ref) v_u_6
				local v19 = Instance.new("Attachment")
				v19.Parent = workspace.Terrain
				v19.WorldCFrame = v_u_17.CFrame
				local v20
				if v_u_16 == "shotgun" then
					v20 = v_u_5[math.random(1, #v_u_5)]:Clone()
				else
					v20 = v_u_4[math.random(1, #v_u_4)]:Clone()
				end
				v20.PlaybackSpeed = 0.95
				v20.Parent = v19
				v20:Play()
				if v_u_16 ~= "shotgun" then
					v_u_6:Create(v20, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false), {
						["Volume"] = 0
					}):Play()
				end
				game.Debris:AddItem(v19, 7)
			end)
			v_u_6:Create(v_u_17, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0.75), {
				["Transparency"] = 1
			}):Play()
			local v21 = v_u_2
			table.insert(v21, v18)
		end
	else
		return
	end
end
function v1.Update(_, p22) -- name: Update
	-- upvalues: (ref) v_u_3, (ref) v_u_10, (ref) v_u_11, (ref) v_u_12, (copy) v_u_2, (copy) v_u_13
	v_u_3 = v_u_3 + p22
	if v_u_3 >= 0.016666666666666666 then
		local v23 = v_u_3
		v_u_3 = 0
		if v_u_10 then
			if v_u_11 then
				v_u_12 = (v_u_10.WorldPosition - v_u_11):Dot(v_u_10.WorldCFrame.RightVector) / v23 * 0.05
			end
			v_u_11 = v_u_10.WorldPosition
		end
		local v24 = {}
		local v25 = {}
		for v26 = #v_u_2, 1, -1 do
			local v27 = v_u_2[v26]
			local v28 = v27.Shell
			if v27.Lifetime >= 1.5 or not v28.Parent then
				v_u_13[v28.Name]:ReturnPart(v28)
				table.remove(v_u_2, v26)
			else
				v27.Lifetime = v27.Lifetime + v23
				local v29 = v27.Lifetime / 0.15
				local v30 = math.clamp(v29, 0, 1)
				local v31 = v27.YPos - v23 * 25
				v27.YPos = math.clamp(v31, -100, 15)
				local v32 = CFrame.Angles
				local v33 = v27.InitRotation
				local v34 = v32(0, 0, math.rad(v33) + v27.Lifetime * 12)
				local v35 = v27.InitialVelocity
				local v36 = v27.YPos
				local v37 = (v35 + Vector3.new(0, v36, 0)) * v27.Lifetime
				local v38 = v27.InitialCFrame * v34 + v37
				local v39 = (v27.Attachment.WorldCFrame * v34 + v37):Lerp(v38, v30)
				table.insert(v24, v28)
				table.insert(v25, v39)
			end
		end
		if #v24 > 0 then
			workspace:BulkMoveTo(v24, v25, Enum.BulkMoveMode.FireCFrameChanged)
		end
	end
end
return v1