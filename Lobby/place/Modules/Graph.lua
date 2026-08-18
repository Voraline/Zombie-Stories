local v_u_1 = game:GetService("TextService")
local v2 = {}
local v_u_3 = {
	["Name"] = "Dark",
	["Background"] = nil,
	["LightBackground"] = nil,
	["Text"] = nil,
	["Background"] = Color3.fromRGB(35, 35, 40),
	["LightBackground"] = Color3.fromRGB(45, 45, 50),
	["Text"] = Color3.fromRGB(220, 220, 230)
}
local v_u_4 = {
	["DMG"] = Color3.new(1, 0, 0),
	["HS DMG"] = Color3.new(1, 0.682353, 0)
}
local function v_u_9(p5) -- name: getKeyColor
	-- upvalues: (copy) v_u_4
	if v_u_4[p5] then
		return v_u_4[p5]
	end
	local v6 = 0
	for v7 = 1, #p5 do
		v6 = v6 + p5:byte(v7)
	end
	local v8 = Random.new(v6):NextInteger(0, 50) / 50
	return Color3.fromHSV(v8, 0.63, 0.84)
end
function v2.new(p10) -- name: new
	-- upvalues: (ref) v_u_3, (copy) v_u_9, (copy) v_u_1
	if not p10 then
		error("Must give graph a frame")
	end
	local v_u_11 = {
		["Frame"] = nil,
		["Resolution"] = 75,
		["Frame"] = p10
	}
	local v_u_12 = false
	local v_u_13 = v_u_11.Frame.ZIndex
	local v_u_14 = Instance.new("Frame")
	v_u_14.Name = "Background"
	v_u_14.BackgroundColor3 = v_u_3.Background
	v_u_14.Size = UDim2.new(1, 0, 1, 0)
	v_u_14.ZIndex = v_u_13 + 1
	v_u_14.Parent = v_u_11.Frame
	local v_u_15 = Instance.new("Frame")
	v_u_15.Name = "MarkerBackground"
	v_u_15.Size = UDim2.new(0.1, 0, 1, 0)
	v_u_15.BackgroundColor3 = v_u_3.LightBackground
	v_u_15.BorderSizePixel = 0
	v_u_15.ZIndex = v_u_13 + 2
	v_u_15.Parent = v_u_11.Frame
	local v_u_16 = Instance.new("Frame")
	v_u_16.Name = "Markers"
	v_u_16.Size = UDim2.new(0.1, 0, 0.85, 0)
	v_u_16.Position = UDim2.new(0, 0, 0.15, 0)
	v_u_16.BackgroundTransparency = 1
	v_u_16.BorderSizePixel = 0
	v_u_16.ZIndex = v_u_13 + 2
	v_u_16.Parent = v_u_11.Frame
	local v_u_17 = Instance.new("Frame")
	v_u_17.Name = "GraphingFrame"
	v_u_17.Size = UDim2.new(0.9, 0, 0.85, 0)
	v_u_17.Position = UDim2.new(0.1, 0, 0.15, 0)
	v_u_17.BackgroundTransparency = 1
	v_u_17.ZIndex = v_u_13 + 2
	v_u_17.Parent = v_u_11.Frame
	local v_u_18 = Instance.new("Frame")
	v_u_18.Name = "KeyNames"
	v_u_18.Size = UDim2.new(1, 0, 0.1, 0)
	v_u_18.Position = UDim2.new(0, 0, 0, 0)
	v_u_18.BackgroundColor3 = v_u_3.LightBackground
	v_u_18.BorderSizePixel = 0
	v_u_18.ZIndex = v_u_13 + 2
	v_u_18.Parent = v_u_11.Frame
	v_u_11.Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		-- upvalues: (copy) v_u_11
		local v19 = v_u_11.Frame.AbsoluteSize
		wait(0.04)
		if v19 == v_u_11.Frame.AbsoluteSize then
			v_u_11.Render()
		end
	end)
	function v_u_11.Theme(p20) -- name: Theme
		-- upvalues: (ref) v_u_3, (copy) v_u_14, (copy) v_u_15, (copy) v_u_18, (copy) v_u_11
		wait()
		v_u_3 = {
			["Name"] = p20.Name or "Dark",
			["Background"] = p20.Background or Color3.fromRGB(46, 46, 46),
			["LightBackground"] = p20.LightBackground or Color3.fromRGB(70, 70, 70),
			["Text"] = p20.Text or Color3.fromRGB(220, 220, 230)
		}
		v_u_14.BackgroundColor3 = v_u_3.Background
		v_u_15.BackgroundColor3 = v_u_3.LightBackground
		v_u_18.BackgroundColor3 = v_u_3.LightBackground
		v_u_11.Render()
	end
	function v_u_11.Render() -- name: Render
		-- upvalues: (copy) v_u_11, (ref) v_u_12, (copy) v_u_16, (copy) v_u_17, (copy) v_u_18, (ref) v_u_13, (copy) v_u_14, (copy) v_u_15, (ref) v_u_3, (ref) v_u_9, (ref) v_u_1
		if v_u_11.Frame and (v_u_11.Data and v_u_11.Resolution) then
			while v_u_12 do
				wait(0.1)
			end
			v_u_12 = true
			v_u_16:ClearAllChildren()
			v_u_17:ClearAllChildren()
			v_u_18:ClearAllChildren()
			v_u_13 = v_u_11.Frame.ZIndex
			v_u_14.ZIndex = v_u_13 + 1
			v_u_15.ZIndex = v_u_13 + 2
			v_u_16.ZIndex = v_u_13 + 2
			v_u_17.ZIndex = v_u_13 + 2
			v_u_18.ZIndex = v_u_13 + 2
			local v21 = Instance.new("UIListLayout")
			v21.FillDirection = Enum.FillDirection.Horizontal
			v21.HorizontalAlignment = Enum.HorizontalAlignment.Left
			v21.VerticalAlignment = Enum.VerticalAlignment.Center
			v21.Padding = UDim.new(0.01, 0)
			v21.Parent = v_u_18
			local v22 = (1 / 0)
			local v23 = (-1 / 0)
			for _, v24 in pairs(v_u_11.Data) do
				local v25 = #v24
				local v26 = v25 / v_u_11.Resolution
				for v27 = 1, v25, math.ceil(v26) do
					local v28 = v24[v27]
					if v28 then
						v22 = math.min(v22, v28)
						v23 = math.max(v23, v28)
					end
				end
			end
			if v_u_11.BaselineZero then
				v23 = v23 * 1.75
				v22 = 0
			end
			local v29 = v23 - v22
			for v30 = 0, 1, 0.2 do
				local v31 = Instance.new("TextLabel")
				v31.Name = v30
				v31.Size = UDim2.new(1, 0, 0.08, 0)
				v31.AnchorPoint = Vector2.new(0, 0.5)
				v31.Position = UDim2.new(0, 0, 0.9 - v30 * 0.9, 0)
				v31.Text = string.format("%.2f  ", v22 + v29 * v30)
				v31.TextXAlignment = Enum.TextXAlignment.Right
				v31.TextColor3 = v_u_3.Text
				v31.Font = Enum.Font.SourceSans
				v31.BackgroundTransparency = 1
				v31.TextSize = v_u_11.Frame.AbsoluteSize.X * 0.03
				v31.ZIndex = v_u_13 + 3
				v31.Parent = v_u_16
			end
			local v32 = {}
			for v33, v34 in pairs(v_u_11.Data) do
				v32[v33] = v_u_9(v33)
				local v35 = v_u_11.Frame.AbsoluteSize.Y * 0.08
				local v36 = v_u_1:GetTextSize(v33, v35, Enum.Font.SourceSansSemibold, v_u_18.AbsoluteSize)
				local v37 = Instance.new("TextLabel")
				v37.Text = v33
				v37.TextColor3 = v32[v33]
				v37.Font = Enum.Font.SourceSansSemibold
				v37.BackgroundTransparency = 1
				v37.TextSize = v35
				v37.Size = UDim2.new(0, v36.X + v35, 1, 0)
				v37.ZIndex = v_u_13 + 3
				v37.Parent = v_u_18
				local v38 = #v34
				local v39 = v38 / v_u_11.Resolution
				local v40 = math.ceil(v39)
				local v41 = nil
				for v42 = 1, v38 + v40, v40 do
					local v43
					if v38 < v42 then
						v43 = v38
					else
						v43 = v42
					end
					local v44 = v34[v43]
					if v44 then
						local v_u_45 = Instance.new("ImageLabel")
						v_u_45.Name = v33 .. v43
						v_u_45.Position = UDim2.new(v43 / v38 * 0.9 + 0.05, 0, 0.9 - (v44 - v22) / v29 * 0.9, 0)
						v_u_45.AnchorPoint = Vector2.new(0.5, 0.5)
						v_u_45.SizeConstraint = Enum.SizeConstraint.RelativeXX
						local v46 = UDim2.new
						local v47 = 0.5 / v_u_11.Resolution
						local v48 = math.clamp(v47, 0.003, 0.016)
						local v49 = 0.5 / v_u_11.Resolution
						v_u_45.Size = v46(v48, 0, math.clamp(v49, 0.003, 0.016), 0)
						v_u_45.ImageColor3 = v32[v33]
						v_u_45.BorderSizePixel = 0
						v_u_45.BackgroundTransparency = 1
						v_u_45.Image = "rbxassetid://200182847"
						v_u_45.ZIndex = v_u_13 + 5
						local v_u_50 = Instance.new("TextLabel")
						v_u_50.Visible = false
						v_u_50.Text = ("Damage: %*\nDistance: %*"):format(string.format("%.1f", v44), v43 - 1)
						v_u_50.BackgroundColor3 = v_u_3.LightBackground
						v_u_50.TextColor3 = v_u_3.Text
						v_u_50.Font = Enum.Font.Code
						v_u_50.TextSize = v_u_11.Frame.AbsoluteSize.X * 0.025
						v_u_50.TextXAlignment = Enum.TextXAlignment.Left
						v_u_50.TextYAlignment = Enum.TextYAlignment.Center
						v_u_50.BorderSizePixel = 0
						v_u_50.AnchorPoint = Vector2.new(0, 0.5)
						local v51 = v_u_50.TextSize * 0.4
						local v52 = math.floor(v51)
						local v_u_53 = math.max(12, v52)
						local v54 = v_u_50.TextSize * 0.3
						local v55 = math.floor(v54)
						local v56 = math.max(6, v55)
						local v57 = v_u_1:GetTextSize(v_u_50.Text, v_u_50.TextSize, v_u_50.Font, Vector2.new(10000, 10000))
						v_u_50.Size = UDim2.new(0, v57.X + v_u_53, 0, v57.Y + v56)
						v_u_50.Position = UDim2.new(1, v_u_53, 0.5, 0)
						v_u_50.Parent = v_u_45
						v_u_50.ZIndex = v_u_13 + 10
						local function v_u_73() -- name: updateLabelPosition
							-- upvalues: (copy) v_u_50, (ref) v_u_11, (copy) v_u_45, (copy) v_u_53
							if v_u_50.Parent then
								local v58 = v_u_11.Frame.AbsolutePosition
								local v59 = v_u_11.Frame.AbsoluteSize
								local v60 = v_u_45.AbsolutePosition
								local v61 = v_u_45.AbsoluteSize
								local v62 = Vector2.new(v60.X + v61.X * 0.5, v60.Y + v61.Y * 0.5)
								local v63 = v_u_50.AbsoluteSize
								local v64 = v58.X + v59.X - v62.X >= v63.X + v_u_53
								local v65 = v64 and 0 or 1
								local v66 = v64 and 1 or 0
								local v67 = v64 and v_u_53 or -v_u_53
								local v68 = v58.Y
								local v69 = v58.Y + v59.Y
								local v70 = v68 - (v62.Y - v63.Y * 0.5)
								local v71 = v69 - (v62.Y + v63.Y * 0.5)
								local v72
								if v71 < v70 then
									v72 = (v70 + v71) * 0.5
								else
									v72 = math.clamp(0, v70, v71)
								end
								v_u_50.AnchorPoint = Vector2.new(v65, 0.5)
								v_u_50.Position = UDim2.new(v66, v67, 0.5, v72)
							end
						end
						v_u_45.MouseEnter:Connect(function()
							-- upvalues: (copy) v_u_50, (copy) v_u_73
							v_u_50.Visible = true
							v_u_73()
						end)
						v_u_45.MouseLeave:Connect(function()
							-- upvalues: (copy) v_u_50
							v_u_50.Visible = false
						end)
						v_u_50:GetPropertyChangedSignal("AbsoluteSize"):Connect(v_u_73)
						v_u_45:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
							-- upvalues: (copy) v_u_50, (copy) v_u_73
							if v_u_50.Visible then
								v_u_73()
							end
						end)
						if v41 then
							local v74 = Instance.new("Frame")
							v74.Name = v33 .. v43 .. "-" .. v43 - 1
							v74.BackgroundColor3 = v32[v33]
							v74.BorderSizePixel = 0
							v74.SizeConstraint = Enum.SizeConstraint.RelativeXX
							v74.AnchorPoint = Vector2.new(0.5, 0.5)
							v74.ZIndex = v_u_13 + 4
							local v75 = v_u_17.AbsoluteSize
							local v76 = v_u_45.Position.X.Scale * v75.X
							local v77 = v_u_45.Position.Y.Scale * v75.Y
							local v78 = v41.Position.X.Scale * v75.X
							local v79 = v41.Position.Y.Scale * v75.Y
							local v80 = (Vector2.new(v76, v77) - Vector2.new(v78, v79)).Magnitude
							local v81 = UDim2.new
							local v82 = 0.2 / v_u_11.Resolution
							v74.Size = v81(0, v80, math.clamp(v82, 0.002, 0.0035), 0)
							v74.Position = UDim2.new(0, (v76 + v78) / 2, 0, (v77 + v79) / 2)
							local v83 = v79 - v77
							local v84 = v78 - v76
							v74.Rotation = math.atan2(v83, v84) * 57.29577951308232
							v74.Parent = v_u_17
						end
						v_u_45.Parent = v_u_17
						v41 = v_u_45
					end
				end
			end
			v_u_12 = false
		end
	end
	return setmetatable({}, {
		["__index"] = function(_, p85) -- name: __index
			-- upvalues: (copy) v_u_11
			return v_u_11[p85]
		end,
		["__newindex"] = function(_, p86, p87) -- name: __newindex
			-- upvalues: (copy) v_u_11
			if p86 == "Data" and type(p87) == "table" then
				v_u_11.Data = p87
				v_u_11.Render()
				return
			elseif p86 == "Resolution" and type(p87) == "number" then
				v_u_11.Resolution = math.clamp(p87, 3, 500)
				v_u_11.Render()
			elseif p86 == "BaselineZero" and type(p87) == "boolean" then
				v_u_11.BaselineZero = p87
				v_u_11.Render()
			end
		end
	})
end
return v2