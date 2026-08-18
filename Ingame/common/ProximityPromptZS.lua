local v1 = game:GetService("TweenService")
local v_u_2 = game:GetService("TextService")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("HttpService")
local v_u_5 = game:GetService("CollectionService")
game:GetService("UserInputService")
local v6 = game.ReplicatedStorage.common
local v7 = game.ReplicatedStorage.Packages
local v8 = game.ReplicatedStorage.common.RedEvents
local v_u_9 = script.PromptUI
local v_u_10 = v_u_9.Complete
local v_u_11 = v_u_9.PromptGroup
local v_u_12 = v_u_11.NoProgressFrame
local v_u_13 = v_u_11.ProgressSliceFrame
local v_u_14 = v_u_13.ProgressFrame
local v_u_15 = v_u_9.Button
local v16 = v_u_14.InputFrame
local v17 = v_u_12.InputFrame
local v_u_18 = Instance.new("Highlight")
local v_u_19 = require(v6.Signal)
local _ = require(v7.Streamable).Streamable
local v20, v_u_21, v_u_22, v23
if v_u_3:IsServer() then
	v20 = nil
	v_u_21 = nil
	v_u_22 = nil
	v23 = nil
else
	v20 = require(v6.BindUtil)
	v23 = require(v6.InputLabel)
	v_u_21 = require(v7.Fusion)
	v_u_22 = require("@game/ReplicatedStorage/common/skillTree/SkillTreeData")
	task.spawn(function()
		-- upvalues: (copy) v_u_18
		v_u_18.FillTransparency = 1
		v_u_18.DepthMode = Enum.HighlightDepthMode.Occluded
		v_u_18.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	end)
end
local v_u_24 = require(v8.General.ReplicateProximityPrompt)
local v_u_25 = v_u_3:IsServer()
local v_u_26 = 0.15
local v_u_27 = 0.05
local v_u_28 = 0
local v_u_29 = 0
local v_u_30 = false
local v_u_31 = false
local v_u_32 = {}
local v_u_33 = {}
local v_u_34 = ""
local v_u_35 = ""
local v_u_36 = false
local v_u_37 = nil
local v_u_38 = true
local v_u_39 = v1:Create(v_u_10, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
	["BackgroundTransparency"] = 1
})
local v_u_40 = {
	["Position"] = true,
	["Part"] = true,
	["Range"] = true,
	["Obstructable"] = true,
	["ObstructionIgnoreList"] = true,
	["HoldTime"] = true,
	["ResetOnRelease"] = true,
	["ActionText"] = true,
	["ObjectText"] = true,
	["Enabled"] = true,
	["Players"] = true
}
local v_u_69 = {
	["openedPrompt"] = nil,
	["__index"] = function(p41, p42) -- name: __index
		-- upvalues: (copy) v_u_40, (copy) v_u_69
		local v43 = rawget(p41, p42)
		if v_u_40[p42] then
			return rawget(p41, "Properties")[p42]
		elseif v43 == nil then
			return v_u_69[p42]
		else
			return v43
		end
	end,
	["__newindex"] = function(p44, p45, p46) -- name: __newindex
		-- upvalues: (copy) v_u_40, (copy) v_u_69
		local v47 = rawget(p44, p45)
		if v_u_40[p45] then
			p44:_SetProperty(p45, p46)
			return p44
		elseif v47 == nil then
			v_u_69[p45] = p46
			return p44
		else
			p44[p45] = p46
			return p44
		end
	end,
	["new"] = function(p48, p49) -- name: new
		-- upvalues: (copy) v_u_4, (copy) v_u_25, (copy) v_u_19, (copy) v_u_32, (copy) v_u_5, (copy) v_u_24, (copy) v_u_33, (copy) v_u_69
		local v50 = p49 or v_u_4:GenerateGUID(false)
		local v51 = p48 ~= nil
		assert(v51, "Must pass a property table")
		local v52 = (p48.Position ~= nil or p48.Part ~= nil) and true or not v_u_25
		assert(v52, "Must pass either a Part or a Position")
		local v53
		if p48.ActionText == nil then
			v53 = false
		else
			v53 = p48.ObjectText ~= nil
		end
		assert(v53, "Must pass ActionText and ObjectText")
		if p48.Part then
			local v54 = p48.Part
			local v55
			if typeof(v54) == "Instance" then
				v55 = p48.Part:IsA("BasePart")
			else
				v55 = false
			end
			assert(v55, "Part must be a BasePart")
		end
		if p48.Position then
			local v56 = p48.Position
			local v57 = typeof(v56) == "Vector3"
			assert(v57, "Position must be of type Vector3")
		elseif not (v_u_25 or p48.Part) then
			p48.Part = getUnreplicatedPart(v50)
		end
		local v58 = {
			["Position"] = p48.Position,
			["Part"] = p48.Part,
			["Range"] = p48.Range or 4,
			["Obstructable"] = p48.Obstructable == nil and true or p48.Obstructable,
			["ObstructionIgnoreList"] = p48.ObstructionIgnoreList,
			["HoldTime"] = p48.HoldTime or 0.75
		}
		local v59
		if p48.ResetOnRelease == nil then
			v59 = false
		else
			v59 = p48.ResetOnRelease
		end
		v58.ResetOnRelease = v59
		v58.ActionText = p48.ActionText
		v58.ObjectText = p48.ObjectText
		v58.Enabled = p48.Enabled == nil and true or p48.Enabled
		v58.Players = p48.Players
		local v_u_60 = {
			["_Identifier"] = v50,
			["Properties"] = v58,
			["_IsLocal"] = v50 == nil,
			["Triggered"] = v_u_19.new(),
			["InteractBegan"] = v_u_19.new(),
			["InteractEnded"] = v_u_19.new()
		}
		v_u_32[v_u_60._Identifier] = v_u_60
		if v_u_25 then
			if v58.Part then
				v_u_5:AddTag(v58.Part, v50)
			end
			local v61 = {
				["Type"] = "Add",
				["Identifier"] = nil,
				["PropertyTable"] = nil,
				["Identifier"] = v_u_60._Identifier,
				["PropertyTable"] = v58
			}
			if v58.Players then
				v_u_24:FireClients(v58.Players, v61)
			else
				v_u_24:FireAllClients(v61)
			end
			v_u_33[v50] = v61
		end
		if not v_u_25 then
			v_u_60.Triggered:Connect(function()
				-- upvalues: (ref) v_u_24, (copy) v_u_60
				v_u_24:FireServer({
					["Type"] = "Triggered",
					["Identifier"] = nil,
					["Identifier"] = v_u_60._Identifier
				})
			end)
			v_u_60.InteractBegan:Connect(function()
				-- upvalues: (ref) v_u_24, (copy) v_u_60
				v_u_24:FireServer({
					["Type"] = "InteractBegin",
					["Identifier"] = nil,
					["Identifier"] = v_u_60._Identifier
				})
			end)
			v_u_60.InteractEnded:Connect(function()
				-- upvalues: (ref) v_u_24, (copy) v_u_60
				v_u_24:FireServer({
					["Type"] = "InteractEnd",
					["Identifier"] = nil,
					["Identifier"] = v_u_60._Identifier
				})
			end)
		end
		local v62 = v_u_69
		return setmetatable(v_u_60, v62)
	end,
	["Destroy"] = function(p63) -- name: Destroy
		-- upvalues: (copy) v_u_25, (copy) v_u_24, (copy) v_u_32
		p63.Triggered:DisconnectAll()
		p63.InteractBegan:DisconnectAll()
		p63.InteractEnded:DisconnectAll()
		if v_u_25 then
			v_u_24:FireAllClients({
				["Type"] = "Destroy",
				["Identifier"] = nil,
				["Identifier"] = p63._Identifier
			})
		end
		v_u_32[p63._Identifier] = nil
	end,
	["GetPromptByIdentifier"] = function(_, p64) -- name: GetPromptByIdentifier
		-- upvalues: (copy) v_u_32
		return v_u_32[p64]
	end,
	["_SetProperty"] = function(p65, p66, p67) -- name: _SetProperty
		-- upvalues: (copy) v_u_40, (copy) v_u_25, (copy) v_u_24, (copy) v_u_69
		if v_u_40[p66] then
			p65.Properties[p66] = p67
			if v_u_25 then
				local v68 = {
					["Type"] = "PropertyChanged",
					["Identifier"] = nil,
					["Index"] = nil,
					["Value"] = nil,
					["Identifier"] = p65._Identifier,
					["Index"] = p66,
					["Value"] = p67
				}
				if p65.Properties.Players == nil then
					v_u_24:FireAllClients(v68)
				else
					v_u_24:FireClients(p65.Properties.Players, v68)
				end
			end
			if p66 == "ActionText" or p66 == "ObjectText" then
				if v_u_69.openedPrompt == p65 then
					setText(p65.ActionText, p65.ObjectText)
					return
				end
			elseif p66 == "Part" and not p67 then
				p65.Properties[p66] = getUnreplicatedPart(p65._Identifier)
			end
		end
	end
}
function easeOutQuad(p70) -- name: easeOutQuad
	return 1 - (1 - p70) * (1 - p70)
end
function doComplete() -- name: doComplete
	-- upvalues: (copy) v_u_10, (copy) v_u_12, (copy) v_u_39
	v_u_10.BackgroundTransparency = 0
	v_u_10.Size = UDim2.new(0, v_u_12.AbsoluteSize.X, 0, v_u_12.AbsoluteSize.Y)
	v_u_10.Visible = true
	v_u_10:TweenSize(UDim2.new(0, v_u_12.AbsoluteSize.X * 1.5, 0, v_u_12.AbsoluteSize.Y * 1.5), "Out", "Quad", 0.15, true)
	v_u_39:Play()
end
v_u_39.Completed:Connect(function(p71)
	-- upvalues: (copy) v_u_10
	if p71 == Enum.PlaybackState.Completed then
		v_u_10.Visible = false
	end
end)
function setProgress(p72) -- name: setProgress
	-- upvalues: (ref) v_u_29, (ref) v_u_26, (copy) v_u_9, (copy) v_u_13
	v_u_29 = p72
	local v73 = v_u_26 * v_u_9.AbsoluteSize.Y * p72
	v_u_13.Size = UDim2.new(0, v73, 1, 0)
end
function updateWidth(p74) -- name: updateWidth
	-- upvalues: (copy) v_u_9, (ref) v_u_26, (copy) v_u_11, (ref) v_u_27, (copy) v_u_14, (copy) v_u_15, (ref) v_u_29
	local _ = v_u_9.AbsoluteSize
	v_u_26 = p74
	v_u_11:TweenSize(UDim2.new(p74, 0, v_u_27, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
	v_u_14.Size = UDim2.new(0, p74 * v_u_9.AbsoluteSize.Y, 1, 0)
	v_u_15.Size = UDim2.new(p74 * 1.5, 0, v_u_27 * 2, 0)
	setProgress(v_u_29)
end
function updateScaleWidth() -- name: updateScaleWidth
	-- upvalues: (ref) v_u_28, (ref) v_u_27, (copy) v_u_12, (copy) v_u_14
	v_u_12.TextFrame:TweenSize(UDim2.new(v_u_28 / v_u_27, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
	v_u_14.TextFrame:TweenSize(UDim2.new(v_u_28 / v_u_27, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
	updateWidth(v_u_28 + v_u_27)
end
function updateTextScaleWidth() -- name: updateTextScaleWidth
	-- upvalues: (copy) v_u_11, (ref) v_u_26, (ref) v_u_27, (copy) v_u_9, (copy) v_u_12, (copy) v_u_2, (ref) v_u_34, (ref) v_u_35, (ref) v_u_28
	v_u_11.Size = UDim2.new(v_u_26, 0, v_u_27, 0)
	local v75 = v_u_9.AbsoluteSize
	local v76 = v_u_12.TextFrame.HeaderLabel.TextBounds.Y
	local v77 = v_u_12.TextFrame.TextLabel.TextBounds.Y
	local v78 = v_u_12.TextFrame.HeaderLabel.Font
	local v79 = v_u_2:GetTextSize(v_u_34, v76, v78, Vector2.new((1 / 0), v76)).X
	local v80 = v_u_2:GetTextSize(v_u_35, v77, v78, Vector2.new((1 / 0), v77)).X
	v_u_28 = math.max(v79, v80) / v75.Y + 0.0075
end
function setText(p81, p82) -- name: setText
	-- upvalues: (ref) v_u_34, (ref) v_u_35, (copy) v_u_12, (copy) v_u_14
	v_u_34 = p81
	v_u_35 = p82
	updateTextScaleWidth()
	updateScaleWidth()
	local v83 = v_u_12.TextFrame
	v83.HeaderLabel.Text = p81
	v83.TextLabel.Text = p82
	local v84 = v_u_14.TextFrame
	v84.HeaderLabel.Text = p81
	v84.TextLabel.Text = p82
end
local v_u_85 = nil
function setPromptVisible(p86) -- name: setPromptVisible
	-- upvalues: (copy) v_u_15, (ref) v_u_30, (ref) v_u_85, (copy) v_u_11, (copy) v_u_3
	local v_u_87 = os.clock()
	v_u_15.Active = p86
	if p86 and not v_u_30 then
		local v_u_88 = os.clock() * 100
		v_u_85 = v_u_88
		task.defer(function()
			-- upvalues: (ref) v_u_11, (ref) v_u_3, (copy) v_u_87, (ref) v_u_85, (copy) v_u_88
			local v89 = easeOutQuad(0 / 0.5)
			repeat
				local v90 = NumberSequence.new({
					NumberSequenceKeypoint.new(0, 1),
					NumberSequenceKeypoint.new(0.5 - v89 * 0.5 - 0.001, 1),
					NumberSequenceKeypoint.new(0.5 - v89 * 0.5, 0),
					NumberSequenceKeypoint.new(0.5 + v89 * 0.5, 0),
					NumberSequenceKeypoint.new(0.5 + v89 * 0.5 + 0.001, 1),
					NumberSequenceKeypoint.new(1, 1)
				})
				v_u_11.UIGradient.Transparency = v90
				v_u_3.Heartbeat:Wait()
				local v91 = os.clock() - v_u_87
				v89 = easeOutQuad(v91 / 0.5)
			until v91 >= 0.5 or (v89 * 0.5 + 0.001 >= 0.5 or v_u_85 ~= v_u_88)
			if v_u_85 == v_u_88 then
				v_u_11.UIGradient.Transparency = NumberSequence.new(0)
			end
		end)
	elseif not p86 and v_u_30 then
		local v_u_92 = os.clock() * 100
		v_u_85 = v_u_92
		task.defer(function()
			-- upvalues: (ref) v_u_11, (ref) v_u_3, (copy) v_u_87, (ref) v_u_85, (copy) v_u_92
			local v93 = easeOutQuad(0 / 0.5)
			while true do
				if v93 >= 0.002 then
					local v94 = NumberSequence.new({
						NumberSequenceKeypoint.new(0, 1),
						NumberSequenceKeypoint.new(v93 * 0.5 - 0.001, 1),
						NumberSequenceKeypoint.new(v93 * 0.5, 0),
						NumberSequenceKeypoint.new(1 - v93 * 0.5, 0),
						NumberSequenceKeypoint.new(1 - v93 * 0.5 + 0.001, 1),
						NumberSequenceKeypoint.new(1, 1)
					})
					v_u_11.UIGradient.Transparency = v94
				end
				v_u_3.RenderStepped:Wait()
				local v95 = os.clock() - v_u_87
				v93 = easeOutQuad(v95 / 0.5)
				if v95 >= 0.5 or (v93 * 0.5 + 0.001 >= 0.5 or v_u_85 ~= v_u_92) then
					if v_u_85 == v_u_92 then
						v_u_11.UIGradient.Transparency = NumberSequence.new(1)
					end
					return
				end
			end
		end)
	end
	v_u_30 = p86
end
function setPrompt(p96) -- name: setPrompt
	-- upvalues: (copy) v_u_69, (copy) v_u_18
	v_u_69.openedPrompt = p96
	v_u_18.Adornee = nil
	if p96.Part then
		local v97 = p96.Part.Parent
		if p96.Part:GetAttribute("Highlight") then
			v_u_18.Adornee = p96.Part
		elseif v97 and v97:GetAttribute("Highlight") then
			v_u_18.Adornee = v97
		else
			v_u_18.Adornee = nil
		end
	end
	setText(p96.ActionText, p96.ObjectText)
	setPromptVisible(true)
	setProgress(0)
end
function removePrompt() -- name: removePrompt
	-- upvalues: (copy) v_u_69, (copy) v_u_18
	v_u_69.openedPrompt = nil
	v_u_18.Adornee = nil
	setPromptVisible(false)
	setProgress(0)
end
function getUnreplicatedPart(p98) -- name: getUnreplicatedPart
	-- upvalues: (copy) v_u_5
	local v99 = v_u_5:GetTagged(p98)[1]
	while v99 == nil do
		v99 = v_u_5:GetInstanceAddedSignal(p98):Wait()
	end
	return v99
end
v_u_9:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
	-- upvalues: (ref) v_u_26
	updateWidth(v_u_26)
end)
if not v_u_25 then
	v_u_9.Parent = game.Players.LocalPlayer.PlayerGui
end
local function v101(p100) -- name: updateInterfaceScale
	-- upvalues: (copy) v_u_11, (ref) v_u_27
	local _ = v_u_11.Size
	if p100 == "Touch" then
		v_u_27 = 0.1
	else
		v_u_27 = 0.05
	end
	updateTextScaleWidth()
	updateScaleWidth()
end
if not v_u_25 then
	local v102 = v23.new("PromptInteract", 3, Color3.fromRGB(9, 39, 65))
	v102.UIObject.AnchorPoint = Vector2.new(0.5, 0.5)
	v102.UIObject.Position = UDim2.new(0.5, 0, 0.5, 0)
	v102.UIObject.Size = UDim2.new(0.7, 0, 0.7, 0)
	v102.UIObject.Parent = v16
	local v103 = v23.new("PromptInteract", 3, Color3.new(1, 1, 1))
	v103.UIObject.AnchorPoint = Vector2.new(0.5, 0.5)
	v103.UIObject.Position = UDim2.new(0.5, 0, 0.5, 0)
	v103.UIObject.Size = UDim2.new(0.7, 0, 0.7, 0)
	v103.UIObject.Parent = v17
	local v104 = v20.getInputMethod()
	local _ = v_u_11.Size
	if v104 == "Touch" then
		v_u_27 = 0.1
	else
		v_u_27 = 0.05
	end
	updateTextScaleWidth()
	updateScaleWidth()
	v20.InputMethodChanged:Connect(v101)
	v_u_15.Visible = v20.getInputMethod() == "Touch"
	v20.InputMethodChanged:Connect(function(p105) -- name: updateTouchButtonVisibility
		-- upvalues: (copy) v_u_15
		v_u_15.Visible = p105 == "Touch"
	end)
	v20.new("PromptInteract", function()
		-- upvalues: (ref) v_u_31
		v_u_31 = true
	end, function()
		-- upvalues: (ref) v_u_31, (ref) v_u_38
		v_u_31 = false
		v_u_38 = true
	end)
	v_u_15.MouseButton1Down:Connect(function()
		-- upvalues: (ref) v_u_31
		v_u_31 = true
	end)
	v_u_15.MouseButton1Up:Connect(function()
		-- upvalues: (ref) v_u_31, (ref) v_u_38
		v_u_31 = false
		v_u_38 = true
	end)
	v_u_15.MouseLeave:Connect(function()
		-- upvalues: (ref) v_u_31, (ref) v_u_38
		v_u_31 = false
		v_u_38 = true
	end)
end
v_u_3:BindToRenderStep("ProximityPromptProgress", Enum.RenderPriority.Camera.Value - 1, function(p106)
	-- upvalues: (copy) v_u_69, (ref) v_u_22, (ref) v_u_21, (ref) v_u_31, (ref) v_u_38, (ref) v_u_36, (ref) v_u_37, (ref) v_u_29
	if v_u_69.openedPrompt then
		local v107 = not (v_u_22 and v_u_22.InteractSpeedMult) and 1 or v_u_21.peek(v_u_22.InteractSpeedMult)
		if not (v_u_31 and v_u_38) then
			if v_u_36 and v_u_38 then
				v_u_69.openedPrompt.InteractEnded:Fire()
				v_u_36 = false
				if v_u_69.openedPrompt.ResetOnRelease then
					v_u_29 = 0
				end
			end
			local v108 = setProgress
			local v109 = v_u_29 - p106 * 2 * v107 / v_u_69.openedPrompt.HoldTime
			v108((math.max(v109, 0)))
			return
		end
		if not v_u_36 or v_u_69.openedPrompt ~= v_u_37 then
			v_u_69.openedPrompt.InteractBegan:Fire()
			v_u_37 = v_u_69.openedPrompt
			v_u_36 = true
		end
		if not v_u_31 and v_u_36 then
			if v_u_37 then
				v_u_37.InteractEnded:Fire()
			end
			v_u_36 = false
		end
		local v110 = setProgress
		local v111 = v_u_29 + p106 * v107 / v_u_69.openedPrompt.HoldTime
		v110((math.min(v111, 1)))
		if v_u_29 == 1 and v_u_69.openedPrompt.Enabled then
			v_u_69.openedPrompt.Triggered:Fire(game.Players.LocalPlayer)
			v_u_38 = false
			doComplete()
			setProgress(0)
			return
		end
	elseif v_u_37 and v_u_38 then
		v_u_37.InteractEnded:Fire()
		v_u_37 = nil
	end
end)
if v_u_25 then
	v_u_24:SetServerListener(function(p112, p113)
		-- upvalues: (copy) v_u_32, (copy) v_u_33, (copy) v_u_24
		if p113 then
			if p113.Type == "Triggered" then
				local v114 = v_u_32[p113.Identifier]
				if v114 then
					v114.Triggered:Fire(p112)
					return
				end
			elseif p113.Type == "InteractBegin" then
				local v115 = v_u_32[p113.Identifier]
				if v115 then
					v115.InteractBegan:Fire(p112)
					return
				end
			else
				local v116 = p113.Type == "InteractEnd" and v_u_32[p113.Identifier]
				if v116 then
					v116.InteractEnded:Fire(p112)
					return
				end
			end
		else
			for _, v117 in v_u_33 do
				if not v117.PropertyTable.Players or table.find(v117.PropertyTable.Players, p112) then
					v_u_24:FireClient(p112, v117)
				end
			end
		end
	end)
else
	local v_u_118 = game.Players.LocalPlayer
	local v_u_119 = RaycastParams.new()
	v_u_119.FilterDescendantsInstances = { workspace.Ignore, v_u_118.Character }
	v_u_119.FilterType = Enum.RaycastFilterType.Exclude
	task.defer(function()
		-- upvalues: (copy) v_u_118, (copy) v_u_32, (copy) v_u_119, (copy) v_u_69, (ref) v_u_30
		while true do
			while true do
				if not task.wait(0.1) then
					return
				end
				if not (v_u_118.Character and v_u_118.Character:FindFirstChild("HumanoidRootPart")) then
					break
				end
				local v120 = v_u_118.Character.HumanoidRootPart.Position
				local v121 = workspace.CurrentCamera.CFrame.LookVector
				local v122 = workspace.CurrentCamera.CFrame.Position
				local v123 = {}
				for _, v124 in v_u_32 do
					if v124.Enabled then
						local v125 = v124.Position
						if not v125 and v124.Part then
							v125 = v124.Part.Position
						end
						if v125 then
							local v126 = (v120 - v125).Magnitude
							if v126 <= v124.Range then
								if v124.Obstructable then
									v_u_119.FilterDescendantsInstances = { workspace.Ignore, v_u_118.Character }
									if v124.ObstructionIgnoreList then
										v_u_119.FilterDescendantsInstances = table.move(v124.ObstructionIgnoreList, 1, #v124.ObstructionIgnoreList, #v_u_119.FilterDescendantsInstances + 1, v_u_119.FilterDescendantsInstances)
									end
									if not workspace:Raycast(v125, v120 - v125, v_u_119) then
										goto l15
									end
								else
									::l15::
									table.insert(v123, {
										["Prompt"] = v124,
										["Position"] = v125,
										["Distance"] = v126
									})
								end
							end
						end
					end
				end
				local v127 = nil
				local v128 = nil
				local v129 = nil
				local v130 = RaycastParams.new()
				v130.FilterDescendantsInstances = { workspace.Ignore, v_u_118.Character }
				v130.FilterType = Enum.RaycastFilterType.Exclude
				local v131 = workspace:Raycast(v122, v121 * 35, v130)
				local v132
				if v131 then
					local v133 = v131.Instance
					local v134 = {}
					local v135 = {}
					v132 = {}
					for _, v136 in v123 do
						if v136 ~= nil and (v136.Prompt ~= nil and v136.Prompt.Part ~= nil) then
							local v137 = v136.Prompt.Part.Parent
							if v136.Prompt.Part == v133 then
								table.insert(v134, v136)
							elseif v133.Parent == v137 then
								table.insert(v135, v136)
							elseif v133:IsDescendantOf(v137) then
								table.insert(v132, v136)
							end
						end
					end
					if #v134 == 0 then
						if #v135 == 0 then
							if #v132 == 0 then
								v132 = v123
							end
						else
							v132 = v135
						end
					else
						v132 = v134
					end
				else
					v132 = v123
				end
				for _, v138 in ipairs(v132) do
					local v139 = v121:Dot((v138.Position - v120).Unit)
					local v140 = math.clamp(v139, -1, 1)
					local v141 = math.acos(v140)
					if v127 then
						if v141 < v128 or v141 == v128 and v138.Distance < v129 then
							v127 = v138.Prompt
							v129 = v138.Distance
							v128 = v141
						end
					else
						v127 = v138.Prompt
						v129 = v138.Distance
						v128 = v141
					end
				end
				if v127 == nil then
					if v_u_30 then
						removePrompt()
					end
				elseif v_u_69.openedPrompt ~= v127 then
					setPrompt(v127)
				end
			end
			if v_u_30 then
				removePrompt()
			end
		end
	end)
	v_u_24:SetClientListener(function(p142)
		-- upvalues: (copy) v_u_69, (copy) v_u_32
		if p142.Type == "Add" then
			v_u_69.new(p142.PropertyTable, p142.Identifier)
		elseif p142.Type == "Destroy" then
			local v143 = v_u_32[p142.Identifier]
			if v143 then
				v143:Destroy()
				return
			end
		else
			local v144 = p142.Type == "PropertyChanged" and v_u_32[p142.Identifier]
			if v144 then
				v144:_SetProperty(p142.Index, p142.Value)
			end
		end
	end)
	v_u_24:FireServer()
end
return v_u_69