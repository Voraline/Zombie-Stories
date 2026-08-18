local v_u_1 = game:GetService("SoundService")
local v2 = {}
local v_u_3 = script:WaitForChild("HitMarkLense")
local v_u_4 = v_u_3:WaitForChild("Crosshair"):WaitForChild("Hitmarker")
v_u_3.Parent = game.Players.LocalPlayer.PlayerGui
local v5 = require(script:WaitForChild("SpriteClip"))
local v_u_6 = game:GetService("TweenService")
local v_u_7 = v5.new()
v_u_7.InheritSpriteSheet = true
v_u_7.SpriteSizePixel = Vector2.new(341.3333333333333, 341.3333333333333)
v_u_7.SpriteCountX = 3
v_u_7.SpriteCount = 9
v_u_7.FrameRate = 60
v_u_7.CurrentFrame = 9
v_u_7.Looped = false
local v_u_8 = nil
local v_u_9 = nil
function v2.Init(_, p10) -- name: Init
	-- upvalues: (ref) v_u_8, (copy) v_u_7, (ref) v_u_9, (copy) v_u_6
	v_u_8 = p10
	v_u_7.Adornee = v_u_8:WaitForChild("Crosshair"):WaitForChild("SpriteLabel")
	v_u_9 = v_u_6:Create(v_u_8.Crosshair.ArmorIcon, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
		["ImageTransparency"] = 1
	})
end
function v2.UpdateLense(_, p11) -- name: UpdateLense
	-- upvalues: (copy) v_u_7, (copy) v_u_4, (copy) v_u_3, (ref) v_u_8
	if p11 and p11.Parent then
		v_u_7.Adornee.Parent = v_u_4
		v_u_3.Enabled = true
		local v12 = p11.Position
		local v13 = p11:FindFirstAncestorWhichIsA("Part")
		local v14 = Vector2.new(v12.X.Scale, v12.Y.Scale)
		local _ = v13.Size
		local v15 = v13.CFrame * CFrame.new(-(v13.Size.X / 2) + v13.Size.X * v14.X, v13.Size.Y / 2 - v13.Size.Y * v14.Y, 0)
		local v16 = workspace.Camera:WorldToScreenPoint(v15.p)
		v_u_4.Position = UDim2.new(0, v16.X, 0, v16.Y)
	else
		v_u_7.Adornee.Parent = v_u_8.Crosshair
		v_u_3.Enabled = false
	end
end
function v2.Emit(_, p17, p18, p19) -- name: Emit
	-- upvalues: (ref) v_u_9, (ref) v_u_8, (copy) v_u_1, (copy) v_u_7
	local v20 = p17 or Color3.new(1, 1, 1)
	if p18 == "HitArmor" then
		v_u_9:Cancel()
		v_u_8.Crosshair.ArmorIcon.Image = "rbxassetid://9021696258"
		v_u_8.Crosshair.ArmorIcon.ImageTransparency = -2
		v_u_8.Crosshair.ArmorIcon.ImageColor3 = Color3.new(1, 1, 1)
		v_u_9:Play()
		local v_u_21 = script.Parent.Parent.Resources.hitarmor:Clone()
		v_u_21.TimePosition = 0.08
		v_u_21.Parent = v_u_1
		v_u_21:Play()
		task.delay(5, function()
			-- upvalues: (copy) v_u_21
			v_u_21:Destroy()
		end)
	elseif p18 == "BrokeArmor" then
		v_u_9:Cancel()
		v_u_8.Crosshair.ArmorIcon.Image = "rbxassetid://9021696096"
		v_u_8.Crosshair.ArmorIcon.ImageColor3 = Color3.new(0, 0.65098, 1)
		v_u_8.Crosshair.ArmorIcon.ImageTransparency = -2
		v_u_9:Play()
		local v_u_22 = script.Parent.Parent.Resources.breakarmor:Clone()
		v_u_22.TimePosition = 0.08
		v_u_22.Parent = v_u_1
		v_u_22:Play()
		task.delay(5, function()
			-- upvalues: (copy) v_u_22
			v_u_22:Destroy()
		end)
	elseif not (p19 and p19.dontDoSound) then
		local v_u_23 = script.Parent.Parent.Resources.hitmarker:Clone()
		v_u_23.Parent = v_u_1
		v_u_23:Play()
		task.delay(5, function()
			-- upvalues: (copy) v_u_23
			v_u_23:Destroy()
		end)
	end
	if p18 ~= "HitArmor" then
		v_u_7.Adornee.Visible = true
		v_u_7.Adornee.ImageColor3 = v20
		v_u_7:Play()
	end
end
return v2