local v_u_1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v4 = v2.Packages
local v5 = require(v4.Fusion)
local v_u_6 = v5.Children
local v_u_7 = v5.OnEvent
local v_u_8 = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
local v_u_9 = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic)
local v_u_10 = Color3.fromRGB(35, 61, 80)
local v_u_11 = TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local v_u_12 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local v_u_13 = UDim2.fromScale(0.5, 0.5)
local v_u_14 = UDim2.fromScale(0.5, 1.5)
return function(p15)
	-- upvalues: (copy) v_u_3, (copy) v_u_12, (copy) v_u_14, (copy) v_u_6, (copy) v_u_8, (copy) v_u_9, (copy) v_u_7, (copy) v_u_10, (copy) v_u_1, (copy) v_u_11, (copy) v_u_13
	local v_u_16 = p15:innerScope()
	local v_u_17 = v_u_16:Value(false)
	local v_u_18 = v_u_16:Value("")
	local v_u_19 = v_u_16:Value("")
	local v_u_20 = nil
	local v_u_21 = nil
	local function v_u_23() -- name: dismiss
		-- upvalues: (ref) v_u_3, (ref) v_u_21, (ref) v_u_12, (ref) v_u_14, (copy) v_u_17, (ref) v_u_20
		local v22 = v_u_3:Create(v_u_21, v_u_12, {
			["Position"] = v_u_14
		})
		v22:Play()
		v22.Completed:Once(function()
			-- upvalues: (ref) v_u_17
			v_u_17:set(false)
		end)
		v_u_20 = nil
	end
	local v24 = v_u_16:New("Frame")
	local v25 = {
		["Name"] = "MainFrame",
		["AnchorPoint"] = Vector2.new(0.5, 0.5),
		["BackgroundColor3"] = Color3.fromRGB(35, 61, 80),
		["Position"] = v_u_14,
		["Size"] = UDim2.fromScale(0.28, 0.32)
	}
	local v26 = v_u_6
	local v27 = {}
	local v28 = v_u_16:New("UICorner")({
		["CornerRadius"] = UDim.new(0.04, 0)
	})
	local v29 = v_u_16:New("UISizeConstraint")({
		["MinSize"] = Vector2.new(320, 180),
		["MaxSize"] = Vector2.new(500, 320)
	})
	local v30 = v_u_16:New("UIStroke")({
		["ApplyStrokeMode"] = nil,
		["Thickness"] = 5,
		["Transparency"] = 0.6,
		["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border
	})
	local v31 = v_u_16:New("UIGradient")({
		["Color"] = nil,
		["Rotation"] = 100,
		["Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(126, 126, 126)) })
	})
	local v32 = v_u_16:New("UIPadding")({
		["PaddingTop"] = UDim.new(0.04, 0),
		["PaddingBottom"] = UDim.new(0.05, 0),
		["PaddingLeft"] = UDim.new(0.05, 0),
		["PaddingRight"] = UDim.new(0.05, 0)
	})
	local v33 = v_u_16:New("UIListLayout")({
		["SortOrder"] = Enum.SortOrder.LayoutOrder,
		["FillDirection"] = Enum.FillDirection.Vertical,
		["HorizontalAlignment"] = Enum.HorizontalAlignment.Center,
		["VerticalAlignment"] = Enum.VerticalAlignment.Center,
		["Padding"] = UDim.new(0.03, 0)
	})
	local v34 = v_u_16:New("TextLabel")({
		["Name"] = "Title",
		["FontFace"] = nil,
		["Text"] = nil,
		["TextColor3"] = nil,
		["TextScaled"] = true,
		["TextWrapped"] = true,
		["AutomaticSize"] = nil,
		["BackgroundTransparency"] = 1,
		["LayoutOrder"] = 1,
		["Size"] = nil,
		["ZIndex"] = 5,
		["FontFace"] = v_u_8,
		["Text"] = v_u_18,
		["TextColor3"] = Color3.new(1, 1, 1),
		["AutomaticSize"] = Enum.AutomaticSize.None,
		["Size"] = UDim2.fromScale(0.9, 0.22)
	})
	local v35 = v_u_16:New("TextLabel")({
		["Name"] = "Message",
		["FontFace"] = nil,
		["Text"] = nil,
		["TextColor3"] = nil,
		["TextScaled"] = true,
		["TextWrapped"] = true,
		["AutomaticSize"] = nil,
		["BackgroundTransparency"] = 1,
		["LayoutOrder"] = 2,
		["Size"] = nil,
		["ZIndex"] = 5,
		["FontFace"] = v_u_9,
		["Text"] = v_u_19,
		["TextColor3"] = Color3.fromRGB(200, 200, 200),
		["AutomaticSize"] = Enum.AutomaticSize.None,
		["Size"] = UDim2.fromScale(0.95, 0.3)
	})
	local v36 = v_u_16:New("Frame")
	local v37 = {
		["Name"] = "ButtonRow",
		["BackgroundTransparency"] = 1,
		["LayoutOrder"] = 3,
		["Size"] = UDim2.fromScale(0.9, 0.3)
	}
	local v38 = v_u_6
	local v39 = {}
	local v40 = v_u_16:New("UIListLayout")({
		["FillDirection"] = Enum.FillDirection.Horizontal,
		["HorizontalAlignment"] = Enum.HorizontalAlignment.Center,
		["VerticalAlignment"] = Enum.VerticalAlignment.Center,
		["Padding"] = UDim.new(0.04, 0),
		["HorizontalFlex"] = Enum.UIFlexAlignment.SpaceEvenly
	})
	local v41 = v_u_16:New("TextButton")
	local v43 = {
		["Name"] = "Yes",
		["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
		["Text"] = "",
		["TextColor3"] = Color3.new(),
		["TextSize"] = 14,
		["BackgroundColor3"] = Color3.fromRGB(164, 255, 157),
		["ClipsDescendants"] = true,
		["LayoutOrder"] = 1,
		["Size"] = UDim2.fromScale(0.43, 0.85),
		["ZIndex"] = 5,
		[v_u_7("Activated")] = function()
			-- upvalues: (ref) v_u_20, (copy) v_u_23
			local v42 = v_u_20
			v_u_23()
			if v42 then
				v42()
			end
		end,
		[v_u_6] = { v_u_16:New("TextLabel")({
				["FontFace"] = nil,
				["Text"] = "YES",
				["TextColor3"] = nil,
				["TextScaled"] = true,
				["TextWrapped"] = true,
				["BackgroundTransparency"] = 1,
				["Position"] = nil,
				["Size"] = nil,
				["ZIndex"] = 25,
				["FontFace"] = v_u_8,
				["TextColor3"] = v_u_10,
				["Position"] = UDim2.fromScale(0, 0.1),
				["Size"] = UDim2.fromScale(1, 0.8)
			}), v_u_16:New("UICorner")({
				["CornerRadius"] = UDim.new(0.25, 0)
			}) }
	}
	local v44 = v41(v43)
	local v45 = v_u_16:New("TextButton")
	local v46 = {
		["Name"] = "No",
		["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
		["Text"] = "",
		["TextColor3"] = Color3.new(),
		["TextSize"] = 14,
		["BackgroundColor3"] = Color3.fromRGB(255, 152, 152),
		["ClipsDescendants"] = true,
		["LayoutOrder"] = 2,
		["Size"] = UDim2.fromScale(0.43, 0.85),
		["ZIndex"] = 5,
		[v_u_7("Activated")] = function()
			-- upvalues: (copy) v_u_23
			v_u_23()
		end,
		[v_u_6] = { v_u_16:New("TextLabel")({
				["FontFace"] = nil,
				["Text"] = "NO",
				["TextColor3"] = nil,
				["TextScaled"] = true,
				["TextWrapped"] = true,
				["BackgroundTransparency"] = 1,
				["Position"] = nil,
				["Size"] = nil,
				["ZIndex"] = 25,
				["FontFace"] = v_u_8,
				["TextColor3"] = v_u_10,
				["Position"] = UDim2.fromScale(0, 0.1),
				["Size"] = UDim2.fromScale(1, 0.8)
			}), v_u_16:New("UICorner")({
				["CornerRadius"] = UDim.new(0.25, 0)
			}) }
	}
	__set_list(v39, 1, {v40, v44, v45(v46)})
	v37[v38] = v39
	__set_list(v27, 1, {v28, v29, v30, v31, v32, v33, v34, v35, v36(v37)})
	v25[v26] = v27
	v_u_21 = v24(v25)
	local v47 = v_u_16:New("ScreenGui")
	local v48 = {
		["Name"] = "ConfirmationDialog",
		["Parent"] = v_u_1.LocalPlayer:WaitForChild("PlayerGui"),
		["DisplayOrder"] = 25,
		["IgnoreGuiInset"] = true,
		["ResetOnSpawn"] = false,
		["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling,
		["Enabled"] = v_u_17
	}
	local v49 = v_u_6
	local v50 = {}
	local v51 = v_u_16:New("Frame")
	local v52 = {
		["Name"] = "TopFrame",
		["BackgroundColor3"] = Color3.new(1, 1, 1),
		["BackgroundTransparency"] = 1,
		["BorderSizePixel"] = 0,
		["Size"] = UDim2.fromScale(1, 1),
		[v_u_6] = { v_u_16:New("UIGradient")({
				["Color"] = nil,
				["Rotation"] = 90,
				["Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(5, 24, 40)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(11, 52, 86)), ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 24, 40)) })
			}) }
	}
	__set_list(v50, 1, {v51(v52), v_u_21})
	v48[v49] = v50
	v47(v48)
	return {
		["show"] = function(_, p53, p54, p55) -- name: show
			-- upvalues: (copy) v_u_18, (copy) v_u_19, (ref) v_u_20, (ref) v_u_21, (ref) v_u_14, (copy) v_u_17, (ref) v_u_3, (ref) v_u_11, (ref) v_u_13
			v_u_18:set(p53)
			v_u_19:set(p54)
			v_u_20 = p55
			v_u_21.Position = v_u_14
			v_u_17:set(true)
			v_u_3:Create(v_u_21, v_u_11, {
				["Position"] = v_u_13
			}):Play()
		end,
		["destroy"] = function(_) -- name: destroy
			-- upvalues: (copy) v_u_16
			v_u_16:doCleanup()
		end
	}
end