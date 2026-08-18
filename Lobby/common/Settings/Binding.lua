local v_u_1 = script.BindGui
local v_u_2 = v_u_1.PressLabel
local v_u_3 = v_u_1.ClearLabel
local v_u_4 = v_u_1.ConfirmationFrame
local v_u_5 = v_u_4.SelectedInputFrame.LabelFrame
local v_u_6 = game:GetService("UserInputService")
local v7 = game.ReplicatedStorage.common
local v_u_8 = require(script.Parent)
local v_u_9 = require("./DefaultSettings")
local v_u_10 = require(v7.InputLabel)
local v11 = require(v7.Signal)
local v_u_12 = "MouseKeyboard"
local v_u_13 = nil
local v_u_14 = {}
local v_u_15 = {
	["Reload"] = {
		["LayoutOrder"] = 2,
		["DisplayText"] = "RELOAD",
		["Description"] = nil
	},
	["PrimaryAttack"] = {
		["LayoutOrder"] = 3,
		["DisplayText"] = "PRIMARY ATTACK",
		["Description"] = nil
	},
	["SecondaryAttack"] = {
		["LayoutOrder"] = 4,
		["DisplayText"] = "SECONDARY ATTACK",
		["Description"] = nil
	},
	["ToggleSecondaryAttack"] = {
		["LayoutOrder"] = 5,
		["DisplayText"] = "TOGGLE SECONDARY ATTACK",
		["Description"] = nil
	},
	["Firemode"] = {
		["LayoutOrder"] = 6,
		["DisplayText"] = "FIREMODE",
		["Description"] = nil
	},
	["QuickMeleeAndBlock"] = {
		["LayoutOrder"] = 7,
		["DisplayText"] = "QUICK MELEE/BLOCK",
		["Description"] = "TAP TO MELEE, HOLD TO BLOCK"
	},
	["OffHandUse"] = {
		["LayoutOrder"] = 8,
		["DisplayText"] = "ABILITY/OFF-HAND",
		["Description"] = "USE FOCUS OR OFF-HAND ITEM"
	},
	["SprintHold"] = {
		["LayoutOrder"] = 9,
		["DisplayText"] = "SPRINT [HOLD]",
		["Description"] = nil
	},
	["SprintToggle"] = {
		["LayoutOrder"] = 10,
		["DisplayText"] = "SPRINT [TOGGLE]",
		["Description"] = nil
	},
	["CrouchHold"] = {
		["LayoutOrder"] = 11,
		["DisplayText"] = "CROUCH [HOLD]",
		["Description"] = nil
	},
	["CrouchToggle"] = {
		["LayoutOrder"] = 12,
		["DisplayText"] = "CROUCH [TOGGLE]",
		["Description"] = nil
	},
	["ProneToggle"] = {
		["LayoutOrder"] = 13,
		["DisplayText"] = "PRONE [TOGGLE]",
		["Description"] = nil
	},
	["CrouchProneToggle"] = {
		["LayoutOrder"] = 14,
		["DisplayText"] = "CROUCH/PRONE [TOGGLE]",
		["Description"] = "TAP TO CROUCH, HOLD TO PRONE"
	},
	["Thirdperson"] = {
		["LayoutOrder"] = 16,
		["DisplayText"] = "THIRD PERSON",
		["Description"] = nil
	},
	["PromptInteract"] = {
		["LayoutOrder"] = 17,
		["DisplayText"] = "INTERACT",
		["Description"] = nil
	},
	["LeaderboardToggle"] = {
		["LayoutOrder"] = 18,
		["DisplayText"] = "LEADERBOARD [TOGGLE]",
		["Description"] = nil
	},
	["LeaderboardHold"] = {
		["LayoutOrder"] = 19,
		["DisplayText"] = "LEADERBOARD [HOLD]",
		["Description"] = nil
	},
	["NVGToggle"] = {
		["LayoutOrder"] = 20,
		["DisplayText"] = "NIGHT VISION GOOGLES [TOGGLE]",
		["Description"] = nil
	}
}
local v_u_16 = {
	[Enum.KeyCode.Escape] = true,
	[Enum.UserInputType.Focus] = true,
	[Enum.UserInputType.Touch] = true,
	[Enum.UserInputType.Gyro] = true,
	[Enum.UserInputType.Accelerometer] = true,
	[Enum.UserInputType.MouseMovement] = true
}
local v_u_45 = {
	["IsBinding"] = false,
	["BindingChanged"] = v11.new(),
	["CreateSection"] = function(p17) -- name: CreateSection
		-- upvalues: (copy) v_u_8, (copy) v_u_15, (copy) v_u_14, (copy) v_u_45, (ref) v_u_12, (ref) v_u_13, (copy) v_u_1, (copy) v_u_2, (copy) v_u_3, (copy) v_u_10, (copy) v_u_5, (copy) v_u_4
		local v18 = p17:Tab("BINDS")
		v18:BindsHeader()
		for v_u_19, v20 in v_u_8.Controls.Binds do
			if v_u_15[v_u_19] then
				v_u_14[v_u_19] = {}
				local v21 = v18:Bind(v_u_15[v_u_19].DisplayText, v_u_15[v_u_19].Description)
				local v22 = v21:WaitForChild("Frame")
				v21.LayoutOrder = v_u_15[v_u_19].LayoutOrder
				for v23, v24 in v20 do
					local v25 = v22:WaitForChild(v23 .. "Button")
					setButtonLabel(v25, v24)
				end
				local v26 = v22:WaitForChild("KeyboardButton")
				v_u_14[v_u_19].Keyboard = v26
				local v_u_27 = "Keyboard"
				v26.MouseButton1Click:Connect(function()
					-- upvalues: (ref) v_u_45, (ref) v_u_12, (ref) v_u_13, (ref) v_u_1, (ref) v_u_8, (copy) v_u_19, (copy) v_u_27, (ref) v_u_2, (ref) v_u_3, (ref) v_u_10, (ref) v_u_5, (ref) v_u_4
					if not v_u_45.IsBinding and v_u_12 ~= "Touch" then
						local v_u_28 = os.clock()
						v_u_13 = v_u_28
						v_u_45.IsBinding = true
						v_u_1.Parent = game.Players.LocalPlayer.PlayerGui
						v_u_1.Enabled = true
						local v29 = getNextInput()
						local v30 = true
						if v29 == v_u_8.Controls.Binds[v_u_19][v_u_27] then
							v29 = nil
						elseif v29 ~= v_u_8.Controls.Binds[v_u_19][v_u_27] and inputAlreadyInUse(v29) then
							v_u_2.Visible = false
							v_u_3.Visible = false
							local v31 = v_u_10.new(v29, 3, nil, false)
							v31.UIObject.Size = UDim2.new(1, 0, 1, 0)
							v31.UIObject.Parent = v_u_5
							v_u_4.Visible = true
							v30 = getNextInput() == v29
							v31:Destroy()
						end
						if v30 then
							setBind(v_u_19, v_u_27, v29)
						end
						v_u_1.Enabled = false
						v_u_1.Parent = nil
						v_u_2.Visible = true
						v_u_3.Visible = true
						v_u_4.Visible = false
						task.delay(1, function()
							-- upvalues: (copy) v_u_28, (ref) v_u_13, (ref) v_u_45
							if v_u_28 == v_u_13 then
								v_u_45.IsBinding = false
							end
						end)
					end
				end)
				local v32 = v22:WaitForChild("MouseButton")
				v_u_14[v_u_19].Mouse = v32
				local v_u_33 = "Mouse"
				v32.MouseButton1Click:Connect(function()
					-- upvalues: (ref) v_u_45, (ref) v_u_12, (ref) v_u_13, (ref) v_u_1, (ref) v_u_8, (copy) v_u_19, (copy) v_u_33, (ref) v_u_2, (ref) v_u_3, (ref) v_u_10, (ref) v_u_5, (ref) v_u_4
					if not v_u_45.IsBinding and v_u_12 ~= "Touch" then
						local v_u_34 = os.clock()
						v_u_13 = v_u_34
						v_u_45.IsBinding = true
						v_u_1.Parent = game.Players.LocalPlayer.PlayerGui
						v_u_1.Enabled = true
						local v35 = getNextInput()
						local v36 = true
						if v35 == v_u_8.Controls.Binds[v_u_19][v_u_33] then
							v35 = nil
						elseif v35 ~= v_u_8.Controls.Binds[v_u_19][v_u_33] and inputAlreadyInUse(v35) then
							v_u_2.Visible = false
							v_u_3.Visible = false
							local v37 = v_u_10.new(v35, 3, nil, false)
							v37.UIObject.Size = UDim2.new(1, 0, 1, 0)
							v37.UIObject.Parent = v_u_5
							v_u_4.Visible = true
							v36 = getNextInput() == v35
							v37:Destroy()
						end
						if v36 then
							setBind(v_u_19, v_u_33, v35)
						end
						v_u_1.Enabled = false
						v_u_1.Parent = nil
						v_u_2.Visible = true
						v_u_3.Visible = true
						v_u_4.Visible = false
						task.delay(1, function()
							-- upvalues: (copy) v_u_34, (ref) v_u_13, (ref) v_u_45
							if v_u_34 == v_u_13 then
								v_u_45.IsBinding = false
							end
						end)
					end
				end)
				local v38 = v22:WaitForChild("GamepadButton")
				v_u_14[v_u_19].Gamepad = v38
				local v_u_39 = "Gamepad"
				v38.MouseButton1Click:Connect(function()
					-- upvalues: (ref) v_u_45, (ref) v_u_12, (ref) v_u_13, (ref) v_u_1, (ref) v_u_8, (copy) v_u_19, (copy) v_u_39, (ref) v_u_2, (ref) v_u_3, (ref) v_u_10, (ref) v_u_5, (ref) v_u_4
					if not v_u_45.IsBinding and v_u_12 ~= "Touch" then
						local v_u_40 = os.clock()
						v_u_13 = v_u_40
						v_u_45.IsBinding = true
						v_u_1.Parent = game.Players.LocalPlayer.PlayerGui
						v_u_1.Enabled = true
						local v41 = getNextInput()
						local v42 = true
						if v41 == v_u_8.Controls.Binds[v_u_19][v_u_39] then
							v41 = nil
						elseif v41 ~= v_u_8.Controls.Binds[v_u_19][v_u_39] and inputAlreadyInUse(v41) then
							v_u_2.Visible = false
							v_u_3.Visible = false
							local v43 = v_u_10.new(v41, 3, nil, false)
							v43.UIObject.Size = UDim2.new(1, 0, 1, 0)
							v43.UIObject.Parent = v_u_5
							v_u_4.Visible = true
							v42 = getNextInput() == v41
							v43:Destroy()
						end
						if v42 then
							setBind(v_u_19, v_u_39, v41)
						end
						v_u_1.Enabled = false
						v_u_1.Parent = nil
						v_u_2.Visible = true
						v_u_3.Visible = true
						v_u_4.Visible = false
						task.delay(1, function()
							-- upvalues: (copy) v_u_40, (ref) v_u_13, (ref) v_u_45
							if v_u_40 == v_u_13 then
								v_u_45.IsBinding = false
							end
						end)
					end
				end)
			end
		end
		v18:Button("RESET TO DEFAULT", "RESET", function()
			resetBinds()
		end, Color3.fromRGB(255, 73, 73), Color3.fromRGB(49, 49, 49), Color3.fromRGB(255, 73, 73)).LayoutOrder = 100
		return v18
	end,
	["SetInputMethod"] = function(p44) -- name: SetInputMethod
		-- upvalues: (ref) v_u_12
		v_u_12 = p44
	end
}
function setButtonLabel(p46, p47) -- name: setButtonLabel
	-- upvalues: (copy) v_u_10
	local v48 = p46:FindFirstChildWhichIsA("GuiObject")
	if v48 then
		v48:Destroy()
	end
	if p47 then
		local v49 = v_u_10.new(p47, 3, nil, false)
		v49.UIObject.AnchorPoint = Vector2.new(0.5, 0.5)
		v49.UIObject.Position = UDim2.new(0.5, 0, 0.5, 0)
		v49.UIObject.Size = UDim2.new(0.7, 0, 0.7, 0)
		v49.UIObject.Parent = p46
	end
end
function setBind(p50, p51, p52) -- name: setBind
	-- upvalues: (copy) v_u_8, (copy) v_u_10, (copy) v_u_14, (copy) v_u_45
	local v53 = v_u_8.Controls.Binds[p50][p51]
	v_u_8.Controls.Binds[p50][p51] = p52
	v_u_10.UpdateBind(p50, v_u_8.Controls.Binds[p50])
	setButtonLabel(v_u_14[p50][p51], p52)
	v_u_45.BindingChanged:Fire(p50, p51, v53, p52)
end
function resetBinds() -- name: resetBinds
	-- upvalues: (copy) v_u_8, (copy) v_u_9
	for v54, v55 in v_u_8.Controls.Binds do
		for _, v56 in { "Keyboard", "Mouse", "Gamepad" } do
			local v57 = v55[v56]
			local v58 = v_u_9.Controls.Binds[v54][v56]
			if v58 ~= v57 then
				setBind(v54, v56, v58)
			end
		end
	end
end
function inputAlreadyInUse(p59) -- name: inputAlreadyInUse
	-- upvalues: (copy) v_u_8
	for _, v60 in v_u_8.Controls.Binds do
		for _, v61 in v60 do
			if v61 == p59 then
				return true
			end
		end
	end
	return false
end
function getNextInput() -- name: getNextInput
	-- upvalues: (copy) v_u_6, (copy) v_u_16
	repeat
		local v62, _ = v_u_6.InputBegan:Wait()
		local v63 = v62.UserInputType
		local v64 = v62.KeyCode
	until not (v_u_16[v63] or v_u_16[v64])
	if v64 == Enum.KeyCode.Unknown then
		return v63
	else
		return v64
	end
end
for v65, v66 in v_u_8.Controls.Binds do
	v_u_10.UpdateBind(v65, v66)
end
v_u_45.BindingChanged:Connect(function(p67, p68, _, p69)
	-- upvalues: (copy) v_u_8
	v_u_8.SettingsChanged:Fire({
		"Controls",
		"Binds",
		p67,
		p68
	}, p69)
end)
return v_u_45