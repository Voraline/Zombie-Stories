game:GetService("RunService")
game:GetService("UserInputService")
local v_u_1 = game:GetService("TweenService")
local v2 = game:GetService("TextChatService")
local v3 = script.QuickChatUI
v3.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local v_u_4 = workspace.CurrentCamera
local v_u_5 = game.Players.LocalPlayer:GetMouse()
local v_u_6 = game.ReplicatedStorage.common:WaitForChild("Remotes"):WaitForChild("Net")
local v7 = game:GetService("ReplicatedStorage").common.ZS_Framework.Modules.Controllers
local v8 = v3:WaitForChild("Frame")
v8.Visible = false
v8:WaitForChild("Buttons")
local v_u_9 = v8:WaitForChild("Icons")
v8:WaitForChild("Circlerotatepart")
local v_u_10 = v8:WaitForChild("buttonSelected")
local v_u_11 = v2:WaitForChild("TextChannels"):WaitForChild("RBXSystem")
local v_u_12 = {
	["8"] = { "Need Medic", "I need a medic!" },
	["9"] = { "Need Ammo", "I\'m out of rounds!" },
	["10"] = { "Need Help", "Give me some help!" },
	["1"] = { "Let\'s Move", "Let\'s move forward!" },
	["2"] = { "Sorry", "Sorry" },
	["3"] = { "Thanks", "Thanks. I owe you one." },
	["11"] = { "Ping Location", "Look here." }
}
require(v7:WaitForChild("WeaponController"))
require(v7:WaitForChild("LocalPlayerController"))
require(v7.CameraController)
local v_u_13 = {
	["IsDisabled"] = function() -- name: IsDisabled
		return true
	end
}
local function v_u_24(p14) -- name: color3ToHex
	local v15 = p14.R * 255 + 0.5
	local v16 = math.floor(v15)
	local v17 = math.clamp(v16, 0, 255)
	local v18 = p14.G * 255 + 0.5
	local v19 = math.floor(v18)
	local v20 = math.clamp(v19, 0, 255)
	local v21 = p14.B * 255 + 0.5
	local v22 = math.floor(v21)
	local v23 = math.clamp(v22, 0, 255)
	return string.format("#%02X%02X%02X", v17, v20, v23)
end
function v_u_13.Init() -- name: Init
	-- upvalues: (copy) v_u_13, (copy) v_u_6, (copy) v_u_24, (copy) v_u_11, (copy) v_u_1, (copy) v_u_9
	v_u_13.Connections = {}
	v_u_13.Activated = false
	v_u_13.Cooldown = false
	v_u_6.OnClientEvent:Connect(function(p25, p26, p27, p28, p_u_29)
		-- upvalues: (ref) v_u_24, (ref) v_u_11, (ref) v_u_1, (ref) v_u_9
		if p25 == "Quickchat" then
			local v30 = p26.Character
			if not v30 then
				return
			end
			local v_u_31 = v30:FindFirstChild("HumanoidRootPart")
			if not v_u_31 then
				return
			end
			v_u_11:DisplaySystemMessage(string.format("<font face=\"SourceSansBold\" size=\"11\" color=\"%s\">%s says: %s</font>", v_u_24(Color3.new(0, 0.97647, 0.521568)), p26.Name, p28), "systemMessage")
			local v32 = script.beepclear:Clone()
			v32.Parent = workspace
			v32:Play()
			game.Debris:AddItem(v32, 5)
			if p26 == game.Players.LocalPlayer and p27 ~= "11" then
				return
			end
			local v_u_33 = script.ScreenMarker:Clone()
			v_u_33.Parent = game.Players.LocalPlayer.PlayerGui
			local v_u_34 = p_u_29 or v_u_31.Position + Vector3.new(0, 5, 0)
			local v_u_35 = workspace.CurrentCamera
			local v36 = v_u_33:WaitForChild("Frame")
			local v_u_37 = v36:WaitForChild("OnScreenPos")
			local v_u_38 = v36:WaitForChild("OffScreenPos")
			v_u_1:Create(v_u_37.UIScale, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
				["Scale"] = 0.9
			}):Play()
			v_u_1:Create(v_u_38.UIScale, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
				["Scale"] = 0.9
			}):Play()
			local v_u_39 = v_u_37.Alert
			local v_u_40 = v_u_37.ImageLabel
			v_u_40.Image = v_u_9[p27].Image
			local v_u_41 = 1
			local function v_u_57(p42, p43) -- name: ScreenPointEdgeClamp
				-- upvalues: (copy) v_u_33
				local v44 = Vector2.new(v_u_33.AbsoluteSize.X / 2, v_u_33.AbsoluteSize.Y / 2)
				local v45 = (p42 - v44).Unit
				local v46 = v45.X
				local v47 = v45.Y
				local v48 = math.atan2(v46, v47)
				local v49 = (v44.Y - p43) / math.cos(v48)
				local v50 = math.abs(v49)
				local v51 = v44.X - p43
				local v52 = v48 + 1.5707963267948966
				local v53 = v51 / math.cos(v52)
				local v54 = math.abs(v53)
				local v55 = math.min(v50, v54)
				local v56 = -math.deg(v48)
				return v44 + v45 * v55, v56
			end
			local v_u_58 = tick() + 8
			local v_u_59 = false
			local v_u_60 = nil
			v_u_60 = game:GetService("RunService").RenderStepped:Connect(function(_)
				-- upvalues: (copy) v_u_58, (ref) v_u_59, (copy) v_u_37, (copy) v_u_38, (ref) v_u_1, (ref) v_u_60, (copy) v_u_33, (ref) v_u_41, (copy) v_u_39, (copy) v_u_40, (ref) v_u_34, (copy) v_u_35, (copy) v_u_57, (copy) p_u_29, (ref) v_u_31
				if v_u_58 < tick() then
					if v_u_59 then
						if not v_u_37 or v_u_59 and (v_u_37 and (v_u_37.Parent and v_u_37.UIScale.Scale < 0.01)) then
							v_u_60:Disconnect()
							v_u_33:Destroy()
						end
					else
						v_u_59 = true
						if v_u_37.Parent and v_u_38.Parent then
							v_u_1:Create(v_u_37.UIScale, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
								["Scale"] = 0
							}):Play()
							v_u_1:Create(v_u_38.UIScale, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
								["Scale"] = 0
							}):Play()
						end
					end
				end
				if v_u_41 == 1 and v_u_39.ImageTransparency == 1 then
					v_u_1:Create(v_u_39, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
						["ImageTransparency"] = 0
					}):Play()
					v_u_1:Create(v_u_40, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
						["ImageTransparency"] = 1
					}):Play()
					v_u_41 = 2
				elseif v_u_41 == 2 and v_u_39.ImageTransparency == 0 then
					v_u_1:Create(v_u_39, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
						["ImageTransparency"] = 1
					}):Play()
					v_u_1:Create(v_u_40, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
						["ImageTransparency"] = 0
					}):Play()
					v_u_41 = 1
				end
				local v61 = v_u_34
				local v62 = v_u_35.CFrame.lookVector
				local v63 = v61 - v_u_35.CFrame.p
				local v64 = v62.X * v63.X + v62.Y * v63.Y + v62.Z * v63.Z
				if v64 <= 0 then
					local v65 = v62 * v64 * 1.01
					v61 = v_u_35.CFrame.p + (v63 - v65)
				end
				local v66, v67 = v_u_35:WorldToScreenPoint(v61)
				if v67 or not (v_u_39.Parent and v_u_40.Parent) then
					if v_u_39.Parent and v_u_40.Parent then
						v_u_39.Parent = v_u_37
						v_u_40.Parent = v_u_37
						v_u_37.Visible = true
						v_u_38.Visible = false
						local v68 = v66.X - v_u_37.Size.X.Offset / 2
						local v69 = v66.Y - v_u_37.Size.Y.Offset / 2
						v_u_37.Position = UDim2.new(0.25, v68, 0.25, v69)
					end
				else
					v_u_37.Visible = false
					v_u_38.Visible = true
					local v70, _ = v_u_57(Vector2.new(v66.X, v66.Y), 30)
					local v71 = v70.X - v_u_38.Size.X.Offset / 2
					local v72 = v70.Y - v_u_38.Size.Y.Offset / 2
					v_u_38.Position = UDim2.new(0.25, v71, 0.25, v72)
					v_u_39.Parent = v_u_38
					v_u_40.Parent = v_u_38
				end
				if v_u_37 and (v_u_37.Parent and (p_u_29 or (not v_u_31 or v_u_31.Parent))) then
					if not p_u_29 and v_u_31.Parent then
						v_u_34 = v_u_31.Position + Vector3.new(0, 4, 0)
					end
				else
					v_u_60:Disconnect()
					v_u_33:Destroy()
				end
			end)
		end
	end)
end
function v_u_13.ToggleActivate(_, _) -- name: ToggleActivate end
function angleDifference(p73, p74) -- name: angleDifference
	local v75 = p73 % 360
	local v76 = p74 % 360 - v75
	return v76 + (v76 > 180 and -360 or (v76 < -180 and 360 or 0))
end
function findClosestPart(p77) -- name: findClosestPart
	for v78 = 1, 10 do
		local v79 = ((v78 - 1) * 36 + 90) % 360
		local _ = v79 + 36
		local v80 = angleDifference(v79, p77)
		if v80 < 36 and v80 >= 0 then
			local v81 = v78 >= 4 and v78 < 8 and 11 or v78
			local v82 = tostring(v81)
			if v82 ~= nil then
				return v82
			end
		end
	end
end
function changeText(p83) -- name: changeText
	-- upvalues: (copy) v_u_12, (copy) v_u_10
	if v_u_12[p83] then
		v_u_10.Text = v_u_12[p83][1]
	end
end
function GetMouseDirection(p84, p85) -- name: GetMouseDirection
	-- upvalues: (copy) v_u_4, (copy) v_u_5
	local v86 = {}
	if p85 then
		for _, v87 in pairs(p85) do
			local v88 = #v86 + 1
			table.insert(v86, v88, v87)
		end
	end
	local v89 = v_u_4:ScreenPointToRay(v_u_5.X, v_u_5.Y)
	local v90 = Ray.new(v89.Origin, v89.Direction * 5000)
	local _, v91 = workspace:FindPartOnRayWithIgnoreList(v90, { game.Players.LocalPlayer.Character, v_u_4, workspace.Ignore })
	return (v91 - p84).Unit, v91
end
function visibleButton(p92, p93) -- name: visibleButton
	if p92:IsA("Folder") then
		for _, v94 in pairs(p92:GetChildren()) do
			v94.Visible = p93
		end
	else
		p92.Visible = p93
	end
end
return v_u_13