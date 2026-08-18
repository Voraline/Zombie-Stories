local v_u_1 = script:WaitForChild("ObjectivesUI")
local v_u_2 = v_u_1.ObjectiveList
local v_u_3 = v_u_2.Template
local v_u_4 = v_u_1.NewObjective.InnerFrame
local v_u_5 = v_u_1.ObjectiveCompleted.InnerFrame
local v_u_6 = v_u_1.Markers
local v_u_7 = v_u_6.Template
local v_u_8 = v_u_1.CheckFrame.ImageLabel
local v_u_9 = v_u_1.Sounds
local v_u_10 = game:GetService("HttpService")
local v_u_11 = game:GetService("RunService")
require(game.ReplicatedStorage.common:WaitForChild("HUDService"))
local v_u_12 = {
	["kill"] = "rbxassetid://14066162181",
	["collect"] = "rbxassetid://14066160240",
	["find"] = "rbxassetid://14066161325",
	["move"] = "rbxassetid://14066155074",
	["interact"] = "rbxassetid://14101485038"
}
local v_u_13 = {
	["kill"] = Color3.fromRGB(255, 98, 98),
	["collect"] = Color3.fromRGB(255, 175, 94),
	["find"] = Color3.fromRGB(189, 172, 255),
	["move"] = Color3.fromRGB(157, 247, 255),
	["interact"] = Color3.fromRGB(138, 255, 130)
}
local v_u_14 = {}
local v_u_15 = {}
local v_u_47 = {
	["IsShowing"] = true,
	["Show"] = function(_) -- name: Show
		-- upvalues: (copy) v_u_1, (copy) v_u_47
		v_u_1.Enabled = true
		v_u_47.IsShowing = true
	end,
	["Hide"] = function(_) -- name: Hide
		-- upvalues: (copy) v_u_1, (copy) v_u_47
		v_u_1.Enabled = false
		v_u_47.IsShowing = false
	end,
	["AddObjective"] = function(_, p16, p17) -- name: AddObjective
		-- upvalues: (copy) v_u_10, (copy) v_u_3, (copy) v_u_12, (copy) v_u_13, (copy) v_u_14, (copy) v_u_2
		p16.Identifier = p17 or v_u_10:GenerateGUID(false)
		p16.IsPrimary = p16.IsPrimary or false
		p16.Progress = not p16.Progress and 0 or p16.Progress
		p16.ObjectiveType = p16.Type
		local v18 = v_u_3:Clone()
		v18.Name = p16.Identifier
		v18.IsPrimaryLabel.Visible = p16.IsPrimary
		v18.TextLabel.Text = p16.Text
		if p16.ImageID then
			v18.ImageLabel.Image = p16.ImageID
		else
			v18.ImageLabel.Image = v_u_12[p16.ObjectiveType]
		end
		local v19
		if p16.AccentColor then
			v19 = p16.AccentColor
		elseif p16.ImageID then
			v19 = Color3.new(1, 1, 1)
		else
			v19 = v_u_13[p16.ObjectiveType]
		end
		v18.ImageLabel.ImageColor3 = v19
		v18.ProgressLabel.TextColor3 = v19
		v18.Visible = true
		p16.ListElement = v18
		p16.CreationTime = os.clock()
		v_u_14[p16.Identifier] = p16
		evaluateLayoutOrder()
		updateListItemProgress(v_u_14[p16.Identifier])
		showNewOrCompletedObjective(p16)
		v18.Parent = v_u_2
		return p16.Identifier
	end,
	["UpdateProgress"] = function(_, p20, p21, p22) -- name: UpdateProgress
		-- upvalues: (copy) v_u_14
		local v23 = v_u_14[p20]
		if v23 then
			if p21 then
				v23.Progress = p21
			end
			if p22 then
				v23.ProgressTotal = p22
			end
			updateListItemProgress(v23)
		end
	end,
	["SetIsPrimary"] = function(_, p24, p25) -- name: SetIsPrimary
		-- upvalues: (copy) v_u_14
		local v26 = v_u_14[p24]
		if v26 then
			local v27 = v26.ListElement
			v26.IsPrimary = p25
			v27.IsPrimaryLabel.Visible = p25
			evaluateLayoutOrder()
		end
	end,
	["RemoveObjective"] = function(_, p28, p29) -- name: RemoveObjective
		-- upvalues: (copy) v_u_14
		local v30 = v_u_14[p28]
		if v30 then
			v30.ListElement:Destroy()
			v_u_14[p28] = nil
			if p29 then
				showNewOrCompletedObjective(v30, p29)
			end
		end
	end,
	["AddMarker"] = function(_, p31, p32, p33, p34) -- name: AddMarker
		-- upvalues: (copy) v_u_10, (copy) v_u_13, (copy) v_u_7, (copy) v_u_12, (copy) v_u_6, (copy) v_u_15
		local v35 = p33 or v_u_10:GenerateGUID(false)
		local v36
		if p31.AccentColor then
			v36 = p31.AccentColor
		elseif p31.ImageID then
			v36 = Color3.new(1, 1, 1)
		else
			v36 = v_u_13[p31.ObjectiveType]
		end
		local v37 = v_u_7:Clone()
		v37.Visible = true
		v37.ImageLabel.Image = p31.ImageID or v_u_12[p31.ObjectiveType]
		v37.ImageLabel.ImageColor3 = v36
		v37.TextLabel.TextColor3 = v36
		v37.TextLabel.Text = p31.Text
		v37.Parent = v_u_6
		v_u_15[v35] = {
			["Identifier"] = v35,
			["ObjectiveType"] = p31.ObjectiveType,
			["Text"] = p31.Text,
			["Location"] = p32,
			["UIElement"] = v37,
			["ObjectiveIdentifier"] = p34
		}
		updateMarkerTextTransparency()
		return v35
	end,
	["RemoveMarker"] = function(_, p38) -- name: RemoveMarker
		-- upvalues: (copy) v_u_15
		local v39 = v_u_15[p38]
		if v39 then
			v_u_15[p38] = nil
			updateMarkerTextTransparency()
			v39.UIElement:Destroy()
		end
	end,
	["SetMarkerText"] = function(_, p40, p41) -- name: SetMarkerText
		-- upvalues: (copy) v_u_15
		local v42 = v_u_15[p40]
		if v42 then
			v42.Text = p41
			v42.UIElement.TextLabel.Text = p41
		end
	end,
	["SetMarkerType"] = function(_, p43, p44) -- name: SetMarkerType
		-- upvalues: (copy) v_u_15, (copy) v_u_12, (copy) v_u_13
		local v45 = v_u_15[p43]
		if v45 then
			local v46 = v45.UIElement
			v46.ImageLabel.Image = v_u_12[p44]
			v46.ImageLabel.ImageColor3 = v_u_13[p44]
			v46.TextLabel.TextColor3 = v_u_13[p44]
		end
	end,
	["GetGuiList"] = function(_) -- name: GetGuiList
		-- upvalues: (copy) v_u_2
		return v_u_2
	end
}
function evaluateLayoutOrder() -- name: evaluateLayoutOrder
	-- upvalues: (copy) v_u_14
	local v48 = {}
	for v49 in v_u_14 do
		table.insert(v48, v49)
	end
	table.sort(v48, function(p50, p51)
		-- upvalues: (ref) v_u_14
		local v52 = v_u_14[p50].IsPrimary
		local v53 = v_u_14[p51].IsPrimary
		local v54 = v_u_14[p50].CreationTime
		local v55 = v_u_14[p51].CreationTime
		if v52 == v53 then
			return v54 < v55
		else
			return v52 and true or false
		end
	end)
	for v56, v57 in v48 do
		v_u_14[v57].ListElement.LayoutOrder = v56
	end
end
function updateListItemProgress(p58) -- name: updateListItemProgress
	local _ = p58.ListElement
	local v59 = p58.ObjectiveType
	if p58.ProgressFormat then
		p58.ListElement.ProgressLabel.Text = p58.ProgressFormat:format(p58.Progress, p58.ProgressTotal)
		return
	elseif v59 == "kill" or (v59 == "collect" or (v59 == "find" or v59 == "interact")) then
		p58.ListElement.ProgressLabel.Text = ("%d/%d"):format(p58.Progress, p58.ProgressTotal)
	elseif v59 == "move" then
		p58.ListElement.ProgressLabel.Text = ("%dm"):format(p58.Progress)
	end
end
local v_u_60 = {}
local v_u_61 = false
function showNewOrCompletedObjective(p62, p63) -- name: showNewOrCompletedObjective
	-- upvalues: (copy) v_u_13, (copy) v_u_60, (copy) v_u_12, (ref) v_u_61, (copy) v_u_5, (copy) v_u_9, (copy) v_u_8, (copy) v_u_4
	local v64
	if p62.AccentColor then
		v64 = p62.AccentColor
	elseif p62.ImageID then
		v64 = Color3.new(1, 1, 1)
	else
		v64 = v_u_13[p62.ObjectiveType]
	end
	local v65 = v_u_60
	local v66 = {
		["Text"] = p62.Text,
		["ImageID"] = p62.ImageID or v_u_12[p62.ObjectiveType],
		["AccentColor"] = v64,
		["IsCompleted"] = p63 or false,
		["NewSoundId"] = p62.NewSoundId,
		["CompleteSoundId"] = p62.CompleteSoundId
	}
	table.insert(v65, v66)
	if not v_u_61 then
		v_u_61 = true
		task.defer(function()
			-- upvalues: (ref) v_u_60, (ref) v_u_5, (ref) v_u_9, (ref) v_u_8, (ref) v_u_4, (ref) v_u_61
			while true do
				local v67 = v_u_60[1]
				if v67.IsCompleted then
					if v67.CompleteSoundId then
						local v_u_68 = Instance.new("Sound", v_u_5)
						v_u_68.SoundId = v67.CompleteSoundId
						v_u_68.Volume = 1
						v_u_68:Play()
						v_u_68.Ended:Connect(function()
							-- upvalues: (copy) v_u_68
							v_u_68:Destroy()
						end)
					else
						v_u_9.ObjectiveCompleted:Play()
					end
					v_u_5.ObjectiveLabel.Text = v67.Text
					v_u_5.ImageLabel.Image = v67.ImageID
					v_u_5.ImageLabel.ImageColor3 = v67.AccentColor
					v_u_5:TweenPosition(UDim2.fromScale(0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
					v_u_8:TweenPosition(UDim2.fromScale(0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
					task.wait(3)
					v_u_5:TweenPosition(UDim2.fromScale(0, -1), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
					v_u_8:TweenPosition(UDim2.fromScale(0, -1), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
					task.wait(0.25)
					table.remove(v_u_60, 1)
				else
					if v67.NewSoundId then
						local v_u_69 = Instance.new("Sound", v_u_4)
						v_u_69.SoundId = v67.NewSoundId
						v_u_69.Volume = 1
						v_u_69:Play()
						v_u_69.Ended:Connect(function()
							-- upvalues: (copy) v_u_69
							v_u_69:Destroy()
						end)
					else
						v_u_9.NewObjective:Play()
					end
					v_u_4.ObjectiveLabel.Text = v67.Text
					v_u_4.ImageLabel.Image = v67.ImageID
					v_u_4.ImageLabel.ImageColor3 = v67.AccentColor
					v_u_4:TweenPosition(UDim2.fromScale(0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
					task.wait(3)
					v_u_4:TweenPosition(UDim2.fromScale(0, -1), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
					task.wait(0.25)
					table.remove(v_u_60, 1)
				end
				if #v_u_60 == 0 then
					v_u_61 = false
					return
				end
			end
		end)
	end
end
function updateMarkerFormat(p70, p71) -- name: updateMarkerFormat
	p70.ArrowLabel.Visible = not p71
	local v72 = p70.ImageLabel
	local v73
	if p71 then
		v73 = Vector2.new(0.5, 1)
	else
		v73 = Vector2.new(0.5, 0.5)
	end
	v72.AnchorPoint = v73
	p70.ImageLabel.Position = UDim2.new(0.5, 0, p71 and -0.5 or 0.5, 0)
	p70.ImageTransparency = p71 and 0 or 1
	p70.TextLabel.Visible = p71
end
function updateMarkerArrow(p74, p75) -- name: updateMarkerArrow
	-- upvalues: (copy) v_u_1
	local v76 = p75 - Vector2.new(v_u_1.AbsoluteSize.X * 0.5, v_u_1.AbsoluteSize.Y * 0.5)
	local v77 = v76.Y
	local v78 = v76.X
	local v79 = math.atan2(v77, v78)
	p74.ArrowLabel.Rotation = math.deg(v79)
end
function clampScreenPosition(p80, p81) -- name: clampScreenPosition
	-- upvalues: (copy) v_u_1
	local v82 = v_u_1.AbsoluteSize.X - p81 * 2
	local v83 = v_u_1.AbsoluteSize.Y - p81 * 2
	local v84 = p80 - Vector2.new(v_u_1.AbsoluteSize.X * 0.5, v_u_1.AbsoluteSize.Y * 0.5)
	local v85 = p80.X
	local v86 = p80.Y
	if v85 < p81 or (v86 < p81 or (v82 + p81 < v85 or v83 + p81 < v86)) then
		local v87 = v82 * 0.5 * (v82 * 0.5) + v83 * 0.5 * (v83 * 0.5)
		local v88 = math.sqrt(v87)
		local v89 = v84.Y
		local v90 = v84.X
		local v91 = math.atan2(v89, v90)
		local v92 = math.cos(v91) * v88
		local v93 = math.sin(v91) * v88
		if v82 * 0.5 < v92 then
			local v94 = v82 * 0.5 / v92
			v92 = v92 * v94
			v93 = v93 * v94
		elseif v92 < -v82 * 0.5 then
			local v95 = -v82 * 0.5 / v92
			v92 = v92 * v95
			v93 = v93 * v95
		end
		if v83 * 0.5 < v93 then
			local v96 = v83 * 0.5 / v93
			v92 = v92 * v96
			v93 = v93 * v96
		elseif v93 < -v83 * 0.5 then
			local v97 = -v83 * 0.5 / v93
			v92 = v92 * v97
			v93 = v93 * v97
		end
		v85 = v92 + (v82 + p81 * 2) * 0.5
		v86 = v93 + (v83 + p81 * 2) * 0.5
	end
	return Vector2.new(v85, v86), v85 ~= p80.X and true or v86 ~= p80.Y
end
function updateMarkerTextTransparency() -- name: updateMarkerTextTransparency
	-- upvalues: (copy) v_u_15
	local v98 = {}
	for _, v99 in v_u_15 do
		if not v98[v99.ObjectiveType] then
			v98[v99.ObjectiveType] = {}
		end
		local v100 = v98[v99.ObjectiveType]
		table.insert(v100, v99)
	end
	for _, v101 in v98 do
		local v102 = {}
		for _, v103 in v101 do
			local v104 = v103.ObjectiveIdentifier or ""
			if not v102[v104] then
				v102[v104] = {}
			end
			local v105 = v102[v104]
			table.insert(v105, v103)
		end
		for _, v106 in v102 do
			for _, v107 in v106 do
				v107.UIElement.TextLabel.TextTransparency = #v102 > 1 and 0 or 1
			end
		end
	end
end
v_u_1.Parent = game.Players.LocalPlayer.PlayerGui
task.defer(function()
	-- upvalues: (copy) v_u_11, (copy) v_u_15, (copy) v_u_1
	v_u_11.RenderStepped:Connect(function()
		-- upvalues: (ref) v_u_15, (ref) v_u_1
		for _, v108 in v_u_15 do
			local v109 = nil
			local v110 = v108.Location
			if typeof(v110) == "Instance" then
				v109 = v108.Location.Position
			else
				local v111 = v108.Location
				if typeof(v111) == "Vector3" then
					v109 = v108.Location
				end
			end
			if v109 then
				local v112 = v108.UIElement
				local v113, _ = workspace.CurrentCamera:WorldToScreenPoint(v109)
				local v114 = Vector2.new(v113.X, v113.Y)
				local v115 = v113.Z
				local v116 = Vector2.new(v_u_1.AbsoluteSize.X * 0.5, v_u_1.AbsoluteSize.Y * 0.5)
				local v117 = v114 - v116
				local _ = v115 < 0
				local v118, v119
				if v115 > 0 then
					v118, v119 = clampScreenPosition(v114, v108.UIElement.AbsoluteSize.X * 5)
				else
					v118, v119 = clampScreenPosition(v116 - v117 * 1000, v108.UIElement.AbsoluteSize.X * 5)
					v117 = v118 - v116
				end
				updateMarkerFormat(v108.UIElement, not v119)
				v108.UIElement.Position = UDim2.new(0, v118.X, 0, v118.Y)
				if v119 then
					local v120 = v117.Y
					local v121 = v117.X
					local v122 = math.atan2(v120, v121)
					v112.ArrowLabel.Rotation = math.deg(v122)
				end
			end
		end
	end)
end)
return v_u_47