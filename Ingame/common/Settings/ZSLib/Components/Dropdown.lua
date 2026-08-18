local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Packages.Fusion)
local v_u_3 = v2.Children
local v_u_4 = v2.OnEvent
local _ = v2.peek
local v_u_5 = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
return function(p_u_6)
	-- upvalues: (copy) v_u_3, (copy) v_u_5, (copy) v_u_4
	local v7 = p_u_6.scope
	local v_u_8 = v7:Value(p_u_6.Default)
	local v9 = p_u_6.Description ~= nil
	local v10 = {}
	for v14, v12 in p_u_6.Options do
		local v13
		if type(v12) == "table" then
			v13 = v12[1]
		else
			v13 = v12
		end
		if type(v12) == "table" then
			local v14 = v12[2]
		end
		local v15 = v7:New("TextButton")
		local v16 = {
			["Name"] = v13,
			["BackgroundTransparency"] = 1,
			["LayoutOrder"] = v14,
			["Size"] = UDim2.fromScale(0.5, 0.14),
			["SizeConstraint"] = Enum.SizeConstraint.RelativeXX,
			[v_u_3] = { v7:New("Frame")({
					["Name"] = "Frame",
					["AnchorPoint"] = Vector2.new(0.5, 0.5),
					["BackgroundColor3"] = Color3.new(1, 1, 1),
					["BackgroundTransparency"] = 0.95,
					["Position"] = UDim2.fromScale(0.5, 0.5),
					["Size"] = UDim2.new(1, 0, 0.8, -6),
					[v_u_3] = { v7:New("UICorner")({
							["CornerRadius"] = UDim.new(0.2, 0)
						}), v7:New("UIStroke")({
							["Color"] = nil,
							["Thickness"] = 3,
							["Color"] = Color3.fromRGB(255, 184, 84)
						}), v7:New("TextLabel")({
							["Name"] = "Label",
							["AnchorPoint"] = nil,
							["BackgroundTransparency"] = 1,
							["FontFace"] = nil,
							["Position"] = nil,
							["Size"] = nil,
							["Text"] = nil,
							["TextColor3"] = nil,
							["TextScaled"] = true,
							["AnchorPoint"] = Vector2.new(0.5, 0.5),
							["FontFace"] = v_u_5,
							["Position"] = UDim2.fromScale(0.5, 0.5),
							["Size"] = UDim2.fromScale(0.9, 0.8),
							["Text"] = v13,
							["TextColor3"] = Color3.fromRGB(255, 184, 84)
						}) }
				}) }
		}
		table.insert(v10, v15(v16))
	end
	local v_u_17 = nil
	v_u_17 = v7:New("ImageButton")({
		["Name"] = "Dropdown",
		["AnchorPoint"] = Vector2.new(1, 1),
		["BackgroundTransparency"] = 1,
		["ClipsDescendants"] = true,
		["Image"] = "rbxassetid://2851928361",
		["ImageColor3"] = Color3.fromRGB(6, 14, 24),
		["ImageTransparency"] = 0.2,
		["Position"] = UDim2.fromScale(1, 1),
		["ScaleType"] = Enum.ScaleType.Slice,
		["Selectable"] = false,
		["Size"] = UDim2.fromScale(1, 1),
		["SliceCenter"] = Rect.new(7, 7, 7, 7),
		["Visible"] = false,
		["ZIndex"] = 2,
		[v_u_3] = { v7:New("ScrollingFrame")({
				["Name"] = "Frame",
				["AnchorPoint"] = Vector2.new(0.5, 0.5),
				["BackgroundTransparency"] = 1,
				["CanvasSize"] = UDim2.new(),
				["ClipsDescendants"] = false,
				["Position"] = UDim2.fromScale(0.5, 0.5),
				["ScrollBarImageColor3"] = Color3.fromRGB(16, 16, 16),
				["ScrollBarThickness"] = 0,
				["ScrollingDirection"] = Enum.ScrollingDirection.Y,
				["Selectable"] = false,
				["Size"] = UDim2.new(1, -5, 1, -5),
				[v_u_3] = { v7:New("UIListLayout")({
						["HorizontalAlignment"] = Enum.HorizontalAlignment.Center,
						["SortOrder"] = Enum.SortOrder.LayoutOrder,
						["VerticalAlignment"] = Enum.VerticalAlignment.Center
					}), table.unpack(v10) }
			}), v7:New("TextButton")({
				["Name"] = "Exit",
				["AnchorPoint"] = Vector2.new(1, 0),
				["BackgroundColor3"] = Color3.fromRGB(50, 17, 17),
				["BackgroundTransparency"] = 0.5,
				["LayoutOrder"] = 1000,
				["Position"] = UDim2.fromScale(0.98, 0.02),
				["Size"] = UDim2.fromScale(0.1, 0.1),
				["SizeConstraint"] = Enum.SizeConstraint.RelativeXX,
				["Text"] = "X",
				["TextColor3"] = Color3.fromRGB(255, 73, 73),
				["TextScaled"] = true,
				["TextTransparency"] = 1,
				[v_u_4("MouseButton1Click")] = function()
					-- upvalues: (copy) p_u_6, (ref) v_u_17
					if p_u_6.ButtonSound then
						p_u_6.ButtonSound:Play()
					end
					v_u_17.Visible = false
				end,
				[v_u_3] = { v7:New("UIStroke")({
						["ApplyStrokeMode"] = nil,
						["Color"] = nil,
						["Thickness"] = 3,
						["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border,
						["Color"] = Color3.fromRGB(255, 73, 73)
					}), v7:New("UICorner")({
						["CornerRadius"] = UDim.new(0.2, 0)
					}), v7:New("TextLabel")({
						["Name"] = "Label",
						["AnchorPoint"] = nil,
						["BackgroundTransparency"] = 1,
						["FontFace"] = nil,
						["Position"] = nil,
						["Size"] = nil,
						["Text"] = "X",
						["TextColor3"] = nil,
						["TextScaled"] = true,
						["AnchorPoint"] = Vector2.new(0.5, 0.5),
						["FontFace"] = v_u_5,
						["Position"] = UDim2.fromScale(0.525, 0.5),
						["Size"] = UDim2.fromScale(0.85, 0.8),
						["TextColor3"] = Color3.fromRGB(255, 73, 73)
					}) }
			}) }
	})
	local v_u_18 = v_u_17
	for v_u_19, v20 in v10 do
		local v_u_21 = p_u_6.Options[v_u_19]
		if type(v_u_21) == "table" then
			v_u_21 = v_u_21[1]
		end
		v20.MouseButton1Click:Connect(function()
			-- upvalues: (copy) p_u_6, (ref) v_u_18, (copy) v_u_8, (copy) v_u_21, (copy) v_u_19
			if p_u_6.ButtonSound then
				p_u_6.ButtonSound:Play()
			end
			v_u_18.Visible = false
			v_u_8:set(v_u_21)
			if p_u_6.OnChanged then
				p_u_6.OnChanged(v_u_19, v_u_21)
			end
		end)
	end
	local v_u_22 = v_u_18:FindFirstChild("Frame")
	local v_u_23 = v_u_22 and v_u_22:FindFirstChildWhichIsA("UIListLayout")
	if v_u_23 then
		v_u_23:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			-- upvalues: (copy) v_u_23, (copy) v_u_22
			local v24 = v_u_23.AbsoluteContentSize.Y
			v_u_22.CanvasSize = UDim2.new(0, 0, 0, v24)
			if v_u_22.AbsoluteSize.Y < v24 then
				v_u_23.VerticalAlignment = Enum.VerticalAlignment.Top
			end
		end)
	end
	local v25 = v7:New("Frame")
	local v26 = {
		["Name"] = "Dropdown",
		["BackgroundTransparency"] = 1,
		["LayoutOrder"] = p_u_6.LayoutOrder or 1
	}
	local v27
	if v9 then
		v27 = UDim2.fromScale(1, 0.11)
	else
		v27 = UDim2.fromScale(1, 0.08)
	end
	v26.Size = v27
	v26.SizeConstraint = Enum.SizeConstraint.RelativeXX
	v26.Visible = p_u_6.Visible == nil and true or p_u_6.Visible
	local v28 = v_u_3
	local v29 = {}
	local v30 = v7:New("Frame")
	local v31 = {
		["Name"] = "Frame",
		["AnchorPoint"] = Vector2.new(0.5, 0.5),
		["BackgroundColor3"] = Color3.new(),
		["BackgroundTransparency"] = 0.8,
		["Position"] = UDim2.fromScale(0.5, 0.5),
		["Size"] = UDim2.fromScale(0.99, 0.85)
	}
	local v32 = v_u_3
	local v33 = {}
	local v34 = v7:New("UICorner")({})
	local v35 = v7:New("ImageButton")({
		["Name"] = "Toggle",
		["AnchorPoint"] = Vector2.new(1, 0.5),
		["BackgroundColor3"] = Color3.new(1, 1, 1),
		["BackgroundTransparency"] = 0.9,
		["Image"] = "rbxassetid://2851928361",
		["ImageColor3"] = Color3.fromRGB(33, 33, 33),
		["ImageTransparency"] = 1,
		["Position"] = UDim2.fromScale(1, 0.5),
		["ScaleType"] = Enum.ScaleType.Slice,
		["Size"] = UDim2.fromScale(0.22, 1),
		["SliceCenter"] = Rect.new(7, 7, 7, 7),
		[v_u_4("MouseButton1Click")] = function()
			-- upvalues: (copy) p_u_6, (ref) v_u_18
			if p_u_6.ButtonSound then
				p_u_6.ButtonSound:Play()
			end
			v_u_18.Visible = true
			if p_u_6.OnDropdownOpened then
				p_u_6.OnDropdownOpened(v_u_18)
			end
		end,
		[v_u_3] = { v7:New("TextLabel")({
				["Name"] = "Label",
				["AnchorPoint"] = nil,
				["BackgroundTransparency"] = 1,
				["FontFace"] = nil,
				["Position"] = nil,
				["Size"] = nil,
				["Text"] = nil,
				["TextColor3"] = nil,
				["TextScaled"] = true,
				["AnchorPoint"] = Vector2.new(0, 0.5),
				["FontFace"] = v_u_5,
				["Position"] = UDim2.fromScale(0.05, 0.5),
				["Size"] = UDim2.fromScale(0.78, 0.6),
				["Text"] = v_u_8,
				["TextColor3"] = Color3.new(1, 1, 1)
			}), v7:New("ImageLabel")({
				["Name"] = "keyboard_arrow_down",
				["AnchorPoint"] = nil,
				["BackgroundTransparency"] = 1,
				["Image"] = "rbxassetid://3926305904",
				["ImageRectOffset"] = nil,
				["ImageRectSize"] = nil,
				["LayoutOrder"] = 19,
				["Position"] = nil,
				["Selectable"] = true,
				["Size"] = nil,
				["SizeConstraint"] = nil,
				["ZIndex"] = 2,
				["AnchorPoint"] = Vector2.new(1, 0.5),
				["ImageRectOffset"] = Vector2.new(404, 284),
				["ImageRectSize"] = Vector2.new(36, 36),
				["Position"] = UDim2.fromScale(1, 0.5),
				["Size"] = UDim2.fromScale(0.2, 0.2),
				["SizeConstraint"] = Enum.SizeConstraint.RelativeXX
			}), v7:New("UICorner")({
				["CornerRadius"] = UDim.new(0.15, 0)
			}) }
	})
	local v36 = v7:New("TextLabel")({
		["Name"] = "Label",
		["BackgroundTransparency"] = 1,
		["FontFace"] = nil,
		["Position"] = nil,
		["Size"] = nil,
		["SizeConstraint"] = nil,
		["Text"] = nil,
		["TextColor3"] = nil,
		["TextScaled"] = true,
		["TextXAlignment"] = nil,
		["FontFace"] = v_u_5,
		["Position"] = UDim2.fromScale(0.01, 0.04),
		["Size"] = UDim2.fromScale(0.76, 0.06),
		["SizeConstraint"] = Enum.SizeConstraint.RelativeXX,
		["Text"] = p_u_6.Text,
		["TextColor3"] = Color3.new(1, 1, 1),
		["TextXAlignment"] = Enum.TextXAlignment.Left
	})
	local v37
	if v9 then
		v37 = v7:New("TextLabel")({
			["Name"] = "DescriptionLabel",
			["AnchorPoint"] = nil,
			["BackgroundTransparency"] = 1,
			["FontFace"] = nil,
			["Position"] = nil,
			["Size"] = nil,
			["SizeConstraint"] = nil,
			["Text"] = nil,
			["TextColor3"] = nil,
			["TextScaled"] = true,
			["TextTransparency"] = 0.5,
			["TextXAlignment"] = nil,
			["AnchorPoint"] = Vector2.new(0, 1),
			["FontFace"] = v_u_5,
			["Position"] = UDim2.fromScale(0.01, 0.96),
			["Size"] = UDim2.fromScale(0.76, 0.05),
			["SizeConstraint"] = Enum.SizeConstraint.RelativeXX,
			["Text"] = p_u_6.Description,
			["TextColor3"] = Color3.new(1, 1, 1),
			["TextXAlignment"] = Enum.TextXAlignment.Left
		})
	else
		v37 = nil
	end
	__set_list(v33, 1, {v34, v35, v36, v37})
	v31[v32] = v33
	__set_list(v29, 1, {v30(v31)})
	v26[v28] = v29
	return v25(v26), v_u_18, v_u_8
end