local v1 = game.ReplicatedStorage.common.RedEvents
game:GetService("TweenService")
local v_u_2 = script.UI.Earnings
local v_u_3 = v_u_2.Earnings
local v_u_4 = v_u_2.Items
local v_u_5 = v_u_4.Template
local v_u_6 = script.UI.LevelUp
local v_u_7 = v_u_6.ClipFrame
local v_u_8 = v_u_7.ContentFrame
local v_u_9 = script.UI.WeaponUp
local v_u_10 = v_u_9.ClipFrame
local v_u_11 = v_u_10.ContentFrame
local v12 = game.ReplicatedStorage.common
local v_u_13 = workspace:FindFirstChild("Values")
local v_u_14
if v_u_13 then
	v_u_14 = v_u_13:FindFirstChild("IsDoubleXP")
else
	v_u_14 = v_u_13
end
local v_u_15
if v_u_13 then
	v_u_15 = v_u_13:FindFirstChild("IsWeekend")
else
	v_u_15 = v_u_13
end
if v_u_13 then
	v_u_13 = v_u_13:FindFirstChild("StackableDoubleXP")
end
require(game.ReplicatedStorage.common:WaitForChild("HUDService"))
local v_u_16 = require(v12.ItemData)
local v17 = require(v1.General.ProgressionEvent)
local v_u_18 = {}
local v_u_19 = {}
local v_u_20 = {}
local v_u_21 = false
local v_u_22 = {
	["Assault"] = "rbxassetid://4458718282",
	["Medic"] = "rbxassetid://2706886795",
	["Support"] = "rbxassetid://2706886028",
	["Sniper"] = "rbxassetid://4458692655"
}
local v_u_23 = 0
local v_u_24 = nil
local v_u_25 = nil
local v_u_26 = nil
v_u_2.Parent = game.Players.LocalPlayer.PlayerGui
v_u_6.Parent = game.Players.LocalPlayer.PlayerGui
v_u_9.Parent = game.Players.LocalPlayer.PlayerGui
local v_u_27 = {
	["IsShowing"] = true,
	["Show"] = function(_) -- name: Show
		-- upvalues: (copy) v_u_27, (copy) v_u_2, (copy) v_u_6, (copy) v_u_9
		v_u_27.IsShowing = true
		v_u_2.Enabled = true
		v_u_6.Enabled = true
		v_u_9.Enabled = true
	end,
	["Hide"] = function(_) -- name: Hide
		-- upvalues: (copy) v_u_27, (copy) v_u_2, (copy) v_u_6, (copy) v_u_9
		v_u_27.IsShowing = false
		v_u_2.Enabled = false
		v_u_6.Enabled = false
		v_u_9.Enabled = false
	end
}
v17:SetClientListener(function(p28)
	-- upvalues: (copy) v_u_18, (copy) v_u_19, (copy) v_u_20, (copy) v_u_14, (copy) v_u_13, (copy) v_u_15, (ref) v_u_25, (copy) v_u_3, (ref) v_u_26, (ref) v_u_24, (ref) v_u_23, (copy) v_u_5, (copy) v_u_4
	if p28.Type then
		if p28.Type == "LevelUpClass" then
			local v29 = v_u_18
			local v30 = {
				["Class"] = p28.Class,
				["Level"] = p28.Level,
				["ZBucks"] = p28.ZBucks
			}
			table.insert(v29, v30)
			runQueue()
			return
		end
		if p28.Type == "LevelUpWeapon" then
			local v31 = v_u_19
			local v32 = {
				["WeaponID"] = p28.ID,
				["Level"] = p28.Level
			}
			table.insert(v31, v32)
			runQueue()
			return
		end
		if p28.Type == "UnlockedWeapon" then
			local v33 = v_u_20
			local v34 = {
				["WeaponID"] = p28.ID
			}
			table.insert(v33, v34)
			runQueue()
			return
		end
		if p28.Type == "XPEarned" then
			local v35 = v_u_14 and v_u_14.Value and (v_u_13 and (v_u_13.Value and (v_u_15 and v_u_15.Value)) and "XP (x4)" or "XP (x2)") or "XP"
			if not v_u_25 then
				v_u_25 = 0
			end
			v_u_25 = v_u_25 + p28.AddedXP
			v_u_3.XP.Text = ("+%d %s"):format(v_u_25, v35)
			v_u_3:TweenSize(UDim2.new(0.35, 0, 0.05, 0), "Out", "Quad", 0.25, true)
			local v36 = tick() * 1000
			local v37 = math.floor(v36)
			v_u_26 = v37
			task.wait(3)
			if v_u_26 == v37 then
				v_u_24 = nil
				v_u_25 = nil
				v_u_3:TweenSize(UDim2.new(0, 0, 0.05, 0), "Out", "Quad", 0.25, true)
				return
			end
		elseif p28.Type == "AddXPItem" then
			v_u_23 = v_u_23 + 1
			local v38 = v_u_5:Clone()
			v38.LayoutOrder = -v_u_23
			v38:WaitForChild("Reason").Text = p28.Reason
			if p28.Color then
				v38.Reason.TextColor3 = p28.Color
			end
			v38.Parent = v_u_4
			v38.Visible = true
			v38.Reason:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.25, true)
			task.wait(3)
			v38.Reason:TweenPosition(UDim2.new(0, 0, 1, 0), "Out", "Quad", 0.25, true)
			task.wait(0.25)
			v38:Destroy()
		end
	end
end)
function runQueue() -- name: runQueue
	-- upvalues: (ref) v_u_21, (copy) v_u_18, (copy) v_u_8, (copy) v_u_22, (copy) v_u_7, (copy) v_u_20, (copy) v_u_16, (copy) v_u_11, (copy) v_u_10, (copy) v_u_19
	if v_u_21 then
		::l2::
		return
	else
		v_u_21 = true
		while true do
			if #v_u_18 > 0 then
				script.LevelUp:Play()
				local v39 = v_u_18[1]
				v_u_8.ClassIcon.Image = v_u_22[v39.Class]
				v_u_8.Class.Text = ("%s LEVEL %d!"):format(string.upper(v39.Class), v39.Level)
				v_u_8.ZB.Text = ("+ %d Z$"):format(v39.ZBucks)
				v_u_7:TweenSize(UDim2.new(0.7, 0, 0.14, 0), "Out", "Quad", 0.2, true)
				task.wait(3)
				v_u_7:TweenSize(UDim2.new(0.7, 0, 0, 0), "Out", "Quad", 0.2, true)
				task.wait(0.25)
				table.remove(v_u_18, 1)
			end
			if #v_u_20 > 0 then
				script.LevelUp:Play()
				local v40 = v_u_20[1]
				local v41 = v_u_16.List[v40.WeaponID].Name
				local v42 = "rbxgameasset://Images/" .. v41
				v_u_11.WeaponImage.ImageLabel.Image = v42
				v_u_11.LevelLabel.Text = ("%s UNLOCKED!"):format(string.upper(v41))
				v_u_10:TweenSize(UDim2.new(0.6, 0, 0.12, 0), "Out", "Quad", 0.2, true)
				task.wait(3)
				v_u_10:TweenSize(UDim2.new(0.6, 0, 0, 0), "Out", "Quad", 0.2, true)
				task.wait(0.25)
				table.remove(v_u_20, 1)
			end
			if #v_u_19 > 0 then
				script.LevelUp:Play()
				local v43 = v_u_19[1]
				local v44 = v_u_16.List[v43.WeaponID].Name
				local v45 = "rbxgameasset://Images/" .. v44
				v_u_11.WeaponImage.ImageLabel.Image = v45
				v_u_11.LevelLabel.Text = ("%s LEVEL %d!"):format(string.upper(v44), v43.Level)
				v_u_10:TweenSize(UDim2.new(0.6, 0, 0.12, 0), "Out", "Quad", 0.2, true)
				task.wait(3)
				v_u_10:TweenSize(UDim2.new(0.6, 0, 0, 0), "Out", "Quad", 0.2, true)
				task.wait(0.25)
				table.remove(v_u_19, 1)
			end
			if #v_u_18 == 0 and (#v_u_20 == 0 and #v_u_19 == 0) then
				v_u_21 = false
				goto l2
			end
		end
	end
end
return v_u_27