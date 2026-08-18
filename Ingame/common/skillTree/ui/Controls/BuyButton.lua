local v1 = game:GetService("ReplicatedStorage").Packages
local v2 = require(v1.Fusion)
local v_u_3 = v2.Children
local v_u_4 = v2.OnEvent
return function(p_u_5)
	-- upvalues: (copy) v_u_4, (copy) v_u_3
	local v6 = p_u_5.scope
	local v_u_9 = v6:Computed(function(p7)
		-- upvalues: (copy) p_u_5
		local v8 = p_u_5.Enabled
		return v8 == nil and true or p7(v8)
	end)
	local v11 = v6:Computed(function(p10)
		-- upvalues: (copy) v_u_9
		if p10(v_u_9) then
			return Color3.fromRGB(115, 216, 79)
		else
			return Color3.fromRGB(100, 100, 100)
		end
	end)
	local v12 = v6:New("TextButton")
	local v13 = {
		["Name"] = "Buy",
		["BackgroundColor3"] = v11,
		["BorderSizePixel"] = 0,
		["FontFace"] = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
		["RichText"] = true,
		["Size"] = UDim2.fromScale(3, 1),
		["SizeConstraint"] = Enum.SizeConstraint.RelativeYY,
		["Text"] = "Buy",
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
				["AspectRatio"] = 2.93
			})
		}
	}
	return v12(v13)
end