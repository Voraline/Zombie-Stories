local v1 = game:GetService("TweenService")
local v_u_2 = game:GetService("SoundService")
local v_u_3 = script:WaitForChild("CrosshairUI")
local v_u_4 = script:WaitForChild("HitMarkLense")
local v_u_5 = v_u_4:WaitForChild("Crosshair"):WaitForChild("Hitmarker")
require(game.ReplicatedStorage.common:WaitForChild("HUDService"))
local v6 = require(script:WaitForChild("SpriteClip"))
local v_u_7 = require(script.Parent.Parent.Parent:WaitForChild("LocalPlayerController"))
local v_u_8 = require(script.Parent.Parent.Parent.Parent:WaitForChild("Utils"):WaitForChild("CursorRecoilUtil"))
local v_u_9 = v1:Create(v_u_3.Crosshair.ArmorIcon, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
	["ImageTransparency"] = 1
})
local v_u_10 = {
	[v_u_3:WaitForChild("Crosshair"):WaitForChild("A")] = Vector2.new(0, -1),
	[v_u_3.Crosshair:WaitForChild("B")] = Vector2.new(0, 1),
	[v_u_3.Crosshair:WaitForChild("C")] = Vector2.new(-1, 0),
	[v_u_3.Crosshair:WaitForChild("D")] = Vector2.new(1, 0)
}
local v_u_11 = v6.new()
v_u_11.InheritSpriteSheet = true
v_u_11.SpriteSizePixel = Vector2.new(341.3333333333333, 341.3333333333333)
v_u_11.SpriteCountX = 3
v_u_11.SpriteCount = 9
v_u_11.FrameRate = 60
v_u_11.CurrentFrame = 9
v_u_11.Looped = false
v_u_3.Parent = game.Players.LocalPlayer.PlayerGui
v_u_4.Parent = game.Players.LocalPlayer.PlayerGui
v_u_11.Adornee = v_u_3:WaitForChild("Crosshair"):WaitForChild("SpriteLabel")
v_u_3.Crosshair.Visible = false
v_u_3.NoWeaponCursor.Visible = false
local v_u_12 = {
	["IsShowing"] = true
}
local v_u_13 = "dot"
function v_u_12.Show(_) -- name: Show
	-- upvalues: (copy) v_u_12, (copy) v_u_3
	v_u_12.IsShowing = true
	v_u_3.Enabled = true
end
function v_u_12.Hide(_) -- name: Hide
	-- upvalues: (copy) v_u_12, (copy) v_u_3
	v_u_12.IsShowing = false
	v_u_3.Enabled = false
end
function v_u_12.SetType(_, p14) -- name: SetType
	-- upvalues: (ref) v_u_13, (copy) v_u_3, (copy) v_u_7
	v_u_13 = p14
	if p14 == "cross" then
		v_u_3.Crosshair.Visible = true
		v_u_3.NoWeaponCursor.Visible = false
	elseif p14 == "dot" then
		v_u_3.Crosshair.Visible = false
		v_u_3.NoWeaponCursor.Visible = not v_u_7.ThirdPerson
	end
end
function v_u_12.SetCrossVisible(_, p15) -- name: SetCrossVisible
	-- upvalues: (copy) v_u_10
	for v16, _ in v_u_10 do
		v16.Visible = p15
	end
end
function v_u_12.UpdateCrosshairColor(_, p17) -- name: UpdateCrosshairColor
	-- upvalues: (copy) v_u_10
	for v18, _ in v_u_10 do
		v18.Frame.BackgroundColor3 = p17
	end
end
function v_u_12.UpdateCrosshair(_, p19, p20) -- name: UpdateCrosshair
	-- upvalues: (copy) v_u_8, (copy) v_u_3, (copy) v_u_10
	local v21 = true
	local v22 = v_u_8.crosshairRecoil
	local v23 = workspace.CurrentCamera.ViewportSize
	local v24 = v22.X * v23.X
	local v25 = -v22.Y * v23.Y
	v_u_3.Crosshair.Position = UDim2.new(0.5, p20.X + v24, 0.5, p20.Y + v25)
	if p19.ReloadingTime and not p19.Reloaded then
		v_u_3.Crosshair.ReloadIcon.Visible = true
		local v26 = v_u_3.Crosshair.ReloadIcon
		local v27 = os.clock() * 10
		v26.ImageTransparency = math.sin(v27) / 2.5 + 0.4
		v21 = false
	else
		v_u_3.Crosshair.ReloadIcon.Visible = false
	end
	for v28, _ in v_u_10 do
		v28.Visible = v21
	end
	local v29 = p19.Inaccuracy
	for v30, v31 in v_u_10 do
		v30.Position = UDim2.new(0, v31.X * v29, 0, v31.Y * v29)
	end
end
function v_u_12.HitmarkerUpdateLense(_, p32) -- name: HitmarkerUpdateLense
	-- upvalues: (copy) v_u_11, (copy) v_u_5, (copy) v_u_4, (copy) v_u_3
	if p32 and p32.Parent then
		v_u_11.Adornee.Parent = v_u_5
		v_u_4.Enabled = true
		local v33 = p32.Position
		local v34 = p32:FindFirstAncestorWhichIsA("Part")
		local v35 = Vector2.new(v33.X.Scale, v33.Y.Scale)
		local _ = v34.Size
		local v36 = v34.CFrame * CFrame.new(-(v34.Size.X / 2) + v34.Size.X * v35.X, v34.Size.Y / 2 - v34.Size.Y * v35.Y, 0)
		local v37 = workspace.Camera:WorldToScreenPoint(v36.p)
		v_u_5.Position = UDim2.new(0, v37.X, 0, v37.Y)
	else
		v_u_11.Adornee.Parent = v_u_3.Crosshair
		v_u_4.Enabled = false
	end
end
local function v_u_40(p_u_38) -- name: playSoundRandom
	-- upvalues: (copy) v_u_2
	local v39 = p_u_38.PlaybackSpeed * 100
	p_u_38.PlaybackSpeed = math.random(v39 - 5, v39 + 5) / 100
	p_u_38.Parent = v_u_2
	p_u_38:Play()
	task.delay(5, function()
		-- upvalues: (copy) p_u_38
		p_u_38:Destroy()
	end)
end
function v_u_12.EmitHitmarker(_, p41, p42, p43) -- name: EmitHitmarker
	-- upvalues: (copy) v_u_9, (copy) v_u_3, (copy) v_u_40, (copy) v_u_2, (copy) v_u_11
	local v44 = p41 or Color3.new(1, 1, 1)
	if p42 == "HitArmor" then
		v_u_9:Cancel()
		v_u_3.Crosshair.ArmorIcon.Image = "rbxassetid://9021696258"
		v_u_3.Crosshair.ArmorIcon.ImageTransparency = -2
		v_u_3.Crosshair.ArmorIcon.ImageColor3 = Color3.new(1, 1, 1)
		v_u_9:Play()
		local v45 = script.Parent.Parent.Resources.hitarmor:Clone()
		v45.Volume = 1
		v_u_40(v45)
	elseif p42 == "BrokeArmor" then
		v_u_9:Cancel()
		v_u_3.Crosshair.ArmorIcon.Image = "rbxassetid://9021696096"
		v_u_3.Crosshair.ArmorIcon.ImageColor3 = Color3.new(0, 0.65098, 1)
		v_u_3.Crosshair.ArmorIcon.ImageTransparency = -2
		v_u_9:Play()
		local v46 = script.Parent.Parent.Resources.breakarmor:Clone()
		v46.Volume = 4.5
		v_u_40(v46)
	elseif not (p43 and p43.dontDoSound) then
		local v_u_47 = script.Parent.Parent.Resources.hitmarker:Clone()
		v_u_47.Parent = v_u_2
		v_u_47:Play()
		task.delay(5, function()
			-- upvalues: (copy) v_u_47
			v_u_47:Destroy()
		end)
	end
	if p42 ~= "HitArmor" then
		v_u_11.Adornee.Visible = true
		v_u_11.Adornee.ImageColor3 = v44
		v_u_11:Play()
	end
end
v_u_7.ThirdPersonChanged:Connect(function(_)
	-- upvalues: (copy) v_u_12, (ref) v_u_13
	v_u_12:SetType(v_u_13)
end)
task.defer(function()
	-- upvalues: (copy) v_u_7, (copy) v_u_12
	if v_u_7.CurrentWeapon then
		v_u_12:SetType("cross")
	else
		v_u_12:SetType("dot")
	end
end)
return v_u_12