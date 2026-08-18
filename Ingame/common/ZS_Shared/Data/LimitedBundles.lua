local v1 = {}
local v_u_2 = {}
local v3 = {
	["BundleId"] = "LIBERATOR_NIGHTHAVEN_AR45",
	["ProductId"] = 3610114698,
	["Name"] = "Liberator Nighthaven AR-45 Premium Skin [LIMITED]",
	["Description"] = "Includes:\n- Liberator Nighthaven AR-45 [TRADEABLE]\n- 2,000 Z$",
	["Currency"] = "Robux",
	["ImageId"] = 137600960893968,
	["Special"] = "PurpleGradient",
	["EndTimestamp"] = 1785556800,
	["IsDeveloperProduct"] = true,
	["ProductType"] = "DeveloperProduct",
	["PrimaryItemId"] = "1344",
	["Rewards"] = nil,
	["Rewards"] = {
		["ZBucks"] = 2000,
		["Items"] = nil,
		["Items"] = {
			{
				["ItemId"] = "1344",
				["Tradable"] = true
			}
		}
	}
}
local v4 = {
	["BundleId"] = "COLONIAL_WINCHESTER_1873",
	["ProductId"] = 3462043569,
	["Name"] = "Colonial Winchester 1873 Premium Skin [LIMITED]",
	["Description"] = "Includes:\n- Colonial Winchester 1873 [TRADEABLE]\n- 2,000 Z$",
	["Currency"] = "Robux",
	["ImageId"] = 131493567678988,
	["Special"] = "PurpleGradient",
	["EndTimestamp"] = 1765645200,
	["IsDeveloperProduct"] = true,
	["ProductType"] = "DeveloperProduct",
	["Events"] = nil,
	["Hidden"] = true,
	["PrimaryItemId"] = "1325",
	["Rewards"] = nil,
	["Events"] = { "THANKSGIVING2025" },
	["Rewards"] = {
		["ZBucks"] = 2000,
		["Items"] = nil,
		["Items"] = {
			{
				["ItemId"] = "1325",
				["Tradable"] = true
			}
		}
	}
}
local v5 = {
	["BundleId"] = "FRONTIER_MINUTEMAN",
	["ProductId"] = 3462423506,
	["Name"] = "Frontier Minuteman Premium Outfit [LIMITED]",
	["Description"] = "Includes:\n- Frontier Minuteman Outfit [TRADEABLE]\n- 3,000 Z$",
	["Currency"] = "Robux",
	["ImageId"] = 138237913361324,
	["Special"] = "PurpleGradient",
	["EndTimestamp"] = 1765645200,
	["IsDeveloperProduct"] = true,
	["ProductType"] = "DeveloperProduct",
	["Events"] = nil,
	["Hidden"] = true,
	["PrimaryItemId"] = "4039",
	["Rewards"] = nil,
	["Events"] = { "THANKSGIVING2025" },
	["Rewards"] = {
		["ZBucks"] = 3000,
		["Items"] = nil,
		["Items"] = {
			{
				["ItemId"] = "4039",
				["Tradable"] = true
			}
		}
	}
}
local v6 = {
	["BundleId"] = "DESOLATE_GAZE_BUNDLE",
	["ProductId"] = 3491113031,
	["Name"] = "Desolate Gaze Bundle",
	["Description"] = "Includes:\n- Desolate Gaze M200 Intervention [TRADEABLE]\n- Desolate Gaze Serbu Super Shorty [TRADEABLE]\n- Celyn [TRADEABLE]\n- 3,000 Z$",
	["Currency"] = "Robux",
	["Price"] = 699,
	["ImageId"] = 80390619281513,
	["Special"] = "PurpleGradient",
	["EndTimestamp"] = 1769896800,
	["IsDeveloperProduct"] = true,
	["ProductType"] = "DeveloperProduct",
	["Events"] = nil,
	["Hidden"] = true,
	["PrimaryItemId"] = "1332",
	["Rewards"] = nil,
	["Events"] = { "CHRISTMAS2025" },
	["Rewards"] = {
		["ZBucks"] = 3000,
		["Items"] = nil,
		["Items"] = {
			{
				["ItemId"] = "1332",
				["Tradable"] = true
			},
			{
				["ItemId"] = "2156",
				["Tradable"] = true
			},
			{
				["ItemId"] = "3114",
				["Tradable"] = true
			}
		}
	}
}
__set_list(v_u_2, 1, {v3, v4, v5, v6})
local function v_u_11(p7) -- name: deepCopy
	-- upvalues: (copy) v_u_11
	if typeof(p7) ~= "table" then
		return p7
	end
	local v8 = {}
	for v9, v10 in pairs(p7) do
		v8[v9] = v_u_11(v10)
	end
	return v8
end
function v1.GetAll() -- name: GetAll
	-- upvalues: (copy) v_u_2, (copy) v_u_11
	local v12 = {}
	for _, v13 in ipairs(v_u_2) do
		if not v13.Hidden then
			local v14 = v_u_11(v13)
			table.insert(v12, v14)
		end
	end
	return v12
end
function v1.GetShopEntries() -- name: GetShopEntries
	-- upvalues: (copy) v_u_2, (copy) v_u_11
	local v15 = {}
	for _, v16 in ipairs(v_u_2) do
		if not v16.Hidden then
			local v17 = v_u_11(v16)
			v17.Type = "Bundle"
			table.insert(v15, v17)
		end
	end
	return v15
end
function v1.GetEventEntries(p18) -- name: GetEventEntries
	-- upvalues: (copy) v_u_2, (copy) v_u_11
	local v19 = {}
	for _, v20 in ipairs(v_u_2) do
		if not v20.Hidden then
			if p18 and v20.Events then
				for _, v21 in ipairs(v20.Events) do
					if v21 == p18 then
						v22 = true
						goto l7
					end
				end
				v22 = false
				goto l7
			end
			local v22 = true
			::l7::
			if v22 then
				local v23 = v_u_11(v20)
				v23.Type = "LimitedBundle"
				table.insert(v19, v23)
			end
		end
	end
	return v19
end
function v1.GetByProductId(p24) -- name: GetByProductId
	-- upvalues: (copy) v_u_2, (copy) v_u_11
	for _, v25 in ipairs(v_u_2) do
		if v25.ProductId == p24 then
			return v_u_11(v25)
		end
	end
	return nil
end
function v1.GetByBundleId(p26) -- name: GetByBundleId
	-- upvalues: (copy) v_u_2, (copy) v_u_11
	for _, v27 in ipairs(v_u_2) do
		if v27.BundleId == p26 then
			return v_u_11(v27)
		end
	end
	return nil
end
return v1