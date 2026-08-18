game:GetService("UserInputService")
local v_u_1 = game:GetService("Players")
local v2 = game.ReplicatedStorage.common
local v_u_3 = script:WaitForChild("HUDOverlay")
local v_u_4 = v_u_3:WaitForChild("ModalButton")
local v_u_5 = v_u_3:WaitForChild("Scoreboard")
local v_u_6 = v_u_5:WaitForChild("ScrollingFrame")
local v7 = v_u_1.LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("FrameworkEvent")
local v_u_8 = game.ReplicatedStorage.common:WaitForChild("Remotes"):WaitForChild("Net")
local v_u_9 = require(game:GetService("ReplicatedStorage").common.ZS_Framework.Modules.Controllers.CameraController)
local v_u_10 = workspace:GetAttribute("IsArcade") or false
workspace:GetAttributeChangedSignal("IsArcade"):Connect(function()
	-- upvalues: (ref) v_u_10
	v_u_10 = workspace:GetAttribute("IsArcade") or false
end)
local v11 = require(v2.Icon)
local v_u_12 = false
local v_u_13 = true
local v_u_14 = true
local v_u_15 = {}
v_u_3.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local v_u_18 = {
	["SetVisible"] = function(_, p16) -- name: SetVisible
		-- upvalues: (ref) v_u_13, (ref) v_u_12, (copy) v_u_3, (copy) v_u_4, (copy) v_u_9
		if v_u_13 then
			v_u_12 = p16
			v_u_3.Enabled = p16
			v_u_4.Modal = p16
		end
		v_u_9:SetMouseUnlocked("Leaderboard", p16)
		v_u_9:MouseIconEnabled("Leaderboard", p16)
	end,
	["SetEnabled"] = function(_, p17) -- name: SetEnabled
		-- upvalues: (ref) v_u_12, (copy) v_u_18, (ref) v_u_13
		if not p17 and v_u_12 then
			v_u_18:SetVisible(false)
		end
		v_u_13 = p17
	end,
	["IsVisible"] = function(_) -- name: IsVisible
		-- upvalues: (ref) v_u_12
		return v_u_12
	end
}
v11.new():setImage(2246486837):bindEvent("selected", function(_)
	-- upvalues: (copy) v_u_18
	v_u_18:SetVisible(true)
end):bindEvent("deselected", function()
	-- upvalues: (copy) v_u_18
	v_u_18:SetVisible(false)
end)
v7.Event:Connect(function(p19, _, p20)
	-- upvalues: (ref) v_u_14
	if p19 == "SettingsUpdated" and (p20 and (type(p20) == "table" and p20.HUDOverlayToggleMode ~= nil)) then
		v_u_14 = p20.HUDOverlayToggleMode
	end
end)
local v_u_21 = {
	["Assault"] = "rbxassetid://4458718282",
	["Medic"] = "rbxassetid://2706886795",
	["Sniper"] = "rbxassetid://4458692655",
	["Support"] = "rbxassetid://2706886028",
	["Unknown"] = "rbxassetid://4458718282",
	["Arcade"] = "rbxassetid://112766246588072"
}
local function v_u_24() -- name: countPlayerListItems
	-- upvalues: (copy) v_u_6
	local v22 = 0
	for _, v23 in pairs(v_u_6:GetChildren()) do
		if v23:IsA("Frame") then
			v22 = v22 + (v23.Visible and 1 or 0)
		end
	end
	return v22
end
local function v_u_31() -- name: ShiftLeaderboard
	-- upvalues: (copy) v_u_15, (copy) v_u_21, (copy) v_u_24, (copy) v_u_6, (copy) v_u_5
	for _, v25 in pairs(v_u_15) do
		local v26 = v25.UI.PaddedFrame
		local v27 = v25.UI
		local v28 = v25.Score
		v27.LayoutOrder = -math.floor(v28) - 2
		v26.Header.ClassLevelLabel.Text = v25.Level
		v26.Stats.ScoreLabel.Text = string.format("%.0f", v25.Score)
		v26.Stats.KillsLabel.Text = v25.Kills
		v26.Stats.DownsLabel.Text = v25.Downs
		v26.Header.ClassIcon.Image = v_u_21[v25.Class]
	end
	local v29 = v_u_24()
	local v30 = math.min(v29, 6)
	v_u_6.Size = UDim2.new(1, 0, v30 * 0.1, 0)
	v_u_6.CanvasSize = UDim2.new(0, 0, v29 * 0.1, 0)
	v_u_5.Header.Position = UDim2.new(0, 0, (6 - v30) * 0.0491666666666667 + 0.225, 0)
end
local function v_u_43(p_u_32, p33) -- name: CreateNewTemplate
	-- upvalues: (copy) v_u_15, (copy) v_u_6, (copy) v_u_21, (copy) v_u_31, (copy) v_u_1
	if workspace:FindFirstChild("LoadingStatus") then
		if v_u_15[p_u_32] then
			return
		end
		local v34 = v_u_6.Template:Clone()
		local v35 = p33 or {}
		v_u_15[p_u_32] = {
			["UI"] = nil,
			["Level"] = nil,
			["Score"] = nil,
			["Kills"] = nil,
			["Downs"] = nil,
			["Class"] = "Assault",
			["UI"] = v34,
			["Level"] = v35.Level or 0,
			["Score"] = v35.Score or 0,
			["Kills"] = v35.Kills or 0,
			["Downs"] = v35.Downs or 0
		}
		local v_u_36 = v34:WaitForChild("PaddedFrame")
		local v37 = workspace.LoadingStatus.Players:WaitForChild(p_u_32.Name)
		local v_u_38 = v37:WaitForChild("Class")
		local v_u_39 = v37:WaitForChild("Level")
		local function v40() -- name: updateClassAndLevel
			-- upvalues: (ref) v_u_15, (copy) p_u_32, (copy) v_u_38, (copy) v_u_39, (copy) v_u_36, (ref) v_u_21, (ref) v_u_31
			v_u_15[p_u_32].Class = v_u_38.Value
			v_u_15[p_u_32].Level = v_u_39.Value
			v_u_36.Header.ClassIcon.Image = v_u_21[v_u_38.Value]
			v_u_31()
		end
		v_u_15[p_u_32].Class = v_u_38.Value
		v_u_15[p_u_32].Level = v_u_39.Value
		v_u_36.Header.ClassIcon.Image = v_u_21[v_u_38.Value]
		v_u_31()
		v_u_38.Changed:Connect(v40)
		v_u_39.Changed:Connect(v40)
		v34.Visible = true
		v34.Name = p_u_32.Name
		local v41 = v_u_1:FindFirstChild(p_u_32.Name)
		local v42
		if v41 then
			v42 = v41.DisplayName
		else
			v42 = v41.Name
		end
		v_u_36.NameLabel.Text = "@" .. v41.Name
		v_u_36.DisplayNameLabel.Text = v42
		v_u_36.Header.ClassIcon.Image = v_u_21[v_u_38.Value]
		if v41 then
			v_u_36.Header.HeadshotLabel.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. v41.UserId .. "&width=420&height=420&format=png"
		else
			v_u_36.Header.HeadshotLabel.Image = "rbxassetid://5650877971"
		end
		v34.Parent = v_u_6
		v_u_31()
	end
end
v_u_8.OnClientEvent:Connect(function(p44, ...)
	-- upvalues: (copy) v_u_15, (copy) v_u_8, (copy) v_u_31, (copy) v_u_43
	local v45 = { ... }
	if p44 == "UpdLDB" then
		local v46 = v45[1]
		local v47 = v45[2]
		local v48 = v45[3]
		if v_u_15[v46] then
			v_u_15[v46][v47] = v48
			v_u_31()
		else
			v_u_8:FireServer("GetLDB")
		end
	elseif p44 == "NewLDB" then
		v_u_43(v45[1])
	elseif p44 == "GetLDB" then
		for v49, v50 in v45[1] do
			local v51 = game.Players:FindFirstChild(v49)
			if v51 then
				v_u_43(v51, v50)
			end
		end
	end
end)
v_u_8:FireServer("GetLDB")
game.Players.PlayerRemoving:Connect(function(p52)
	-- upvalues: (copy) v_u_15, (ref) v_u_10
	if v_u_15[p52] then
		local v_u_53 = v_u_15[p52].UI
		v_u_53.PaddedFrame.Left.Visible = true
		if v_u_10 then
			v_u_15[p52].UI:Destroy()
			v_u_15[p52] = nil
			return
		end
		task.delay(180, function()
			-- upvalues: (copy) v_u_53
			if v_u_53.PaddedFrame.Left.Visible then
				v_u_53.Visible = false
			end
		end)
	end
end)
game.Players.PlayerAdded:Connect(function(p54)
	-- upvalues: (copy) v_u_15, (copy) v_u_31
	if v_u_15[p54] then
		local v55 = v_u_15[p54].UI
		v55.PaddedFrame.Left.Visible = false
		v55.Visible = true
		v_u_31()
	end
end)
v_u_31()
return v_u_18