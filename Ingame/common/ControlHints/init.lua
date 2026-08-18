local v1 = game:GetService("Players")
local v_u_2 = game:GetService("UserInputService")
local v_u_3 = game:GetService("ContentProvider")
local v4 = game:GetService("ReplicatedStorage")
local v_u_5 = require(v4.Packages.Fusion).peek
local v_u_6 = require(v4.common:WaitForChild("Settings"))
local v_u_7 = require(v4.common:WaitForChild("BindUtil"))
local v_u_8 = require(script:WaitForChild("Icons"))
local v_u_9 = require(script:WaitForChild("Sorting"))
local v10 = v1.LocalPlayer:WaitForChild("PlayerGui")
local v_u_11 = {
	[Enum.UserInputType.MouseButton1] = Enum.KeyCode.MouseLeftButton,
	[Enum.UserInputType.MouseButton2] = Enum.KeyCode.MouseRightButton,
	[Enum.UserInputType.MouseButton3] = Enum.KeyCode.MouseMiddleButton
}
local v_u_12 = {}
local v_u_13 = nil
local v_u_14 = nil
for v15, v16 in v_u_11 do
	v_u_12[v16] = v15
end
local function v_u_26(p17, p18, p19) -- name: getIconId
	-- upvalues: (copy) v_u_8, (copy) v_u_7, (copy) v_u_2
	local v20 = p19 == true
	if p18 then
		if p18 == "keyboard" then
			local v21
			if v20 then
				v21 = v_u_8.keyboard_solid
			else
				v21 = v_u_8.keyboard
			end
			return v21[p17] or ""
		else
			local v22
			if v20 then
				v22 = v_u_8[p18 .. "_solid"]
			else
				v22 = v_u_8[p18]
			end
			return v22 and (v22[p17] or "") or ""
		end
	else
		if v_u_7.getInputMethod() ~= "Gamepad" then
			local v23
			if v20 then
				v23 = v_u_8.keyboard_solid
			else
				v23 = v_u_8.keyboard
			end
			return v23[p17] or ""
		end
		local v24 = v_u_2:GetStringForKeyCode(Enum.KeyCode.ButtonA) == "ButtonCross" and "ps" or "xbox"
		local v25
		if v20 then
			v25 = v_u_8[v24 .. "_solid"]
		else
			v25 = v_u_8[v24]
		end
		return v25 and (v25[p17] or "") or ""
	end
end
local function v27() -- name: alive
	-- upvalues: (ref) v_u_13
	if v_u_13 then
		return not v_u_13.States.IsDead
	else
		return false
	end
end
local function v31() -- name: hasGun
	-- upvalues: (ref) v_u_13, (ref) v_u_14
	local v28
	if v_u_13 then
		v28 = not v_u_13.States.IsDead
	else
		v28 = false
	end
	if not (v28 and v_u_14) then
		return false
	end
	local v29 = v_u_14:GetCurrentWeapon()
	local v30
	if v29 == nil then
		v30 = false
	else
		v30 = not v29.Config.IsMelee
	end
	return v30
end
local function v35() -- name: hasMelee
	-- upvalues: (ref) v_u_13, (ref) v_u_14
	local v32
	if v_u_13 then
		v32 = not v_u_13.States.IsDead
	else
		v32 = false
	end
	if not (v32 and v_u_14) then
		return false
	end
	local v33 = v_u_14:GetCurrentWeapon()
	local v34
	if v33 == nil then
		v34 = false
	else
		v34 = v33.Config.IsMelee == true
	end
	return v34
end
local v_u_46 = {
	{
		["id"] = "Shoot",
		["label"] = "Shoot",
		["actions"] = nil,
		["priority"] = 1,
		["condition"] = nil,
		["actions"] = { "PrimaryAttack" },
		["condition"] = v31
	},
	{
		["id"] = "Aim",
		["label"] = "Aim",
		["actions"] = nil,
		["priority"] = 2,
		["condition"] = nil,
		["actions"] = { "SecondaryAttack" },
		["condition"] = v31
	},
	{
		["id"] = "Reload",
		["label"] = "Reload",
		["actions"] = nil,
		["priority"] = 3,
		["condition"] = nil,
		["actions"] = { "Reload" },
		["condition"] = v31
	},
	{
		["id"] = "Firemode",
		["label"] = "Fire Mode",
		["actions"] = nil,
		["priority"] = 4,
		["condition"] = nil,
		["actions"] = { "Firemode" },
		["condition"] = function() -- name: hasMultiFireMode
			-- upvalues: (ref) v_u_13, (ref) v_u_14
			local v36
			if v_u_13 then
				v36 = not v_u_13.States.IsDead
			else
				v36 = false
			end
			local v37
			if v36 and v_u_14 then
				local v38 = v_u_14:GetCurrentWeapon()
				if v38 == nil then
					v37 = false
				else
					v37 = not v38.Config.IsMelee
				end
			else
				v37 = false
			end
			if not (v37 and v_u_14) then
				return false
			end
			local v39 = v_u_14:GetCurrentWeapon()
			local v40
			if v39 == nil or v39.Config.FireMode == nil then
				v40 = false
			else
				v40 = #v39.Config.FireMode > 1
			end
			return v40
		end
	},
	{
		["id"] = "Attack",
		["label"] = "Attack",
		["actions"] = nil,
		["priority"] = 1,
		["condition"] = nil,
		["actions"] = { "PrimaryAttack" },
		["condition"] = v35
	},
	{
		["id"] = "Block",
		["label"] = "Block",
		["actions"] = nil,
		["priority"] = 2,
		["condition"] = nil,
		["actions"] = { "SecondaryAttack" },
		["condition"] = v35
	},
	{
		["id"] = "Charge",
		["label"] = "Hold to Charge",
		["actions"] = nil,
		["priority"] = 3,
		["condition"] = nil,
		["actions"] = { "PrimaryAttack" },
		["condition"] = function() -- name: hasCharge
			-- upvalues: (ref) v_u_13, (ref) v_u_14
			local v41
			if v_u_13 then
				v41 = not v_u_13.States.IsDead
			else
				v41 = false
			end
			local v42
			if v41 and v_u_14 then
				local v43 = v_u_14:GetCurrentWeapon()
				if v43 == nil then
					v42 = false
				else
					v42 = v43.Config.IsMelee == true
				end
			else
				v42 = false
			end
			if not (v42 and v_u_14) then
				return false
			end
			local v44 = v_u_14:GetCurrentWeapon()
			local v45
			if v44 == nil then
				v45 = false
			else
				v45 = v44.Config.ChargeTime ~= nil
			end
			return v45
		end
	},
	{
		["id"] = "Ability",
		["label"] = "Ability",
		["actions"] = nil,
		["priority"] = 5,
		["condition"] = nil,
		["actions"] = { "OffHandUse" },
		["condition"] = v27
	},
	{
		["id"] = "QuickMelee",
		["label"] = "Quick Melee",
		["actions"] = nil,
		["priority"] = 6,
		["condition"] = nil,
		["actions"] = { "QuickMeleeAndBlock" },
		["condition"] = v31
	},
	{
		["id"] = "Sprint",
		["label"] = "Sprint",
		["actions"] = nil,
		["priority"] = 10,
		["condition"] = nil,
		["actions"] = { "SprintHold", "SprintToggle" },
		["condition"] = v27
	},
	{
		["id"] = "Crouch",
		["label"] = "Crouch",
		["actions"] = nil,
		["priority"] = 11,
		["condition"] = nil,
		["actions"] = { "CrouchToggle", "CrouchHold", "CrouchProneToggle" },
		["condition"] = v27
	},
	{
		["id"] = "Prone",
		["label"] = "Prone",
		["actions"] = nil,
		["priority"] = 12,
		["condition"] = nil,
		["actions"] = { "ProneToggle" },
		["condition"] = v27
	},
	{
		["id"] = "ThirdPerson",
		["label"] = "Third Person (Hold)",
		["actions"] = nil,
		["priority"] = 13,
		["condition"] = nil,
		["actions"] = { "Thirdperson" },
		["condition"] = v27
	},
	{
		["id"] = "NVG",
		["label"] = "Night Vision",
		["actions"] = nil,
		["priority"] = 14,
		["condition"] = nil,
		["actions"] = { "NVGToggle" },
		["condition"] = v27
	}
}
local v_u_47 = Instance.new("ScreenGui")
v_u_47.Name = "ControlHints"
v_u_47.ResetOnSpawn = false
v_u_47.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
v_u_47.IgnoreGuiInset = true
v_u_47.DisplayOrder = 5
v_u_47.Parent = v10
local v_u_48 = Instance.new("Frame")
v_u_48.Name = "HintsFrame"
v_u_48.AnchorPoint = Vector2.new(1, 0.5)
v_u_48.BackgroundTransparency = 1
v_u_48.Position = UDim2.new(1, -10, 0.5, 0)
v_u_48.Size = UDim2.fromScale(0.2, 0.4)
v_u_48.Parent = v_u_47
local v49 = Instance.new("UIListLayout")
v49.Name = "UIListLayout"
v49.HorizontalAlignment = Enum.HorizontalAlignment.Right
v49.SortOrder = Enum.SortOrder.LayoutOrder
v49.VerticalAlignment = Enum.VerticalAlignment.Center
v49.Parent = v_u_48
local v50 = Instance.new("UISizeConstraint")
v50.MaxSize = Vector2.new((1 / 0), 400)
v50.MinSize = Vector2.new(200, 200)
v50.Parent = v_u_48
local v51 = Instance.new("UIAspectRatioConstraint")
v51.AspectRatio = 1.078
v51.Parent = v_u_48
local v_u_52 = Instance.new("Frame")
v_u_52.Name = "HintTemplate"
v_u_52.AnchorPoint = Vector2.new(1, 0.5)
v_u_52.BackgroundTransparency = 1
v_u_52.Size = UDim2.fromScale(1, 0.12)
v_u_52.Visible = false
local v53 = Instance.new("UIListLayout")
v53.FillDirection = Enum.FillDirection.Horizontal
v53.HorizontalAlignment = Enum.HorizontalAlignment.Right
v53.Padding = UDim.new(0, 5)
v53.SortOrder = Enum.SortOrder.LayoutOrder
v53.VerticalAlignment = Enum.VerticalAlignment.Center
v53.Parent = v_u_52
local v54 = Instance.new("TextLabel")
v54.Name = "ActionText"
v54.AnchorPoint = Vector2.new(1, 0.5)
v54.AutomaticSize = Enum.AutomaticSize.X
v54.BackgroundTransparency = 1
v54.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium)
v54.Position = UDim2.fromScale(0.795, 0.5)
v54.Size = UDim2.fromScale(0.7, 0.7)
v54.Text = "Action"
v54.TextColor3 = Color3.new(1, 1, 1)
v54.TextScaled = true
v54.TextXAlignment = Enum.TextXAlignment.Right
v54.Parent = v_u_52
local v55 = Instance.new("ImageLabel")
v55.Name = "IconImage"
v55.BackgroundTransparency = 1
v55.Image = ""
v55.LayoutOrder = 1
v55.ScaleType = Enum.ScaleType.Fit
v55.Size = UDim2.fromScale(0.3, 1)
Instance.new("UIAspectRatioConstraint").Parent = v55
v55.Parent = v_u_52
local v56 = Instance.new("TextLabel")
v56.Name = "Separator"
v56.AnchorPoint = Vector2.new(1, 0.5)
v56.AutomaticSize = Enum.AutomaticSize.X
v56.BackgroundTransparency = 1
v56.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
v56.LayoutOrder = 2
v56.Position = UDim2.fromScale(0.795, 0.5)
v56.Size = UDim2.fromScale(0.01, 0.5)
v56.Text = "/"
v56.TextColor3 = Color3.new(1, 1, 1)
v56.TextScaled = true
v56.Visible = false
v56.Parent = v_u_52
v_u_52.Parent = v_u_48
local v_u_57 = {}
local v_u_58 = {}
local v_u_59 = false
local function v_u_73(p60, p61) -- name: resolveKeyCodes
	-- upvalues: (copy) v_u_6, (copy) v_u_11, (copy) v_u_9
	local v62 = {}
	local v63 = {}
	for _, v64 in p60.actions do
		local v65 = v_u_6.Controls.Binds[v64]
		if v65 then
			if p61 == "MouseKeyboard" then
				local v66 = v65.Keyboard
				if v66 and not v62[v66] then
					v62[v66] = true
					table.insert(v63, v66)
				end
				local v67 = v65.Mouse
				if v67 then
					local v68 = v_u_11[v67]
					if v68 and not v62[v68] then
						v62[v68] = true
						table.insert(v63, v68)
					end
				end
			elseif p61 == "Gamepad" then
				local v69 = v65.Gamepad
				if v69 and not v62[v69] then
					v62[v69] = true
					table.insert(v63, v69)
				end
			end
		end
	end
	local v_u_70
	if p61 == "Gamepad" then
		v_u_70 = v_u_9.gamepad_sort_index
	else
		v_u_70 = v_u_9.keyboard_sort_index
	end
	table.sort(v63, function(p71, p72)
		-- upvalues: (copy) v_u_70
		return (v_u_70[p71] or (1 / 0)) < (v_u_70[p72] or (1 / 0))
	end)
	return v63
end
local v_u_107 = {
	["IsShowing"] = false,
	["Update"] = function(_) -- name: Update
		-- upvalues: (ref) v_u_59, (copy) v_u_7, (copy) v_u_47, (copy) v_u_5, (copy) v_u_6, (copy) v_u_107, (copy) v_u_2, (copy) v_u_48, (copy) v_u_57, (copy) v_u_58, (copy) v_u_46, (copy) v_u_73, (copy) v_u_52, (copy) v_u_26, (copy) v_u_12, (copy) v_u_3
		if v_u_59 then
			local v74 = v_u_7.getInputMethod()
			if v74 == "Touch" then
				v_u_47.Enabled = false
				return
			elseif v_u_5(v_u_6.Controls.ShowControlHints) then
				v_u_47.Enabled = v_u_107.IsShowing
				local v75 = v74 == "Gamepad" and (v_u_2:GetStringForKeyCode(Enum.KeyCode.ButtonA) == "ButtonCross" and "ps" or "xbox") or "keyboard"
				for _, v76 in v_u_48:GetChildren() do
					if v76:IsA("Frame") and v76.Name == "HintLabel" then
						v76:Destroy()
					end
				end
				table.clear(v_u_57)
				table.clear(v_u_58)
				local v77 = {}
				for _, v78 in v_u_46 do
					if v78.condition() then
						local v79 = v_u_73(v78, v74)
						if #v79 > 0 then
							table.insert(v77, {
								["hintDef"] = v78,
								["keyCodes"] = v79
							})
						end
					end
				end
				table.sort(v77, function(p80, p81)
					return p80.hintDef.priority < p81.hintDef.priority
				end)
				local v_u_82 = {}
				for _, v83 in v77 do
					local v84 = v83.hintDef
					local v85 = v83.keyCodes
					local v86 = v_u_52:Clone()
					v86.Name = "HintLabel"
					v86.LayoutOrder = v84.priority
					local v87 = v86:FindFirstChild("ActionText")
					if v87 then
						v87.Text = v84.label
					end
					local v88 = v86:FindFirstChild("IconImage")
					local v89 = v86:FindFirstChild("Separator")
					if v88 and (v89 and #v85 > 0) then
						local v90 = v_u_26(v85[1], v75, false)
						local v91 = v_u_26(v85[1], v75, true)
						v88.Image = v90
						v88.Visible = true
						v89.Visible = false
						if v90 ~= "" then
							table.insert(v_u_82, v90)
						end
						if v91 ~= "" then
							table.insert(v_u_82, v91)
						end
						local v92 = v88.LayoutOrder + 1
						for v93 = 2, #v85 do
							local v94 = v89:Clone()
							v94.Name = "Separator" .. v93 - 1
							v94.Text = "/"
							v94.LayoutOrder = v92
							v94.Visible = true
							v94.Parent = v86
							local v95 = v92 + 1
							local v96 = v88:Clone()
							v96.Name = "IconImage" .. v93
							local v97 = v_u_26(v85[v93], v75, false)
							local v98 = v_u_26(v85[v93], v75, true)
							v96.Image = v97
							v96.LayoutOrder = v95
							v96.Visible = true
							v96.Parent = v86
							v92 = v95 + 1
							if v97 ~= "" then
								table.insert(v_u_82, v97)
							end
							if v98 ~= "" then
								table.insert(v_u_82, v98)
							end
						end
					end
					v86.Visible = true
					v86.Parent = v_u_48
					local v99 = v_u_57
					table.insert(v99, {
						["hintDef"] = v84,
						["keyCodes"] = v85,
						["frame"] = v86
					})
					for _, v100 in v85 do
						if not v_u_58[v100] then
							v_u_58[v100] = {}
						end
						local v101 = v_u_58[v100]
						table.insert(v101, v86)
						local v102 = v_u_12[v100]
						if v102 then
							if not v_u_58[v102] then
								v_u_58[v102] = {}
							end
							local v103 = v_u_58[v102]
							table.insert(v103, v86)
						end
					end
				end
				if #v_u_82 > 0 then
					task.spawn(function()
						-- upvalues: (copy) v_u_82, (ref) v_u_3
						local v104 = Instance.new("Folder")
						for _, v105 in v_u_82 do
							local v106 = Instance.new("ImageLabel")
							v106.Image = v105
							v106.Parent = v104
						end
						v_u_3:PreloadAsync(v104:GetChildren())
						v104:Destroy()
					end)
				end
			else
				v_u_47.Enabled = false
			end
		else
			return
		end
	end
}
local function v_u_118(p108, p109) -- name: updateIconsForKey
	-- upvalues: (copy) v_u_7, (copy) v_u_2, (copy) v_u_58, (copy) v_u_57, (copy) v_u_12, (copy) v_u_26
	local v110 = v_u_7.getInputMethod() == "Gamepad" and (v_u_2:GetStringForKeyCode(Enum.KeyCode.ButtonA) == "ButtonCross" and "ps" or "xbox") or "keyboard"
	local v111 = v_u_58[p108]
	if not v111 then
		return
	end
	for _, v112 in v111 do
		for _, v113 in v112:GetChildren() do
			if v113:IsA("ImageLabel") and v113.Name:match("^IconImage") then
				for _, v114 in v_u_57 do
					if v114.frame == v112 then
						for v115, v116 in v114.keyCodes do
							local v117 = v112:FindFirstChild(v115 == 1 and "IconImage" or "IconImage" .. v115)
							if v117 and (v116 == p108 or v_u_12[v116] == p108) then
								v117.Image = v_u_26(v116, v110, p109)
							end
						end
						break
					end
				end
				break
			end
		end
	end
end
function v_u_107.Show(_) -- name: Show
	-- upvalues: (copy) v_u_107, (copy) v_u_7, (copy) v_u_47
	v_u_107.IsShowing = true
	if v_u_7.getInputMethod() ~= "Touch" then
		v_u_47.Enabled = true
	end
end
function v_u_107.Hide(_) -- name: Hide
	-- upvalues: (copy) v_u_107, (copy) v_u_47
	v_u_107.IsShowing = false
	v_u_47.Enabled = false
end
function v_u_107.Init(_, p119, p120) -- name: Init
	-- upvalues: (ref) v_u_59, (ref) v_u_14, (ref) v_u_13, (copy) v_u_107, (copy) v_u_7, (copy) v_u_6, (copy) v_u_2, (copy) v_u_118
	if not v_u_59 then
		v_u_59 = true
		v_u_14 = p119
		v_u_13 = p120
		v_u_14.WeaponEquipped:Connect(function()
			-- upvalues: (ref) v_u_107
			v_u_107:Update()
		end)
		v_u_14.WeaponUnequipped:Connect(function()
			-- upvalues: (ref) v_u_107
			v_u_107:Update()
		end)
		v_u_7.InputMethodChanged:Connect(function()
			-- upvalues: (ref) v_u_107
			v_u_107:Update()
		end)
		v_u_6.SettingsChanged:Connect(function(p121)
			-- upvalues: (ref) v_u_107
			if p121 and p121[1] == "Controls" then
				v_u_107:Update()
			end
		end)
		v_u_2.InputBegan:Connect(function(p122, p123)
			-- upvalues: (ref) v_u_118
			if not p123 then
				local v124 = p122.KeyCode
				if v124 == Enum.KeyCode.Unknown then
					v124 = p122.UserInputType
				end
				v_u_118(v124, true)
			end
		end)
		v_u_2.InputEnded:Connect(function(p125)
			-- upvalues: (ref) v_u_118
			local v126 = p125.KeyCode
			if v126 == Enum.KeyCode.Unknown then
				v126 = p125.UserInputType
			end
			v_u_118(v126, false)
		end)
		v_u_107:Update()
	end
end
return v_u_107