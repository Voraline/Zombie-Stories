local v1 = game:GetService("ReplicatedStorage")
local v2 = script.Parent.Parent:WaitForChild("Classes")
script.Parent.Parent:WaitForChild("Utils")
local v3 = script.Parent.Parent:WaitForChild("Controllers")
local v_u_4 = game:GetService("GuiService")
local v5 = v1.common
local v_u_6 = require(v1.Packages.Fusion).peek
local v_u_7 = require(v5:WaitForChild("BindUtil"))
local v_u_8 = require(v3:WaitForChild("WeaponController"))
local v_u_9 = require(v3:WaitForChild("LocalPlayerController"))
local v_u_10 = require(v3.CameraController)
local v_u_11 = require(v5:WaitForChild("HUDService"))
local v_u_12 = require(v5.Settings)
local v13 = require(v5.Settings.Binding)
local v_u_14 = require(v5.ProximityPromptZS)
local v_u_15 = require(v3:WaitForChild("HUDOverlayController"))
local v_u_16 = require(v2.Viewmodel.ViewmodelUtils:WaitForChild("NVGs"))
local v_u_17 = require(v3.QuickChatController)
local v_u_18 = game:GetService("GamepadService")
local v_u_19 = false
local v_u_20 = v_u_7.getInputMethod()
local v_u_21 = false
local v56 = {
	["Init"] = function(_) -- name: Init
		-- upvalues: (copy) v_u_7, (copy) v_u_14, (copy) v_u_8, (copy) v_u_6, (copy) v_u_12, (copy) v_u_11, (copy) v_u_9, (copy) v_u_10, (copy) v_u_15, (copy) v_u_18, (copy) v_u_16, (copy) v_u_17
		v_u_7.new("Reload", function(_, p22)
			-- upvalues: (ref) v_u_7, (ref) v_u_14, (ref) v_u_8
			if v_u_7.getInputMethod() ~= "Gamepad" or v_u_14.openedPrompt == nil then
				if not p22 then
					v_u_8:Reload()
				end
			end
		end)
		v_u_7.new("Swap", function(p23, p24, p25)
			-- upvalues: (ref) v_u_7, (ref) v_u_8
			if not p24 then
				if p25 then
					local v26 = v_u_7.getActionBinds("OffHandUse")
					if v26 and v26[p25.KeyCode] then
						return
					end
				end
				v_u_8:SwapWeapon(p23)
			end
		end)
		v_u_7.new("XboxSwap", function(p27, p28)
			-- upvalues: (ref) v_u_6, (ref) v_u_12, (ref) v_u_11, (ref) v_u_8
			if not p28 then
				if v_u_6(v_u_12.Controls.GamepadSelectionMode) == 2 then
					local v29 = v_u_11:GetElement("DPadSelection")
					local v30 = v29 and v29:Interact(p27)
					if v30 then
						v_u_8:SwapWeapon(v29:GetHotbarSlot(v30), nil)
						return
					end
				else
					v_u_8:SwapWeaponXbox(p27 == "Left" and -1 or 1)
				end
			end
		end)
		v_u_7.new("PrimaryAttack", function(_, p31)
			-- upvalues: (ref) v_u_8
			if not p31 then
				v_u_8.PrimaryAttackDown = true
			end
		end, function(_, _)
			-- upvalues: (ref) v_u_8
			v_u_8.PrimaryAttackDown = false
		end)
		v_u_7.new("SecondaryAttack", function(_, p32)
			-- upvalues: (ref) v_u_8
			if not p32 then
				v_u_8.SecondaryAttackDown = true
			end
		end, function(_, _)
			-- upvalues: (ref) v_u_8
			v_u_8.SecondaryAttackDown = false
		end)
		v_u_7.new("ToggleSecondaryAttack", function(_, p33)
			-- upvalues: (ref) v_u_8
			if not p33 then
				v_u_8.SecondaryAttackDown = not v_u_8.SecondaryAttackDown
			end
		end)
		v_u_7.new("Firemode", function(_, p34)
			-- upvalues: (ref) v_u_8
			if not p34 then
				v_u_8:CycleFiremode()
			end
		end)
		v_u_7.new("QuickMeleeAndBlock", function(_, p35)
			-- upvalues: (ref) v_u_9
			if not p35 then
				v_u_9.BlockPressed = true
			end
		end, function(_, _)
			-- upvalues: (ref) v_u_9
			v_u_9.BlockPressed = false
		end)
		v_u_7.new("OffHandUse", function(_, p36)
			-- upvalues: (ref) v_u_9, (ref) v_u_8
			if not p36 then
				v_u_9.OffHandPressed = true
				v_u_8:UseOffHand()
			end
		end, function(_, _)
			-- upvalues: (ref) v_u_9, (ref) v_u_8
			v_u_9.OffHandPressed = false
			v_u_8:CancelOffHand()
		end)
		v_u_7.new("SprintHold", function(_, p37)
			-- upvalues: (ref) v_u_9, (ref) v_u_8
			if not p37 then
				v_u_9.SprintPressed = true
				v_u_8.SecondaryAttackDown = false
				v_u_9.CrouchPressed = false
				v_u_9.PronePressed = false
				if v_u_9.States.Sliding then
					v_u_9.RequestCancel = true
				end
			end
		end, function(_, _)
			-- upvalues: (ref) v_u_9
			v_u_9.SprintPressed = false
		end)
		v_u_7.new("SprintToggle", function(_, p38)
			-- upvalues: (ref) v_u_9, (ref) v_u_8
			if not p38 then
				v_u_9.SprintPressed = not v_u_9.SprintPressed
				if v_u_9.SprintPressed then
					v_u_8.SecondaryAttackDown = false
					v_u_9.CrouchPressed = false
					v_u_9.PronePressed = false
					if v_u_9.States.Sliding then
						v_u_9.RequestCancel = true
					end
				end
			end
		end)
		v_u_7.new("Thirdperson", function(_, p39)
			-- upvalues: (ref) v_u_10, (ref) v_u_7, (ref) v_u_9
			if v_u_10.Enabled then
				if not p39 or v_u_7.getInputMethod() == "Gamepad" then
					if v_u_7.getInputMethod() == "Gamepad" then
						v_u_9.RequestThirdPerson = not v_u_9.RequestThirdPerson
						return
					end
					v_u_9.TPPressed = true
				end
			end
		end, function(_, _)
			-- upvalues: (ref) v_u_9
			v_u_9.TPPressed = false
		end)
		v_u_7.new("CrouchToggle", function(_, p40)
			-- upvalues: (ref) v_u_9
			if not p40 then
				v_u_9.CrouchPressed = not v_u_9.CrouchPressed
			end
		end)
		local v_u_41 = nil
		v_u_7.new("CrouchProneToggle", function(_, p42)
			-- upvalues: (ref) v_u_41, (ref) v_u_9
			if not p42 then
				v_u_41 = true
				task.spawn(function()
					-- upvalues: (ref) v_u_41, (ref) v_u_9
					local v43 = 0
					while v_u_41 and v43 < 0.25 do
						v43 = v43 + task.wait()
					end
					if v43 < 0.25 then
						v_u_9.CrouchPressed = not v_u_9.CrouchPressed
					else
						v_u_9.PronePressed = not v_u_9.PronePressed
					end
				end)
			end
		end, function(_, _)
			-- upvalues: (ref) v_u_41
			v_u_41 = false
		end)
		v_u_7.new("DiveAndProneToggle", function(_, p44)
			-- upvalues: (ref) v_u_9
			if not (p44 or v_u_9.States.Diving) then
				v_u_9.PronePressed = not v_u_9.PronePressed
			end
		end)
		v_u_7.new("CrouchHold", function(_, p45)
			-- upvalues: (ref) v_u_9
			if not p45 then
				v_u_9.CrouchPressed = true
			end
		end, function(_, _)
			-- upvalues: (ref) v_u_9
			v_u_9.CrouchPressed = false
		end)
		v_u_7.new("ProneToggle", function(_, p46)
			-- upvalues: (ref) v_u_9
			if not (p46 or v_u_9.States.Diving) then
				v_u_9.PronePressed = not v_u_9.PronePressed
			end
		end)
		v_u_7.new("LeaderboardToggle", function(_, p47)
			-- upvalues: (ref) v_u_15
			if not p47 then
				v_u_15:SetVisible(not v_u_15:IsVisible())
			end
		end)
		v_u_7.new("LeaderboardHold", function(_, p48)
			-- upvalues: (ref) v_u_15
			if not p48 then
				v_u_15:SetVisible(true)
			end
		end, function(_, _)
			-- upvalues: (ref) v_u_15
			v_u_15:SetVisible(false)
		end)
		v_u_7.new("VirtualCursor", function(_, p49)
			-- upvalues: (ref) v_u_18
			if workspace:FindFirstChild("Values") then
				if workspace.Values:FindFirstChild("IsLobby") then
					if workspace.Values.IsLobby.Value then
						if p49 then
							return
						elseif v_u_18.GamepadCursorEnabled then
							game.GamepadService:DisableGamepadCursor()
						else
							game.GamepadService:EnableGamepadCursor(nil)
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
		end, function() end)
		v_u_16.Init()
		v_u_7.new("NVGToggle", function(_, p50)
			-- upvalues: (ref) v_u_16
			if not p50 then
				if workspace:FindFirstChild("Values") and (workspace.Values:FindFirstChild("IsLobby") and workspace.Values.IsLobby.Value == true) then
					return
				end
				v_u_16.ToggleActivate()
			end
		end)
		v_u_17.Init()
		v_u_7.new("QuickChat", function(_, p51)
			-- upvalues: (ref) v_u_17, (ref) v_u_7, (ref) v_u_9, (ref) v_u_10
			if not p51 then
				if v_u_17.IsDisabled() then
					return
				end
				if workspace:FindFirstChild("Values") and (workspace.Values:FindFirstChild("IsLobby") and workspace.Values.IsLobby.Value == true) then
					return
				end
				if v_u_17.Cooldown then
					return
				end
				v_u_17.Activated = not v_u_17.Activated
				local v52 = v_u_7.getInputMethod() == "Gamepad"
				v_u_17.ToggleActivate(v_u_17.Activated, v52)
				if not v52 then
					v_u_9:SetMovementEnabled(not v_u_17.Activated)
				end
				v_u_10:SetEnabled(not v_u_17.Activated)
			end
		end)
		local v53 = game:GetService("UserInputService")
		local v_u_54 = os.clock() + 1
		v53.JumpRequest:Connect(function()
			-- upvalues: (ref) v_u_9, (ref) v_u_54
			if v_u_9.States.Sliding then
				v_u_9.RequestSlideJump = true
				return
			else
				local v55 = v_u_9.humanoid.Humanoid
				if v_u_9.States.IsDead or v_u_9.States.IsDowned then
					v55:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
				elseif not v_u_9.States.Diving then
					if v_u_9.PronePressed then
						v_u_9.PronePressed = false
						v_u_9.CrouchPressed = true
						v55:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
						return
					end
					if v_u_9.CrouchPressed then
						v_u_9.CrouchPressed = false
						v55:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
						return
					end
					v_u_9.RequestVault = true
					if v55.FloorMaterial == Enum.Material.Air or v_u_54 > os.clock() then
						v55:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
						return
					end
					v_u_54 = os.clock() + 0.05
					v55:ChangeState(Enum.HumanoidStateType.Jumping)
				end
			end
		end)
	end
}
task.spawn(function()
	-- upvalues: (copy) v_u_4, (ref) v_u_21, (copy) v_u_18
	if workspace:FindFirstChild("Values") then
		if workspace.Values:FindFirstChild("IsLobby") then
			if workspace.Values.IsLobby.Value then
				v_u_4.GuiNavigationEnabled = false
				v_u_4.AutoSelectGuiEnabled = false
				v_u_21 = true
				v_u_18:EnableGamepadCursor(nil)
			end
		else
			return
		end
	else
		return
	end
end)
function v56.SetupBinds(_) -- name: SetupBinds
	-- upvalues: (copy) v_u_7, (copy) v_u_6, (copy) v_u_12
	v_u_7.unbindAllActions()
	v_u_7.bind(Enum.KeyCode.One, "Swap", 1)
	v_u_7.bind(Enum.KeyCode.Two, "Swap", 2)
	v_u_7.bind(Enum.KeyCode.Three, "Swap", 3)
	v_u_7.bind(Enum.KeyCode.Four, "Swap", 4)
	v_u_7.bind(Enum.KeyCode.Five, "Swap", 5)
	v_u_7.bind(Enum.KeyCode.Six, "Swap", 6)
	v_u_7.bind(Enum.KeyCode.Seven, "Swap", 7)
	v_u_7.bind(Enum.KeyCode.Eight, "Swap", 8)
	v_u_7.bind(Enum.KeyCode.Nine, "Swap", 9)
	v_u_7.bind(Enum.KeyCode.Zero, "Swap", 0)
	v_u_7.bind(Enum.KeyCode.DPadLeft, "XboxSwap", "Left")
	v_u_7.bind(Enum.KeyCode.DPadRight, "XboxSwap", "Right")
	if v_u_6(v_u_12.Controls.GamepadSelectionMode) == 2 then
		v_u_7.bind(Enum.KeyCode.DPadUp, "XboxSwap", "Up")
		v_u_7.bind(Enum.KeyCode.DPadDown, "XboxSwap", "Down")
	end
	v_u_7.bind(Enum.KeyCode.ButtonSelect, "VirtualCursor", "Select")
	for v57, v58 in v_u_12.Controls.Binds do
		for _, v59 in v58 do
			v_u_7.bind(v59, v57)
		end
	end
end
local function v60() -- name: updateVirtualCursorEnabled
	-- upvalues: (copy) v_u_11, (ref) v_u_19, (ref) v_u_20
	if v_u_11.Visible and not v_u_19 or v_u_20 ~= "Gamepad" then
		game.GamepadService:DisableGamepadCursor()
	else
		game.GamepadService:EnableGamepadCursor(nil)
	end
end
v13.BindingChanged:Connect(function(p61, _, p62, p63)
	-- upvalues: (copy) v_u_7
	v_u_7.unbindActionInput(p61, p62)
	if p63 then
		v_u_7.bind(p63, p61)
	end
end)
v_u_7.InputMethodChanged:Connect(function(p64)
	-- upvalues: (ref) v_u_20, (copy) v_u_8, (copy) v_u_11, (ref) v_u_19, (ref) v_u_21, (copy) v_u_18
	v_u_20 = p64
	v_u_8:SetInputMethod(p64)
	if v_u_11.Visible and not v_u_19 or v_u_20 ~= "Gamepad" then
		game.GamepadService:DisableGamepadCursor()
	else
		game.GamepadService:EnableGamepadCursor(nil)
	end
	if v_u_21 then
		v_u_18:EnableGamepadCursor(nil)
	end
end)
v_u_12.OpenChanged:Connect(function(p65)
	-- upvalues: (ref) v_u_19, (copy) v_u_11, (ref) v_u_20
	v_u_19 = p65
	if v_u_11.Visible and not v_u_19 or v_u_20 ~= "Gamepad" then
		game.GamepadService:DisableGamepadCursor()
	else
		game.GamepadService:EnableGamepadCursor(nil)
	end
end)
v_u_11.VisibilityChanged:Connect(v60)
v_u_12.SettingsChanged:Connect(function(p66)
	-- upvalues: (copy) v_u_6, (copy) v_u_12, (copy) v_u_7
	if p66 and (p66[1] == "Controls" and p66[2] == "GamepadSelectionMode") then
		if v_u_6(v_u_12.Controls.GamepadSelectionMode) == 2 then
			v_u_7.bind(Enum.KeyCode.DPadUp, "XboxSwap", "Up")
			v_u_7.bind(Enum.KeyCode.DPadDown, "XboxSwap", "Down")
			return
		end
		v_u_7.unbindActionInput("XboxSwap", Enum.KeyCode.DPadUp)
		v_u_7.unbindActionInput("XboxSwap", Enum.KeyCode.DPadDown)
	end
end)
return v56