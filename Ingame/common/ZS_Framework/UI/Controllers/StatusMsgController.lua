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
	["DisplayOrder"] = 100,
	["Name"] = "StatusMsg",
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
local function v_u_23(p12, p13) -- name: createMessagePrompt
	-- upvalues: (copy) v_u_7, (ref) v_u_11, (copy) v_u_9, (copy) v_u_4, (copy) v_u_8, (copy) v_u_10
	local v_u_14 = v_u_7:innerScope()
	local v_u_15 = v_u_14:Value(1)
	local v_u_16 = v_u_14:Value(1)
	local v_u_17 = v_u_14:Value(v_u_11 + 1)
	v_u_11 = v_u_11 + 1
	local v_u_18 = nil
	v_u_18 = {
		["prompt"] = nil,
		["index"] = v_u_17,
		["durationTask"] = task.delay(3, function()
			-- upvalues: (ref) v_u_9, (ref) v_u_4, (ref) v_u_18, (ref) v_u_11, (copy) v_u_15, (copy) v_u_16, (copy) v_u_14
			for _, v19 in v_u_9 do
				local v20 = v_u_4(v19.index)
				local v21
				if v20 == 0 then
					v21 = v20 - 2
				else
					v21 = v20 - 1
				end
				v19.index:set(v21)
			end
			v_u_9[v_u_18] = nil
			v_u_11 = v_u_11 - 1
			v_u_15:set(1)
			v_u_16:set(1)
			task.wait(1)
			v_u_14:doCleanup()
		end)
	}
	v_u_14:New("TextLabel")({
		["Parent"] = nil,
		["Size"] = nil,
		["Position"] = nil,
		["AnchorPoint"] = nil,
		["BackgroundTransparency"] = 1,
		["Text"] = nil,
		["Font"] = nil,
		["TextScaled"] = true,
		["TextColor3"] = nil,
		["TextXAlignment"] = nil,
		["TextStrokeTransparency"] = nil,
		["TextTransparency"] = nil,
		["TextStrokeColor3"] = nil,
		["Parent"] = v_u_8,
		["Size"] = UDim2.new(1, 0, 0.135, 0),
		["Position"] = v_u_14:Spring(v_u_14:Computed(function(p22)
			-- upvalues: (copy) v_u_17
			return UDim2.new(0.5, 0, 0.1 + p22(v_u_17) * 0.16, 0)
		end), 10, 1),
		["AnchorPoint"] = Vector2.new(0.5, 0),
		["Text"] = string.upper(p12),
		["Font"] = Enum.Font.GothamBold,
		["TextColor3"] = v_u_10[p13].TextColor3,
		["TextXAlignment"] = Enum.TextXAlignment.Center,
		["TextStrokeTransparency"] = v_u_14:Spring(v_u_16, 10, 1),
		["TextTransparency"] = v_u_14:Spring(v_u_15, 10, 1),
		["TextStrokeColor3"] = Color3.new(0, 0, 0)
	})
	v_u_15:set(0)
	v_u_16:set(0.5)
	v_u_17:set(v_u_4(v_u_17) - 1)
	v_u_9[v_u_18] = v_u_18
end
v6.StatusMessage.On(function(p24)
	-- upvalues: (copy) v_u_23
	v_u_23(p24.message, p24.type)
end)
v5.Signals.StatusMessage:Connect(function(p25, p26)
	-- upvalues: (copy) v_u_23
	v_u_23(p25, p26)
end)
return {}