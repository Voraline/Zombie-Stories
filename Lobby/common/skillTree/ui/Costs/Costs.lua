local v1 = game:GetService("ReplicatedStorage").Packages
local v2 = require(v1.Fusion)
local v_u_3 = v2.Children
local _ = v2.ForPairs
local v_u_4 = require("./CostTemplate")
return function(p5)
	-- upvalues: (copy) v_u_4, (copy) v_u_3
	local v6 = p5.scope
	local v10 = v6:ForPairs(p5.Costs or {}, function(_, p7, p8, p9)
		-- upvalues: (ref) v_u_4
		return p8, v_u_4({
			["scope"] = p7,
			["CostType"] = p9.type,
			["Amount"] = p9.amount,
			["LayoutOrder"] = p8
		})
	end)
	return v6:New("Frame")({
		["Name"] = "Costs",
		["BackgroundTransparency"] = 1,
		["BorderSizePixel"] = 0,
		["LayoutOrder"] = 4,
		["Size"] = UDim2.fromScale(1, 0.3),
		[v_u_3] = { v6:New("UIListLayout")({
				["Name"] = "UIListLayout",
				["FillDirection"] = nil,
				["HorizontalAlignment"] = nil,
				["Padding"] = nil,
				["SortOrder"] = nil,
				["VerticalAlignment"] = nil,
				["FillDirection"] = Enum.FillDirection.Horizontal,
				["HorizontalAlignment"] = Enum.HorizontalAlignment.Center,
				["Padding"] = UDim.new(0, 2),
				["SortOrder"] = Enum.SortOrder.LayoutOrder,
				["VerticalAlignment"] = Enum.VerticalAlignment.Center
			}), v10 }
	})
end