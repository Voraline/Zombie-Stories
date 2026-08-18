local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("TweenService")
local v3 = game:GetService("RunService")
local v4 = game:GetService("Players")
local v5 = v1.common
local v_u_6 = v4.LocalPlayer:WaitForChild("PlayerGui")
local v7 = script:WaitForChild("Resources")
local v_u_8 = v7:FindFirstChild("deselect")
local v_u_9 = v7:FindFirstChild("select")
local v_u_10 = v7:WaitForChild("HUD")
local v_u_11 = v_u_10:WaitForChild("Weapons")
v_u_11.AnchorPoint = Vector2.new(0.5, 1)
local v_u_12 = Instance.new("UIScale")
v_u_12.Parent = v_u_10
local v_u_13 = v_u_11:WaitForChild("Template")
local v14 = script:WaitForChild("Utils")
local v15 = script:WaitForChild("HUDElements")
local v_u_16 = require(v5.Settings)
local v_u_17 = require(game:GetService("ReplicatedStorage").Packages.Fusion).peek
local v_u_18 = require(v5:WaitForChild("ItemData"))
local v_u_19 = require(v5:WaitForChild("WepConfig"))
local v_u_20 = require(v5:WaitForChild("HUDService"))
local v_u_21 = require(v5.BindUtil)
local v_u_22 = require("./CameraController")
local v_u_23 = require(v14.ViewportModel)
local v_u_24 = require(v5.ZS_Framework.Modules.Utils.WeaponNameUtil)
local v_u_25 = nil
local v_u_26 = require(v15:WaitForChild("Fade"))
local v_u_27 = require(v15:WaitForChild("HealthUI"))
local v_u_28 = require(v15:WaitForChild("StaminaDisplay"))
local v_u_29 = require(v15:WaitForChild("DPadSelectionUI"))
local v_u_30 = require(v15:WaitForChild("Objectives"))
local v_u_31 = require(v15:WaitForChild("MobileControls"))
local v_u_32 = require(v15:WaitForChild("AmmoDisplay"))
local v_u_33 = require(v15:WaitForChild("ProgressionPopups"))
local v_u_34 = require(v15:WaitForChild("Crosshair"))
local v_u_35 = require(v15:WaitForChild("BossHealth"))
local v_u_36 = require(v15:WaitForChild("ActiveModifierIcons"))
local v_u_37 = require(v15:WaitForChild("TurkeyHuntBoostIndicators"))
local v_u_38 = require(v15:WaitForChild("AbilityDisplay"))
local v_u_39 = require(v15:WaitForChild("SecondWindUI"))
local v_u_40 = require(v5:WaitForChild("ControlHints"))
local v_u_41 = {}
local v_u_42 = nil
local v_u_43 = nil
local v_u_60 = {
	["Inaccuracy"] = 0,
	["ReloadOffset"] = Vector2.new(0, 0),
	["IsVisible"] = true,
	["Init"] = function(_) -- name: Init
		-- upvalues: (ref) v_u_25, (copy) v_u_20, (copy) v_u_26, (copy) v_u_27, (copy) v_u_28, (copy) v_u_29, (copy) v_u_30, (copy) v_u_31, (copy) v_u_32, (copy) v_u_33, (copy) v_u_34, (copy) v_u_35, (copy) v_u_36, (copy) v_u_37, (copy) v_u_38, (copy) v_u_39, (copy) v_u_40, (copy) v_u_13, (ref) v_u_43, (copy) v_u_60, (ref) v_u_42, (copy) v_u_21, (copy) v_u_16, (copy) v_u_10, (copy) v_u_6
		v_u_25 = require("./LocalPlayerController")
		game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Health, false)
		v_u_20:AddElement("Fade", v_u_26)
		v_u_20:AddElement("HealthUI", v_u_27)
		v_u_20:AddElement("StaminaDisplay", v_u_28)
		v_u_20:AddElement("DPadSelection", v_u_29)
		v_u_20:AddElement("Objectives", v_u_30)
		v_u_20:AddElement("MobileControls", v_u_31)
		v_u_20:AddElement("AmmoDisplay", v_u_32)
		v_u_20:AddElement("ProgressionPopups", v_u_33)
		v_u_20:AddElement("Crosshair", v_u_34)
		v_u_20:AddElement("BossHealth", v_u_35)
		v_u_20:AddElement("ActiveModifierIcons", v_u_36)
		v_u_20:AddElement("TurkeyHuntBoostIndicators", v_u_37)
		v_u_20:AddElement("AbilityDisplay", v_u_38)
		v_u_20:AddElement("SecondWindUI", v_u_39)
		v_u_20:AddElement("ControlHints", v_u_40)
		v_u_20:ShowElement("ActiveModifierIcons")
		v_u_20:ShowElement("TurkeyHuntBoostIndicators")
		v_u_20:ShowElement("AbilityDisplay")
		v_u_13.Parent = nil
		v_u_43 = require("./WeaponController")
		v_u_40:Init(v_u_43, v_u_25)
		v_u_20:ShowElement("ControlHints")
		v_u_43.EquippedSlot:Connect(function(p44)
			-- upvalues: (ref) v_u_60
			v_u_60:EquippedSlot(p44)
		end)
		v_u_43.WeaponEquipped:Connect(function(p45)
			-- upvalues: (ref) v_u_60
			v_u_60:WeaponEquipped(p45)
		end)
		v_u_43.WeaponUnequipped:Connect(function()
			-- upvalues: (ref) v_u_60
			v_u_60:WeaponUnequipped()
		end)
		v_u_43.InventoryChanged:Connect(function(p46)
			-- upvalues: (ref) v_u_60
			v_u_60:InventoryUpdated(p46)
		end)
		v_u_43.TargetChanged:Connect(function(p47)
			-- upvalues: (ref) v_u_34
			if p47 then
				v_u_34:UpdateCrosshairColor(Color3.new(1, 0.509804, 0.509804))
			else
				v_u_34:UpdateCrosshairColor(Color3.new(1, 1, 1))
			end
		end)
		v_u_43.InaccuracyUpdated:Connect(function()
			-- upvalues: (ref) v_u_34, (ref) v_u_42, (ref) v_u_60, (ref) v_u_25
			v_u_34:UpdateCrosshair(v_u_42, v_u_60.ReloadOffset)
			local v48 = true
			if v_u_42 and (v_u_42.Aiming and not v_u_25.ThirdPerson) then
				v48 = false
				if v_u_42 and v_u_42.Viewmodel then
					v_u_34:HitmarkerUpdateLense(v_u_42.Viewmodel.Reticle)
				end
			elseif v_u_42 and v_u_42.Viewmodel then
				v_u_34:HitmarkerUpdateLense(nil)
			end
			v_u_34:SetCrossVisible(v48)
		end)
		require("../Classes/Weapon").HitEntity:Connect(function(p49, p50)
			-- upvalues: (ref) v_u_34
			if p49 == "Kill" then
				v_u_34:EmitHitmarker(Color3.new(1, 0, 0), nil, p50)
				return
			elseif p49 == "Headshot" then
				v_u_34:EmitHitmarker(Color3.new(1, 0.666667, 0), nil, p50)
				return
			elseif p49 == "ArmorBreak" then
				v_u_34:EmitHitmarker(Color3.new(0, 0.65098, 1), "BrokeArmor", p50)
				return
			elseif p49 == "HitArmor" then
				v_u_34:EmitHitmarker(nil, "HitArmor", p50)
			elseif p49 == "Flesh" then
				v_u_34:EmitHitmarker(nil, nil, p50)
			end
		end)
		local v_u_51 = false
		local v_u_52 = v_u_21.getInputMethod()
		v_u_16.OpenChanged:Connect(function(p53)
			-- upvalues: (ref) v_u_51, (ref) v_u_52, (ref) v_u_20
			v_u_51 = p53
			if v_u_51 or v_u_52 ~= "Touch" then
				v_u_20:HideElement("MobileControls")
			else
				v_u_20:ShowElement("MobileControls")
			end
		end)
		v_u_21.InputMethodChanged:Connect(function(p54)
			-- upvalues: (ref) v_u_52, (ref) v_u_51, (ref) v_u_20
			v_u_52 = p54
			if v_u_51 or v_u_52 ~= "Touch" then
				v_u_20:HideElement("MobileControls")
			else
				v_u_20:ShowElement("MobileControls")
			end
		end)
		if game.UserInputService.TouchEnabled then
			task.wait(5)
			v_u_20:ShowElement("MobileControls")
		end
		v_u_10.Parent = v_u_6
	end,
	["SetVisible"] = function(_, p55) -- name: SetVisible
		-- upvalues: (copy) v_u_10, (copy) v_u_20, (copy) v_u_60
		v_u_10.Enabled = p55
		v_u_20:SetAllVisibility(p55)
		v_u_60.IsVisible = p55
	end,
	["MobileActive"] = function(_) -- name: MobileActive
		-- upvalues: (copy) v_u_32
		v_u_32:MobileActive()
	end,
	["MobileInactive"] = function(_) -- name: MobileInactive
		-- upvalues: (copy) v_u_32
		v_u_32:MobileInactive()
	end,
	["InventoryUpdated"] = function(_, p56) -- name: InventoryUpdated
		-- upvalues: (ref) v_u_41
		v_u_41 = p56
		if not v_u_41 then
			v_u_41 = {}
		end
		UpdateBarIcons()
	end,
	["EquippedSlot"] = function(_, p57) -- name: EquippedSlot
		-- upvalues: (copy) v_u_8, (copy) v_u_9, (copy) v_u_29
		if p57 then
			if v_u_9 then
				v_u_9:Play()
			end
		elseif v_u_8 then
			v_u_8:Play()
		end
		updateWeaponBarEquipped(p57)
		v_u_29:UpdateSelected(p57)
	end,
	["WeaponUnequipped"] = function(_) -- name: WeaponUnequipped
		-- upvalues: (ref) v_u_42, (copy) v_u_34, (copy) v_u_32
		v_u_42 = nil
		v_u_34:SetType("dot")
		v_u_32:WeaponUnequipped()
	end,
	["WeaponEquipped"] = function(_, p58) -- name: WeaponEquipped
		-- upvalues: (ref) v_u_42, (copy) v_u_34, (copy) v_u_32
		v_u_42 = p58
		v_u_34:SetType("cross")
		v_u_32:WeaponEquipped(p58)
	end,
	["UpdateStamina"] = function(_, p59) -- name: UpdateStamina
		-- upvalues: (copy) v_u_28
		v_u_28:SetPercentage(p59 / 100)
	end
}
function UpdateBarIcons() -- name: UpdateBarIcons
	-- upvalues: (copy) v_u_10, (copy) v_u_29, (ref) v_u_41, (copy) v_u_13, (copy) v_u_11, (copy) v_u_19, (copy) v_u_23, (copy) v_u_18, (copy) v_u_24, (copy) v_u_21, (copy) v_u_17, (copy) v_u_16, (ref) v_u_43
	for _, v61 in v_u_10.Weapons:GetChildren() do
		if not v61:IsA("UIListLayout") then
			v61:Destroy()
		end
	end
	v_u_29:ResetInventory()
	for v62, v_u_63 in v_u_41 do
		if v_u_63.Config then
			local v64 = v_u_63.Config.HideFromHotbar
			if type(v64) == "function" then
				v64 = v64(v_u_63.Config, v_u_63)
			end
			if not v64 then
				goto l8
			end
		else
			::l8::
			local v_u_65 = v_u_13:Clone()
			v_u_65.NumberLabel.Text = v_u_63.HotbarSlot
			v_u_65.LayoutOrder = v_u_63.HotbarSlot * 100 + v62
			v_u_65.Name = v_u_63.Slot
			v_u_65.Parent = v_u_11
			local v66 = v_u_63.WeaponId
			if v66 then
				v_u_19:StreamViewmodel(v66):andThen(function(p67)
					-- upvalues: (copy) v_u_65, (ref) v_u_23, (ref) v_u_18, (copy) v_u_63, (ref) v_u_24, (ref) v_u_29
					if v_u_65.Parent then
						local v68 = p67:Clone()
						resolveWeldPositions(v68)
						cleanVModel(v68)
						local v69 = v_u_65.ViewportFrame
						v69:ClearAllChildren()
						local v70 = Instance.new("Camera")
						v70.FieldOfView = 70
						v70.Parent = v_u_65.ViewportFrame
						v69.CurrentCamera = v70
						local v71 = v_u_23.new(v69, v70)
						v71:SetModel(v68)
						v70.CFrame = v71:GetMinimumFitCFrame(CFrame.Angles(0, 1.5707963267948966, 0))
						v68.Parent = v_u_65:WaitForChild("ViewportFrame")
						v_u_65.Fill.UIStroke.Color = v_u_18.RarityColors[v_u_63.Rarity].Main
						v_u_65.Fill.BackgroundColor3 = v_u_18.RarityColors[v_u_63.Rarity].Back
						v_u_65.NameLabel.TextColor3 = v_u_18.RarityColors[v_u_63.Rarity].Main
						v_u_65.NameLabel.Text = v_u_24.GetDisplayName(v_u_63.Name, v_u_63.Config)
						v_u_29:AddItem(v_u_63, v_u_65)
					end
				end)
			else
				v_u_65.ViewportFrame:ClearAllChildren()
				v_u_65.Fill.UIStroke.Color = v_u_18.RarityColors.Stock.Main
				v_u_65.Fill.BackgroundColor3 = v_u_18.RarityColors.Stock.Back
				v_u_65.NameLabel.TextColor3 = v_u_18.RarityColors.Stock.Main
				v_u_65.NameLabel.Text = "Empty"
			end
			v_u_65.Visible = true
			v_u_63.WeaponButton = v_u_65
			local v72 = Instance.new("TextButton")
			v72.Name = "TapButton"
			v72.Size = UDim2.new(1, 0, 1, 0)
			v72.BackgroundTransparency = 1
			v72.Text = ""
			v72.TextTransparency = 1
			v72.ZIndex = 10
			local v73
			if v_u_21.getInputMethod() == "Touch" then
				v73 = v_u_17(v_u_16.Controls.MobileSelectionMode) == 1
			else
				v73 = false
			end
			v72.Visible = v73
			v72.Parent = v_u_65
			v72.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u_43, (copy) v_u_63
				v_u_43:SwapWeapon(v_u_63.HotbarSlot)
			end)
		end
	end
end
local v_u_74 = os.clock()
function updateWeaponBarEquipped(p75, p76) -- name: updateWeaponBarEquipped
	-- upvalues: (ref) v_u_74, (copy) v_u_11, (copy) v_u_2, (copy) v_u_21, (copy) v_u_17, (copy) v_u_16
	local v_u_77 = os.clock()
	v_u_74 = v_u_77
	if p76 ~= true then
		v_u_11:TweenPosition(UDim2.new(0.5, 0, 0.985, 0), "Out", "Sine", 0.33, true)
	end
	local _ = v_u_11.AbsoluteSize.Y / v_u_11.AbsoluteSize.X
	local v78 = 0
	for v79, v80 in v_u_11:GetChildren() do
		if v80:IsA("Frame") then
			if p75 then
				if v80.Name == tostring(p75) then
					v78 = v78 + 0.39 + 0.015
					v80:TweenSize(UDim2.new(0.39, 0, 20, 0), "Out", "Sine", 0.2, true)
					v_u_2:Create(v80.Cover, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						["BackgroundTransparency"] = 1
					}):Play()
				else
					v78 = v78 + 0.29 + 0.015
					v80:TweenSize(UDim2.new(0.29, 0, 20, 0), "Out", "Sine", 0.2, true)
					v_u_2:Create(v80.Cover, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						["BackgroundTransparency"] = 0.2
					}):Play()
				end
			else
				v80:TweenPosition(UDim2.new((v79 - 1) * 0.3333333333333333, 0, 1, 0), "Out", "Sine", 0.2, true)
				v80:TweenSize(UDim2.new(0.3183333333333333, 0, 20, 0), "Out", "Sine", 0.2, true)
				v_u_2:Create(v80.Cover, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					["BackgroundTransparency"] = 0.2
				}):Play()
			end
		end
	end
	coroutine.resume(coroutine.create(function()
		-- upvalues: (ref) v_u_21, (ref) v_u_17, (ref) v_u_16, (ref) v_u_74, (copy) v_u_77, (ref) v_u_11
		task.wait(2)
		local v81
		if v_u_21.getInputMethod() == "Touch" then
			v81 = v_u_17(v_u_16.Controls.MobileSelectionMode) == 1
		else
			v81 = false
		end
		if v_u_74 == v_u_77 and not v81 then
			v_u_11:TweenPosition(UDim2.new(0.5, 0, 1.245, 0), "In", "Sine", 0.33, true)
		end
	end))
end
function resolveWeldPositions(p82) -- name: resolveWeldPositions
	local v83 = p82:FindFirstChild("KeyParts")
	local v84 = v83 and v83:FindFirstChild("Handle") or p82.PrimaryPart
	if v84 then
		local v85 = {}
		for _, v86 in p82:GetDescendants() do
			if v86:IsA("JointInstance") and (v86.Part0 and v86.Part1) then
				if not v85[v86.Part0] then
					v85[v86.Part0] = {}
				end
				if not v85[v86.Part1] then
					v85[v86.Part1] = {}
				end
				local v87 = v85[v86.Part0]
				local v88 = {
					["joint"] = v86,
					["other"] = v86.Part1
				}
				table.insert(v87, v88)
				local v89 = v85[v86.Part1]
				local v90 = {
					["joint"] = v86,
					["other"] = v86.Part0
				}
				table.insert(v89, v90)
			end
		end
		local v91 = { v84 }
		local v92 = 1
		local v93 = {
			[v84] = true
		}
		while v92 <= #v91 do
			local v94 = v91[v92]
			v92 = v92 + 1
			if v85[v94] then
				for _, v95 in v85[v94] do
					if not v93[v95.other] then
						local v96 = v95.joint
						if v96.Part0 == v94 then
							v95.other.CFrame = v94.CFrame * v96.C0 * v96.C1:Inverse()
						else
							v95.other.CFrame = v94.CFrame * v96.C1 * v96.C0:Inverse()
						end
						v93[v95.other] = true
						local v97 = v95.other
						table.insert(v91, v97)
					end
				end
			end
		end
	end
end
function cleanVModel(p98) -- name: cleanVModel
	for _, v99 in p98:QueryDescendants("BasePart[Transparency = 1], #KeyParts, #GlobalParts") do
		v99:Destroy()
	end
end
local v_u_100 = v_u_21.getInputMethod()
if v_u_100 == "Touch" then
	v_u_60:MobileActive()
	if v_u_17(v_u_16.Controls.MobileSelectionMode) == 1 then
		v_u_11:TweenPosition(UDim2.new(0.5, 0, 0.985, 0), "Out", "Sine", 0.33, true)
		v_u_12.Scale = v_u_17(v_u_16.Controls.HotbarScale)
	end
else
	v_u_60:MobileInactive()
end
v_u_21.InputMethodChanged:Connect(function(p101)
	-- upvalues: (ref) v_u_100, (copy) v_u_17, (copy) v_u_16, (copy) v_u_11, (copy) v_u_12, (copy) v_u_60
	v_u_100 = p101
	local v102 = v_u_100 == "Touch"
	local v103
	if v102 then
		v103 = v_u_17(v_u_16.Controls.MobileSelectionMode) == 1
	else
		v103 = v102
	end
	for _, v104 in v_u_11:GetChildren() do
		local v105 = v104:FindFirstChild("TapButton")
		if v105 then
			v105.Visible = v103
		end
	end
	v_u_12.Scale = v103 and v_u_17(v_u_16.Controls.HotbarScale) or 1
	if v102 then
		v_u_60:MobileActive()
		if v103 then
			v_u_11:TweenPosition(UDim2.new(0.5, 0, 0.985, 0), "Out", "Sine", 0.33, true)
			return
		end
	else
		v_u_60:MobileInactive()
	end
end)
v_u_16.SettingsChanged:Connect(function(p106)
	-- upvalues: (copy) v_u_21, (copy) v_u_17, (copy) v_u_16, (copy) v_u_12
	if p106 and (p106[1] == "Controls" and p106[2] == "HotbarScale") then
		local v107 = v_u_21.getInputMethod() == "Touch"
		if v107 then
			v107 = v_u_17(v_u_16.Controls.MobileSelectionMode) == 1
		end
		if v107 then
			v_u_12.Scale = v_u_17(v_u_16.Controls.HotbarScale)
		end
	end
end)
v_u_16.SettingsChanged:Connect(function(p108)
	-- upvalues: (copy) v_u_21, (copy) v_u_17, (copy) v_u_16, (copy) v_u_11, (copy) v_u_12
	if p108 and (p108[1] == "Controls" and p108[2] == "MobileSelectionMode") then
		if v_u_21.getInputMethod() ~= "Touch" then
			return
		end
		local v109 = v_u_17(v_u_16.Controls.MobileSelectionMode) == 1
		for _, v110 in v_u_11:GetChildren() do
			local v111 = v110:FindFirstChild("TapButton")
			if v111 then
				v111.Visible = v109
			end
		end
		if v109 then
			v_u_12.Scale = v_u_17(v_u_16.Controls.HotbarScale)
			v_u_11:TweenPosition(UDim2.new(0.5, 0, 0.985, 0), "Out", "Sine", 0.33, true)
			return
		end
		v_u_12.Scale = 1
		v_u_11:TweenPosition(UDim2.new(0.5, 0, 1.245, 0), "In", "Sine", 0.33, true)
	end
end)
v3:BindToRenderStep("HUD_UPDATE", Enum.RenderPriority.Camera.Value, function()
	-- upvalues: (copy) v_u_22, (copy) v_u_60
	local v112 = workspace.CurrentCamera
	local v113 = v_u_22.AimCFrame.LookVector * 8000
	local v114 = v112.CFrame.LookVector * 8000
	v_u_60.ReloadOffset = v112:WorldToViewportPoint(v113) - v112:WorldToViewportPoint(v114)
end)
game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
return v_u_60