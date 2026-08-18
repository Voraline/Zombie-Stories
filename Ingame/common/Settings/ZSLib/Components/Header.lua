local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Packages.Fusion)
local v_u_3 = v2.Children
local v_u_4 = v2.OnEvent
local v_u_5 = v2.peek
local v_u_6 = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
return function(p_u_7)
	-- upvalues: (copy) v_u_3, (copy) v_u_4, (copy) v_u_5, (copy) v_u_6
	local v8 = p_u_7.scope
	local v_u_9 = v8:Value(true)
	local v11 = v8:Spring(v8:Computed(function(p10)
		-- upvalues: (copy) v_u_9
		return p10(v_u_9) and 0 or -90
	end), 25, 1)
	local v12 = v8:New("Frame")
	local v13 = {
		["Name"] = "Header",
		["BackgroundTransparency"] = 1,
		["LayoutOrder"] = p_u_7.LayoutOrder or 1,
		["Size"] = UDim2.fromScale(1, 0.09),
		["SizeConstraint"] = Enum.SizeConstraint.RelativeXX
	}
	local v14 = v_u_3
	local v15 = {}
	local v16 = v8:New("TextButton")
	local v17 = {
		["Name"] = "Frame",
		["AnchorPoint"] = Vector2.new(0.5, 0.5),
		["BackgroundColor3"] = Color3.fromRGB(255, 184, 84),
		["BackgroundTransparency"] = 0.8,
		["Position"] = UDim2.fromScale(0.5, 0.5),
		["Size"] = UDim2.fromScale(0.99, 0.85),
		["Text"] = "",
		[v_u_4("MouseButton1Click")] = function()
			-- upvalues: (copy) p_u_7, (copy) v_u_9, (ref) v_u_5
			if p_u_7.ButtonSound then
				p_u_7.ButtonSound:Play()
			end
			v_u_9:set(not v_u_5(v_u_9))
		end,
		[v_u_3] = { v8:New("UICorner")({}), v8:New("TextLabel")({
				["Name"] = "Label",
				["AnchorPoint"] = nil,
				["BackgroundTransparency"] = 1,
				["FontFace"] = nil,
				["Position"] = nil,
				["Size"] = nil,
				["Text"] = nil,
				["TextColor3"] = nil,
				["TextScaled"] = true,
				["TextXAlignment"] = nil,
				["AnchorPoint"] = Vector2.new(0, 0.5),
				["FontFace"] = v_u_6,
				["Position"] = UDim2.fromScale(0.05, 0.5),
				["Size"] = UDim2.fromScale(0.8, 0.9),
				["Text"] = p_u_7.Text,
				["TextColor3"] = Color3.new(1, 1, 1),
				["TextXAlignment"] = Enum.TextXAlignment.Left
			}), v8:New("ImageLabel")({
				["Name"] = "Arrow",
				["AnchorPoint"] = nil,
				["BackgroundTransparency"] = 1,
				["Image"] = "rbxassetid://3926305904",
				["ImageColor3"] = nil,
				["ImageRectOffset"] = nil,
				["ImageRectSize"] = nil,
				["Position"] = nil,
				["Size"] = nil,
				["SizeConstraint"] = nil,
				["Rotation"] = nil,
				["AnchorPoint"] = Vector2.new(1, 0.5),
				["ImageColor3"] = Color3.fromRGB(255, 184, 84),
				["ImageRectOffset"] = Vector2.new(404, 284),
				["ImageRectSize"] = Vector2.new(36, 36),
				["Position"] = UDim2.fromScale(0.97, 0.5),
				["Size"] = UDim2.fromScale(0.06, 0.06),
				["SizeConstraint"] = Enum.SizeConstraint.RelativeXX,
				["Rotation"] = v11
			}) }
	}
	__set_list(v15, 1, {v16(v17)})
	v13[v14] = v15
	return v12(v13), v_u_9
end