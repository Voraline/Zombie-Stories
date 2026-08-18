local v1 = game:GetService("ReplicatedStorage").Packages
local v2 = require(v1.Fusion)
local v_u_3 = v2.Children
local v_u_4 = v2.OnEvent
return function(p_u_5)
	-- upvalues: (copy) v_u_4, (copy) v_u_3
	local v6 = p_u_5.scope
	local v7 = v6:New("TextButton")
	local v8 = {
		["Name"] = "Exit",
		["BackgroundColor3"] = Color3.fromRGB(255, 120, 120),
		["BorderSizePixel"] = 0,
		["FontFace"] = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
		["RichText"] = true,
		["Size"] = UDim2.fromScale(0.8, 1),
		["SizeConstraint"] = Enum.SizeConstraint.RelativeYY,
		["Text"] = "X",
		["TextColor3"] = Color3.fromRGB(255, 255, 255),
		["TextScaled"] = true,
		[v_u_4("Activated")] = function()
			-- upvalues: (copy) p_u_5
			if p_u_5.OnClick then
				p_u_5.OnClick()
			end
		end,
		[v_u_3] = {
			v6:New("UICorner")({
				["Name"] = "UICorner",
				["CornerRadius"] = nil,
				["CornerRadius"] = UDim.new(0.1, 0)
			}),
			v6:New("UIStroke")({
				["Name"] = "UIStroke",
				["StrokeSizingMode"] = "ScaledSize",
				["Thickness"] = 0.05
			}),
			v6:New("UIStroke")({
				["Name"] = "UIStrokeBorder",
				["ApplyStrokeMode"] = nil,
				["Thickness"] = 0.06,
				["Transparency"] = 0.57,
				["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border
			}),
			v6:New("UIAspectRatioConstraint")({
				["Name"] = "UIAspectRatioConstraint",
				["AspectRatio"] = 0.91
			})
		}
	}
	return v7(v8)
end