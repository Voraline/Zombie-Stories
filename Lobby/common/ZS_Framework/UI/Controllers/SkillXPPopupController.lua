local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("TweenService")
local v3 = require(v1.Packages.Fusion)
local v4 = v3.Children
local v5 = require("../../Data/PlayerDatabase")
local v6 = require("@game/ReplicatedStorage/common/skillTree/SkillTreeData")
local v_u_7 = require("@game/ReplicatedStorage/common/skillTree/config/EconomyConfig").SP_XP_PER_SP
local v_u_8 = UDim2.new(0, -280, 0.45, 0)
local v_u_9 = UDim2.new(0, 16, 0.45, 0)
local v10 = Color3.fromRGB(20, 20, 30)
local v11 = Color3.fromRGB(40, 40, 50)
local v12 = Color3.fromRGB(38, 175, 255)
local v13 = Color3.fromRGB(180, 180, 200)
local v14 = Color3.fromRGB(38, 175, 255)
local v15 = Color3.fromRGB(100, 210, 255)
local v16 = Color3.fromRGB(255, 200, 100)
local v17 = v3.scoped(v3)
local v_u_18 = {}
local v_u_19 = false
local v_u_20 = v17:Value((("0 / %*"):format(v_u_7)))
local v_u_21 = v17:Value(0)
local v_u_22 = v17:Value("")
local v_u_23 = v17:Value(false)
local v_u_24 = v17:Value("")
local v_u_25 = v17:Value(false)
local v_u_26 = v17:Spring(v_u_21, 20, 1)
local v27 = v17:New("Frame")
local v28 = {
	["Name"] = "SkillXPPopup",
	["Size"] = UDim2.new(0, 250, 0, 76),
	["Position"] = v_u_8,
	["AnchorPoint"] = Vector2.new(0, 0.5),
	["BackgroundColor3"] = v10,
	["BackgroundTransparency"] = 0.15,
	["BorderSizePixel"] = 0
}
local v29 = {}
local v30 = v17:New("UICorner")({
	["CornerRadius"] = UDim.new(0, 8)
})
local v31 = v17:New("UIPadding")({
	["PaddingTop"] = UDim.new(0, 8),
	["PaddingBottom"] = UDim.new(0, 8),
	["PaddingLeft"] = UDim.new(0, 12),
	["PaddingRight"] = UDim.new(0, 12)
})
local v32 = v17:New("Frame")
local v33 = {
	["Name"] = "HeaderRow",
	["Size"] = UDim2.new(1, 0, 0, 16),
	["Position"] = UDim2.new(0, 0, 0, 0),
	["BackgroundTransparency"] = 1,
	[v4] = { v17:New("TextLabel")({
			["Name"] = "Header",
			["Size"] = nil,
			["BackgroundTransparency"] = 1,
			["Font"] = nil,
			["Text"] = "SKILL XP",
			["TextColor3"] = nil,
			["TextSize"] = 12,
			["TextXAlignment"] = nil,
			["Size"] = UDim2.new(0.5, 0, 1, 0),
			["Font"] = Enum.Font.GothamBold,
			["TextColor3"] = v13,
			["TextXAlignment"] = Enum.TextXAlignment.Left
		}), v17:New("TextLabel")({
			["Name"] = "GainLabel",
			["Size"] = nil,
			["Position"] = nil,
			["BackgroundTransparency"] = 1,
			["Font"] = nil,
			["Text"] = nil,
			["TextColor3"] = nil,
			["TextSize"] = 12,
			["TextXAlignment"] = nil,
			["Visible"] = nil,
			["Size"] = UDim2.new(0.5, 0, 1, 0),
			["Position"] = UDim2.new(0.5, 0, 0, 0),
			["Font"] = Enum.Font.GothamBold,
			["Text"] = v_u_22,
			["TextColor3"] = v15,
			["TextXAlignment"] = Enum.TextXAlignment.Right,
			["Visible"] = v_u_23
		}) }
}
local v34 = v32(v33)
local v35 = v17:New("TextLabel")({
	["Name"] = "Counter",
	["Size"] = nil,
	["Position"] = nil,
	["BackgroundTransparency"] = 1,
	["Font"] = nil,
	["Text"] = nil,
	["TextColor3"] = nil,
	["TextSize"] = 16,
	["TextXAlignment"] = nil,
	["Size"] = UDim2.new(1, 0, 0, 18),
	["Position"] = UDim2.new(0, 0, 0, 18),
	["Font"] = Enum.Font.GothamBold,
	["Text"] = v_u_20,
	["TextColor3"] = v14,
	["TextXAlignment"] = Enum.TextXAlignment.Left
})
local v36 = v17:New("Frame")
local v37 = {
	["Name"] = "BarBG",
	["Size"] = UDim2.new(1, 0, 0, 8),
	["Position"] = UDim2.new(0, 0, 0, 40),
	["BackgroundColor3"] = v11,
	["BorderSizePixel"] = 0
}
local v38 = {}
local v39 = v17:New("UICorner")({
	["CornerRadius"] = UDim.new(0.5, 0)
})
local v40 = v17:New("Frame")
local v42 = {
	["Name"] = "Fill",
	["Size"] = v17:Computed(function(p41)
		-- upvalues: (copy) v_u_26
		return UDim2.new(p41(v_u_26), 0, 1, 0)
	end),
	["BackgroundColor3"] = v12,
	["BorderSizePixel"] = 0,
	[v4] = { v17:New("UICorner")({
			["CornerRadius"] = UDim.new(0.5, 0)
		}) }
}
__set_list(v38, 1, {v39, v40(v42)})
v37[v4] = v38
__set_list(v29, 1, {v30, v31, v34, v35, v36(v37), v17:New("TextLabel")({
	["Name"] = "SPLabel",
	["Size"] = nil,
	["Position"] = nil,
	["BackgroundTransparency"] = 1,
	["Font"] = nil,
	["Text"] = nil,
	["TextColor3"] = nil,
	["TextSize"] = 14,
	["TextXAlignment"] = nil,
	["Visible"] = nil,
	["Size"] = UDim2.new(1, 0, 0, 16),
	["Position"] = UDim2.new(0, 0, 0, 52),
	["Font"] = Enum.Font.GothamBlack,
	["Text"] = v_u_24,
	["TextColor3"] = v16,
	["TextXAlignment"] = Enum.TextXAlignment.Center,
	["Visible"] = v_u_25
})})
v28[v4] = v29
local v_u_43 = v27(v28)
v17:New("ScreenGui")({
	["Parent"] = v5.PlayerGui,
	["Name"] = "SkillXPPopupGui",
	["DisplayOrder"] = 8,
	["ResetOnSpawn"] = false,
	["IgnoreGuiInset"] = true,
	[v4] = { v_u_43 }
})
local function v_u_48(p44, p45, p46) -- name: tweenPosition
	-- upvalues: (copy) v_u_2, (copy) v_u_43
	local v47 = v_u_2:Create(v_u_43, TweenInfo.new(p45, Enum.EasingStyle.Quad, p46), {
		["Position"] = p44
	})
	v47:Play()
	v47.Completed:Wait()
end
local function v_u_53(p49, p50, p51) -- name: animateSegment
	-- upvalues: (copy) v_u_20, (copy) v_u_7, (copy) v_u_21
	while p49 < p50 do
		local v52 = p49 + p51
		p49 = math.min(v52, p50)
		v_u_20:set((("%* / %*"):format(math.floor(p49), v_u_7)))
		v_u_21:set(p49 / v_u_7)
		task.wait(0.03)
	end
end
local function v_u_61(p54, p55, p56) -- name: animateXP
	-- upvalues: (copy) v_u_7, (copy) v_u_53, (copy) v_u_24, (copy) v_u_25, (copy) v_u_21, (copy) v_u_20
	local v57
	if p56 > 0 then
		v57 = v_u_7 - p54 + p55 + (p56 - 1) * v_u_7
	else
		v57 = p55 - p54
	end
	local v58 = v57 / 40
	local v59 = math.max(1, v58)
	if p56 > 0 then
		for v60 = 1, p56 do
			v_u_53(p54, v_u_7, v59)
			v_u_24:set(p56 == 1 and "+1 SP!" or ("+%* SP!"):format(v60))
			v_u_25:set(true)
			task.wait(0.6)
			v_u_25:set(false)
			v_u_21:set(0)
			v_u_20:set((("0 / %*"):format(v_u_7)))
			p54 = 0
		end
		if p55 > 0 then
			v_u_53(0, p55, v59)
			return
		end
	else
		v_u_53(p54, p55, v59)
	end
end
local function v_u_68(p62, p63, p64, p65) -- name: showPopup
	-- upvalues: (copy) v_u_7, (copy) v_u_20, (copy) v_u_21, (copy) v_u_22, (copy) v_u_23, (copy) v_u_25, (copy) v_u_48, (copy) v_u_9, (copy) v_u_61, (copy) v_u_8
	local v66 = p65 - p64
	local v67
	if v66 > 0 then
		v67 = v_u_7 - p62 + p63 + (v66 - 1) * v_u_7
	else
		v67 = p63 - p62
	end
	if v67 > 0 then
		v_u_20:set((("%* / %*"):format(p62, v_u_7)))
		v_u_21:set(p62 / v_u_7)
		v_u_22:set((("+%* XP"):format(v67)))
		v_u_23:set(true)
		v_u_25:set(false)
		v_u_48(v_u_9, 0.35, Enum.EasingDirection.Out)
		task.wait(0.2)
		v_u_61(p62, p63, v66)
		task.wait(1.5)
		v_u_23:set(false)
		v_u_25:set(false)
		v_u_48(v_u_8, 0.3, Enum.EasingDirection.In)
	end
end
local function v_u_70() -- name: processQueue
	-- upvalues: (ref) v_u_19, (copy) v_u_18, (copy) v_u_68
	if not v_u_19 then
		v_u_19 = true
		while #v_u_18 > 0 do
			local v69 = table.remove(v_u_18, 1)
			v_u_68(v69.oldXP, v69.newXP, v69.oldSP, v69.newSP)
			if #v_u_18 > 0 then
				task.wait(0.3)
			end
		end
		v_u_19 = false
	end
end
v6.XPChanged:Connect(function(p71, p72, p73, p74)
	-- upvalues: (copy) v_u_18, (copy) v_u_70
	local v75 = v_u_18
	table.insert(v75, {
		["oldXP"] = p71,
		["newXP"] = p72,
		["oldSP"] = p73,
		["newSP"] = p74
	})
	task.spawn(v_u_70)
end)
return {}