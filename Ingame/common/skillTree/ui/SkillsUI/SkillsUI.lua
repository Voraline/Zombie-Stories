local v1 = game:GetService("ReplicatedStorage")
local v2 = v1.Packages
local v_u_3 = require(v2.Fusion).Children
local v_u_4 = require(v1.common.skillTree.config.SkillConfig)
local v_u_5 = require(v1.common.skillTree.SkillTreeData)
local v_u_6 = require("../Controls/Controls")
local v_u_7 = require("../Costs/Costs")
return function(p_u_8)
	-- upvalues: (copy) v_u_4, (copy) v_u_5, (copy) v_u_3, (copy) v_u_7, (copy) v_u_6
	local v9 = p_u_8.scope
	local v_u_22 = v9:Computed(function(p10)
		-- upvalues: (copy) p_u_8, (ref) v_u_4
		local v11 = p10(p_u_8.SelectedSkillId)
		if not v11 then
			return {}
		end
		local v12 = v_u_4.getSkill(v11)
		if not (v12 and v12.costs) then
			return {}
		end
		local v13 = p_u_8.CurrentRank and p10(p_u_8.CurrentRank) or 0
		local v14 = v13 + 1
		if v12.maxRank <= v13 then
			return {}
		end
		local v15 = {}
		if v12.firstRankOnlyCosts then
			for _, v16 in v12.firstRankOnlyCosts do
				v15[v16] = true
			end
		end
		local v17 = {}
		for _, v18 in v12.costs do
			if not v15[v18.type] or v14 <= 1 then
				local v19 = v18.amount
				if v18.type ~= "SP" then
					local v20 = v18.amount * v14
					v19 = math.floor(v20)
				end
				local v21 = {
					["type"] = v18.type,
					["amount"] = v19
				}
				table.insert(v17, v21)
			end
		end
		return v17
	end)
	local v26 = v9:Computed(function(p23)
		-- upvalues: (copy) v_u_22, (ref) v_u_5
		local v24 = p23(v_u_22)
		if #v24 == 0 then
			return false
		end
		for _, v25 in v24 do
			if v25.type == "SP" and p23(v_u_5.SP) < v25.amount then
				return false
			end
		end
		return true
	end)
	local v29 = v9:Computed(function(p27)
		-- upvalues: (copy) p_u_8
		local v28 = p_u_8.Visible
		return v28 == nil and true or p27(v28)
	end)
	local v30 = v9:New("Frame")
	local v31 = {
		["Name"] = "SkillsUI",
		["AnchorPoint"] = Vector2.new(0.5, 1),
		["BackgroundTransparency"] = 1,
		["BorderSizePixel"] = 0,
		["Position"] = UDim2.fromScale(0.5, 1),
		["Size"] = UDim2.fromScale(1, 0.25),
		["Visible"] = v29,
		[v_u_3] = { v9:New("UIListLayout")({
				["Name"] = "UIListLayout",
				["HorizontalAlignment"] = nil,
				["SortOrder"] = nil,
				["HorizontalAlignment"] = Enum.HorizontalAlignment.Center,
				["SortOrder"] = Enum.SortOrder.LayoutOrder
			}), v_u_7({
				["scope"] = v9,
				["Costs"] = v_u_22
			}), v_u_6({
				["scope"] = v9,
				["OnBuy"] = p_u_8.OnBuy,
				["OnExit"] = p_u_8.OnExit,
				["BuyEnabled"] = v26
			}) }
	}
	return v30(v31)
end