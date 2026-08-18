local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Packages.Fusion)
local v3 = v2.Children
local v_u_4 = v2.peek
local v5 = require("../../Data/PlayerDatabase")
local v6 = require("@game/ReplicatedStorage/common/zap")
local v_u_7 = v2.scoped(v2)
local v_u_8 = v_u_7:New("Frame")({
	["Size"] = UDim2.new(0.35, 0, 0.25, 0),
	["Position"] = UDim2.new(0.5, 0, 0.15, 0),
	["AnchorPoint"] = Vector2.new(0.5, 0.5),
	["BackgroundColor3"] = Color3.new(0, 0, 0),
	["BackgroundTransparency"] = 1,
	[v3] = {}
})
v_u_7:New("ScreenGui")({
	["Parent"] = v5.PlayerGui,
	["DisplayOrder"] = 10,
	[v3] = { v_u_8 }
})
local v_u_9 = {}
local v_u_10 = {
	[0] = {
		["TextColor3"] = Color3.fromRGB(255, 0, 0)
	},
	[1] = {
		["TextColor3"] = Color3.fromRGB(23, 255, 54)
	},
	[2] = {
		["TextColor3"] = Color3.fromRGB(255, 255, 255)
	}
}
local v_u_11 = 0
local function v_u_26(p12, p13, p14) -- name: createMessagePrompt
	-- upvalues: (copy) v_u_7, (ref) v_u_11, (copy) v_u_9, (copy) v_u_4, (copy) v_u_8, (copy) v_u_10
	local v_u_15 = v_u_7:innerScope()
	local v_u_16 = v_u_15:Value(1)
	local v_u_17 = v_u_15:Value(1)
	local v_u_18 = v_u_15:Value(v_u_11 + 1)
	v_u_11 = v_u_11 + 1
	local v_u_19 = nil
	v_u_19 = {
		["prompt"] = nil,
		["index"] = v_u_18,
		["durationTask"] = task.delay(3, function()
			-- upvalues: (ref) v_u_9, (ref) v_u_4, (ref) v_u_19, (ref) v_u_11, (copy) v_u_16, (copy) v_u_17, (copy) v_u_15
			for _, v20 in v_u_9 do
				local v21 = v_u_4(v20.index)
				local v22
				if v21 == 0 then
					v22 = v21 - 2
				else
					v22 = v21 - 1
				end
				v20.index:set(v22)
			end
			v_u_9[v_u_19] = nil
			v_u_11 = v_u_11 - 1
			v_u_16:set(1)
			v_u_17:set(1)
			task.wait(1)
			v_u_15:doCleanup()
		end)
	}
	local v23 = v_u_15:New("TextLabel")
	local v25 = {
		["Parent"] = v_u_8,
		["Size"] = UDim2.new(1, 0, 0.275, 0),
		["Position"] = v_u_15:Spring(v_u_15:Computed(function(p24)
			-- upvalues: (copy) v_u_18
			return UDim2.new(0.5, 0, 0.1 + p24(v_u_18) * 0.16, 0)
		end), 10, 1),
		["AnchorPoint"] = Vector2.new(0.5, 0),
		["BackgroundTransparency"] = 1,
		["Text"] = string.upper(p12),
		["Font"] = Enum.Font.GothamBlack,
		["TextScaled"] = true,
		["TextColor3"] = v_u_10[p14].TextColor3,
		["TextXAlignment"] = Enum.TextXAlignment.Center,
		["TextStrokeTransparency"] = v_u_15:Spring(v_u_17, 10, 1),
		["TextTransparency"] = v_u_15:Spring(v_u_16, 10, 1),
		["TextStrokeColor3"] = Color3.new(0, 0, 0),
		[v_u_15.Children] = { v_u_15:New("TextLabel")({
				["Size"] = nil,
				["Position"] = nil,
				["AnchorPoint"] = nil,
				["Text"] = nil,
				["Font"] = nil,
				["BackgroundTransparency"] = 1,
				["TextXAlignment"] = nil,
				["TextStrokeTransparency"] = nil,
				["TextTransparency"] = nil,
				["TextStrokeColor3"] = nil,
				["TextScaled"] = true,
				["TextColor3"] = nil,
				["Size"] = UDim2.new(1, 0, 0.33, 0),
				["Position"] = UDim2.new(0, 0, 1, 0),
				["AnchorPoint"] = Vector2.new(0, 0),
				["Text"] = string.upper(p13),
				["Font"] = Enum.Font.GothamBold,
				["TextXAlignment"] = Enum.TextXAlignment.Center,
				["TextStrokeTransparency"] = v_u_15:Spring(v_u_17, 10, 1),
				["TextTransparency"] = v_u_15:Spring(v_u_16, 10, 1),
				["TextStrokeColor3"] = Color3.new(0, 0, 0),
				["TextColor3"] = v_u_10[p14].TextColor3
			}) }
	}
	v23(v25)
	v_u_16:set(0)
	v_u_17:set(0.5)
	v_u_18:set(v_u_4(v_u_18) - 1)
	v_u_9[v_u_19] = v_u_19
end
v6.BannerMessage.On(function(p27)
	-- upvalues: (copy) v_u_26
	v_u_26(p27.header, p27.message, p27.type)
end)
v5.Signals.BannerMessage:Connect(function(p28, p29, p30)
	-- upvalues: (copy) v_u_26
	v_u_26(p28, p29, p30)
end)
return {}