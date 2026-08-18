local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("GuiService")
local v_u_3 = require(v1.Packages.Fusion).peek
local v_u_4 = require(game.ReplicatedStorage.common:WaitForChild("HUDService"))
local v_u_5 = require("@game/ReplicatedStorage/common/Settings")
local v6 = require("@game/ReplicatedStorage/common/BindUtil")
require("@game/ReplicatedStorage/common/Signal")
local v_u_7 = require(script.Parent.Parent.Parent.Parent.Classes.Viewmodel.ViewmodelUtils:WaitForChild("NVGs"))
local v_u_8 = require("@game/ReplicatedStorage/common/HintSystem")
local v_u_9 = game.ReplicatedStorage.common:WaitForChild("Remotes"):WaitForChild("Net")
game.ReplicatedStorage.common:WaitForChild("Remotes"):WaitForChild("DataRemote")
local v_u_10 = script.Sounds
local v_u_11 = require(script.ButtonTemplate)
local v_u_12 = require(script.Edit)
local v_u_13 = script.Parent.Parent.Parent
local _ = game.Players.LocalPlayer
local v_u_14 = nil
local v_u_15 = nil
local v_u_16 = nil
local v_u_17 = nil
local v_u_18 = Instance.new("Folder")
require(game.Players.LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("ControlScript"):WaitForChild("MasterControl"))
local v_u_19 = game:GetService("UserInputService")
local v_u_20 = {}
local v_u_21 = {}
local v_u_22 = nil
local v_u_23 = false
local v_u_24 = false
local v_u_25 = nil
local v_u_26 = nil
local v_u_27 = nil
local v_u_28 = nil
local v_u_29 = {
	["IsShowing"] = false,
	["EditData"] = {},
	["PresetData"] = {}
}
local function v_u_36(p30, p31, p32) -- name: createTouchButton
	-- upvalues: (ref) v_u_17, (copy) v_u_11
	local v33 = v_u_17.TouchControlFrame.JumpButton:Clone()
	if not v33:FindFirstChildWhichIsA("UIScale") then
		Instance.new("UIScale").Parent = v33
	end
	v33.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
	v33.Name = p30
	v33.ImageRectOffset = Vector2.new(0, 0)
	v33.ImageRectSize = Vector2.new(146, 146)
	v33.ImageTransparency = 0.5
	v33.ImageColor3 = Color3.fromRGB(199, 223, 255)
	local v34 = v_u_11.TextLabel:Clone()
	v34.Text = p32
	v34.Visible = false
	v34.Parent = v33
	local v35 = v_u_11.ImageLabel:Clone()
	v35.Image = p31
	v35.Parent = v33
	return v33, v35, v34
end
local function v_u_39(p37) -- name: touchPosToScreenPos
	-- upvalues: (copy) v_u_2
	local v38 = v_u_2.TopbarInset.Height
	return UDim2.new(p37.X.Scale, p37.X.Offset, p37.Y.Scale, p37.Y.Offset + v38 * (1 - p37.Y.Scale))
end
local function v_u_196(p40) -- name: Generate
	-- upvalues: (ref) v_u_24, (ref) v_u_14, (copy) v_u_13, (ref) v_u_15, (ref) v_u_16, (ref) v_u_17, (ref) v_u_23, (ref) v_u_20, (ref) v_u_22, (copy) v_u_29, (copy) v_u_18, (copy) v_u_21, (copy) v_u_36, (ref) v_u_26, (copy) v_u_10, (copy) v_u_8, (copy) v_u_7, (copy) v_u_3, (copy) v_u_5, (copy) v_u_196, (copy) v_u_2, (copy) v_u_4, (ref) v_u_28, (ref) v_u_27, (copy) v_u_12, (copy) v_u_19, (copy) v_u_9, (ref) v_u_25
	if not v_u_24 then
		v_u_14 = require(v_u_13.LocalPlayerController)
		v_u_15 = require(v_u_13.WeaponController)
		v_u_16 = require(v_u_13.CameraController)
		v_u_17 = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("TouchGui")
		v_u_17.DisplayOrder = 1
	end
	if p40 then
		if v_u_23 then
			return
		end
		v_u_23 = true
		v_u_20 = {}
		if not v_u_22 then
			v_u_22 = not v_u_29.EditData and {} or table.clone(v_u_29.EditData)
		end
		v_u_18:ClearAllChildren()
	end
	if v_u_29.EditData then
		for v41, v42 in pairs(v_u_29.EditData) do
			local v43 = v42[2]
			if typeof(v43) ~= "UDim2" then
				local v44 = v42[2]
				if typeof(v44) == "table" then
					local v45 = v42[2]
					v_u_29.EditData[v41] = { v42[1], UDim2.new(v45[1], v45[2], v45[3], v45[4]) }
				end
			end
		end
	end
	local v_u_46 = v_u_17:WaitForChild("TouchControlFrame"):WaitForChild("JumpButton")
	v_u_46:GetPropertyChangedSignal("Visible"):Connect(function()
		-- upvalues: (copy) v_u_46
		if not v_u_46.Visible then
			v_u_46.Visible = true
		end
	end)
	if not v_u_21.JumpButton then
		v_u_21.JumpButton = v_u_46.Position
	end
	v_u_46.Position = v_u_21.JumpButton
	local v47 = v_u_46:FindFirstChild("UIScale")
	if v47 then
		v47.Scale = 1
	else
		Instance.new("UIScale").Parent = v_u_46
	end
	local v_u_48, v_u_49, _ = v_u_36("SprintButton", "rbxassetid://6380639022", "Run: Off")
	v_u_26 = v_u_48
	local v50 = v_u_17.TouchControlFrame.ThumbstickFrame
	local v51 = v50.Visible
	if not v_u_21.ThumbstickFrame then
		v_u_21.ThumbstickFrame = v50.Position
	end
	local v52
	if v50.Parent:FindFirstChild("RealThumbStick") then
		v52 = v50.Parent.RealThumbStick
		v50:Destroy()
		v52.Name = "ThumbstickFrame"
	else
		v52 = v50
	end
	local v53 = nil
	if p40 then
		v53 = v52:Clone()
		v53.Parent = v52.Parent
		v52.Visible = false
		v52.Name = "RealThumbStick"
	else
		v52.Visible = v51
	end
	v52.Position = v_u_21.ThumbstickFrame
	local v54 = v52:FindFirstChild("UIScale")
	if v54 then
		v54.Scale = 1
	else
		Instance.new("UIScale").Parent = v52
	end
	local v_u_55, v_u_56 = v_u_36("CrouchButton", "rbxassetid://6377495066", "Crouch: Off")
	v_u_55.Position = v_u_55.Position + UDim2.new(0, v_u_46.Size.X.Offset * 0.5 - 15, 0, -v_u_46.Size.Y.Offset)
	v_u_21.CrouchButton = v_u_55.Position
	v_u_55.Parent = v_u_18
	v_u_55.Visible = true
	if not p40 then
		local v_u_57 = 0
		local v_u_58 = false
		v_u_55.MouseButton1Down:Connect(function()
			-- upvalues: (ref) v_u_58
			v_u_58 = true
		end)
		v_u_55.MouseButton1Up:Connect(function()
			-- upvalues: (ref) v_u_58, (ref) v_u_57, (ref) v_u_14, (copy) v_u_56
			if v_u_58 then
				v_u_58 = false
				if v_u_57 < 0.25 then
					v_u_14.CrouchPressed = not v_u_14.CrouchPressed
					if not v_u_14.CrouchPressed then
						v_u_56.Image = "rbxassetid://6377495066"
					end
				end
			end
			v_u_57 = 0
		end)
		task.spawn(function()
			-- upvalues: (copy) v_u_55, (ref) v_u_58, (ref) v_u_57, (ref) v_u_14
			while v_u_55.Parent do
				local v59 = task.wait()
				if v_u_58 then
					v_u_57 = v_u_57 + v59
					if v_u_57 >= 0.25 then
						v_u_14.PronePressed = not v_u_14.PronePressed
						v_u_58 = false
					end
				end
			end
		end)
	end
	local v60, _ = v_u_36("NVGButton", "rbxassetid://6381369551", "NVGs")
	local _ = game.Players.LocalPlayer
	local v61, _ = v_u_36("ThirdPersonButton", "rbxassetid://13646515215", "View")
	v61.Position = UDim2.new(0, 0, 0, 0)
	v_u_21.ThirdPersonButton = v61.Position
	v61.Parent = v_u_18
	v61.Visible = true
	if not p40 then
		local v_u_62 = 0
		v61.MouseButton1Down:connect(function()
			-- upvalues: (ref) v_u_10, (ref) v_u_14, (ref) v_u_62
			v_u_10.Tap:Play()
			v_u_14.TPPressed = true
			v_u_62 = os.clock()
		end)
		v61.MouseButton1Up:connect(function()
			-- upvalues: (ref) v_u_14, (ref) v_u_62, (ref) v_u_8
			v_u_14.TPPressed = false
			if os.clock() - v_u_62 < 0.33 and not v_u_14.ThirdPerson then
				v_u_8:Show("Hold this button to go into third person")
			end
		end)
	end
	v60.Position = UDim2.new(0, v61.Size.X.Offset, 0, 0)
	v_u_21.NVGButton = v60.Position
	v60.Parent = v_u_18
	v60.Visible = true
	if not p40 then
		v60.MouseButton1Click:connect(function()
			-- upvalues: (ref) v_u_7
			v_u_7.ToggleActivate()
		end)
	end
	local v63 = v_u_36("EditButton", "rbxassetid://18582762591", "Edit")
	v63.Position = UDim2.new(0, v61.Size.X.Offset * 2, 0, 0)
	v_u_21.EditButton = v63.Position
	v63.Parent = v_u_18
	v63.Visible = p40 or v_u_3(v_u_5.Controls.ShowEditButton)
	if not p40 then
		v63.MouseButton1Click:connect(function()
			-- upvalues: (ref) v_u_10, (ref) v_u_196
			v_u_10.Tap:Play()
			v_u_196(true)
		end)
	end
	local v64 = UDim2.fromOffset(0, v_u_2.TopbarInset.Height)
	local v65 = UDim2.fromScale(0.85, 0.4) + v64
	local v66 = UDim2.fromScale(0.75, 0.4) + v64
	local v67 = v_u_4:GetElement("StaminaDisplay")
	if v67 then
		local v68 = v67:GetMainFrame()
		if v68 then
			local v69
			if v68 and v68.AbsoluteSize.X ~= 0 then
				local v70 = v68.AbsolutePosition
				local v71 = v68.AbsoluteSize
				local v72 = v70.X + v71.X / 2
				local v73 = v70.Y + v71.Y / 2
				local v74 = v_u_2.TopbarInset.Height
				v69 = UDim2.fromOffset(v72, v73 - v74)
			else
				v69 = nil
			end
			v65 = v69 or v65
		end
	end
	local v75 = v_u_4:GetElement("AbilityDisplay")
	if v75 and v75.GetMainFrame then
		local v76 = v75:GetMainFrame()
		if v76 then
			local v77
			if v76 and v76.AbsoluteSize.X ~= 0 then
				local v78 = v76.AbsolutePosition
				local v79 = v76.AbsoluteSize
				local v80 = v78.X + v79.X / 2
				local v81 = v78.Y + v79.Y / 2
				local v82 = v_u_2.TopbarInset.Height
				v77 = UDim2.fromOffset(v80, v81 - v82)
			else
				v77 = nil
			end
			v66 = v77 or v66
		end
	end
	local v83 = v66 + v64
	local v84 = v65 + v64
	local v85 = v_u_36("StaminaButton", "", "Stamina")
	v85.AnchorPoint = Vector2.new(0.5, 0.5)
	v85.Position = v84
	v85.ImageLabel.Visible = false
	v85.TextLabel.Visible = true
	v_u_21.StaminaButton = v84
	v85.Parent = v_u_18
	v85.Visible = p40
	local v86 = v_u_36("AbilityButton", "", "Ability")
	v86.AnchorPoint = Vector2.new(0.5, 0.5)
	v86.Position = v83
	v86.ImageLabel.Visible = false
	v86.TextLabel.Visible = true
	v_u_21.AbilityButton = v83
	v86.Parent = v_u_18
	v86.Visible = p40
	local v87 = v_u_29.EditData.StaminaButton
	if v87 then
		local v88 = v87[2]
		if typeof(v88) == "table" then
			local v89 = v87[2]
			v85.Position = unpack(v89)
		else
			v85.Position = v87[2]
		end
		v85.UIScale.Scale = v87[1]
	end
	local v90 = v_u_29.EditData.AbilityButton
	if v90 then
		local v91 = v90[2]
		if typeof(v91) == "table" then
			local v92 = v90[2]
			v86.Position = unpack(v92)
		else
			v86.Position = v90[2]
		end
		v86.UIScale.Scale = v90[1]
	end
	local v_u_93, v_u_94, v_u_95 = v_u_36("AimButton", "rbxassetid://6380722466", "Aim: Off")
	v_u_93.Position = v_u_93.Position + UDim2.new(0, -v_u_46.Size.X.Offset * 0.5 - 15, 0, -v_u_46.Size.Y.Offset)
	v_u_21.AimButton = v_u_93.Position
	v_u_93.Parent = v_u_18
	v_u_93.Visible = true
	if not p40 then
		v_u_93.MouseButton1Click:connect(function()
			-- upvalues: (copy) v_u_95, (ref) v_u_15, (copy) v_u_94, (ref) v_u_14, (copy) v_u_48
			if v_u_95.Text == "Aim: On" then
				v_u_15.SecondaryAttackDown = false
				v_u_95.Text = "Aim: Off"
				v_u_94.Image = "rbxassetid://6380722466"
			else
				v_u_15.SecondaryAttackDown = true
				v_u_14.SprintPressed = false
				v_u_14.AutoRun = false
				v_u_48.TextLabel.Text = "Run: Off"
				v_u_48.ImageLabel.Image = "rbxassetid://6380639022"
				v_u_95.Text = "Aim: On"
				v_u_94.Image = "rbxassetid://6380744738"
			end
		end)
	end
	local v96 = v_u_3(v_u_5.Controls.MobileSelectionMode)
	local v97 = v96 == 2 and true or v96 == 3
	local v98, _, v_u_99 = v_u_36("SwapButton", "rbxassetid://6380772911", "Swap")
	v98.Position = v_u_93.Position + UDim2.new(0, 0, 0, -v_u_46.Size.Y.Offset)
	v_u_21.SwapButton = v98.Position
	v98.Parent = v_u_18
	v98.Visible = v97
	if not p40 then
		v98.MouseButton1Down:connect(function()
			-- upvalues: (ref) v_u_3, (ref) v_u_5, (ref) v_u_4
			if v_u_3(v_u_5.Controls.MobileSelectionMode) == 3 then
				v_u_4.Elements.DPadSelection:HoldingMobile()
			end
		end)
		v98.MouseButton1Up:connect(function()
			-- upvalues: (ref) v_u_3, (ref) v_u_5, (ref) v_u_4
			if v_u_3(v_u_5.Controls.MobileSelectionMode) == 3 then
				v_u_4.Elements.DPadSelection:StopHoldingMobile()
			end
		end)
		v98.MouseButton1Click:connect(function()
			-- upvalues: (ref) v_u_3, (ref) v_u_5, (ref) v_u_15
			if v_u_3(v_u_5.Controls.MobileSelectionMode) == 2 then
				v_u_15:ClassicWeaponSwap()
			end
		end)
	end
	v_u_48.Position = v_u_93.Position + UDim2.new(0, v_u_46.Size.X.Offset, 0, -v_u_46.Size.Y.Offset)
	v_u_21.SprintButton = v_u_48.Position
	v_u_48.Parent = v_u_18
	v_u_48.Visible = true
	if not p40 then
		local v_u_100 = nil
		v_u_48.InputBegan:Connect(function(p101)
			-- upvalues: (ref) v_u_28, (ref) v_u_27, (ref) v_u_100
			if p101 == v_u_28 or p101 == v_u_27 then
				v_u_100 = true
			end
		end)
		v_u_48.MouseLeave:Connect(function()
			-- upvalues: (ref) v_u_100
			v_u_100 = false
		end)
		v_u_48.MouseButton1Up:Connect(function()
			-- upvalues: (ref) v_u_100, (ref) v_u_14, (copy) v_u_99, (copy) v_u_49, (ref) v_u_15, (copy) v_u_93
			if v_u_100 then
				if v_u_14.AutoRun then
					if v_u_14.AutoRun then
						v_u_14.AutoRun = false
						if v_u_99.Text == "Run: On" then
							v_u_14.SprintPressed = false
							v_u_14.AutoRun = false
							v_u_99.Text = "Run: Off"
							v_u_49.Image = "rbxassetid://6380639022"
							return
						end
						v_u_14.SprintPressed = true
						v_u_15.SecondaryAttackDown = false
						v_u_93.TextLabel.Text = "Aim: Off"
						v_u_99.Text = "Run: On"
						v_u_49.Image = "rbxassetid://6380639117"
						v_u_93.ImageLabel.Image = "rbxassetid://6380722466"
					end
				else
					v_u_14.AutoRun = true
					if not v_u_14.SprintPressed then
						if v_u_99.Text == "Run: On" then
							v_u_14.SprintPressed = false
							v_u_14.AutoRun = false
							v_u_99.Text = "Run: Off"
							v_u_49.Image = "rbxassetid://6380639022"
						else
							v_u_14.SprintPressed = true
							v_u_15.SecondaryAttackDown = false
							v_u_93.TextLabel.Text = "Aim: Off"
							v_u_99.Text = "Run: On"
							v_u_49.Image = "rbxassetid://6380639117"
							v_u_93.ImageLabel.Image = "rbxassetid://6380722466"
						end
					end
				end
			end
		end)
		v_u_48.MouseButton1Click:connect(function()
			-- upvalues: (copy) v_u_99, (ref) v_u_14, (copy) v_u_49, (ref) v_u_15, (copy) v_u_93
			if v_u_99.Text == "Run: On" then
				v_u_14.SprintPressed = false
				v_u_14.AutoRun = false
				v_u_99.Text = "Run: Off"
				v_u_49.Image = "rbxassetid://6380639022"
			else
				v_u_14.SprintPressed = true
				v_u_15.SecondaryAttackDown = false
				v_u_93.TextLabel.Text = "Aim: Off"
				v_u_99.Text = "Run: On"
				v_u_49.Image = "rbxassetid://6380639117"
				v_u_93.ImageLabel.Image = "rbxassetid://6380722466"
			end
		end)
	end
	local v102, _, _ = v_u_36("ShootButton", "rbxassetid://6380700475", "Shoot")
	v102.Position = v102.Position + UDim2.new(0, -v_u_46.Size.X.Offset, 0, 0)
	v102.Parent = v_u_18
	v102.Visible = true
	v102.Active = false
	v_u_21.ShootButton = v102.Position
	local v103 = v_u_29.EditData.ShootButton
	if v103 then
		local v104 = v103[2]
		if typeof(v104) == "table" then
			local v105 = v103[2]
			v102.Position = unpack(v105)
		else
			v102.Position = v103[2]
		end
		v102.UIScale.Scale = v103[1]
	end
	local v106 = v_u_29.EditData.SprintButton
	if v106 then
		local v107 = v106[2]
		if typeof(v107) == "table" then
			local v108 = v106[2]
			v_u_48.Position = unpack(v108)
		else
			v_u_48.Position = v106[2]
		end
		v_u_48.UIScale.Scale = v106[1]
	end
	local v109 = v_u_29.EditData.SwapButton
	if v109 then
		local v110 = v109[2]
		if typeof(v110) == "table" then
			local v111 = v109[2]
			v98.Position = unpack(v111)
		else
			v98.Position = v109[2]
		end
		v98.UIScale.Scale = v109[1]
	end
	local v112 = v_u_29.EditData.AimButton
	if v112 then
		local v113 = v112[2]
		if typeof(v113) == "table" then
			local v114 = v112[2]
			v_u_93.Position = unpack(v114)
		else
			v_u_93.Position = v112[2]
		end
		v_u_93.UIScale.Scale = v112[1]
	end
	local v115 = v_u_29.EditData.NVGButton
	if v115 then
		local v116 = v115[2]
		if typeof(v116) == "table" then
			local v117 = v115[2]
			v60.Position = unpack(v117)
		else
			v60.Position = v115[2]
		end
		v60.UIScale.Scale = v115[1]
	end
	local v118 = v_u_29.EditData.ThirdPersonButton
	if v118 then
		local v119 = v118[2]
		if typeof(v119) == "table" then
			local v120 = v118[2]
			v61.Position = unpack(v120)
		else
			v61.Position = v118[2]
		end
		v61.UIScale.Scale = v118[1]
	end
	local v121 = v_u_29.EditData.JumpButton
	if v121 then
		local v122 = v121[2]
		if typeof(v122) == "table" then
			local v123 = v121[2]
			v_u_46.Position = unpack(v123)
		else
			v_u_46.Position = v121[2]
		end
		v_u_46.UIScale.Scale = v121[1]
	end
	local v124 = v_u_29.EditData.EditButton
	if v124 then
		local v125 = v124[2]
		if typeof(v125) == "table" then
			local v126 = v124[2]
			v63.Position = unpack(v126)
		else
			v63.Position = v124[2]
		end
		v63.UIScale.Scale = v124[1]
	end
	if v52:FindFirstChild("ModifiedPosition") then
		v52.ModifiedPosition:Destroy()
	end
	local v127 = Instance.new("Frame")
	v127.Position = v52.Position
	v127.Name = "ModifiedPosition"
	v127.Visible = false
	v127.Parent = v52
	local v128 = v_u_29.EditData.ThumbstickFrame
	if v128 then
		local v129 = v128[2]
		if typeof(v129) == "table" then
			local v130 = v128[2]
			v127.Position = unpack(v130)
			local v131 = v128[2]
			v52.Position = unpack(v131)
		else
			v127.Position = v128[2]
			v52.Position = v128[2]
		end
		v52.UIScale.Scale = v128[1]
	end
	local v132 = v_u_29.EditData.CrouchButton
	if v132 then
		local v133 = v132[2]
		if typeof(v133) == "table" then
			local v134 = v132[2]
			v_u_55.Position = unpack(v134)
		else
			v_u_55.Position = v132[2]
		end
		v_u_55.UIScale.Scale = v132[1]
	end
	if p40 then
		local v_u_135 = v_u_12:Clone()
		v_u_135.Parent = game.Players.LocalPlayer.PlayerGui
		v_u_135.Frame:TweenSize(UDim2.new(0, 405, 0, 50), "Out", "Quad", 0.25, true)
		v_u_135.Options:TweenSize(UDim2.new(0, 306, 0, 50), "Out", "Quad", 0.25, true)
		v_u_135.Presets:TweenSize(UDim2.new(0, 306, 0, 70), "Out", "Quad", 0.25, true)
		local v_u_136 = {}
		local v_u_137 = nil
		local v_u_138 = nil
		local v_u_139 = nil
		local v_u_140 = nil
		local v_u_141 = nil
		local v_u_142 = nil
		local v_u_143 = nil
		for _, v_u_144 in pairs({
			v102,
			v_u_48,
			v98,
			v_u_93,
			v_u_55,
			v60,
			v61,
			v63,
			v85,
			v86,
			v_u_46,
			v53
		}) do
			if v_u_144 then
				v_u_144.Active = true
				v_u_144.BackgroundTransparency = 0.5
				v_u_144.BackgroundColor3 = Color3.new(0.5, 0, 0)
				if v_u_144 == v53 then
					v_u_136[#v_u_136 + 1] = v_u_144.InputBegan:connect(function(p_u_145)
						-- upvalues: (ref) v_u_137, (ref) v_u_10, (copy) v_u_144, (ref) v_u_138, (ref) v_u_139, (copy) v_u_135
						if v_u_137 == nil then
							p_u_145.Changed:Connect(function()
								-- upvalues: (copy) p_u_145, (ref) v_u_137, (ref) v_u_10, (ref) v_u_144, (ref) v_u_138, (ref) v_u_139, (ref) v_u_135
								if p_u_145.UserInputState == Enum.UserInputState.End and v_u_137 == nil then
									game.SoundService:PlayLocalSound(v_u_10.Select)
									v_u_144.BackgroundColor3 = Color3.new(0, 0.75, 0)
									v_u_137 = v_u_144
									v_u_138 = v_u_144.Position
									v_u_139 = v_u_144.UIScale.Scale
									v_u_135.Frame.TextLabel.Text = "Editing " .. v_u_144.Name
									v_u_135.Frame:TweenSize(UDim2.new(0, 405, 0, 150), "Out", "Quad", 0.25, true)
									v_u_135.Options:TweenSize(UDim2.new(0, 306, 0, 0), "Out", "Quad", 0.25, true)
									v_u_135.Presets:TweenSize(UDim2.new(0, 306, 0, 0), "Out", "Quad", 0.25, true)
								end
							end)
						end
					end)
				else
					v_u_136[#v_u_136 + 1] = v_u_144.MouseButton1Click:connect(function()
						-- upvalues: (ref) v_u_137, (ref) v_u_10, (copy) v_u_144, (ref) v_u_138, (ref) v_u_139, (copy) v_u_135
						if v_u_137 == nil then
							game.SoundService:PlayLocalSound(v_u_10.Select)
							v_u_144.BackgroundColor3 = Color3.new(0, 0.75, 0)
							v_u_137 = v_u_144
							v_u_138 = v_u_144.Position
							v_u_139 = v_u_144.UIScale.Scale
							v_u_135.Frame.TextLabel.Text = "Editing " .. v_u_144.Name
							v_u_135.Frame:TweenSize(UDim2.new(0, 405, 0, 150), "Out", "Quad", 0.25, true)
							v_u_135.Options:TweenSize(UDim2.new(0, 306, 0, 0), "Out", "Quad", 0.25, true)
							v_u_135.Presets:TweenSize(UDim2.new(0, 306, 0, 0), "Out", "Quad", 0.25, true)
						end
					end)
				end
			end
		end
		v_u_19.InputBegan:connect(function(p_u_146, _)
			-- upvalues: (ref) v_u_137, (ref) v_u_140, (ref) v_u_141, (ref) v_u_143, (ref) v_u_142
			if v_u_137 then
				local v147 = p_u_146.Position
				local v148 = v_u_137
				if v147.X < v148.AbsolutePosition.X + v148.AbsoluteSize.X and (v147.X > v148.AbsolutePosition.X and (v147.Y < v148.AbsolutePosition.Y + v148.AbsoluteSize.Y and v147.Y > v148.AbsolutePosition.Y)) then
					v_u_140 = true
					v_u_141 = p_u_146
					v_u_143 = p_u_146.Position
					v_u_142 = v_u_137.Position
					p_u_146.Changed:Connect(function()
						-- upvalues: (copy) p_u_146, (ref) v_u_140
						if p_u_146.UserInputState == Enum.UserInputState.End then
							v_u_140 = false
						end
					end)
				end
			end
		end)
		v_u_19.InputChanged:connect(function(p149, _)
			-- upvalues: (ref) v_u_141, (ref) v_u_140, (ref) v_u_143, (ref) v_u_137, (ref) v_u_142
			if p149 == v_u_141 and v_u_140 then
				local v150 = p149.Position - v_u_143
				v_u_137.Position = UDim2.new(v_u_142.X.Scale, v_u_142.X.Offset + v150.X, v_u_142.Y.Scale, v_u_142.Y.Offset + v150.Y)
			end
		end)
		local function v_u_151() -- name: ended
			-- upvalues: (copy) v_u_135
			v_u_135.Options:TweenSize(UDim2.new(0, 306, 0, 50), "Out", "Quad", 0.25, true)
			v_u_135.Presets:TweenSize(UDim2.new(0, 306, 0, 70), "Out", "Quad", 0.25, true)
			v_u_135.Frame:TweenSize(UDim2.new(0, 405, 0, 50), "Out", "Quad", 0.25, true)
			v_u_135.Frame.TextLabel.Text = "Tap on a button to edit"
		end
		local v_u_152 = false
		v_u_135.Options.Save.MouseButton1Click:connect(function()
			-- upvalues: (copy) v_u_135, (ref) v_u_152, (ref) v_u_10, (ref) v_u_140, (ref) v_u_137, (ref) v_u_22, (ref) v_u_20, (ref) v_u_29, (copy) v_u_46, (ref) v_u_18, (ref) v_u_23, (copy) v_u_136, (ref) v_u_9
			if not v_u_135.Frame.Save.Text == "Sure?" then
				v_u_152 = false
			end
			if v_u_152 then
				if not v_u_140 and (not v_u_137 and v_u_135.Options.Save.Text == "Sure?") then
					game.SoundService:PlayLocalSound(v_u_10.Save)
					v_u_22 = nil
					for v153, v154 in pairs(v_u_20) do
						v_u_29.EditData[v153] = v154
					end
					v_u_46.BackgroundTransparency = 1
					v_u_18:ClearAllChildren()
					v_u_135:Destroy()
					v_u_23 = false
					for _, v155 in pairs(v_u_136) do
						v155:Disconnect()
					end
					table.clear(v_u_136)
					v_u_29:MakeButtons()
					v_u_9:FireServer("MobileEditData", v_u_29.EditData)
				end
			else
				game.SoundService:PlayLocalSound(v_u_10.Tap)
				v_u_152 = true
				v_u_135.Options.Save.Text = "Sure?"
				local v156 = 0
				repeat
					v156 = v156 + task.wait()
				until v156 >= 1.5 or v_u_152 == false
				if v_u_135.Parent then
					v_u_135.Options.Save.Text = "Save"
				end
				v_u_152 = false
			end
		end)
		v_u_135.Options.Reset.MouseButton1Click:connect(function()
			-- upvalues: (copy) v_u_135, (ref) v_u_152, (ref) v_u_10, (ref) v_u_140, (ref) v_u_137, (ref) v_u_22, (ref) v_u_29, (copy) v_u_46, (ref) v_u_18, (ref) v_u_23, (copy) v_u_136, (ref) v_u_9
			if not v_u_135.Options.Reset.Text == "Sure?" then
				v_u_152 = false
			end
			if v_u_152 then
				if not v_u_140 and (not v_u_137 and v_u_135.Options.Reset.Text == "Sure?") then
					game.SoundService:PlayLocalSound(v_u_10.Error)
					v_u_22 = nil
					v_u_29.EditData = {}
					v_u_46.BackgroundTransparency = 1
					v_u_18:ClearAllChildren()
					v_u_135:Destroy()
					v_u_23 = false
					for _, v157 in pairs(v_u_136) do
						v157:Disconnect()
					end
					table.clear(v_u_136)
					v_u_29:MakeButtons()
					v_u_9:FireServer("MobileEditData", v_u_29.EditData)
				end
				return
			else
				game.SoundService:PlayLocalSound(v_u_10.Tap)
				v_u_152 = true
				v_u_135.Options.Reset.Text = "Sure?"
				local v158 = 0
				repeat
					v158 = v158 + task.wait()
				until v158 >= 1.5 or v_u_152 == false
				if v_u_135.Parent then
					v_u_135.Options.Reset.Text = "Reset"
					v_u_152 = false
				end
			end
		end)
		v_u_135.Options.Cancel.MouseButton1Click:connect(function()
			-- upvalues: (copy) v_u_135, (ref) v_u_152, (ref) v_u_10, (ref) v_u_140, (ref) v_u_137, (ref) v_u_22, (ref) v_u_29, (copy) v_u_46, (ref) v_u_18, (ref) v_u_23, (copy) v_u_136
			if not v_u_135.Frame.Cancel.Text == "Sure?" then
				v_u_152 = false
			end
			if v_u_152 then
				if not v_u_140 and (not v_u_137 and v_u_135.Options.Cancel.Text == "Sure?") then
					game.SoundService:PlayLocalSound(v_u_10.Error)
					if v_u_22 then
						v_u_29.EditData = v_u_22
					end
					v_u_22 = nil
					v_u_46.BackgroundTransparency = 1
					v_u_18:ClearAllChildren()
					v_u_135:Destroy()
					v_u_23 = false
					for _, v159 in pairs(v_u_136) do
						v159:Disconnect()
					end
					table.clear(v_u_136)
					v_u_29:MakeButtons()
				end
			else
				game.SoundService:PlayLocalSound(v_u_10.Tap)
				v_u_152 = true
				v_u_135.Options.Cancel.Text = "Sure?"
				local v160 = 0
				repeat
					v160 = v160 + task.wait()
				until v160 >= 1.5 or v_u_152 == false
				if v_u_135.Parent then
					v_u_135.Options.Cancel.Text = "Cancel"
				end
				v_u_152 = false
			end
		end)
		v_u_135.Frame.Reset.MouseButton1Click:connect(function()
			-- upvalues: (copy) v_u_135, (ref) v_u_152, (ref) v_u_10, (ref) v_u_140, (ref) v_u_137, (ref) v_u_21, (ref) v_u_20, (copy) v_u_151
			if not v_u_135.Frame.Reset.Text == "Sure?" then
				v_u_152 = false
			end
			if v_u_152 then
				if not v_u_140 and (v_u_137 and v_u_135.Frame.Reset.Text == "Sure?") then
					game.SoundService:PlayLocalSound(v_u_10.Error)
					v_u_137.BackgroundColor3 = Color3.new(0.5, 0, 0)
					v_u_137.UIScale.Scale = 1
					v_u_137.Position = v_u_21[v_u_137.Name]
					v_u_20[v_u_137.Name] = { 1, v_u_21[v_u_137.Name] }
					v_u_137 = nil
					v_u_151()
				end
				return
			else
				game.SoundService:PlayLocalSound(v_u_10.Tap)
				v_u_152 = true
				v_u_135.Frame.Reset.Text = "Sure?"
				local v161 = 0
				repeat
					v161 = v161 + task.wait()
				until v161 >= 1.5 or v_u_152 == false
				if v_u_135.Parent then
					v_u_135.Frame.Reset.Text = "Reset"
					v_u_152 = false
				end
			end
		end)
		v_u_135.Frame.Save.MouseButton1Click:connect(function()
			-- upvalues: (copy) v_u_135, (ref) v_u_152, (ref) v_u_10, (ref) v_u_140, (ref) v_u_137, (ref) v_u_20, (copy) v_u_151
			if not v_u_135.Frame.Save.Text == "Sure?" then
				v_u_152 = false
			end
			if v_u_152 then
				if not v_u_140 and (v_u_137 and v_u_135.Frame.Save.Text == "Sure?") then
					game.SoundService:PlayLocalSound(v_u_10.Save)
					v_u_137.BackgroundColor3 = Color3.new(0.5, 0, 0)
					v_u_20[v_u_137.Name] = { v_u_137.UIScale.Scale, v_u_137.Position }
					v_u_137 = nil
					v_u_151()
				end
				return
			else
				game.SoundService:PlayLocalSound(v_u_10.Tap)
				v_u_152 = true
				v_u_135.Frame.Save.Text = "Sure?"
				local v162 = 0
				repeat
					v162 = v162 + task.wait()
				until v162 >= 1.5 or v_u_152 == false
				if v_u_135.Parent then
					v_u_135.Frame.Save.Text = "Save"
					v_u_152 = false
				end
			end
		end)
		v_u_135.Frame.Cancel.MouseButton1Click:connect(function()
			-- upvalues: (copy) v_u_135, (ref) v_u_152, (ref) v_u_10, (ref) v_u_140, (ref) v_u_137, (ref) v_u_139, (ref) v_u_138, (copy) v_u_151
			if not v_u_135.Frame.Cancel.Text == "Sure?" then
				v_u_152 = false
			end
			if v_u_152 then
				if not v_u_140 and (v_u_137 and v_u_135.Frame.Cancel.Text == "Sure?") then
					game.SoundService:PlayLocalSound(v_u_10.Error)
					v_u_137.BackgroundColor3 = Color3.new(0.5, 0, 0)
					v_u_137.UIScale.Scale = v_u_139
					v_u_137.Position = v_u_138
					v_u_137 = nil
					v_u_151()
				end
				return
			else
				game.SoundService:PlayLocalSound(v_u_10.Tap)
				v_u_152 = true
				v_u_135.Frame.Cancel.Text = "Sure?"
				local v163 = 0
				repeat
					v163 = v163 + task.wait()
				until v163 >= 1.5 or v_u_152 == false
				if v_u_135.Parent then
					v_u_135.Frame.Cancel.Text = "Cancel"
					v_u_152 = false
				end
			end
		end)
		local v_u_164 = {}
		v_u_135.Frame.Incr.InputBegan:connect(function(p_u_165)
			-- upvalues: (ref) v_u_137, (ref) v_u_140, (copy) v_u_164, (ref) v_u_10
			if v_u_137 and not (v_u_140 or v_u_164[v_u_137.Name]) then
				local v_u_166 = true
				local v_u_167 = nil
				v_u_167 = p_u_165.Changed:Connect(function()
					-- upvalues: (copy) p_u_165, (ref) v_u_166, (ref) v_u_167
					if p_u_165.UserInputState == Enum.UserInputState.End then
						v_u_166 = false
						v_u_167:Disconnect()
					end
				end)
				while v_u_166 and v_u_137 do
					local v168 = task.wait()
					game.SoundService:PlayLocalSound(v_u_10.Tap)
					if v_u_137 then
						v_u_137.UIScale.Scale = v_u_137.UIScale.Scale + 0.05 * (v168 * 60)
					end
				end
			end
		end)
		v_u_135.Frame.Dec.InputBegan:connect(function(p_u_169)
			-- upvalues: (ref) v_u_137, (ref) v_u_140, (copy) v_u_164, (ref) v_u_10
			if v_u_137 and not (v_u_140 or v_u_164[v_u_137.Name]) then
				local v_u_170 = true
				local v_u_171 = nil
				v_u_171 = p_u_169.Changed:Connect(function()
					-- upvalues: (copy) p_u_169, (ref) v_u_170, (ref) v_u_171
					if p_u_169.UserInputState == Enum.UserInputState.End then
						v_u_170 = false
						v_u_171:Disconnect()
					end
				end)
				while v_u_170 and v_u_137 do
					local v172 = task.wait()
					game.SoundService:PlayLocalSound(v_u_10.Tap)
					if v_u_137 then
						local v173 = v_u_137.UIScale
						local v174 = v_u_137.UIScale.Scale - 0.05 * (v172 * 60)
						v173.Scale = math.max(v174, 0.05)
					end
				end
			end
		end)
		for v_u_175 = 1, 3 do
			local v_u_176 = v_u_135.Presets["Preset" .. v_u_175]
			local v177 = v_u_29.PresetData[tostring(v_u_175)]
			local v178
			if v177 and next(v177) then
				v178 = "Preset " .. v_u_175
			else
				v178 = "Preset " .. v_u_175 .. " (Empty)"
			end
			v_u_176.Text = v178
			local v_u_179 = nil
			local v_u_180 = false
			v_u_176.MouseButton1Down:Connect(function()
				-- upvalues: (ref) v_u_179, (ref) v_u_180, (ref) v_u_10, (ref) v_u_29, (ref) v_u_20, (copy) v_u_175, (ref) v_u_9, (copy) v_u_176
				v_u_179 = os.clock()
				v_u_180 = true
				task.delay(0.6, function()
					-- upvalues: (ref) v_u_180, (ref) v_u_179, (ref) v_u_10, (ref) v_u_29, (ref) v_u_20, (ref) v_u_175, (ref) v_u_9, (ref) v_u_176
					if v_u_180 and v_u_179 then
						v_u_180 = false
						game.SoundService:PlayLocalSound(v_u_10.Save)
						local v181 = table.clone(v_u_29.EditData)
						for v182, v183 in pairs(v_u_20) do
							v181[v182] = v183
						end
						local v184 = v_u_175
						v_u_29.PresetData[tostring(v184)] = v181
						v_u_9:FireServer("MobilePresetSave", {
							["slot"] = v_u_175,
							["data"] = v181
						})
						v_u_176.Text = "Saved!"
						task.delay(1, function()
							-- upvalues: (ref) v_u_176, (ref) v_u_175, (ref) v_u_29
							if v_u_176.Parent then
								local v185 = v_u_176
								local v186 = v_u_175
								local v187 = v_u_29.PresetData[tostring(v186)]
								local v188
								if v187 and next(v187) then
									v188 = "Preset " .. v186
								else
									v188 = "Preset " .. v186 .. " (Empty)"
								end
								v185.Text = v188
							end
						end)
					end
				end)
			end)
			v_u_176.MouseButton1Up:Connect(function()
				-- upvalues: (ref) v_u_180, (ref) v_u_179, (ref) v_u_29, (copy) v_u_175, (ref) v_u_10, (copy) v_u_46, (ref) v_u_18, (copy) v_u_135, (ref) v_u_23, (copy) v_u_136, (ref) v_u_196
				if v_u_180 and (v_u_179 and os.clock() - v_u_179 < 0.6) then
					v_u_180 = false
					v_u_179 = nil
					local v189 = v_u_175
					local v190 = v_u_29.PresetData[tostring(v189)]
					if v190 and next(v190) then
						game.SoundService:PlayLocalSound(v_u_10.Tap)
						v_u_29.EditData = {}
						for v191, v192 in pairs(v190) do
							local v193 = v192[2]
							if typeof(v193) == "table" then
								v_u_29.EditData[v191] = { v192[1], UDim2.new(v192[2][1], v192[2][2], v192[2][3], v192[2][4]) }
							else
								v_u_29.EditData[v191] = v192
							end
						end
						v_u_46.BackgroundTransparency = 1
						v_u_18:ClearAllChildren()
						v_u_135:Destroy()
						v_u_23 = false
						for _, v194 in pairs(v_u_136) do
							v194:Disconnect()
						end
						table.clear(v_u_136)
						v_u_196(true)
					else
						game.SoundService:PlayLocalSound(v_u_10.Error)
					end
				end
				v_u_180 = false
				v_u_179 = nil
			end)
		end
	else
		for _, v195 in pairs({
			v102,
			v_u_48,
			v98,
			v_u_93,
			v_u_55,
			v60,
			v61,
			v_u_46
		}) do
			if v195 then
				v195.Active = false
			end
		end
	end
	v_u_25 = v102
	return v_u_17, v102
end
local function v_u_203() -- name: applyCustomPositions
	-- upvalues: (copy) v_u_4, (copy) v_u_29, (copy) v_u_39, (copy) v_u_3, (copy) v_u_5
	local v197 = v_u_4:GetElement("StaminaDisplay")
	local v198 = v_u_4:GetElement("AbilityDisplay")
	local v199 = v_u_29.EditData.StaminaButton
	if v197 then
		if v199 then
			local v200 = v199[2]
			if typeof(v200) == "table" then
				v200 = UDim2.new(v200[1], v200[2], v200[3], v200[4])
			end
			v197:SetCustomPosition(v_u_39(v200))
		else
			v197:SetCustomPosition(nil)
		end
		v197:SetDynamicStaminaEnabled(v_u_3(v_u_5.Controls.DynamicStaminaUI))
		if v199 then
			v197:SetUIScale(v199[1] or 1)
		else
			v197:SetUIScale(1)
		end
	end
	local v201 = v_u_29.EditData.AbilityButton
	if v198 then
		if v201 then
			local v202 = v201[2]
			if typeof(v202) == "table" then
				v202 = UDim2.new(v202[1], v202[2], v202[3], v202[4])
			end
			v198:SetCustomPosition(v_u_39(v202))
		else
			v198:SetCustomPosition(nil)
		end
		if v201 then
			v198:SetUIScale(v201[1] or 1)
			return
		end
		v198:SetUIScale(1)
	end
end
function v_u_29.MakeButtons(_) -- name: MakeButtons
	-- upvalues: (copy) v_u_29, (copy) v_u_196, (copy) v_u_18, (copy) v_u_203, (ref) v_u_24, (ref) v_u_27, (ref) v_u_16, (ref) v_u_28, (ref) v_u_15, (copy) v_u_19, (ref) v_u_25
	v_u_29.Hidden = false
	local v_u_204 = v_u_196()
	v_u_18.Parent = v_u_204
	v_u_203()
	if not v_u_24 then
		v_u_24 = true
		local _ = game.Players.LocalPlayer.PlayerGui
		local v205 = v_u_204.TouchControlFrame.DynamicThumbstickFrame
		local _ = v205.ThumbstickStart
		v205.Size = UDim2.new(0.35, 0, 0.5, 0)
		v205.Position = UDim2.new(0, 0, 0.5, 0)
		local v_u_206 = {}
		local v_u_207 = 0
		local v_u_208 = nil
		local v_u_209 = nil
		local v_u_210 = nil
		local v_u_211 = nil
		Vector2.new(0, 0)
		Vector2.new(0.029688050576423545, 0.010602875205865551)
		local function v_u_218(p212) -- name: isInThumbstickArea
			-- upvalues: (copy) v_u_204
			local v213 = game.Players.LocalPlayer:FindFirstChildOfClass("PlayerGui")
			if v213 then
				v213 = v213:FindFirstChild("TouchGui")
			end
			local v214
			if v213 then
				v214 = v213:FindFirstChild("TouchControlFrame")
			else
				v214 = v213
			end
			if v214 then
				v214 = v214:FindFirstChild("ThumbstickFrame")
			end
			if not v_u_204.TouchControlFrame.ThumbstickFrame.Visible then
				return false
			end
			if not v214 then
				return false
			end
			if not v213.Enabled then
				return false
			end
			local v215 = v214.AbsolutePosition
			local v216 = v215 + v214.AbsoluteSize
			local v217
			if p212.X >= v215.X and (p212.Y >= v215.Y and p212.X <= v216.X) then
				v217 = p212.Y <= v216.Y
			else
				v217 = false
			end
			return v217
		end
		local function v_u_225(p219) -- name: isInDynamicThumbstickArea
			-- upvalues: (copy) v_u_204
			local v220 = game.Players.LocalPlayer:FindFirstChildOfClass("PlayerGui")
			if v220 then
				v220 = v220:FindFirstChild("TouchGui")
			end
			local v221
			if v220 then
				v221 = v220:FindFirstChild("TouchControlFrame")
			else
				v221 = v220
			end
			if v221 then
				v221 = v221:FindFirstChild("DynamicThumbstickFrame")
			end
			if not v_u_204.TouchControlFrame.DynamicThumbstickFrame.Visible then
				return false
			end
			if not v221 then
				return false
			end
			if not v220.Enabled then
				return false
			end
			local v222 = v221.AbsolutePosition
			local v223 = v222 + v221.AbsoluteSize
			local v224
			if p219.X >= v222.X and (p219.Y >= v222.Y and p219.X <= v223.X) then
				v224 = p219.Y <= v223.Y
			else
				v224 = false
			end
			return v224
		end
		local v_u_226 = nil
		local v_u_227 = {}
		local v_u_228 = {}
		local function v_u_249(p229, p230) -- name: OnTouchChanged
			-- upvalues: (ref) v_u_27, (copy) v_u_206, (ref) v_u_226, (copy) v_u_227, (copy) v_u_228, (ref) v_u_208, (ref) v_u_209, (ref) v_u_210, (ref) v_u_211, (ref) v_u_207, (ref) v_u_16
			if p229 ~= v_u_27 then
				if v_u_206[p229] == nil then
					v_u_206[p229] = p230
					if not p230 then
						v_u_226 = p229
						local v231 = v_u_227
						table.insert(v231, p229)
						v_u_228[p229] = {}
						v_u_208 = nil
						v_u_209 = nil
						v_u_210 = nil
						v_u_211 = false
						v_u_207 = v_u_207 + 1
					end
				end
				if v_u_207 >= 1 then
					if v_u_206[p229] == false then
						if v_u_226 == p229 then
							if not v_u_228[p229][1] then
								v_u_228[p229][1] = p229.Position
							end
							if not v_u_228[p229][2] then
								v_u_228[p229][2] = v_u_228[p229][1]
							end
							local v232 = p229.Position - v_u_228[p229][2]
							local v233 = v_u_16:GetSensitivity()
							local v234 = v_u_16:GetMagnificationSensitivity() * v233
							local v235 = Vector2.new(v232.X * v234, v232.Y * UserSettings().GameSettings:GetCameraYInvertValue() * v234)
							v_u_16.X = (v_u_16.X - v235.X / 150 * 1) % 6.283185307179586
							local v236 = v_u_16
							local v237 = v_u_16.Y - v235.Y / 150 * 1
							local v238 = math.max(v237, -1.4)
							v236.Y = math.min(v238, 1.4)
							v_u_228[p229][2] = p229.Position
						else
							if not v_u_228[p229][1] then
								v_u_228[p229][1] = p229.Position
							end
							if not v_u_228[p229][2] then
								v_u_228[p229][2] = v_u_228[p229][1]
							end
							local v239 = p229.Position - v_u_228[p229][2]
							v_u_16.X = (v_u_16.X - v239.X / 150 * 1) % 6.283185307179586
							local v240 = v_u_16
							local v241 = v_u_16.Y - v239.Y / 150 * 1
							local v242 = math.max(v241, -1.4)
							v240.Y = math.min(v242, 1.4)
							v_u_228[p229][2] = p229.Position
						end
					end
				else
					v_u_208 = nil
					v_u_209 = nil
					v_u_210 = nil
					v_u_211 = false
				end
				if v_u_207 == 2 then
					local v243 = {}
					for v244, v245 in pairs(v_u_206) do
						if not v245 then
							table.insert(v243, v244)
						end
					end
					if #v243 == 2 then
						local v246 = (v243[1].Position - v243[2].Position).magnitude
						if startingDiff and pinchBeginZoom then
							local v247 = startingDiff
							local v248 = v246 / math.max(0.01, v247)
							math.clamp(v248, 0.1, 10)
						else
							startingDiff = v246
							pinchBeginZoom = 0.5
						end
					end
				else
					startingDiff = nil
					pinchBeginZoom = nil
				end
			end
		end
		local v_u_250 = nil
		local v_u_251 = nil
		local function v_u_256(p252, p253) -- name: touchBegan
			-- upvalues: (ref) v_u_27, (copy) v_u_225, (ref) v_u_28, (copy) v_u_218
			local v254 = p252.UserInputType == Enum.UserInputType.Touch
			assert(v254)
			local v255 = p252.UserInputState == Enum.UserInputState.Begin
			assert(v255)
			if v_u_27 == nil and (v_u_225(p252.Position) and not p253) then
				v_u_27 = p252
				return
			elseif v_u_28 == nil and v_u_218(p252.Position) then
				v_u_28 = p252
			end
		end
		local function v_u_259(p257, _) -- name: OnTouchEnded
			-- upvalues: (ref) v_u_251, (ref) v_u_250, (ref) v_u_15, (copy) v_u_206, (ref) v_u_207, (ref) v_u_208, (ref) v_u_209, (ref) v_u_210, (ref) v_u_211, (copy) v_u_227, (copy) v_u_228, (ref) v_u_226, (ref) v_u_27, (ref) v_u_28
			if p257 == v_u_251 and v_u_250 then
				v_u_250 = false
				v_u_15.MobileShootDown = false
			end
			if v_u_206[p257] == false then
				if v_u_207 == 1 then
					v_u_208 = nil
					v_u_209 = nil
					v_u_210 = nil
					v_u_211 = false
				elseif v_u_207 == 2 then
					startingDiff = nil
					pinchBeginZoom = nil
				end
			end
			if v_u_206[p257] ~= nil and v_u_206[p257] == false then
				v_u_207 = v_u_207 - 1
				local v258 = table.find(v_u_227, p257)
				if v258 then
					table.remove(v_u_227, v258)
					v_u_228[p257] = nil
				end
				if v_u_226 == p257 and #v_u_227 >= 1 then
					v_u_208 = nil
					v_u_209 = nil
					v_u_210 = nil
					v_u_211 = false
					v_u_226 = v_u_227[#v_u_227]
				end
			end
			v_u_206[p257] = nil
			if p257 == v_u_27 then
				v_u_27 = nil
			end
			if p257 == v_u_28 then
				v_u_28 = nil
			end
		end
		v_u_19.InputBegan:connect(function(p_u_260, p261)
			-- upvalues: (ref) v_u_25, (ref) v_u_250, (ref) v_u_251, (ref) v_u_15, (copy) v_u_256
			if p_u_260.UserInputType == Enum.UserInputType.Touch and v_u_25 then
				local v262 = p_u_260.Position
				local v263 = v_u_25
				if v262.X < v263.AbsolutePosition.X + v263.AbsoluteSize.X and (v262.X > v263.AbsolutePosition.X and (v262.Y < v263.AbsolutePosition.Y + v263.AbsoluteSize.Y and v262.Y > v263.AbsolutePosition.Y)) and (not v_u_250 and v_u_25.Visible) then
					v_u_250 = true
					v_u_251 = p_u_260
					v_u_15.MobileShootDown = true
					p_u_260.Changed:Connect(function()
						-- upvalues: (copy) p_u_260, (ref) v_u_250, (ref) v_u_251, (ref) v_u_15
						if p_u_260.UserInputState == Enum.UserInputState.End and (v_u_250 and v_u_251 == p_u_260) then
							v_u_250 = false
							v_u_15.MobileShootDown = false
						end
					end)
					return
				end
			end
			if p_u_260.UserInputType == Enum.UserInputType.Touch then
				v_u_256(p_u_260, p261)
			end
		end)
		v_u_19.InputChanged:connect(function(p264, p265)
			-- upvalues: (copy) v_u_249
			if p264.UserInputType == Enum.UserInputType.Touch then
				v_u_249(p264, p265)
			end
		end)
		v_u_19.InputEnded:connect(function(p266, p267)
			-- upvalues: (copy) v_u_259
			if p266.UserInputType == Enum.UserInputType.Touch then
				v_u_259(p266, p267)
			end
		end)
	end
end
function v_u_29.HideCreatedButtons(_) -- name: HideCreatedButtons
	-- upvalues: (copy) v_u_29, (copy) v_u_18
	v_u_29.Hidden = true
	v_u_18.Parent = nil
end
function v_u_29.Show(_) -- name: Show
	-- upvalues: (ref) v_u_17, (ref) v_u_24, (copy) v_u_29
	if v_u_17 then
		if not v_u_24 then
			v_u_29:MakeButtons()
		end
		v_u_17.Enabled = true
	end
	v_u_29.IsShowing = true
end
function v_u_29.Hide(_) -- name: Hide
	-- upvalues: (ref) v_u_17, (copy) v_u_29
	if v_u_17 then
		v_u_17.Enabled = false
	end
	v_u_29.IsShowing = false
end
v6.InputMethodChanged:Connect(function(p268)
	-- upvalues: (ref) v_u_17
	if p268 == "Touch" and not v_u_17 then
		v_u_17 = game.Players.LocalPlayer.PlayerGui:WaitForChild("TouchGui")
	end
end)
if game.UserInputService.TouchEnabled and not v_u_17 then
	v_u_17 = game.Players.LocalPlayer.PlayerGui:WaitForChild("TouchGui")
end
v_u_5.SettingsChanged:Connect(function(p269)
	-- upvalues: (ref) v_u_24, (ref) v_u_23, (copy) v_u_18, (copy) v_u_29, (copy) v_u_4, (copy) v_u_3, (copy) v_u_5
	if p269 and p269[1] == "Controls" then
		if p269[2] == "MobileSelectionMode" then
			if v_u_24 and not v_u_23 then
				v_u_18:ClearAllChildren()
				v_u_29:MakeButtons()
				return
			end
		elseif p269[2] == "DynamicStaminaUI" then
			local v270 = v_u_4:GetElement("StaminaDisplay")
			if v270 then
				v270:SetDynamicStaminaEnabled(v_u_3(v_u_5.Controls.DynamicStaminaUI))
				return
			end
		else
			local v271 = p269[2] == "ShowEditButton" and v_u_24 and (not v_u_23 and v_u_18:FindFirstChild("EditButton"))
			if v271 then
				v271.Visible = v_u_3(v_u_5.Controls.ShowEditButton)
			end
		end
	end
end)
function v_u_29.EnterEditMode(_) -- name: EnterEditMode
	-- upvalues: (ref) v_u_24, (ref) v_u_23, (copy) v_u_196
	if v_u_24 and not v_u_23 then
		v_u_196(true)
	end
end
return v_u_29