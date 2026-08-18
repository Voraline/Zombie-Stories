local v1 = game:GetService("ReplicatedStorage")
require(v1.Packages.Fusion)
local v_u_2 = require(v1.common.fusion_utils)
local v_u_3 = require("../GenericButton")
return function(p4)
	-- upvalues: (copy) v_u_2, (copy) v_u_3
	local v5 = p4.scope:innerScope(v_u_2)
	local v6 = p4.Visible or v5:Value(true)
	local v_u_7 = v5:usePx()(1)
	local v10 = v5:Computed(function(p8)
		-- upvalues: (copy) v_u_7
		local v9 = p8(v_u_7)
		return UDim.new(0, v9 * 6)
	end)
	local v13 = v5:Computed(function(p11)
		-- upvalues: (copy) v_u_7
		local v12 = p11(v_u_7)
		return UDim.new(0, v12 * 24)
	end)
	local v16 = v5:Computed(function(p14)
		-- upvalues: (copy) v_u_7
		local v15 = p14(v_u_7)
		return UDim.new(0, v15 * 8)
	end)
	local v17 = v5:New("Frame")
	local v18 = {
		["Parent"] = p4.target,
		["Size"] = UDim2.new(1, 0, 1, 0),
		["BackgroundTransparency"] = 1,
		["Visible"] = v6,
		[v5.Children] = { v5:New("Frame")({
				["Size"] = UDim2.new(0.15, 0, 0.4, 0),
				["Position"] = UDim2.new(0.985, 0, 0.925, 0),
				["AnchorPoint"] = Vector2.new(1, 1),
				["BackgroundTransparency"] = 1,
				[v5.Children] = { v5:New("UIListLayout")({
						["FillDirection"] = Enum.FillDirection.Vertical,
						["SortOrder"] = Enum.SortOrder.LayoutOrder,
						["HorizontalAlignment"] = Enum.HorizontalAlignment.Right,
						["VerticalAlignment"] = Enum.VerticalAlignment.Bottom,
						["Padding"] = v13
					}), v_u_3({
						["scope"] = nil,
						["Size"] = nil,
						["Position"] = nil,
						["AnchorPoint"] = nil,
						["TextScaled"] = true,
						["Text"] = "SERVER BROWSER",
						["OnClick"] = nil,
						["BackgroundColor3"] = nil,
						["BackgroundTransparency"] = 0,
						["Font"] = nil,
						["LayoutOrder"] = 1,
						["Children"] = nil,
						["scope"] = v5,
						["Size"] = UDim2.new(1, 0, 0.25, 0),
						["Position"] = UDim2.new(0, 0, 0.5, 0),
						["AnchorPoint"] = Vector2.new(0.5, 0.5),
						["OnClick"] = p4.OnClickServerBrowser,
						["BackgroundColor3"] = Color3.new(0.133333, 0.215686, 0.454902),
						["Font"] = Enum.Font.GothamBold,
						["Children"] = { v5:New("UICorner")({
								["CornerRadius"] = v10
							}), v5:New("UIPadding")({
								["PaddingTop"] = v16,
								["PaddingBottom"] = v16,
								["PaddingLeft"] = v16,
								["PaddingRight"] = v16
							}) }
					}), v_u_3({
						["scope"] = nil,
						["Size"] = nil,
						["Position"] = nil,
						["AnchorPoint"] = nil,
						["TextScaled"] = true,
						["Text"] = nil,
						["OnClick"] = nil,
						["BackgroundColor3"] = nil,
						["BackgroundTransparency"] = 0,
						["LayoutOrder"] = 2,
						["Font"] = nil,
						["Children"] = nil,
						["scope"] = v5,
						["Size"] = UDim2.new(1, 0, 0.25, 0),
						["Position"] = UDim2.new(0, 0, 0.5, 0),
						["AnchorPoint"] = Vector2.new(0.5, 0.5),
						["Text"] = p4.LobbyButtonText,
						["OnClick"] = p4.OnClickLobby,
						["BackgroundColor3"] = Color3.new(0.133333, 0.215686, 0.454902),
						["Font"] = Enum.Font.GothamBold,
						["Children"] = { v5:New("UICorner")({
								["CornerRadius"] = v10
							}), v5:New("UIPadding")({
								["PaddingTop"] = v16,
								["PaddingBottom"] = v16,
								["PaddingLeft"] = v16,
								["PaddingRight"] = v16
							}) }
					}) }
			}), v5:New("Frame")({
				["Size"] = UDim2.new(0.35, 0, 0.1, 0),
				["AnchorPoint"] = Vector2.new(0.5, 1),
				["Position"] = UDim2.new(0.5, 0, 0.925, 0),
				["BackgroundColor3"] = Color3.new(0, 0, 0),
				["BackgroundTransparency"] = 1,
				[v5.Children] = {
					v5:New("TextLabel")({
						["Text"] = "SPECTATING",
						["TextScaled"] = true,
						["TextColor3"] = nil,
						["Position"] = nil,
						["Size"] = nil,
						["BackgroundTransparency"] = 1,
						["Font"] = nil,
						["TextColor3"] = Color3.new(1, 1, 1),
						["Position"] = UDim2.new(0, 0, -0.31, 0),
						["Size"] = UDim2.new(1, 0, 0.3, 0),
						["Font"] = Enum.Font.GothamBold
					}),
					v5:New("TextLabel")({
						["Text"] = p4.Spectating,
						["TextScaled"] = true,
						["TextColor3"] = Color3.new(1, 1, 1),
						["Size"] = UDim2.new(0.7, 0, 1, 0),
						["AnchorPoint"] = Vector2.new(0.5, 0.5),
						["Position"] = UDim2.new(0.5, 0, 0.5, 0),
						["BackgroundColor3"] = Color3.new(0.133333, 0.215686, 0.454902),
						["BackgroundTransparency"] = 0,
						["Font"] = Enum.Font.GothamBold,
						[v5.Children] = { v5:New("UIPadding")({
								["PaddingLeft"] = UDim.new(0.05, 0),
								["PaddingRight"] = UDim.new(0.05, 0)
							}), v5:New("UICorner")({
								["CornerRadius"] = v10
							}) }
					}),
					v_u_3({
						["scope"] = nil,
						["Size"] = nil,
						["Position"] = nil,
						["AnchorPoint"] = nil,
						["TextScaled"] = true,
						["Font"] = nil,
						["Text"] = "<",
						["OnClick"] = nil,
						["BackgroundColor3"] = nil,
						["BackgroundTransparency"] = 0,
						["Children"] = nil,
						["scope"] = v5,
						["Size"] = UDim2.new(0.2, 0, 1, 0),
						["Position"] = UDim2.new(0, 0, 0.5, 0),
						["AnchorPoint"] = Vector2.new(0.5, 0.5),
						["Font"] = Enum.Font.GothamBold,
						["OnClick"] = p4.OnClickLeft,
						["BackgroundColor3"] = Color3.new(0.133333, 0.215686, 0.454902),
						["Children"] = { v5:New("UICorner")({
								["CornerRadius"] = v10
							}) }
					}),
					v_u_3({
						["scope"] = nil,
						["Size"] = nil,
						["Position"] = nil,
						["AnchorPoint"] = nil,
						["TextScaled"] = true,
						["Font"] = nil,
						["Text"] = ">",
						["OnClick"] = nil,
						["BackgroundColor3"] = nil,
						["BackgroundTransparency"] = 0,
						["Children"] = nil,
						["scope"] = v5,
						["Size"] = UDim2.new(0.2, 0, 1, 0),
						["Position"] = UDim2.new(1, 0, 0.5, 0),
						["AnchorPoint"] = Vector2.new(0.5, 0.5),
						["Font"] = Enum.Font.GothamBold,
						["OnClick"] = p4.OnClickRight,
						["BackgroundColor3"] = Color3.new(0.133333, 0.215686, 0.454902),
						["Children"] = { v5:New("UICorner")({
								["CornerRadius"] = v10
							}) }
					})
				}
			}) }
	}
	return v17(v18)
end