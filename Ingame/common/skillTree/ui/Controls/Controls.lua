local v1 = game:GetService("ReplicatedStorage").Packages
local v_u_2 = require(v1.Fusion).Children
local v_u_3 = require("./BuyButton")
require("./ExitButton")
return function(p4)
	-- upvalues: (copy) v_u_2, (copy) v_u_3
	local v5 = p4.scope
	local v6 = v5:New("Frame")
	local v7 = {
		["Name"] = "Controls",
		["BackgroundTransparency"] = 1,
		["BorderSizePixel"] = 0,
		["LayoutOrder"] = 5,
		["Size"] = UDim2.fromScale(1, 0.3),
		[v_u_2] = { v5:New("UIListLayout")({
				["Name"] = "UIListLayout",
				["FillDirection"] = nil,
				["HorizontalAlignment"] = nil,
				["Padding"] = nil,
				["SortOrder"] = nil,
				["VerticalAlignment"] = nil,
				["FillDirection"] = Enum.FillDirection.Horizontal,
				["HorizontalAlignment"] = Enum.HorizontalAlignment.Center,
				["Padding"] = UDim.new(0, 5),
				["SortOrder"] = Enum.SortOrder.LayoutOrder,
				["VerticalAlignment"] = Enum.VerticalAlignment.Center
			}), v5:New("UIPadding")({
				["Name"] = "UIPadding",
				["PaddingBottom"] = nil,
				["PaddingTop"] = nil,
				["PaddingBottom"] = UDim.new(0.1, 0),
				["PaddingTop"] = UDim.new(0.1, 0)
			}), v_u_3({
				["scope"] = v5,
				["OnClick"] = p4.OnBuy,
				["Enabled"] = p4.BuyEnabled
			}) }
	}
	return v6(v7)
end