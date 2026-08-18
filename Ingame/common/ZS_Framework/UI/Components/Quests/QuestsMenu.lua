local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
require(v1.Packages.Fusion)
local v_u_3 = require("../MenuBase")
local v_u_4 = require("./QuestFrame")
return function(p5)
	-- upvalues: (copy) v_u_2, (copy) v_u_4, (copy) v_u_3
	local v_u_6 = p5.scope
	local v_u_7 = p5.QuestCategories
	local v_u_8 = v_u_6:Value("")
	local v9 = (1 / 0)
	local v10 = {}
	for v11, v12 in v_u_7 do
		if v12.LayoutOrder < v9 then
			v9 = v12.LayoutOrder
			v_u_8:set(v11)
		end
		v10[v11] = {
			["LayoutOrder"] = v12.LayoutOrder
		}
	end
	local v_u_13 = v_u_6:usePx()(1)
	local v_u_15 = v_u_6:Computed(function(p14)
		-- upvalues: (copy) v_u_13
		return UDim.new(0, p14(v_u_13) * 6)
	end)
	local v_u_17 = v_u_6:Computed(function(p16)
		-- upvalues: (copy) v_u_8, (copy) v_u_7
		return v_u_7[p16(v_u_8)] or {}
	end)
	local v19 = v_u_6:Computed(function(p18)
		-- upvalues: (copy) v_u_17
		return p18(v_u_17).List or {}
	end)
	local v_u_21 = v_u_6:Computed(function(p20)
		-- upvalues: (copy) v_u_13
		return p20(v_u_13) * 2
	end)
	local v_u_22 = v_u_6:Value(Vector2.new(0, 0))
	local v_u_25 = v_u_6:Computed(function(p23)
		-- upvalues: (copy) v_u_22
		local v24 = p23(v_u_22).X
		return UDim2.new(1, 0, 0, v24 * 0.135)
	end)
	local v_u_27 = v_u_6:Computed(function(p26)
		-- upvalues: (copy) v_u_13
		return UDim.new(0, p26(v_u_13) * 6)
	end)
	local v_u_29 = v_u_6:Computed(function(p28)
		-- upvalues: (copy) v_u_17
		return p28(v_u_17).NextReset or 0
	end)
	local v_u_30 = v_u_6:Value(0)
	local v33 = v_u_2.Heartbeat:Connect(function(_)
		-- upvalues: (copy) v_u_6, (copy) v_u_29, (copy) v_u_30
		local v31 = os.time()
		local v32 = v_u_6.peek(v_u_29) - v31
		v_u_30:set((math.max(0, v32)))
	end)
	table.insert(v_u_6, v33)
	local v37 = v_u_6:ForPairs(v19, function(_, p34, p35, p36)
		-- upvalues: (ref) v_u_4, (copy) v_u_25, (copy) v_u_15, (copy) v_u_21, (copy) v_u_27, (copy) v_u_13
		return p35, v_u_4({
			["Size"] = v_u_25,
			["CornerRadius"] = v_u_15,
			["StrokeSize"] = v_u_21,
			["Padding"] = v_u_27,
			["Quest"] = p36,
			["QuestKey"] = p35,
			["px"] = v_u_13,
			["scope"] = p34
		})
	end)
	local v_u_38 = v_u_6:Value(Vector2.new(0, 0))
	local v41 = v_u_6:Computed(function(p39)
		-- upvalues: (copy) v_u_13
		local v40 = p39(v_u_13)
		return UDim.new(0, v40 * 6 + 2 * v40)
	end)
	local v42 = v_u_3
	local v45 = {
		["Parent"] = nil,
		["Size"] = nil,
		["Position"] = nil,
		["AnchorPoint"] = nil,
		["Title"] = nil,
		["AspectRatio"] = 1.8,
		["scope"] = nil,
		["OnClickClose"] = nil,
		["NavigationBar"] = nil,
		["ContentChildren"] = nil,
		["Parent"] = p5.Parent,
		["Size"] = UDim2.new(0.8, 0, 0.8, 0),
		["Position"] = UDim2.new(0.5, 0, 0.5, 0),
		["AnchorPoint"] = Vector2.new(0.5, 0.5),
		["Title"] = v_u_6:Computed(function(p43)
			-- upvalues: (copy) v_u_8
			return (p43(v_u_8) .. " Quests"):upper()
		end),
		["scope"] = v_u_6,
		["OnClickClose"] = p5.OnClickClose,
		["NavigationBar"] = {
			["List"] = nil,
			["Width"] = 0.225,
			["Selected"] = nil,
			["OnClick"] = nil,
			["List"] = v10,
			["Selected"] = v_u_8,
			["OnClick"] = function(p44) -- name: OnClick
				-- upvalues: (copy) v_u_8
				v_u_8:set(p44)
			end
		}
	}
	local v46 = {}
	local v47 = v_u_6:New("Frame")
	local v48 = {
		["Size"] = UDim2.new(1, 0, 1, 0),
		["BackgroundTransparency"] = 1
	}
	local v49 = v_u_6.Children
	local v50 = {}
	local v55 = v_u_6:New("UIPadding")({
		["PaddingRight"] = v_u_6:Computed(function(p51)
			-- upvalues: (copy) v_u_13
			return UDim.new(0, p51(v_u_13) * 6)
		end),
		["PaddingLeft"] = v_u_6:Computed(function(p52)
			-- upvalues: (copy) v_u_13
			return UDim.new(0, p52(v_u_13) * 6)
		end),
		["PaddingTop"] = v_u_6:Computed(function(p53)
			-- upvalues: (copy) v_u_13
			return UDim.new(0, p53(v_u_13) * 6)
		end),
		["PaddingBottom"] = v_u_6:Computed(function(p54)
			-- upvalues: (copy) v_u_13
			return UDim.new(0, p54(v_u_13) * 6)
		end)
	})
	local v65 = v_u_6:New("TextLabel")({
		["Text"] = nil,
		["Position"] = nil,
		["AnchorPoint"] = nil,
		["TextColor3"] = nil,
		["FontFace"] = nil,
		["Size"] = nil,
		["BackgroundTransparency"] = 1,
		["TextXAlignment"] = nil,
		["TextScaled"] = true,
		["Text"] = v_u_6:Computed(function(p56)
			-- upvalues: (copy) v_u_30
			local v57 = p56(v_u_30)
			local v58 = v57 / 86400
			local v59 = math.floor(v58)
			local v60 = v57 % 86400 / 3600
			local v61 = math.floor(v60)
			local v62 = v57 % 3600 / 60
			local v63 = math.floor(v62)
			local v64 = v57 % 60
			if v59 > 0 then
				return string.format("Resets In %dd %02d:%02d:%02d", v59, v61, v63, v64)
			else
				return string.format("Resets In %02d:%02d:%02d", v61, v63, v64)
			end
		end),
		["Position"] = UDim2.new(1, 0, 1.01, 0),
		["AnchorPoint"] = Vector2.new(1, 0),
		["TextColor3"] = Color3.new(1, 1, 1),
		["FontFace"] = Font.new("rbxasset://fonts/families/RobotoMono.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
		["Size"] = UDim2.new(0.8, 0, 0.075, 0),
		["TextXAlignment"] = Enum.TextXAlignment.Right
	})
	local v66 = v_u_6:New("ScrollingFrame")
	local v72 = {
		["Size"] = UDim2.new(1, 0, 1, 0),
		["CanvasSize"] = v_u_6:Computed(function(p67)
			-- upvalues: (copy) v_u_38, (copy) v_u_13
			local v68 = p67(v_u_38)
			local v69 = p67(v_u_13)
			return UDim2.new(0, 0, 0, v68.Y + v69 * 25)
		end),
		["BackgroundTransparency"] = 1,
		["ScrollBarThickness"] = 8,
		["VerticalScrollBarInset"] = Enum.ScrollBarInset.ScrollBar,
		[v_u_6.Out("AbsoluteSize")] = v_u_22,
		[v_u_6.Children] = { v_u_6:New("UIPadding")({
				["PaddingRight"] = v41,
				["PaddingTop"] = v41,
				["PaddingBottom"] = v41,
				["PaddingLeft"] = v41
			}), v_u_6:New("UIListLayout")({
				["Padding"] = v_u_6:Computed(function(p70)
					-- upvalues: (copy) v_u_13
					local v71 = p70(v_u_13)
					return UDim.new(0, v71 * 8 + v71 * 2 * 3)
				end),
				["SortOrder"] = Enum.SortOrder.LayoutOrder,
				[v_u_6.Out("AbsoluteContentSize")] = v_u_38
			}), v37 }
	}
	__set_list(v50, 1, {v55, v65, v66(v72)})
	v48[v49] = v50
	__set_list(v46, 1, {v47(v48)})
	v45.ContentChildren = v46
	return v42(v45)
end