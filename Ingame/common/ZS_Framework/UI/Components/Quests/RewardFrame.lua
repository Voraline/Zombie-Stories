local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("RunService")
require(v1.Packages.Fusion)
local v_u_3 = require(v1.common.ZS_Shared.Data.RewardsData)
local v4 = nil
local v_u_5
if v2:IsClient() then
	local v6
	v6, v_u_5 = pcall(require, v1.common.skillTree.SkillTreeData)
	if not v6 then
		v_u_5 = v4
	end
else
	v_u_5 = v4
end
return function(p_u_7)
	-- upvalues: (copy) v_u_3, (ref) v_u_5
	local v8 = p_u_7.scope:innerScope()
	local v32 = v8:ForPairs(p_u_7.Rewards, function(_, p9, p10, p11)
		-- upvalues: (ref) v_u_3, (ref) v_u_5, (copy) p_u_7
		local v12 = v_u_3[p10]
		local v13 = v12.LayoutOrder
		if p10 == "ZBucks" then
			local v14 = p11.Amount
			if v12.Tier3.Amount <= v14 then
				v12 = v12.Tier3
			elseif v12.Tier2.Amount <= v14 then
				v12 = v12.Tier2
			else
				v12 = v12.Tier1
			end
		end
		if p11.Type then
			v12 = v12[p11.Type]
		end
		local v15 = v12.Image
		local v16 = v12.Text or ""
		local v17 = v12.TextRotation or 0
		local v18 = v12.TextOffset or 0
		local v19
		if p10 == "SP" and (v_u_5 and v_u_5.AtSPCap) then
			local v20 = p9:New("TextLabel")
			local v21 = {
				["Name"] = "SPCapX",
				["AnchorPoint"] = Vector2.new(0.5, 0.5),
				["BackgroundTransparency"] = 1,
				["FontFace"] = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold),
				["Position"] = UDim2.fromScale(0.5, 0.5),
				["Rotation"] = 0,
				["Size"] = UDim2.fromScale(0.8, 0.8),
				["Text"] = "X",
				["TextColor3"] = Color3.fromRGB(255, 50, 50),
				["TextScaled"] = true,
				["Visible"] = v_u_5.AtSPCap,
				["ZIndex"] = 10,
				[p9.Children] = { p9:New("UIStroke")({
						["Thickness"] = 3,
						["Color"] = nil,
						["Color"] = Color3.new(0, 0, 0)
					}) }
			}
			v19 = v20(v21)
		else
			v19 = nil
		end
		local v22 = p9:New("Frame")
		local v23 = {
			["Size"] = UDim2.new(0.33, 0, 0.85, 0),
			["BackgroundColor3"] = Color3.new(0, 0, 0),
			["BackgroundTransparency"] = 1,
			["LayoutOrder"] = v13
		}
		local v24 = p9.Children
		local v25 = {}
		local v26 = p9:New("ImageLabel")({
			["Image"] = nil,
			["BackgroundTransparency"] = 1,
			["Size"] = nil,
			["ScaleType"] = nil,
			["Image"] = v15,
			["Size"] = UDim2.new(1, 0, 1, 0),
			["ScaleType"] = Enum.ScaleType.Fit
		})
		local v27 = p9:New("TextLabel")
		local v28 = {
			["Text"] = v16,
			["TextColor3"] = Color3.new(1, 1, 1),
			["BackgroundTransparency"] = 1,
			["TextScaled"] = true,
			["Font"] = Enum.Font.GothamBold,
			["TextXAlignment"] = Enum.TextXAlignment.Left,
			["AnchorPoint"] = Vector2.new(1, 1),
			["Position"] = UDim2.new(1, 0, 0.4 + v18, 0),
			["Size"] = UDim2.new(1, 0, 0.4, 0),
			["ZIndex"] = 2,
			["Rotation"] = v17,
			[p9.Children] = { p9:New("UIStroke")({
					["Thickness"] = p_u_7.StrokeSize,
					["Color"] = Color3.new(0, 0, 0)
				}) }
		}
		local v29 = v27(v28)
		local v30 = p9:New("TextLabel")
		local v31 = {
			["Text"] = "+" .. p11.Amount,
			["TextColor3"] = Color3.new(1, 1, 1),
			["BackgroundTransparency"] = 1,
			["TextScaled"] = true,
			["Font"] = Enum.Font.GothamBold,
			["TextXAlignment"] = Enum.TextXAlignment.Right,
			["AnchorPoint"] = Vector2.new(1, 1),
			["Position"] = UDim2.new(1, 0, 1, 0),
			["Size"] = UDim2.new(1, 0, 0.4, 0),
			["ZIndex"] = 2,
			[p9.Children] = { p9:New("UIStroke")({
					["Thickness"] = p_u_7.StrokeSize,
					["Color"] = Color3.new(0, 0, 0)
				}) }
		}
		__set_list(v25, 1, {v26, v19, v29, v30(v31)})
		v23[v24] = v25
		return p10, v22(v23)
	end)
	local v33 = v8:New("Frame")
	local v34 = {
		["Size"] = p_u_7.Size,
		["BackgroundColor3"] = Color3.new(0, 0, 0),
		["BackgroundTransparency"] = 0.75,
		[v8.Children] = {
			v8:New("UIListLayout")({
				["FillDirection"] = Enum.FillDirection.Horizontal,
				["HorizontalAlignment"] = Enum.HorizontalAlignment.Center,
				["VerticalAlignment"] = Enum.VerticalAlignment.Center,
				["HorizontalFlex"] = Enum.UIFlexAlignment.SpaceEvenly,
				["SortOrder"] = Enum.SortOrder.LayoutOrder
			}),
			v32,
			v8:New("UICorner")({
				["CornerRadius"] = p_u_7.CornerRadius
			}),
			v8:New("UIStroke")({
				["Thickness"] = p_u_7.StrokeSize,
				["Color"] = p_u_7.StrokeColor,
				["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border
			})
		}
	}
	return v33(v34)
end