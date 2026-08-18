local v1 = game:GetService("ReplicatedStorage")
require(v1.Packages.Fusion)
local v_u_2 = require("./GenericExitButton")
local v_u_3 = require("./GenericButton")
return function(p_u_4)
	-- upvalues: (copy) v_u_3, (copy) v_u_2
	local v5 = p_u_4.scope
	local v_u_6 = v5:usePx()(1)
	local v_u_9 = v5:Computed(function(p7)
		-- upvalues: (copy) v_u_6
		local v8 = p7(v_u_6)
		return UDim.new(0, v8 * 8)
	end)
	local v_u_10 = v5:New("Sound")({
		["SoundId"] = "rbxassetid://1852347417",
		["Volume"] = 0.5
	})
	local v_u_11, v12
	if p_u_4.NavigationBar then
		local v_u_15 = v5:Computed(function(p13)
			-- upvalues: (copy) v_u_6
			local v14 = p13(v_u_6) * 2 * 2
			return UDim2.new(1, -v14, 0.125, -v14)
		end)
		local v33 = v5:ForPairs(p_u_4.NavigationBar.List, function(_, p16, p_u_17, p18)
			-- upvalues: (copy) p_u_4, (ref) v_u_3, (copy) v_u_15, (copy) v_u_10, (copy) v_u_9
			local v_u_20 = p16:Computed(function(p19)
				-- upvalues: (ref) p_u_4, (copy) p_u_17
				return p19(p_u_4.NavigationBar.Selected) == p_u_17
			end)
			local v21 = v_u_3
			local v23 = {
				["scope"] = nil,
				["Size"] = nil,
				["LayoutOrder"] = nil,
				["BackgroundTransparency"] = 0,
				["Text"] = "",
				["TextScaled"] = true,
				["Font"] = nil,
				["BackgroundColor3"] = nil,
				["OnClick"] = nil,
				["Children"] = nil,
				["scope"] = p16,
				["Size"] = v_u_15,
				["LayoutOrder"] = p18.LayoutOrder,
				["Font"] = Enum.Font.GothamBold,
				["BackgroundColor3"] = p16:Computed(function(p22)
					-- upvalues: (copy) v_u_20
					if p22(v_u_20) then
						return Color3.fromRGB(255, 255, 255)
					else
						return Color3.fromRGB(126, 126, 126)
					end
				end),
				["OnClick"] = function() -- name: OnClick
					-- upvalues: (ref) v_u_10, (ref) p_u_4, (copy) p_u_17
					v_u_10:Play()
					p_u_4.NavigationBar.OnClick(p_u_17)
				end
			}
			local v24 = {}
			local v26 = p16:New("TextLabel")({
				["Text"] = nil,
				["TextColor3"] = nil,
				["BackgroundTransparency"] = 1,
				["Size"] = nil,
				["Position"] = nil,
				["AnchorPoint"] = nil,
				["TextScaled"] = true,
				["Font"] = nil,
				["Text"] = p_u_17:upper(),
				["TextColor3"] = p16:Computed(function(p25)
					-- upvalues: (copy) v_u_20
					if p25(v_u_20) then
						return Color3.fromRGB(255, 255, 255)
					else
						return Color3.fromRGB(172, 172, 172)
					end
				end),
				["Size"] = UDim2.new(0.85, 0, 0.8, 0),
				["Position"] = UDim2.new(0.5, 0, 0.5, 0),
				["AnchorPoint"] = Vector2.new(0.5, 0.5),
				["Font"] = Enum.Font.GothamBold
			})
			local v27 = p16:New("UIGradient")({
				["Color"] = nil,
				["Rotation"] = 90,
				["Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 7, 112)), ColorSequenceKeypoint.new(1, Color3.fromRGB(7, 0, 70)) })
			})
			local v28 = {
				["CornerRadius"] = v_u_9
			}
			local v29 = p16:New("UICorner")(v28)
			local v30 = p16:New("UIStroke")
			local v32 = {
				["Color"] = p16:Spring(p16:Computed(function(p31)
					-- upvalues: (copy) v_u_20
					if p31(v_u_20) then
						return Color3.fromRGB(211, 211, 211)
					else
						return Color3.fromRGB(134, 134, 134)
					end
				end), 30, 1),
				["Thickness"] = 2,
				["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border,
				[p16.Children] = { p16:New("UIGradient")({
						["Color"] = nil,
						["Rotation"] = 90,
						["Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 7, 112)), ColorSequenceKeypoint.new(1, Color3.fromRGB(7, 0, 70)) })
					}) }
			}
			__set_list(v24, 1, {v26, v27, v29, v30(v32)})
			v23.Children = v24
			return p_u_17, v21(v23)
		end)
		local v35 = v5:Computed(function(p34)
			-- upvalues: (copy) v_u_6
			return UDim.new(0, p34(v_u_6) * 2)
		end)
		v_u_11 = p_u_4.NavigationBar.Width
		local v36 = v5:New("Frame")
		local v39 = {
			["Size"] = UDim2.new(p_u_4.NavigationBar.Width, 0, 1, 0),
			["Position"] = UDim2.new(0, 0, 0, 0),
			["BackgroundTransparency"] = 1,
			["LayoutOrder"] = 1,
			[v5.Children] = { v5:New("UIPadding")({
					["PaddingTop"] = v35,
					["PaddingLeft"] = v35,
					["PaddingRight"] = v35,
					["PaddingBottom"] = v35
				}), v5:New("UIListLayout")({
					["FillDirection"] = Enum.FillDirection.Vertical,
					["HorizontalAlignment"] = Enum.HorizontalAlignment.Center,
					["SortOrder"] = Enum.SortOrder.LayoutOrder,
					["VerticalAlignment"] = Enum.VerticalAlignment.Top,
					["Padding"] = v5:Computed(function(p37)
						-- upvalues: (copy) v_u_6
						local v38 = p37(v_u_6)
						return UDim.new(0, v38 * 7.5 + p37(v_u_6) * 2 * 4)
					end)
				}), v33 }
		}
		v12 = v36(v39)
	else
		v12 = nil
		v_u_11 = 0
	end
	local v40 = v5:New("Frame")
	local v41 = {
		["Parent"] = p_u_4.Parent,
		["Size"] = p_u_4.Size,
		["Position"] = p_u_4.Position,
		["AnchorPoint"] = p_u_4.AnchorPoint,
		["BackgroundTransparency"] = 1
	}
	local v42 = v5.Children
	local v43 = {}
	local v44 = v5:New("UIAspectRatioConstraint")({
		["AspectRatio"] = p_u_4.AspectRatio
	})
	local v45 = v5:New("UIListLayout")({})
	local v46 = v5:New("Frame")
	local v47 = {
		["BackgroundTransparency"] = 1,
		["Size"] = UDim2.new(1, 0, 1, 0),
		["LayoutOrder"] = 2
	}
	local v48 = v5.Children
	local v49 = {}
	local v50 = v5:New("UIListLayout")({
		["FillDirection"] = Enum.FillDirection.Vertical,
		["SortOrder"] = Enum.SortOrder.LayoutOrder,
		["VerticalFlex"] = Enum.UIFlexAlignment.SpaceBetween
	})
	local v51 = v5:New("Frame")
	local v54 = {
		["Name"] = "TitleFrame",
		["Size"] = v5:Computed(function(p52)
			-- upvalues: (copy) v_u_6
			local v53 = p52(v_u_6)
			return UDim2.new(1, 0, 0, v53 * 80)
		end),
		["LayoutOrder"] = 1
	}
	local v55 = v5.Children
	local v56 = {}
	local v57 = v_u_2
	local v62 = {
		["scope"] = nil,
		["OnClick"] = nil,
		["BackgroundTransparency"] = 0,
		["Position"] = nil,
		["AnchorPoint"] = nil,
		["Size"] = nil,
		["Children"] = nil,
		["scope"] = v5,
		["OnClick"] = p_u_4.OnClickClose,
		["Position"] = v5:Computed(function(p58)
			-- upvalues: (copy) v_u_6
			local v59 = p58(v_u_6)
			return UDim2.new(1, -v59 * 7.5, 0.5, 0)
		end),
		["AnchorPoint"] = Vector2.new(1, 0.5),
		["Size"] = v5:Computed(function(p60)
			-- upvalues: (copy) v_u_6
			local v61 = p60(v_u_6)
			return UDim2.new(0.1, 0, 1, -v61 * 7.5 * 2)
		end),
		["Children"] = { v5:New("UICorner")({
				["CornerRadius"] = v_u_9
			}) }
	}
	__set_list(v56, 1, {v57(v62), v5:New("TextLabel")({
	["Text"] = nil,
	["TextColor3"] = nil,
	["BackgroundTransparency"] = 1,
	["Size"] = nil,
	["Position"] = nil,
	["AnchorPoint"] = nil,
	["TextXAlignment"] = nil,
	["TextScaled"] = true,
	["Font"] = nil,
	["Text"] = p_u_4.Title,
	["TextColor3"] = Color3.fromRGB(255, 255, 255),
	["Size"] = UDim2.new(0.45, 0, 0.75, 0),
	["Position"] = UDim2.new(0.02, 0, 0.5, 0),
	["AnchorPoint"] = Vector2.new(0, 0.5),
	["TextXAlignment"] = Enum.TextXAlignment.Left,
	["Font"] = Enum.Font.GothamBlack
}), v5:New("UIGradient")({
	["Color"] = nil,
	["Rotation"] = 90,
	["Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 7, 112)), ColorSequenceKeypoint.new(1, Color3.fromRGB(7, 0, 70)) })
}), v5:New("UICorner")({
	["CornerRadius"] = v_u_9
})})
	v54[v55] = v56
	local v63 = v51(v54)
	local v64 = v5:New("Frame")
	local v67 = {
		["Name"] = "BottomFrame",
		["Size"] = v5:Computed(function(p65)
			-- upvalues: (copy) v_u_6
			local v66 = p65(v_u_6)
			return UDim2.new(1, 0, 1, -v66 * 90)
		end),
		["LayoutOrder"] = 2,
		["BackgroundTransparency"] = 1
	}
	local v68 = v5.Children
	local v69 = {}
	local v70 = v5:New("UIListLayout")({
		["FillDirection"] = Enum.FillDirection.Horizontal,
		["SortOrder"] = Enum.SortOrder.LayoutOrder,
		["HorizontalFlex"] = Enum.UIFlexAlignment.SpaceBetween
	})
	local v71 = v5:New("Frame")
	local v75 = {
		["Name"] = "ContentFrame",
		["Size"] = v5:Computed(function(p72)
			-- upvalues: (copy) v_u_6, (ref) v_u_11
			local v73 = p72(v_u_6)
			local v74 = v_u_11 == 0 and 0 or v73 * 7.5
			return UDim2.new(1 - v_u_11, -v74, 1, 0)
		end),
		["LayoutOrder"] = 2,
		["BackgroundTransparency"] = 0,
		[v5.Children] = { p_u_4.ContentChildren, v5:New("UIGradient")({
				["Color"] = nil,
				["Rotation"] = 90,
				["Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 7, 112)), ColorSequenceKeypoint.new(1, Color3.fromRGB(7, 0, 70)) })
			}), v5:New("UICorner")({
				["CornerRadius"] = v_u_9
			}) }
	}
	__set_list(v69, 1, {v70, v12, v71(v75)})
	v67[v68] = v69
	__set_list(v49, 1, {v50, v63, v64(v67)})
	v47[v48] = v49
	__set_list(v43, 1, {v_u_10, v44, v45, v46(v47)})
	v41[v42] = v43
	return v40(v41)
end