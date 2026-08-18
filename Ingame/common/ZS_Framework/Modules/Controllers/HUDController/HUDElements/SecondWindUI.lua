local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
require(v2.common.Assets.assets)
local v3 = require(v2.Packages.Fusion)
local v4 = v3.scoped
local v_u_5 = v3.peek
local v6 = v3.Children
require("@game/ReplicatedStorage/common/HUDService")
local v7 = require("@game/ReplicatedStorage/common/PlayerHandler")
local v_u_8 = require(v2.common.skillTree.SkillTreeData)
local v9 = require(v2.common.Assets.assets)
local v10 = v4(v3)
local v_u_11 = v10:Value(false)
local v_u_12 = v10:Value(0)
local v_u_13 = v7:WaitForPlayerState(v1.LocalPlayer)
local v15 = v10:Computed(function(p14)
	-- upvalues: (copy) v_u_12
	return UDim2.fromScale(p14(v_u_12), 1)
end)
local v16 = v10:New("ScreenGui")
local v17 = {
	["Name"] = "SecondWindUI",
	["Parent"] = v1.LocalPlayer:WaitForChild("PlayerGui"),
	["ResetOnSpawn"] = false,
	["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling,
	["Enabled"] = v_u_11
}
local v18 = {}
local v19 = v10:New("Frame")
local v20 = {
	["Name"] = "SecondWindFrame",
	["AnchorPoint"] = Vector2.new(0.5, 0),
	["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
	["BackgroundTransparency"] = 1,
	["BorderColor3"] = Color3.fromRGB(0, 0, 0),
	["BorderSizePixel"] = 0,
	["Position"] = UDim2.fromScale(0.5, 0.55),
	["Size"] = UDim2.fromScale(0.2, 0.1)
}
local v21 = {}
local v22 = v10:New("UIListLayout")({
	["Name"] = "UIListLayout",
	["FillDirection"] = nil,
	["SortOrder"] = nil,
	["VerticalAlignment"] = nil,
	["FillDirection"] = Enum.FillDirection.Horizontal,
	["SortOrder"] = Enum.SortOrder.LayoutOrder,
	["VerticalAlignment"] = Enum.VerticalAlignment.Center
})
local v23 = v10:New("Frame")
local v24 = {
	["Name"] = "ProgressBar",
	["BackgroundColor3"] = Color3.fromRGB(0, 0, 0),
	["BackgroundTransparency"] = 0.5,
	["BorderColor3"] = Color3.fromRGB(0, 0, 0),
	["BorderSizePixel"] = 0,
	["LayoutOrder"] = 1,
	["Size"] = UDim2.new(0.6, 0, 0, 10)
}
local v25 = {}
local v26 = v10:New("UICorner")({
	["Name"] = "UICorner",
	["CornerRadius"] = nil,
	["CornerRadius"] = UDim.new(0, 3)
})
local v27 = v10:New("Frame")
local v28 = {
	["Name"] = "Fill",
	["BackgroundColor3"] = Color3.fromRGB(80, 159, 255),
	["BorderColor3"] = Color3.fromRGB(0, 0, 0),
	["BorderSizePixel"] = 0,
	["Size"] = v15,
	[v6] = { v10:New("UICorner")({
			["Name"] = "UICorner",
			["CornerRadius"] = nil,
			["CornerRadius"] = UDim.new(0, 3)
		}) }
}
__set_list(v25, 1, {v26, v27(v28)})
v24[v6] = v25
local v29 = v23(v24)
local v30 = v10:New("Frame")
local v31 = {
	["Name"] = "ImageContainer",
	["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
	["BackgroundTransparency"] = 1,
	["BorderColor3"] = Color3.fromRGB(0, 0, 0),
	["BorderSizePixel"] = 0,
	["Size"] = UDim2.fromScale(1, 1)
}
local v32 = {}
local v33 = v10:New("UIAspectRatioConstraint")({
	["Name"] = "UIAspectRatioConstraint"
})
local v34 = v10:New("ImageLabel")
local v35 = {
	["Name"] = "ImageLabel",
	["AnchorPoint"] = Vector2.new(0.5, 0.5),
	["BackgroundColor3"] = Color3.fromRGB(0, 0, 0),
	["BackgroundTransparency"] = 0.9,
	["BorderColor3"] = Color3.fromRGB(0, 0, 0),
	["BorderSizePixel"] = 0,
	["Image"] = v9.Images.SkillTree.secondWind,
	["ImageColor3"] = Color3.fromRGB(124, 224, 255),
	["Position"] = UDim2.fromScale(0.5, 0.5),
	["ScaleType"] = Enum.ScaleType.Fit,
	["Size"] = UDim2.fromScale(0.8, 0.8),
	[v6] = { v10:New("UICorner")({
			["Name"] = "UICorner",
			["CornerRadius"] = nil,
			["CornerRadius"] = UDim.new(1, 0)
		}) }
}
__set_list(v32, 1, {v33, v34(v35)})
v31[v6] = v32
__set_list(v21, 1, {v22, v29, v30(v31)})
v20[v6] = v21
__set_list(v18, 1, {v19(v20)})
v17[v6] = v18
v16(v17)
local v_u_36 = {
	["IsShowing"] = false,
	["Show"] = function(_) -- name: Show
		-- upvalues: (copy) v_u_11, (copy) v_u_36
		v_u_11:set(true)
		v_u_36.IsShowing = true
	end,
	["Hide"] = function(_) -- name: Hide
		-- upvalues: (copy) v_u_11, (copy) v_u_36
		v_u_11:set(false)
		v_u_36.IsShowing = false
	end
}
local function v41() -- name: updateUI
	-- upvalues: (copy) v_u_5, (copy) v_u_8, (copy) v_u_13, (copy) v_u_11, (copy) v_u_36, (copy) v_u_12
	local v37 = v_u_5(v_u_8.HasSecondWind)
	local v38 = v_u_13.IsDowned
	local v39 = v_u_13.SecondWindUsed
	if v38 then
		if v37 then
			v37 = not v39
		end
	else
		v37 = v38
	end
	v_u_11:set(v37)
	v_u_36.IsShowing = v37
	if v37 then
		local v40 = (v_u_13.SecondWindDamage or 0) / (v_u_13.SecondWindMaxDamage or 100)
		v_u_12:set((math.clamp(v40, 0, 1)))
	end
end
v_u_13:GetPropertyChangedSignal("IsDowned"):Connect(v41)
v_u_13:GetPropertyChangedSignal("SecondWindDamage"):Connect(v41)
v_u_13:GetPropertyChangedSignal("SecondWindMaxDamage"):Connect(v41)
v10:Observer(v_u_8.HasSecondWind):onChange(v41)
v41()
return v_u_36