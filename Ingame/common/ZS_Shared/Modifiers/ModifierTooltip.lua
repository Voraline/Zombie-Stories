local v_u_1 = game:GetService("Players")
local v_u_2 = game:GetService("UserInputService")
local v_u_3 = game:GetService("RunService")
local v_u_4 = require(game.ReplicatedStorage.Packages.Fusion)
local v_u_5 = v_u_4.Children
local v_u_6 = v_u_4.scoped
local v_u_8 = v_u_4.peek or function(p7)
	return p7:get()
end
local v_u_9 = {}
local v_u_10 = false
local v_u_11 = nil
local v_u_12 = nil
local v_u_13 = nil
local v_u_14 = nil
local v_u_15 = nil
local v_u_16 = nil
local v_u_17 = nil
local v_u_18 = nil
local function v_u_39() -- name: ensureGui
	-- upvalues: (ref) v_u_10, (ref) v_u_11, (copy) v_u_6, (copy) v_u_4, (ref) v_u_12, (ref) v_u_13, (ref) v_u_14, (ref) v_u_15, (ref) v_u_16, (ref) v_u_17, (ref) v_u_18, (copy) v_u_1, (copy) v_u_5
	if not v_u_10 then
		v_u_10 = true
		v_u_11 = v_u_6(v_u_4)
		v_u_12 = v_u_11:Value(false)
		v_u_13 = v_u_11:Value("")
		v_u_14 = v_u_11:Value("")
		v_u_15 = v_u_11:Value("")
		v_u_16 = v_u_11:Value("")
		v_u_17 = v_u_11:Value("")
		v_u_18 = v_u_11:Value(Vector2.new(0, 0))
		local v19 = v_u_1.LocalPlayer:WaitForChild("PlayerGui")
		local v20 = v_u_11:New("ScreenGui")
		local v21 = {
			["Name"] = "ModifierTooltipGui",
			["ResetOnSpawn"] = false,
			["IgnoreGuiInset"] = true,
			["Parent"] = v19,
			["DisplayOrder"] = 1
		}
		local v22 = v_u_5
		local v23 = {}
		local v24 = v_u_11:New("Frame")
		local v38 = {
			["Name"] = "Tooltip",
			["Visible"] = v_u_12,
			["BackgroundColor3"] = Color3.fromRGB(22, 22, 22),
			["BackgroundTransparency"] = 0.05,
			["BorderSizePixel"] = 0,
			["ZIndex"] = 1000,
			["Position"] = v_u_11:Computed(function(p25)
				-- upvalues: (ref) v_u_18
				local v26 = p25(v_u_18)
				local v27 = workspace.CurrentCamera.ViewportSize
				local v28 = v26.X + 16
				local v29 = v26.Y + 16
				if v28 + 260 > v27.X then
					v28 = v26.X - 260 - 16
				end
				if v29 + 100 > v27.Y then
					v29 = v26.Y - 100 - 8
				end
				local v30 = math.max(8, v28)
				local v31 = math.max(8, v29)
				return UDim2.fromOffset(v30, v31)
			end),
			["Size"] = UDim2.fromOffset(260, 0),
			["AutomaticSize"] = Enum.AutomaticSize.Y,
			["ClipsDescendants"] = true,
			[v_u_5] = {
				v_u_11:New("UICorner")({
					["CornerRadius"] = UDim.new(0, 6)
				}),
				v_u_11:New("UIStroke")({
					["Thickness"] = 1,
					["Color"] = nil,
					["Color"] = Color3.fromRGB(60, 60, 60)
				}),
				v_u_11:New("UIPadding")({
					["PaddingTop"] = UDim.new(0, 8),
					["PaddingBottom"] = UDim.new(0, 8),
					["PaddingLeft"] = UDim.new(0, 8),
					["PaddingRight"] = UDim.new(0, 8)
				}),
				v_u_11:New("UIListLayout")({
					["SortOrder"] = Enum.SortOrder.LayoutOrder,
					["Padding"] = UDim.new(0, 4)
				}),
				v_u_11:New("TextLabel")({
					["Name"] = "Name",
					["LayoutOrder"] = 1,
					["BackgroundTransparency"] = 1,
					["Font"] = nil,
					["TextSize"] = 16,
					["TextXAlignment"] = nil,
					["TextWrapped"] = true,
					["RichText"] = true,
					["Size"] = nil,
					["AutomaticSize"] = nil,
					["Text"] = nil,
					["TextColor3"] = nil,
					["ZIndex"] = 1001,
					["Font"] = Enum.Font.GothamBold,
					["TextXAlignment"] = Enum.TextXAlignment.Left,
					["Size"] = UDim2.fromScale(1, 0),
					["AutomaticSize"] = Enum.AutomaticSize.Y,
					["Text"] = v_u_11:Computed(function(p32)
						-- upvalues: (ref) v_u_13
						return p32(v_u_13)
					end),
					["TextColor3"] = Color3.fromRGB(255, 255, 255)
				}),
				v_u_11:New("TextLabel")({
					["Name"] = "Desc",
					["LayoutOrder"] = 2,
					["BackgroundTransparency"] = 1,
					["Font"] = nil,
					["TextSize"] = 14,
					["TextXAlignment"] = nil,
					["TextWrapped"] = true,
					["Size"] = nil,
					["AutomaticSize"] = nil,
					["Text"] = nil,
					["TextColor3"] = nil,
					["ZIndex"] = 1001,
					["Font"] = Enum.Font.Gotham,
					["TextXAlignment"] = Enum.TextXAlignment.Left,
					["Size"] = UDim2.fromScale(1, 0),
					["AutomaticSize"] = Enum.AutomaticSize.Y,
					["Text"] = v_u_11:Computed(function(p33)
						-- upvalues: (ref) v_u_14
						return p33(v_u_14)
					end),
					["TextColor3"] = Color3.fromRGB(210, 210, 210)
				}),
				v_u_11:New("TextLabel")({
					["Name"] = "Stats",
					["LayoutOrder"] = 3,
					["BackgroundTransparency"] = 1,
					["Font"] = nil,
					["TextSize"] = 13,
					["TextXAlignment"] = nil,
					["TextWrapped"] = true,
					["Size"] = nil,
					["AutomaticSize"] = nil,
					["Text"] = nil,
					["RichText"] = true,
					["TextColor3"] = nil,
					["ZIndex"] = 1001,
					["Font"] = Enum.Font.GothamSemibold,
					["TextXAlignment"] = Enum.TextXAlignment.Left,
					["Size"] = UDim2.fromScale(1, 0),
					["AutomaticSize"] = Enum.AutomaticSize.Y,
					["Text"] = v_u_11:Computed(function(p34)
						-- upvalues: (ref) v_u_17, (ref) v_u_15, (ref) v_u_16
						local v35 = p34(v_u_17)
						local v36 = p34(v_u_15)
						local v37 = p34(v_u_16)
						if v35 and (v35 ~= "" and v35 ~= "+0%") then
							return string.format("<b>Stats:</b> %s  %s Z$  %s XP", v35, v36, v37)
						else
							return v36 == "+0%" and v37 == "+0%" and "" or string.format("<b>Stats:</b> %s Z$  %s XP", v36, v37)
						end
					end),
					["TextColor3"] = Color3.fromRGB(170, 200, 255)
				})
			}
		}
		__set_list(v23, 1, {v24(v38)})
		v21[v22] = v23
		v20(v21)
	end
end
function v_u_9.init() -- name: init
	-- upvalues: (copy) v_u_39
	v_u_39()
end
function v_u_9.show(p40, p41) -- name: show
	-- upvalues: (copy) v_u_39, (ref) v_u_13, (ref) v_u_14, (ref) v_u_17, (ref) v_u_15, (ref) v_u_16, (ref) v_u_18, (ref) v_u_12
	v_u_39()
	local v42 = ""
	if p40 and type(p40) == "table" then
		if p40.StatText then
			v42 = p40.StatText
		elseif p40.GetModifierStatText then
			v42 = p40.GetModifierStatText()
		end
	end
	v_u_13:set(p40 and p40.Name or (p40 and (p40.id or "Modifier") or "Modifier"))
	v_u_14:set(p40 and (p40.Description or "") or "")
	v_u_17:set(v42)
	local v43
	if p40 and p40.ZBucksMultiplier then
		local v44 = p40.ZBucksMultiplier * 100
		local v45 = math.floor(v44)
		if v45 >= 0 then
			v43 = "+" .. tostring(v45) .. "%"
		else
			v43 = tostring(v45) .. "%"
		end
	else
		v43 = "+0%"
	end
	local v46
	if p40 and p40.XPMultiplier then
		local v47 = p40.XPMultiplier * 100
		local v48 = math.floor(v47)
		if v48 >= 0 then
			v46 = "+" .. tostring(v48) .. "%"
		else
			v46 = tostring(v48) .. "%"
		end
	else
		v46 = "+0%"
	end
	v_u_15:set(v43)
	v_u_16:set(v46)
	v_u_18:set(p41)
	v_u_12:set(true)
end
function v_u_9.hide() -- name: hide
	-- upvalues: (ref) v_u_10, (ref) v_u_12
	if v_u_10 then
		v_u_12:set(false)
	end
end
function v_u_9.bindHover(p_u_49, p_u_50) -- name: bindHover
	-- upvalues: (copy) v_u_3, (copy) v_u_2, (ref) v_u_12, (copy) v_u_8, (copy) v_u_9, (ref) v_u_18
	local v_u_51 = false
	local v_u_52 = nil
	local v_u_53 = nil
	p_u_49.MouseEnter:Connect(function()
		-- upvalues: (ref) v_u_51, (ref) v_u_53, (ref) v_u_3, (ref) v_u_2, (copy) p_u_49, (ref) v_u_12, (ref) v_u_8, (copy) p_u_50, (ref) v_u_9, (ref) v_u_52
		v_u_51 = true
		if not v_u_53 then
			v_u_53 = v_u_3.Heartbeat:Connect(function()
				-- upvalues: (ref) v_u_51, (ref) v_u_2, (ref) p_u_49, (ref) v_u_12, (ref) v_u_8, (ref) p_u_50, (ref) v_u_9
				if v_u_51 then
					local v54 = v_u_2:GetMouseLocation()
					local v55 = game:GetService("GuiService"):GetGuiInset()
					local v56 = Vector2.new(v54.X - v55.X, v54.Y - v55.Y)
					local v57 = p_u_49.AbsolutePosition
					local v58 = p_u_49.AbsoluteSize
					local v59
					if v56.X >= v57.X and (v56.X <= v57.X + v58.X and v56.Y >= v57.Y) then
						v59 = v56.Y <= v57.Y + v58.Y
					else
						v59 = false
					end
					if v59 and not (v_u_12 and v_u_8(v_u_12)) then
						local v60 = p_u_50()
						if v60 then
							v_u_9.show(v60, v54)
							return
						end
					elseif not v59 and (v_u_12 and v_u_8(v_u_12)) then
						v_u_51 = false
						v_u_9.hide()
					end
				end
			end)
		end
		if v_u_52 then
			local v61 = v_u_52
			if typeof(v61) == "thread" then
				task.cancel(v_u_52)
			else
				v_u_52:Disconnect()
			end
			v_u_52 = nil
		end
		local v62 = p_u_50()
		if v62 then
			local v63 = v_u_2:GetMouseLocation()
			v_u_9.show(v62, v63)
		end
	end)
	p_u_49.MouseLeave:Connect(function()
		-- upvalues: (ref) v_u_51, (ref) v_u_53, (ref) v_u_52, (ref) v_u_9
		v_u_51 = false
		if v_u_53 then
			v_u_53:Disconnect()
			v_u_53 = nil
		end
		v_u_52 = task.spawn(function()
			-- upvalues: (ref) v_u_51, (ref) v_u_9, (ref) v_u_52
			task.wait(0.1)
			if not v_u_51 then
				v_u_9.hide()
			end
			v_u_52 = nil
		end)
	end)
	p_u_49.MouseMoved:Connect(function(p64, p65)
		-- upvalues: (ref) v_u_51, (ref) v_u_12, (ref) v_u_8, (ref) v_u_18
		if v_u_51 and (v_u_12 and v_u_8(v_u_12)) then
			v_u_18:set(Vector2.new(p64, p65))
		end
	end)
end
return v_u_9