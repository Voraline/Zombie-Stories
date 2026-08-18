local v1 = require("@game/ReplicatedStorage/common/Fusion")
local v_u_2 = v1.New
local v_u_3 = v1.Children
local v_u_4 = v1.OnEvent
local _ = v1.Computed
return function(p5)
	-- upvalues: (copy) v_u_2, (copy) v_u_3, (copy) v_u_4
	local v6 = v_u_2("Frame")
	local v7 = {
		["Name"] = "Buttons",
		["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
		["BackgroundTransparency"] = 1,
		["BorderColor3"] = Color3.fromRGB(0, 0, 0),
		["BorderSizePixel"] = 0,
		["Position"] = UDim2.fromScale(0, -0.4),
		["Size"] = UDim2.fromScale(1, 0.2)
	}
	local v8 = v_u_3
	local v9 = {}
	local v10 = v_u_2("UIGridLayout")({
		["Name"] = "UIGridLayout",
		["CellPadding"] = nil,
		["CellSize"] = nil,
		["SortOrder"] = nil,
		["CellPadding"] = UDim2.new(),
		["CellSize"] = UDim2.fromScale(0.3, 1),
		["SortOrder"] = Enum.SortOrder.LayoutOrder
	})
	local v11 = v_u_2("TextButton")
	local v12 = {
		["Name"] = "Falloff",
		["Text"] = "",
		["AnchorPoint"] = Vector2.new(0, 1),
		["BackgroundColor3"] = Color3.fromRGB(40, 49, 63),
		["BackgroundTransparency"] = 1,
		["BorderColor3"] = Color3.fromRGB(27, 42, 53),
		["BorderSizePixel"] = 0,
		["ClipsDescendants"] = true,
		["Position"] = UDim2.fromScale(0.01, 0.99),
		["Size"] = UDim2.fromScale(0.17, 0.06),
		["SizeConstraint"] = Enum.SizeConstraint.RelativeYY,
		["Visible"] = p5.ButtonVisibility.Falloff,
		["ZIndex"] = 5,
		[v_u_4("MouseButton1Click")] = p5.onFalloff
	}
	local v13 = v_u_3
	local v14 = {}
	local v15 = v_u_2("Frame")
	local v16 = {
		["Name"] = "Frame",
		["AnchorPoint"] = Vector2.new(0.5, 0.5),
		["BackgroundColor3"] = Color3.fromRGB(63, 22, 22),
		["BackgroundTransparency"] = 0.2,
		["BorderColor3"] = Color3.fromRGB(27, 42, 53),
		["Position"] = UDim2.fromScale(0.5, 0.5),
		["Size"] = UDim2.new(1, 0, 1, -5),
		[v_u_3] = {
			v_u_2("Frame")({
				["Name"] = "Point",
				["AnchorPoint"] = nil,
				["BackgroundColor3"] = nil,
				["BackgroundTransparency"] = 1,
				["BorderColor3"] = nil,
				["Position"] = nil,
				["AnchorPoint"] = Vector2.new(0, 0.5),
				["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
				["BorderColor3"] = Color3.fromRGB(27, 42, 53),
				["Position"] = UDim2.fromScale(1, 0.5)
			}),
			v_u_2("TextLabel")({
				["Name"] = "BottomLabel",
				["FontFace"] = nil,
				["Text"] = "FALLOFF",
				["TextColor3"] = nil,
				["TextScaled"] = true,
				["TextSize"] = 14,
				["TextWrapped"] = true,
				["TextXAlignment"] = nil,
				["AnchorPoint"] = nil,
				["BackgroundColor3"] = nil,
				["BackgroundTransparency"] = 1,
				["BorderColor3"] = nil,
				["Position"] = nil,
				["Size"] = nil,
				["ZIndex"] = 6,
				["FontFace"] = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
				["TextColor3"] = Color3.fromRGB(255, 169, 169),
				["TextXAlignment"] = Enum.TextXAlignment.Left,
				["AnchorPoint"] = Vector2.new(0, 0.5),
				["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
				["BorderColor3"] = Color3.fromRGB(27, 42, 53),
				["Position"] = UDim2.fromScale(0.08, 0.5),
				["Size"] = UDim2.fromScale(0.88, 0.9)
			}),
			v_u_2("UIGradient")({
				["Name"] = "UIGradient",
				["Color"] = nil,
				["Rotation"] = 90,
				["Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.536, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)) })
			}),
			v_u_2("UICorner")({
				["Name"] = "UICorner"
			})
		}
	}
	__set_list(v14, 1, {v15(v16)})
	v12[v13] = v14
	__set_list(v9, 1, {v10, v11(v12)})
	v7[v8] = v9
	return v6(v7)
end