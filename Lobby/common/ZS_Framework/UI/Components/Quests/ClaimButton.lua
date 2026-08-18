local v1 = game:GetService("ReplicatedStorage")
require(v1.Packages.Fusion)
local v_u_2 = require("../GenericButton")
return function(p_u_3)
	-- upvalues: (copy) v_u_2
	local v4 = p_u_3.scope:innerScope()
	return v_u_2({
		["OnClick"] = nil,
		["Size"] = nil,
		["Position"] = nil,
		["AnchorPoint"] = nil,
		["Children"] = nil,
		["BackgroundTransparency"] = 0.75,
		["scope"] = nil,
		["OnClick"] = p_u_3.OnClaim,
		["Size"] = p_u_3.Size,
		["Position"] = p_u_3.Position or UDim2.new(0, 0, 0, 0),
		["AnchorPoint"] = Vector2.new(0.5, 0.5),
		["Children"] = { v4:New("TextLabel")({
				["Text"] = nil,
				["Size"] = nil,
				["Position"] = nil,
				["AnchorPoint"] = nil,
				["BackgroundTransparency"] = 1,
				["TextScaled"] = true,
				["TextColor3"] = nil,
				["Font"] = nil,
				["Text"] = v4:Computed(function(p5)
					-- upvalues: (copy) p_u_3
					return p5(p_u_3.IsClaimed) and "CLAIMED" or (p5(p_u_3.IsCompleted) and "CLAIM" or "IN PROGRESS")
				end),
				["Size"] = UDim2.new(0.9, 0, 0.9, 0),
				["Position"] = UDim2.new(0.5, 0, 0.5, 0),
				["AnchorPoint"] = Vector2.new(0.5, 0.5),
				["TextColor3"] = Color3.new(1, 1, 1),
				["Font"] = Enum.Font.GothamBold
			}), v4:New("UIStroke")({
				["Thickness"] = p_u_3.StrokeSize,
				["Color"] = p_u_3.StrokeColor,
				["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border
			}), v4:New("UICorner")({
				["CornerRadius"] = p_u_3.CornerRadius
			}) },
		["scope"] = v4
	})
end