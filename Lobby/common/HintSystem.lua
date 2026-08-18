local v1 = game:GetService("Players")
local v_u_2 = game:GetService("TweenService")
local v_u_3 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v_u_4 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v5 = Instance.new("ScreenGui")
v5.Name = "HintSystem"
v5.ResetOnSpawn = false
v5.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
v5.IgnoreGuiInset = true
v5.DisplayOrder = 10
v5.Parent = v1.LocalPlayer:WaitForChild("PlayerGui")
local v_u_6 = Instance.new("Frame")
v_u_6.Name = "Messages"
v_u_6.AnchorPoint = Vector2.new(0.5, 0)
v_u_6.BackgroundTransparency = 1
v_u_6.Position = UDim2.fromScale(0.5, 0.15)
v_u_6.Size = UDim2.fromScale(0.7, 0.18)
v_u_6.Parent = v5
local v7 = Instance.new("UIListLayout")
v7.HorizontalAlignment = Enum.HorizontalAlignment.Center
v7.SortOrder = Enum.SortOrder.LayoutOrder
v7.Padding = UDim.new(0, 4)
v7.Parent = v_u_6
local v_u_8 = Instance.new("Sound")
v_u_8.Name = "Bleep"
v_u_8.SoundId = "rbxassetid://9125938067"
v_u_8.Parent = v5
local v_u_9 = Instance.new("Sound")
v_u_9.Name = "Error"
v_u_9.SoundId = "rbxassetid://97329712338974"
v_u_9.Parent = v5
local v_u_10 = {}
local v_u_11 = {}
local function v_u_16(p12) -- name: createMessageFrame
	-- upvalues: (copy) v_u_6, (copy) v_u_2, (copy) v_u_3
	local v13 = Instance.new("Frame")
	v13.BackgroundTransparency = 1
	v13.Size = UDim2.new(1, 0, 0, 30)
	v13.AutomaticSize = Enum.AutomaticSize.Y
	local v14 = Instance.new("TextLabel")
	v14.AnchorPoint = Vector2.new(0.5, 0)
	v14.BackgroundTransparency = 1
	v14.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold)
	v14.Position = UDim2.fromScale(0.5, 0)
	v14.RichText = true
	v14.Size = UDim2.fromScale(1, 1)
	v14.Text = p12
	v14.TextColor3 = Color3.fromRGB(245, 245, 245)
	v14.TextScaled = true
	v14.TextTransparency = 1
	v14.Parent = v13
	local v15 = Instance.new("UIStroke")
	v15.Thickness = 2
	v15.Transparency = 1
	v15.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
	v15.Thickness = 0.05
	v15.Parent = v14
	v13.Parent = v_u_6
	v_u_2:Create(v14, v_u_3, {
		["TextTransparency"] = 0
	}):Play()
	v_u_2:Create(v15, v_u_3, {
		["Transparency"] = 0.7
	}):Play()
	return {
		["frame"] = nil,
		["label"] = nil,
		["stroke"] = nil,
		["count"] = 1,
		["timerThread"] = nil,
		["frame"] = v13,
		["label"] = v14,
		["stroke"] = v15
	}
end
local function v_u_18(p_u_17) -- name: fadeOutAndDestroy
	-- upvalues: (copy) v_u_2, (copy) v_u_4
	if p_u_17.timerThread then
		task.cancel(p_u_17.timerThread)
		p_u_17.timerThread = nil
	end
	v_u_2:Create(p_u_17.label, v_u_4, {
		["TextTransparency"] = 1
	}):Play()
	v_u_2:Create(p_u_17.stroke, v_u_4, {
		["Transparency"] = 1
	}):Play()
	task.delay(0.5, function()
		-- upvalues: (copy) p_u_17
		p_u_17.frame:Destroy()
	end)
end
local v_u_48 = {
	["Show"] = function(_, p_u_19, p20) -- name: Show
		-- upvalues: (copy) v_u_10, (copy) v_u_48, (copy) v_u_8, (copy) v_u_9, (copy) v_u_16
		local v21 = p20 or 3
		if v_u_10[p_u_19] then
			local v_u_22 = v_u_10[p_u_19]
			v_u_22.count = v_u_22.count + 1
			v_u_22.label.Text = p_u_19 .. " x" .. v_u_22.count
			if v_u_22.timerThread then
				task.cancel(v_u_22.timerThread)
			end
			v_u_22.timerThread = task.delay(v21, function()
				-- upvalues: (copy) v_u_22, (ref) v_u_48, (copy) p_u_19
				v_u_22.timerThread = nil
				v_u_48:_remove(p_u_19)
			end)
			v_u_8:Play()
			return
		end
		local v23 = false
		for v24, v25, v26 in p_u_19:gmatch("rgb%((%d+)%s*,%s*(%d+)%s*,%s*(%d+)%)") do
			local v27 = tonumber(v24)
			local v28 = tonumber(v25)
			local v29 = tonumber(v26)
			if v27 and (v28 and (v29 and (v27 > 150 and (v28 + 50 < v27 and v29 + 50 < v27)))) then
				v23 = true
				break
			end
		end
		if not v23 then
			for v30 in p_u_19:gmatch("#(%x%x%x%x%x%x)") do
				local v31 = v30:sub(1, 2)
				local v32 = tonumber(v31, 16)
				local v33 = v30:sub(3, 4)
				local v34 = tonumber(v33, 16)
				local v35 = v30:sub(5, 6)
				local v36 = tonumber(v35, 16)
				if v32 and (v34 and (v36 and (v32 > 150 and (v34 + 50 < v32 and v36 + 50 < v32)))) then
					v23 = true
					break
				end
			end
		end
		if v23 then
			v_u_9:Play()
		else
			v_u_8:Play()
		end
		local v_u_37 = v_u_16(p_u_19)
		v_u_37.timerThread = task.delay(v21, function()
			-- upvalues: (copy) v_u_37, (ref) v_u_48, (copy) p_u_19
			v_u_37.timerThread = nil
			v_u_48:_remove(p_u_19)
		end)
		v_u_10[p_u_19] = v_u_37
	end,
	["_remove"] = function(_, p38) -- name: _remove
		-- upvalues: (copy) v_u_10, (copy) v_u_18
		local v39 = v_u_10[p38]
		if v39 then
			v_u_10[p38] = nil
			v_u_18(v39)
		end
	end,
	["ShowKeyed"] = function(_, p_u_40, p41, p42) -- name: ShowKeyed
		-- upvalues: (copy) v_u_11, (copy) v_u_48, (copy) v_u_16
		local v43 = p42 or 3
		if v_u_11[p_u_40] then
			local v_u_44 = v_u_11[p_u_40]
			v_u_44.label.Text = p41
			if v_u_44.timerThread then
				task.cancel(v_u_44.timerThread)
			end
			if v43 > 0 then
				v_u_44.timerThread = task.delay(v43, function()
					-- upvalues: (copy) v_u_44, (ref) v_u_48, (copy) p_u_40
					v_u_44.timerThread = nil
					v_u_48:RemoveKeyed(p_u_40)
				end)
			else
				v_u_44.timerThread = nil
			end
		else
			local v_u_45 = v_u_16(p41)
			if v43 > 0 then
				v_u_45.timerThread = task.delay(v43, function()
					-- upvalues: (copy) v_u_45, (ref) v_u_48, (copy) p_u_40
					v_u_45.timerThread = nil
					v_u_48:RemoveKeyed(p_u_40)
				end)
			end
			v_u_11[p_u_40] = v_u_45
			return
		end
	end,
	["RemoveKeyed"] = function(_, p46) -- name: RemoveKeyed
		-- upvalues: (copy) v_u_11, (copy) v_u_18
		local v47 = v_u_11[p46]
		if v47 then
			v_u_11[p46] = nil
			v_u_18(v47)
		end
	end
}
return v_u_48