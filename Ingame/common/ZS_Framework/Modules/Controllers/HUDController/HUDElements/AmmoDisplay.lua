local v_u_1 = game:GetService("TweenService")
local v_u_2 = script.AmmoUI
local v_u_3 = v_u_2.Ammo
local _ = game.Players.LocalPlayer
local v4 = game:GetService("ReplicatedStorage").common.ZS_Framework
require(game.ReplicatedStorage.common:WaitForChild("HUDService"))
local v_u_5 = require(v4.Modules.Controllers.WeaponController)
local v_u_6 = require(v4.Modules.Controllers.HUDController.HUDElements.Objectives)
local v_u_7 = require(v4.Modules.Utils.WeaponNameUtil)
local v_u_8 = {}
local v_u_9 = {}
local v_u_10 = nil
local v_u_11 = false
local v_u_12 = 0
local v_u_13 = {
	["Pump Action"] = "PUMP",
	["Bolt Action"] = "BOLT",
	["Auto"] = "AUTO",
	["Semi-Auto"] = "SEMI",
	["Burst"] = "BURST",
	["Melee"] = "MELEE",
	["Misc"] = "MISC"
}
v_u_2.Parent = game.Players.LocalPlayer.PlayerGui
local v_u_42 = {
	["IsShowing"] = true,
	["Show"] = function(_) -- name: Show
		-- upvalues: (copy) v_u_2, (copy) v_u_42
		v_u_2.Enabled = true
		v_u_42.IsShowing = true
	end,
	["Hide"] = function(_) -- name: Hide
		-- upvalues: (copy) v_u_2, (copy) v_u_42
		v_u_2.Enabled = false
		v_u_42.IsShowing = false
	end,
	["MobileActive"] = function(_) -- name: MobileActive
		-- upvalues: (ref) v_u_11, (ref) v_u_10, (copy) v_u_42
		v_u_11 = true
		if v_u_10 then
			v_u_42:WeaponEquipped(v_u_10)
		end
	end,
	["MobileInactive"] = function(_) -- name: MobileInactive
		-- upvalues: (ref) v_u_11
		v_u_11 = false
	end,
	["Reloaded"] = function(_) -- name: Reloaded
		-- upvalues: (copy) v_u_8
		for v14, v15 in v_u_8 do
			v15.ImageTransparency = v14 >= 13 and 1 or 0
		end
		UpdateAmmoBar(true)
	end,
	["UpdateFireMode"] = function(_) -- name: UpdateFireMode
		-- upvalues: (ref) v_u_10, (copy) v_u_3, (copy) v_u_13
		if v_u_10 then
			v_u_3.FireMode.Text = v_u_13[v_u_10.FireMode]
		end
	end,
	["WeaponEquipped"] = function(_, p16) -- name: WeaponEquipped
		-- upvalues: (ref) v_u_10, (copy) v_u_42, (ref) v_u_11, (copy) v_u_3, (ref) v_u_12
		v_u_10 = p16
		v_u_42:ResetAmmoBar()
		if v_u_11 then
			v_u_3.AnchorPoint = Vector2.new(1, 0)
			v_u_3:TweenPosition(UDim2.new(0.99, 0, 0, v_u_12 + 90), "Out", "Quad", 0.25, true)
		else
			v_u_3.AnchorPoint = Vector2.new(1, 1)
			v_u_3:TweenPosition(UDim2.new(0.99, 0, 0.99, 0), "Out", "Quad", 0.25, true)
		end
	end,
	["WeaponUnequipped"] = function(_) -- name: WeaponUnequipped
		-- upvalues: (ref) v_u_10, (ref) v_u_11, (copy) v_u_3
		v_u_10 = nil
		if v_u_11 then
			v_u_3.AnchorPoint = Vector2.new(1, 0)
			v_u_3:TweenPosition(UDim2.new(0.99, 0, -0.4, 0), "Out", "Quad", 0.25, true)
		else
			v_u_3.AnchorPoint = Vector2.new(1, 1)
			v_u_3:TweenPosition(UDim2.new(0.99, 0, 1.36, 0), "Out", "Quad", 0.25, true)
		end
	end,
	["ResetAmmoBar"] = function(_) -- name: ResetAmmoBar
		-- upvalues: (ref) v_u_10, (copy) v_u_3, (copy) v_u_13, (copy) v_u_7, (copy) v_u_8, (copy) v_u_9
		if v_u_10 then
			v_u_3.FireMode.Text = v_u_13[v_u_10.FireMode]
			local v17 = v_u_3.Header.WeaponName
			local v18 = v_u_10.Config
			local v19 = v18.IsShotgun and "rbxassetid://4524757275" or ((v18.IsAPistol or v18.UsePistolIcon) and "rbxassetid://5947844444" or "rbxassetid://4524673573")
			v17.Text = v_u_7.GetDisplayName(v_u_10.Name, v18)
			for v20, v21 in v_u_8 do
				v21.ImageTransparency = (v18.Ammo < 13 or v20 < 13) and 0 or 1
				v21.Image = v19
			end
			for v22, v23 in v_u_9 do
				v23.Image = v19
				v23.ImageTransparency = (v18.Ammo < v22 or v22 >= 13) and 1 or 0.75
			end
		end
		UpdateAmmoBar(true)
	end,
	["UpdateAmmo"] = function(_, p24) -- name: UpdateAmmo
		-- upvalues: (ref) v_u_10, (copy) v_u_3
		if v_u_10 then
			local v25 = v_u_10.Ammo
			local v26 = v_u_10.StoredAmmo
			local v27 = string.sub(v25, -1)
			local v28 = string.sub(v26, -1)
			local v29 = v25 % 1000 / 100
			local v30 = math.floor(v29)
			local v31 = v25 % 100 / 10
			local v32 = math.floor(v31)
			local v33 = v26 / 1000
			local v34 = math.floor(v33)
			local v35 = v26 % 1000 / 100
			local v36 = math.floor(v35)
			local v37 = v26 % 100 / 10
			local v38 = math.floor(v37)
			for v39, v40 in {
				[v_u_3.Mag.Digit1] = v27,
				[v_u_3.Mag.Digit2] = v25 >= 10 and v32 .. " " or "",
				[v_u_3.Mag.Digit3] = v25 >= 100 and v30 .. "  " or "",
				[v_u_3.Stored.Digit1] = v28,
				[v_u_3.Stored.Digit2] = v26 >= 10 and v38 .. " " or "",
				[v_u_3.Stored.Digit3] = v26 >= 100 and v36 .. "  " or "",
				[v_u_3.Stored.Digit4] = v26 >= 1000 and v34 .. "  " or ""
			} do
				local v41 = v39.Parent.Anim[v39.Name]
				if v40 ~= v39.Text then
					v41.Text = v39.Text
					v41.Position = UDim2.new(0, 0, 1, 0)
					v39.Position = UDim2.new(0, 0, 0, 0)
				end
				v39.Text = v_u_10.Config.IsMelee and "" or v40
				v39:TweenPosition(UDim2.new(0, 0, 1, 0), "Out", "Quad", 0.1, true)
				v41:TweenPosition(UDim2.new(0, 0, 2, 0), "Out", "Quad", 0.1, true)
			end
			UpdateAmmoBar(p24)
		end
	end
}
function init() -- name: init
	-- upvalues: (copy) v_u_3, (copy) v_u_8, (copy) v_u_9, (copy) v_u_5, (copy) v_u_42, (copy) v_u_6, (ref) v_u_11, (ref) v_u_12, (ref) v_u_10
	for v43 = 1, 14 do
		local v44 = v_u_3.BulletsClip.Bullets.Template:Clone()
		v44.Name = v43
		v44.Visible = true
		v44.LayoutOrder = v43
		v44.Parent = v_u_3.BulletsClip.Bullets
		if v43 >= 13 then
			v44.ImageTransparency = 1
		end
		local v45 = v_u_8
		table.insert(v45, v44)
	end
	local v46 = v_u_3.BulletsClip.Bullets:Clone()
	v46.Name = "BulletsBG"
	v46.Position = UDim2.new(0, 0, 0, 0)
	v46.Parent = v_u_3.BulletsClip
	for _, v47 in v46:GetChildren() do
		local v48 = v47.Name
		if tonumber(v48) then
			local v49 = v_u_9
			table.insert(v49, v47)
			v47.ImageTransparency = 0.75
			if v47.Name == "13" then
				v47.ImageTransparency = 1
			end
		end
	end
	local v_u_50 = nil
	v_u_3.MouseButton1Down:Connect(function()
		-- upvalues: (ref) v_u_50, (ref) v_u_5
		v_u_50 = true
		task.spawn(function()
			-- upvalues: (ref) v_u_50, (ref) v_u_5
			local v51 = 0
			while v_u_50 and v51 < 0.25 do
				v51 = v51 + task.wait()
			end
			if v51 < 0.25 then
				v_u_5:Reload()
			else
				v_u_5:CycleFiremode()
			end
		end)
	end)
	v_u_3.MouseButton1Up:Connect(function()
		-- upvalues: (ref) v_u_50
		v_u_50 = false
	end)
	v_u_5.FireModeChanged:Connect(function(_)
		-- upvalues: (ref) v_u_42
		v_u_42:UpdateFireMode()
	end)
	v_u_5.AmmoChanged:Connect(function(_)
		-- upvalues: (ref) v_u_42
		v_u_42:UpdateAmmo()
	end)
	v_u_5.Reloaded:Connect(function()
		-- upvalues: (ref) v_u_42
		v_u_42:Reloaded()
	end)
	local v_u_52 = v_u_6:GetGuiList()
	v_u_52:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		-- upvalues: (ref) v_u_11, (ref) v_u_12, (copy) v_u_52, (ref) v_u_10, (ref) v_u_42
		if v_u_11 then
			v_u_12 = v_u_52.AbsoluteSize.Y
			if v_u_10 then
				v_u_42:WeaponEquipped(v_u_10)
			end
		end
	end)
end
function UpdateAmmoBar(p53) -- name: UpdateAmmoBar
	-- upvalues: (ref) v_u_10, (copy) v_u_3, (copy) v_u_1
	if v_u_10 then
		local v54 = v_u_10.Ammo
		local v55 = v_u_3.BulletsClip.AbsoluteSize.Y / v_u_3.BulletsClip.AbsoluteSize.X + v_u_3.BulletsClip.Bullets.UIListLayout.Padding.Scale
		if v54 < 13 then
			if v_u_3.BulletsClip.Bullets["14"].ImageTransparency == 1 then
				v_u_3.BulletsClip.Bullets["13"].ImageTransparency = 0
				if p53 then
					v_u_3.BulletsClip.Bullets["14"].ImageTransparency = 0
				else
					v_u_1:Create(v_u_3.BulletsClip.Bullets["14"], TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						["ImageTransparency"] = 0
					}):Play()
				end
			end
			local v56 = 14 - v54
			if p53 then
				v_u_3.BulletsClip.Bullets.Position = UDim2.new(-v56 * v55, 0, 0, 0)
				v_u_3.BulletsClip.Bullets[v56].ImageTransparency = 1
			else
				v_u_3.BulletsClip.Bullets:TweenPosition(UDim2.new(-v56 * v55, 0, 0, 0), "Out", "Quad", 0.1, true)
				v_u_3.BulletsClip.Bullets[v56].ImageTransparency = 0
				v_u_1:Create(v_u_3.BulletsClip.Bullets[v56], TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					["ImageTransparency"] = 1
				}):Play()
			end
		end
		v_u_3.BulletsClip.Bullets.Position = UDim2.new(-0 * v55, 0, 0, 0)
		if not p53 then
			v_u_3.BulletsClip.Bullets:TweenPosition(UDim2.new(-1 * v55, 0, 0, 0), "Out", "Quad", 0.1, true)
			v_u_3.BulletsClip.Bullets["1"].ImageTransparency = 0
			v_u_1:Create(v_u_3.BulletsClip.Bullets["1"], TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				["ImageTransparency"] = 1
			}):Play()
			v_u_3.BulletsClip.Bullets["13"].ImageTransparency = 1
			v_u_1:Create(v_u_3.BulletsClip.Bullets["13"], TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				["ImageTransparency"] = 0
			}):Play()
		end
	end
end
init()
v_u_42:WeaponUnequipped()
return v_u_42