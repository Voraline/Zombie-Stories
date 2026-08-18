local v1 = {}
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = require(v2.Packages.Fusion)
local v_u_4 = v_u_3.Children
local v_u_5 = require(script.Components.Toggle)
local v_u_6 = require(script.Components.NumberSlider)
local v_u_7 = require(script.Components.Header)
local v_u_8 = require(script.Components.Dropdown)
local v_u_9 = require(script.Components.Button)
local v_u_10 = require(script.Components.Bind)
local v_u_11 = require(script.Components.BindsHeader)
local v_u_12 = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
function v1.Init(_, p13, _) -- name: Init
	-- upvalues: (copy) v_u_3, (copy) v_u_4, (copy) v_u_12, (copy) v_u_7, (copy) v_u_5, (copy) v_u_6, (copy) v_u_9, (copy) v_u_8, (copy) v_u_10, (copy) v_u_11
	local v_u_14 = v_u_3.scoped(v_u_3)
	local v_u_15 = v_u_14:New("Sound")({
		["Name"] = "button",
		["SoundId"] = "rbxassetid://1852347417",
		["Parent"] = nil,
		["Parent"] = p13
	})
	local v_u_16 = p13:WaitForChild("Tabs"):WaitForChild("Frame")
	local v_u_17 = p13:WaitForChild("Container")
	local v_u_18 = nil
	local v_u_19 = {}
	local v_u_20 = {}
	local v_u_21 = {}
	function v_u_20.SetContainer(_, p22) -- name: SetContainer
		-- upvalues: (copy) v_u_21, (ref) v_u_18, (copy) v_u_19
		for _, v23 in pairs(v_u_21) do
			v23.Visible = false
		end
		p22.ContainerUI.Visible = true
		if v_u_18 then
			v_u_18.Visible = false
		end
		for _, v24 in v_u_19 do
			v24.Frame.BackgroundColor3 = Color3.new()
			v24.Frame.UIStroke.Color = Color3.fromRGB(144, 144, 144)
		end
		p22.TabButton.Frame.BackgroundColor3 = Color3.fromRGB(86, 62, 28)
		p22.TabButton.Frame.UIStroke.Color = Color3.fromRGB(255, 184, 84)
		if v_u_18 then
			v_u_18.Visible = false
		end
	end
	function v_u_20.Tab(_, p25) -- name: Tab
		-- upvalues: (copy) v_u_14, (ref) v_u_4, (ref) v_u_12, (copy) v_u_19, (copy) v_u_17, (copy) v_u_21, (copy) v_u_15, (copy) v_u_20, (copy) v_u_16, (ref) v_u_7, (ref) v_u_5, (ref) v_u_6, (ref) v_u_9, (ref) v_u_8, (ref) v_u_18, (ref) v_u_10, (ref) v_u_11
		local v26 = v_u_14:New("TextButton")
		local v27 = {
			["Name"] = "Button",
			["BackgroundTransparency"] = 1,
			["Size"] = UDim2.fromScale(1, 0.3),
			["SizeConstraint"] = Enum.SizeConstraint.RelativeXX
		}
		local v28 = v_u_4
		local v29 = {}
		local v30 = v_u_14:New("Frame")
		local v31 = {
			["Name"] = "Frame",
			["AnchorPoint"] = Vector2.new(0.5, 0.5),
			["BackgroundColor3"] = Color3.new(),
			["BackgroundTransparency"] = 0.8,
			["Position"] = UDim2.fromScale(0.5, 0.5),
			["Size"] = UDim2.new(0.95, -8, 0.85, -8),
			[v_u_4] = { v_u_14:New("UICorner")({
					["CornerRadius"] = UDim.new(0.2, 0)
				}), v_u_14:New("UIStroke")({
					["Color"] = nil,
					["Thickness"] = 4,
					["Color"] = Color3.fromRGB(144, 144, 144)
				}), v_u_14:New("TextLabel")({
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
					["FontFace"] = v_u_12,
					["Position"] = UDim2.fromScale(0.5, 0.5),
					["Size"] = UDim2.fromScale(0.9, 0.85),
					["Text"] = p25,
					["TextColor3"] = Color3.new(1, 1, 1)
				}) }
		}
		__set_list(v29, 1, {v30(v31)})
		v27[v28] = v29
		local v32 = v26(v27)
		local v33 = v_u_19
		table.insert(v33, v32)
		local v_u_34 = {
			["UIElements"] = {}
		}
		local v35 = v_u_14:New("ScrollingFrame")
		local v36 = {
			["Name"] = p25,
			["AnchorPoint"] = Vector2.new(0.5, 0.5),
			["BackgroundTransparency"] = 1,
			["BottomImage"] = "",
			["CanvasSize"] = UDim2.fromOffset(0, 346),
			["Position"] = UDim2.fromScale(0.5, 0.5),
			["ScrollBarImageColor3"] = Color3.fromRGB(16, 16, 16),
			["ScrollBarThickness"] = 3,
			["ScrollingDirection"] = Enum.ScrollingDirection.Y,
			["Selectable"] = false,
			["Size"] = UDim2.new(1, -5, 1, -5),
			["TopImage"] = "",
			["Visible"] = false,
			[v_u_4] = { v_u_14:New("UIListLayout")({
					["Name"] = "UIListLayout",
					["SortOrder"] = nil,
					["SortOrder"] = Enum.SortOrder.LayoutOrder
				}) }
		}
		local v_u_37 = v35(v36)
		local v_u_38 = v_u_37:FindFirstChild("UIListLayout")
		v_u_38:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			-- upvalues: (copy) v_u_37, (copy) v_u_38
			v_u_37.CanvasSize = UDim2.fromOffset(0, v_u_38.AbsoluteContentSize.Y)
		end)
		v_u_37.Parent = v_u_17
		local v39 = v_u_21
		table.insert(v39, v_u_37)
		v32.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_15, (ref) v_u_20, (copy) v_u_34
			v_u_15:Play()
			v_u_20:SetContainer(v_u_34)
		end)
		v_u_34.ContainerUI = v_u_37
		v_u_34.TabButton = v32
		v32.Parent = v_u_16
		local v_u_40 = 0
		local v_u_41 = nil
		function v_u_34.Header(_, p42) -- name: Header
			-- upvalues: (ref) v_u_40, (ref) v_u_7, (ref) v_u_14, (ref) v_u_15, (copy) v_u_37, (ref) v_u_41, (copy) v_u_34
			v_u_40 = v_u_40 + 1
			local v43, v44 = v_u_7({
				["scope"] = v_u_14,
				["Text"] = p42,
				["LayoutOrder"] = v_u_40,
				["ButtonSound"] = v_u_15
			})
			v43.Parent = v_u_37
			v_u_41 = v44
			v_u_34.UIElements[p42] = v43
			return v43, v44
		end
		function v_u_34.Toggle(_, p45, p46, p47, p48) -- name: Toggle
			-- upvalues: (ref) v_u_40, (ref) v_u_5, (ref) v_u_14, (ref) v_u_15, (ref) v_u_41, (copy) v_u_37, (copy) v_u_34
			v_u_40 = v_u_40 + 1
			local v49, v50 = v_u_5({
				["scope"] = v_u_14,
				["Text"] = p45,
				["Default"] = p46,
				["OnChanged"] = p47,
				["Description"] = p48,
				["LayoutOrder"] = v_u_40,
				["ButtonSound"] = v_u_15,
				["Visible"] = v_u_41
			})
			v49.Parent = v_u_37
			v_u_34.UIElements[p45] = v49
			return v50
		end
		function v_u_34.Number(_, p51, p52, p53, p54, p55, p56) -- name: Number
			-- upvalues: (ref) v_u_40, (ref) v_u_6, (ref) v_u_14, (ref) v_u_41, (copy) v_u_37, (copy) v_u_34
			v_u_40 = v_u_40 + 1
			local v57, v58 = v_u_6({
				["scope"] = v_u_14,
				["Text"] = p51,
				["Default"] = p52,
				["OnChanged"] = p53,
				["Min"] = p54,
				["Max"] = p55,
				["SnapFactor"] = p56,
				["LayoutOrder"] = v_u_40,
				["Visible"] = v_u_41
			})
			v57.Parent = v_u_37
			v_u_34.UIElements[p51] = v57
			return v58
		end
		function v_u_34.Button(_, p59, p60, p61, p62, p63, p64, p65) -- name: Button
			-- upvalues: (ref) v_u_40, (ref) v_u_9, (ref) v_u_14, (ref) v_u_15, (ref) v_u_41, (copy) v_u_37, (copy) v_u_34
			v_u_40 = v_u_40 + 1
			local v66 = v_u_9({
				["scope"] = v_u_14,
				["Text"] = p59,
				["ButtonText"] = p60,
				["OnClick"] = p61,
				["OutlineColor"] = p62,
				["FillColor"] = p63,
				["TextColor"] = p64,
				["Description"] = p65,
				["LayoutOrder"] = v_u_40,
				["ButtonSound"] = v_u_15,
				["Visible"] = v_u_41
			})
			v66.Parent = v_u_37
			v_u_34.UIElements[p59] = v66
			return v66
		end
		function v_u_34.Dropdown(_, p67, p68, p69, p70, p71) -- name: Dropdown
			-- upvalues: (ref) v_u_40, (ref) v_u_8, (ref) v_u_14, (ref) v_u_15, (ref) v_u_41, (ref) v_u_18, (ref) v_u_17, (copy) v_u_37, (copy) v_u_34
			v_u_40 = v_u_40 + 1
			local v73, v74, v75 = v_u_8({
				["scope"] = v_u_14,
				["Text"] = p67,
				["Options"] = p68,
				["Default"] = p69,
				["OnChanged"] = p70,
				["Description"] = p71,
				["LayoutOrder"] = v_u_40,
				["ButtonSound"] = v_u_15,
				["Visible"] = v_u_41,
				["OnDropdownOpened"] = function(p72) -- name: OnDropdownOpened
					-- upvalues: (ref) v_u_18
					v_u_18 = p72
				end
			})
			v74.Parent = v_u_17
			v73.Parent = v_u_37
			v_u_34.UIElements[p67] = v73
			return v75
		end
		function v_u_34.Bind(_, p76, p77) -- name: Bind
			-- upvalues: (ref) v_u_40, (ref) v_u_10, (ref) v_u_14, (ref) v_u_41, (copy) v_u_37, (copy) v_u_34
			v_u_40 = v_u_40 + 1
			local v78 = v_u_10({
				["scope"] = v_u_14,
				["Text"] = p76,
				["Description"] = p77,
				["LayoutOrder"] = v_u_40,
				["Visible"] = v_u_41
			})
			v78.Parent = v_u_37
			v_u_34.UIElements[p76] = v78
			return v78
		end
		function v_u_34.BindsHeader(_) -- name: BindsHeader
			-- upvalues: (ref) v_u_40, (ref) v_u_11, (ref) v_u_14, (copy) v_u_37, (copy) v_u_34
			v_u_40 = v_u_40 + 1
			local v79 = v_u_11({
				["scope"] = v_u_14,
				["LayoutOrder"] = v_u_40
			})
			v79.Parent = v_u_37
			v_u_34.UIElements.BindsHeader = v79
		end
		return v_u_34
	end
	return v_u_20
end
return v1