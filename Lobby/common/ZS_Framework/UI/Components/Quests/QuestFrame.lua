local v1 = game:GetService("ReplicatedStorage")
local _ = require(v1.Packages.Fusion).Children
local v_u_2 = require("../GradientFade")
local v_u_3 = require("./RewardFrame")
local v_u_4 = require("./QuestUIComputed")
return function(p_u_5)
	-- upvalues: (copy) v_u_4, (copy) v_u_3, (copy) v_u_2
	local v6 = p_u_5.scope:innerScope()
	local v8 = v6:Computed(function(p7)
		-- upvalues: (copy) p_u_5
		return UDim.new(0, p7(p_u_5.StrokeSize))
	end)
	local v9, v10 = v_u_4({
		["scope"] = v6,
		["Quest"] = p_u_5.Quest
	})
	local v11 = p_u_5.Quest.IsCompleted and 1000 or -(p_u_5.Quest.Progress.Current / p_u_5.Quest.Progress.Goal * 100)
	if p_u_5.Quest.IsBonus then
		v11 = v11 + 1
	end
	local v12 = v6:New("Frame")
	local v13 = {
		["BackgroundColor3"] = Color3.new(0, 0, 0),
		["BackgroundTransparency"] = 0.5,
		["Size"] = p_u_5.Size,
		["LayoutOrder"] = v11
	}
	local v14 = v6.Children
	local v15 = {}
	local v16 = v6:New("Frame")({
		["Size"] = UDim2.new(1, 0, 1, 0),
		["BackgroundTransparency"] = 0.3,
		["BackgroundColor3"] = Color3.new(0, 0, 0),
		["Visible"] = p_u_5.Quest.IsCompleted,
		["ZIndex"] = 5,
		[v6.Children] = { v6:New("TextLabel")({
				["Text"] = "COMPLETED",
				["TextColor3"] = nil,
				["BackgroundTransparency"] = 1,
				["TextScaled"] = true,
				["Font"] = nil,
				["Size"] = nil,
				["Position"] = nil,
				["AnchorPoint"] = nil,
				["TextColor3"] = Color3.new(0.035294, 1, 0),
				["Font"] = Enum.Font.GothamBlack,
				["Size"] = UDim2.new(0.6, 0, 0.3, 0),
				["Position"] = UDim2.new(0.5, 0, 0.5, 0),
				["AnchorPoint"] = Vector2.new(0.5, 0.5)
			}), v6:New("UICorner")({
				["CornerRadius"] = p_u_5.CornerRadius
			}) }
	})
	local v17 = v6:New("UIPadding")({
		["PaddingTop"] = p_u_5.Padding,
		["PaddingBottom"] = p_u_5.Padding,
		["PaddingLeft"] = p_u_5.Padding,
		["PaddingRight"] = p_u_5.Padding
	})
	local v18 = v6:New("UIStroke")({
		["Thickness"] = p_u_5.StrokeSize,
		["Color"] = v9,
		["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border
	})
	local v19 = v6:New("UICorner")({
		["CornerRadius"] = p_u_5.CornerRadius
	})
	local v20 = v6:New("TextLabel")({
		["Text"] = nil,
		["TextColor3"] = nil,
		["BackgroundTransparency"] = 1,
		["TextScaled"] = true,
		["TextXAlignment"] = nil,
		["TextYAlignment"] = nil,
		["Font"] = nil,
		["Size"] = nil,
		["Text"] = p_u_5.Quest.Title,
		["TextColor3"] = Color3.new(1, 1, 1),
		["TextXAlignment"] = Enum.TextXAlignment.Left,
		["TextYAlignment"] = Enum.TextYAlignment.Top,
		["Font"] = Enum.Font.GothamBold,
		["Size"] = UDim2.new(0.61, 0, 0.35, 0)
	})
	local v22 = v6:New("TextLabel")({
		["Text"] = p_u_5.Quest.Description,
		["TextColor3"] = Color3.new(1, 1, 1),
		["BackgroundTransparency"] = 1,
		["TextScaled"] = true,
		["TextXAlignment"] = Enum.TextXAlignment.Left,
		["TextYAlignment"] = Enum.TextYAlignment.Top,
		["Font"] = Enum.Font.Gotham,
		["Size"] = UDim2.new(0.61, 0, 0.37, 0),
		["Position"] = UDim2.new(0, 0, 0.325, 0),
		[v6.Children] = { v6:New("UITextSizeConstraint")({
				["MaxTextSize"] = v6:Computed(function(p21)
					-- upvalues: (copy) p_u_5
					return p21(p_u_5.px) * 30
				end)
			}) }
	})
	local v23 = v6:New("Frame")({
		["Name"] = "RewardFrame",
		["Size"] = UDim2.new(0.38, 0, 1, 0),
		["Position"] = UDim2.new(1, 0, 0, 0),
		["AnchorPoint"] = Vector2.new(1, 0),
		["BackgroundTransparency"] = 1,
		[v6.Children] = { v_u_3({
				["Size"] = UDim2.new(1, 0, 1, 0),
				["Rewards"] = p_u_5.Quest.Rewards,
				["px"] = p_u_5.px,
				["CornerRadius"] = p_u_5.CornerRadius,
				["StrokeSize"] = p_u_5.StrokeSize,
				["StrokeColor"] = v9,
				["scope"] = v6
			}), v6:New("UIPadding")({
				["PaddingTop"] = v8,
				["PaddingBottom"] = v8,
				["PaddingLeft"] = v8,
				["PaddingRight"] = v8
			}) }
	})
	local v24 = v6:New("Frame")
	local v26 = {
		["Name"] = "ProgressFrame",
		["Size"] = UDim2.new(0.61, 0, 0.25, 0),
		["Position"] = UDim2.new(0, 0, 0.75, 0),
		["BackgroundTransparency"] = 1,
		[v6.Children] = { v6:New("UIPadding")({
				["PaddingTop"] = v8,
				["PaddingBottom"] = v8,
				["PaddingLeft"] = v8,
				["PaddingRight"] = v8
			}), v6:New("Frame")({
				["Size"] = UDim2.new(1, 0, 1, 0),
				["BackgroundColor3"] = Color3.new(0, 0, 0),
				["BackgroundTransparency"] = 0.75,
				[v6.Children] = {
					v6:New("TextLabel")({
						["ZIndex"] = 2,
						["Text"] = p_u_5.Quest.Progress.Current .. " / " .. p_u_5.Quest.Progress.Goal,
						["TextScaled"] = true,
						["Size"] = UDim2.new(1, 0, 0.8, 0),
						["Position"] = UDim2.new(0.5, 0, 0.5, 0),
						["Font"] = Enum.Font.GothamBold,
						["AnchorPoint"] = Vector2.new(0.5, 0.5),
						["BackgroundTransparency"] = 1,
						["TextColor3"] = Color3.new(1, 1, 1),
						[v6.Children] = { v6:New("UIStroke")({
								["Thickness"] = v6:Computed(function(p25)
									-- upvalues: (copy) p_u_5
									return p25(p_u_5.StrokeSize) / 2
								end),
								["Color"] = Color3.fromRGB(0, 0, 0)
							}) }
					}),
					v6:New("UIStroke")({
						["Thickness"] = p_u_5.StrokeSize,
						["Color"] = v9,
						["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border
					}),
					v6:New("UICorner")({
						["CornerRadius"] = p_u_5.CornerRadius
					}),
					v6:New("Frame")({
						["Name"] = "ProgressBar",
						["Size"] = UDim2.new(1, 0, 1, 0),
						["Position"] = UDim2.new(0, 0, 0, 0),
						[v6.Children] = { v_u_2({
								["Rotation"] = 0,
								["MinTransparency"] = nil,
								["MaxTransparency"] = 1,
								["CurrentValue"] = nil,
								["MaxValue"] = nil,
								["scope"] = nil,
								["MinTransparency"] = v10,
								["CurrentValue"] = p_u_5.Quest.Progress.Current,
								["MaxValue"] = p_u_5.Quest.Progress.Goal,
								["scope"] = v6
							}), v6:New("UICorner")({
								["CornerRadius"] = p_u_5.CornerRadius
							}) }
					})
				}
			}) }
	}
	__set_list(v15, 1, {v16, v17, v18, v19, v20, v22, v23, v24(v26)})
	v13[v14] = v15
	return v12(v13)
end