local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("UserInputService")
local v_u_3 = require(script.Parent)
local v_u_4 = v_u_3.BlockType
local v5 = require(v1.common:FindFirstChild("Fusion", true))
local v_u_6 = v5.New
local v_u_7 = v5.Children
local v_u_8 = v5.OnEvent
local v_u_9 = v5.OnChange
local _ = v5.Out
local _ = v5.Ref
local v_u_10 = v5.Value
local _ = v5.Observer
local v_u_11 = v5.Computed
local v_u_12 = v5.ForPairs
local _ = v5.Spring
local v_u_13 = require("@self/theme")
v_u_13.init(v_u_10("Nord"))
local v_u_14 = require("@self/getImageId")
local v_u_15 = require("@self/getRichTextSize")
local v_u_16 = require("@self/highlight")
local function v_u_20(p17, _, p18) -- name: setTrueImage
	-- upvalues: (copy) v_u_14
	task.wait(math.random(0, 70) / 100)
	local v19 = v_u_14(p18 or "rbxassetid://6266306999")
	if v19 then
		p17:set(v19)
	end
end
local v_u_21 = {}
v_u_21.BlockToGui = {
	[v_u_4.Paragraph] = function(p22, p23, p24)
		-- upvalues: (copy) v_u_6, (copy) v_u_7, (copy) v_u_13, (copy) v_u_11
		local v25 = v_u_6("Frame")
		local v26 = {
			["Name"] = p23,
			["LayoutOrder"] = p23,
			["BackgroundTransparency"] = 1,
			["Size"] = UDim2.fromScale(1, 0),
			["AutomaticSize"] = Enum.AutomaticSize.Y,
			["ZIndex"] = p24,
			[v_u_7] = { v_u_6("TextLabel")({
					["RichText"] = true,
					["Font"] = nil,
					["TextColor3"] = nil,
					["BackgroundTransparency"] = 1,
					["TextXAlignment"] = nil,
					["TextYAlignment"] = nil,
					["TextWrapped"] = true,
					["AutomaticSize"] = nil,
					["Size"] = nil,
					["Position"] = nil,
					["ZIndex"] = nil,
					["Text"] = nil,
					["TextSize"] = nil,
					["Font"] = Enum.Font.SourceSans,
					["TextColor3"] = v_u_13.mainText,
					["TextXAlignment"] = Enum.TextXAlignment.Left,
					["TextYAlignment"] = Enum.TextYAlignment.Top,
					["AutomaticSize"] = Enum.AutomaticSize.Y,
					["Size"] = v_u_11(function()
						-- upvalues: (ref) v_u_13
						return UDim2.new(1, -v_u_13.textSize:get(), 0, 0)
					end),
					["Position"] = v_u_11(function()
						-- upvalues: (ref) v_u_13
						return UDim2.new(0, v_u_13.textSize:get(), 0, 0)
					end),
					["ZIndex"] = p24,
					["Text"] = p22.Text,
					["TextSize"] = v_u_13.textSize
				}) }
		}
		return v25(v26)
	end,
	[v_u_4.Heading] = function(p_u_27, p28, p29)
		-- upvalues: (copy) v_u_6, (copy) v_u_7, (copy) v_u_13, (copy) v_u_11
		local v30 = v_u_6("Frame")
		local v33 = {
			["Name"] = p28,
			["LayoutOrder"] = p28,
			["BackgroundTransparency"] = 1,
			["AutomaticSize"] = Enum.AutomaticSize.Y,
			["Size"] = UDim2.fromScale(1, 0),
			["ZIndex"] = p29,
			[v_u_7] = { v_u_6("TextLabel")({
					["RichText"] = true,
					["Font"] = nil,
					["TextColor3"] = nil,
					["BackgroundTransparency"] = 1,
					["TextXAlignment"] = nil,
					["TextYAlignment"] = nil,
					["TextWrapped"] = true,
					["AutomaticSize"] = nil,
					["Size"] = nil,
					["Position"] = nil,
					["ZIndex"] = nil,
					["Text"] = nil,
					["TextSize"] = nil,
					["Font"] = Enum.Font.SourceSansBold,
					["TextColor3"] = v_u_13["h" .. p_u_27.Level] or v_u_13.mainText,
					["TextXAlignment"] = Enum.TextXAlignment.Left,
					["TextYAlignment"] = Enum.TextYAlignment.Top,
					["AutomaticSize"] = Enum.AutomaticSize.Y,
					["Size"] = v_u_11(function()
						-- upvalues: (ref) v_u_13
						return UDim2.new(1, -v_u_13.textSize:get(), 0, 0)
					end),
					["Position"] = v_u_11(function()
						-- upvalues: (ref) v_u_13
						return UDim2.new(0, v_u_13.textSize:get(), 0, 0)
					end),
					["ZIndex"] = p29,
					["Text"] = p_u_27.Text,
					["TextSize"] = v_u_11(function()
						-- upvalues: (copy) p_u_27, (ref) v_u_13
						local v31 = p_u_27.Level
						local v32 = 5 - math.clamp(v31, 1, 5)
						return v_u_13.headerSize:get() * (v32 * 0.3 + 1)
					end)
				}) }
		}
		return v30(v33)
	end,
	[v_u_4.Image] = function(p_u_34, p35, p36)
		-- upvalues: (copy) v_u_10, (copy) v_u_20, (copy) v_u_6, (copy) v_u_11, (copy) v_u_9, (copy) v_u_7
		local v37 = v_u_10("")
		local v38 = v_u_10(Enum.ScaleType.Stretch)
		local v_u_39 = v_u_10(10)
		task.spawn(v_u_20, v37, v38, p_u_34.ID)
		local v40 = v_u_6("Frame")
		local v42 = {
			["Name"] = p35,
			["LayoutOrder"] = p35,
			["BackgroundTransparency"] = 1,
			["Size"] = v_u_11(function()
				-- upvalues: (copy) v_u_39, (copy) p_u_34
				return UDim2.new(1, 0, 0, v_u_39:get() * p_u_34.Scale * 0.6)
			end),
			["ZIndex"] = p36,
			[v_u_9("AbsoluteSize")] = function(p41)
				-- upvalues: (copy) v_u_39, (copy) p_u_34
				v_u_39:set(p41.X / p_u_34.AspectRatio)
			end
		}
		local v43 = v_u_7
		local v44 = {}
		local v45 = v_u_6("ImageLabel")
		local v46 = {
			["BackgroundTransparency"] = 1,
			["Size"] = UDim2.fromScale(0.6 * p_u_34.Scale, 1),
			["Position"] = v_u_11(function()
				return UDim2.new(0.5, 0, 0, 0)
			end),
			["AnchorPoint"] = Vector2.new(0.5, 0),
			["Image"] = v37,
			["ScaleType"] = v38,
			["ZIndex"] = p36,
			[v_u_7] = { v_u_6("UICorner")({
					["Name"] = "UICorner",
					["CornerRadius"] = nil,
					["CornerRadius"] = UDim.new(0.05, 0)
				}) }
		}
		__set_list(v44, 1, {v45(v46)})
		v42[v43] = v44
		return v40(v42)
	end,
	[v_u_4.Code] = function(p_u_47, p48, p49)
		-- upvalues: (copy) v_u_11, (copy) v_u_15, (copy) v_u_13, (copy) v_u_6, (copy) v_u_8, (copy) v_u_2, (copy) v_u_9, (copy) v_u_16, (copy) v_u_7
		p_u_47.Code = string.gsub(p_u_47.Code, "\t", "    ")
		local v_u_50 = v_u_11(function()
			-- upvalues: (ref) v_u_15, (copy) p_u_47, (ref) v_u_13
			return v_u_15(p_u_47.Code, v_u_13.textSize:get(), Enum.Font.Code, Vector2.new(9999, 9999))
		end)
		local v_u_51 = nil
		v_u_51 = v_u_6("TextBox")({
			["TextEditable"] = false,
			["ShowNativeInput"] = false,
			["MultiLine"] = true,
			["ClearTextOnFocus"] = false,
			["Font"] = Enum.Font.Code,
			["TextColor3"] = v_u_13.scriptBackground,
			["BackgroundTransparency"] = 1,
			["TextXAlignment"] = Enum.TextXAlignment.Left,
			["TextYAlignment"] = Enum.TextYAlignment.Top,
			["TextWrapped"] = false,
			["TextTransparency"] = 0.6,
			["Size"] = v_u_11(function()
				-- upvalues: (ref) v_u_13, (copy) v_u_50
				return UDim2.new(1, -v_u_13.textSize:get(), 0, v_u_50:get().Y + 2)
			end),
			["Position"] = v_u_11(function()
				-- upvalues: (ref) v_u_13
				return UDim2.new(0, v_u_13.textSize:get(), 0, 1)
			end),
			["ZIndex"] = p49 - 1,
			[v_u_8("Focused")] = function()
				-- upvalues: (ref) v_u_2, (ref) v_u_51
				if v_u_2.KeyboardEnabled then
					task.wait(0.15)
					if v_u_51.SelectionStart == -1 then
						v_u_51:ReleaseFocus(false)
					end
				else
					task.wait()
					v_u_51:ReleaseFocus(false)
				end
			end,
			[v_u_9("SelectionStart")] = function(_, _)
				-- upvalues: (ref) v_u_51
				if v_u_51.SelectionStart == -1 then
					v_u_51:ReleaseFocus(false)
				end
			end,
			["Text"] = p_u_47.Code,
			["TextSize"] = v_u_13.textSize
		})
		task.defer(v_u_16.Highlight, v_u_51, p_u_47.Code, p_u_47.Syntax)
		return v_u_6("ScrollingFrame")({
			["Name"] = p48,
			["LayoutOrder"] = p48,
			["BackgroundColor3"] = v_u_13.scriptBackground,
			["Size"] = v_u_11(function()
				-- upvalues: (copy) v_u_50, (ref) v_u_13
				return UDim2.new(1, 0, 0, v_u_50:get().Y + v_u_13.headerSize:get())
			end),
			["CanvasSize"] = v_u_11(function()
				-- upvalues: (copy) v_u_50
				return UDim2.fromOffset(v_u_50:get().X + 40, 0)
			end),
			["ScrollingDirection"] = Enum.ScrollingDirection.X,
			["ZIndex"] = p49,
			[v_u_7] = { v_u_51 }
		})
	end,
	[v_u_4.List] = function(p52, p53, p_u_54)
		-- upvalues: (copy) v_u_10, (copy) v_u_13, (copy) v_u_6, (copy) v_u_11, (copy) v_u_7, (copy) v_u_9, (copy) v_u_12
		local v_u_55 = v_u_10(v_u_13.textSize:get() * #p52.Lines)
		local v56 = v_u_6("Frame")
		local v61 = {
			["Name"] = p53,
			["LayoutOrder"] = p53,
			["BackgroundTransparency"] = 1,
			["AutomaticSize"] = Enum.AutomaticSize.Y,
			["Size"] = v_u_11(function()
				return UDim2.new(1, 0, 0, 0)
			end),
			["ZIndex"] = p_u_54,
			[v_u_7] = { v_u_6("UIListLayout")({
					["FillDirection"] = Enum.FillDirection.Vertical,
					["SortOrder"] = Enum.SortOrder.LayoutOrder,
					["HorizontalAlignment"] = Enum.HorizontalAlignment.Right,
					["VerticalAlignment"] = Enum.VerticalAlignment.Top,
					["Padding"] = UDim.new(0, 3),
					[v_u_9("AbsoluteContentSize")] = function(p57)
						-- upvalues: (copy) v_u_55
						v_u_55:set(p57.Y)
					end
				}), v_u_12(p52.Lines, function(p58, p59)
					-- upvalues: (ref) v_u_6, (ref) v_u_13, (ref) v_u_11, (copy) p_u_54
					return p58, v_u_6("TextLabel")({
						["LayoutOrder"] = nil,
						["Name"] = nil,
						["RichText"] = true,
						["Font"] = nil,
						["TextColor3"] = nil,
						["BackgroundTransparency"] = 1,
						["TextXAlignment"] = nil,
						["TextYAlignment"] = nil,
						["TextWrapped"] = true,
						["AutomaticSize"] = nil,
						["Size"] = nil,
						["ZIndex"] = nil,
						["Text"] = nil,
						["TextSize"] = nil,
						["LayoutOrder"] = p58,
						["Name"] = p58,
						["Font"] = Enum.Font.SourceSans,
						["TextColor3"] = v_u_13.mainText,
						["TextXAlignment"] = Enum.TextXAlignment.Left,
						["TextYAlignment"] = Enum.TextYAlignment.Top,
						["AutomaticSize"] = Enum.AutomaticSize.Y,
						["Size"] = v_u_11(function()
							-- upvalues: (ref) v_u_13
							return UDim2.new(1, -v_u_13.textSize:get(), 0, 0)
						end),
						["ZIndex"] = p_u_54,
						["Text"] = string.rep("  ", p59.Level) .. (p59.Symbol:match("%w+[%.%)]") or "\226\128\162") .. " " .. p59.Text,
						["TextSize"] = v_u_13.textSize
					})
				end, function(p60)
					p60:Destroy()
				end) }
		}
		return v56(v61)
	end,
	[v_u_4.Quote] = function(p62, p63, p64)
		-- upvalues: (copy) v_u_10, (copy) v_u_11, (copy) v_u_13, (copy) v_u_6, (copy) v_u_9, (copy) v_u_7, (copy) v_u_21
		local v_u_65 = v_u_10(0)
		local v_u_66 = v_u_10(10)
		local v67 = v_u_11(function()
			-- upvalues: (copy) v_u_66, (ref) v_u_13
			return v_u_66:get() - v_u_13.textSize:get()
		end)
		local v68 = v_u_6("Frame")
		local v70 = {
			["Name"] = p63,
			["LayoutOrder"] = p63,
			["BackgroundTransparency"] = 1,
			["Size"] = v_u_11(function()
				-- upvalues: (copy) v_u_65
				return UDim2.new(1, 0, 0, v_u_65:get() + 2)
			end),
			["ZIndex"] = p64,
			[v_u_9("AbsoluteSize")] = function(p69)
				-- upvalues: (copy) v_u_66
				v_u_66:set(p69.X)
			end
		}
		local v71 = v_u_7
		local v72 = {}
		local v74 = v_u_6("Frame")({
			["Name"] = "Line",
			["BackgroundColor3"] = nil,
			["AnchorPoint"] = nil,
			["Size"] = nil,
			["Position"] = nil,
			["ZIndex"] = nil,
			["BackgroundColor3"] = v_u_13.light,
			["AnchorPoint"] = Vector2.new(1, 0.5),
			["Size"] = v_u_11(function()
				-- upvalues: (ref) v_u_13
				local v73 = v_u_13.textSize:get()
				return UDim2.new(0, v73 * 0.3, 1, v73 * -0.1)
			end),
			["Position"] = v_u_11(function()
				-- upvalues: (ref) v_u_13
				return UDim2.new(0, v_u_13.textSize:get(), 0.5, 0)
			end),
			["ZIndex"] = p64
		})
		local v75 = v_u_6("Frame")
		local v77 = {
			["Name"] = "Container",
			["BackgroundColor3"] = v_u_13.darkBackground,
			["Position"] = v_u_11(function()
				-- upvalues: (ref) v_u_13
				return UDim2.new(0, v_u_13.textSize:get() * 1.2, 0, 0)
			end),
			["Size"] = v_u_11(function()
				-- upvalues: (ref) v_u_13
				return UDim2.new(1, v_u_13.textSize:get() * -1.2, 1, 0)
			end),
			["ZIndex"] = p64,
			[v_u_7] = { v_u_6("UIListLayout")({
					["FillDirection"] = Enum.FillDirection.Vertical,
					["SortOrder"] = Enum.SortOrder.LayoutOrder,
					["HorizontalAlignment"] = Enum.HorizontalAlignment.Left,
					["VerticalAlignment"] = Enum.VerticalAlignment.Top,
					["Padding"] = UDim.new(0, 3),
					[v_u_9("AbsoluteContentSize")] = function(p76)
						-- upvalues: (copy) v_u_65
						v_u_65:set(p76.Y)
					end
				}), v_u_21.Render(p62.RawText or "", v67) }
		}
		__set_list(v72, 1, {v74, v75(v77)})
		v70[v71] = v72
		return v68(v70)
	end,
	[v_u_4.Ruler] = function(_, p78, p79)
		-- upvalues: (copy) v_u_6, (copy) v_u_7, (copy) v_u_13, (copy) v_u_11
		local v80 = v_u_6("Frame")
		local v81 = {
			["Name"] = p78,
			["LayoutOrder"] = p78,
			["BackgroundTransparency"] = 1,
			["Size"] = UDim2.new(1, 0, 0, 5),
			["ZIndex"] = p79,
			[v_u_7] = { v_u_6("Frame")({
					["Name"] = "ruler",
					["BackgroundColor3"] = nil,
					["Size"] = nil,
					["Position"] = nil,
					["AnchorPoint"] = nil,
					["ZIndex"] = nil,
					["BackgroundColor3"] = v_u_13.light,
					["Size"] = v_u_11(function()
						-- upvalues: (ref) v_u_13
						return UDim2.new(1, -v_u_13.textSize:get(), 0, v_u_13.textSize:get() * 0.2)
					end),
					["Position"] = UDim2.fromScale(0.5, 0.5),
					["AnchorPoint"] = Vector2.new(0.5, 0.5),
					["ZIndex"] = p79
				}) }
		}
		return v80(v81)
	end
}
function v_u_21.Render(p82, p83)
	-- upvalues: (copy) v_u_3, (copy) v_u_21, (copy) v_u_4
	local v84 = 0
	local v85 = {}
	for v86, v87 in v_u_3.parse(p82) do
		v84 = v84 + 1
		local v88, v89 = pcall(v_u_21.BlockToGui[v86] or v_u_21.BlockToGui[v_u_4.Paragraph], v87, v84, p83)
		if v88 then
			v85[v84] = v89
		else
			warn(v89)
		end
	end
	return v85
end
return function(p_u_90)
	-- upvalues: (copy) v_u_10, (copy) v_u_6, (copy) v_u_7, (copy) v_u_11, (copy) v_u_13, (copy) v_u_9, (copy) v_u_21
	local v_u_91 = v_u_10(UDim2.fromScale(1, 0))
	local v92 = v_u_6("Frame")
	local v94 = {
		["Name"] = p_u_90.Name or "MarkdownContainer",
		["Size"] = v_u_91,
		["Position"] = p_u_90.Position,
		["BackgroundTransparency"] = 1,
		["LayoutOrder"] = p_u_90.LayoutOrder,
		["ZIndex"] = p_u_90.ZIndex,
		[v_u_7] = { v_u_6("UIListLayout")({
				["FillDirection"] = Enum.FillDirection.Vertical,
				["SortOrder"] = Enum.SortOrder.LayoutOrder,
				["HorizontalAlignment"] = Enum.HorizontalAlignment.Left,
				["VerticalAlignment"] = Enum.VerticalAlignment.Top,
				["Padding"] = v_u_11(function()
					-- upvalues: (ref) v_u_13
					return UDim.new(0, v_u_13.textSize:get())
				end),
				[v_u_9("AbsoluteContentSize")] = function(p93)
					-- upvalues: (copy) v_u_91, (ref) v_u_13
					v_u_91:set(UDim2.new(1, 0, 0, p93.Y + v_u_13.textSize:get() * 2))
				end
			}), v_u_11(function()
				-- upvalues: (ref) v_u_21, (copy) p_u_90
				return v_u_21.Render(p_u_90.Text:get(), p_u_90.ZIndex)
			end) }
	}
	return v92(v94)
end