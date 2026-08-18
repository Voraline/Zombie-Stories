local v1 = require(script:WaitForChild("DataString"))
local v2 = game:GetService("HttpService"):JSONDecode(v1)
local v_u_3 = game:GetService("RunService"):IsStudio()
local v_u_14 = (function(p4) -- name: parseItemData
	-- upvalues: (copy) v_u_3
	local v5 = {}
	for _, v6 in pairs(p4) do
		for _, v7 in pairs(v6) do
			if v_u_3 and v5[v7.ItemId] then
				error("Duplicate ItemID: You forgot to set an unique ItemId [" .. v7.Name .. "] ..... again.")
			end
			local v8 = v7.ItemId
			local v9 = {
				["Name"] = v7.Name,
				["Id"] = v7.ItemId,
				["Rarity"] = v7.Rarity,
				["Slot"] = v7.Slot,
				["Description"] = v7.Description,
				["Featureable"] = string.lower(v7.Featureable) == "true",
				["InBoxes"] = string.lower(v7.InBoxes) == "true",
				["ArcadeSkin"] = string.lower(v7.ArcadeSkin or "") == "true",
				["WorldCupSkin"] = string.lower(v7.WorldCupSkin or "") == "true"
			}
			local v10 = v7.Price
			v9.Price = tonumber(v10)
			local v11 = v7.ClassAccess
			v9.ClassAccess = {
				["Assault"] = string.sub(v11, 1, 1) == "1",
				["Medic"] = string.sub(v11, 2, 2) == "1",
				["Support"] = string.sub(v11, 3, 3) == "1",
				["Sniper"] = string.sub(v11, 4, 4) == "1"
			}
			v9.BaseWeaponId = v7.BaseWeaponId
			local v12 = v7.HasHats
			if v12 then
				v12 = string.lower(v7.HasHats) == "true"
			end
			v9.HasHats = v12
			local v13 = v7.Inactive
			if v13 then
				v13 = string.lower(v7.Inactive) == "true"
			end
			v9.Inactive = v13
			v5[v8] = v9
		end
	end
	return v5
end)(v2)
local v_u_15 = {}
local v_u_16 = {}
function v_u_15.ClassCanUse(_, p17, p18) -- name: ClassCanUse
	-- upvalues: (copy) v_u_14
	if v_u_14[p18] then
		return v_u_14[p18].ClassAccess[p17]
	end
end
function v_u_15.GetByCriteria(_, p19, p20, p21, p22) -- name: GetByCriteria
	-- upvalues: (copy) v_u_16, (copy) v_u_14
	local v23 = p19 or "All"
	local v24 = p20 or "All"
	local v25 = p21 or "All"
	local v26 = v23 .. v24 .. v25
	if v_u_16[v26] then
		return v_u_16[v26]
	end
	local v27 = {}
	for v28, v29 in pairs(v_u_14) do
		if (v23 == "All" or v29.ClassAccess[v23]) and ((v24 == "All" or v29.Rarity == v24) and (not p22 or v29.InBoxes)) then
			if p22 then
				if v29.ArcadeSkin then
					if v25 == "Arcade" then
						v27[v28] = v29
					end
				else
					if not v29.WorldCupSkin then
						goto l12
					end
					if v25 == "WorldCup" then
						v27[v28] = v29
					end
				end
			else
				::l12::
				if v25 == "All" or v29.Slot == v25 then
					v27[v28] = v29
				end
			end
		end
	end
	v_u_16[v26] = v27
	return v27
end
function v_u_15.GetItemIdFromName(_, p30) -- name: GetItemIdFromName
	-- upvalues: (copy) v_u_15
	local v31 = nil
	for v32, v33 in pairs(v_u_15.List) do
		if v33.Name == p30 then
			return v32
		end
	end
	return v31
end
function v_u_15.GetItemFromName(_, p34) -- name: GetItemFromName
	-- upvalues: (copy) v_u_15
	local v35 = v_u_15:GetItemIdFromName(p34)
	return v_u_15.List[v35]
end
function v_u_15.AdjustFromCopy(_, p36, p37) -- name: AdjustFromCopy
	local v38 = {}
	for _, v39 in pairs({
		["Assault"] = "Aslt",
		["Medic"] = "Medc",
		["Support"] = "Supt",
		["Sniper"] = "Snpr"
	}) do
		for v40, v41 in pairs(p36.Loadout.Classes[v39]) do
			local v42 = p36.Inventory[v41][1]
			if not v38[v39] then
				v38[v39] = {}
			end
			v38[v39][v40] = v42
		end
	end
	for v43, v44 in pairs(p37.Inventory) do
		local v45 = v44[1]
		for v46, v47 in pairs(v38) do
			for v48, v49 in pairs(v47) do
				if v49 == v45 then
					p37.Loadout.Classes[v46][v48] = v43
					v38[v46][v48] = nil
				end
			end
		end
	end
	local v50 = require("@game/ServerStorage/common/DefaultData")
	local v51 = require(game.ReplicatedStorage.common:WaitForChild("LevelInfo"))
	for v52, v53 in pairs(v38) do
		if v52 ~= "Mods" then
			for v54, _ in pairs(v53) do
				local v55 = v50.Loadout.Classes[v52][v54]
				local v56 = v50.Inventory[v55][1]
				local _, v57 = v51.OwnsWeapon(p37, (tostring(v56)))
				p37.Loadout.Classes[v52][tonumber(v54)] = tonumber(v57)
			end
		end
	end
	return p37
end
v_u_15.List = v_u_14
local v58 = {
	["Stock"] = {
		["Main"] = Color3.fromRGB(216, 216, 216),
		["Back"] = Color3.fromRGB(80, 80, 80),
		["Dark"] = Color3.fromRGB(27, 27, 27)
	},
	["Typical"] = {
		["Main"] = Color3.fromRGB(102, 216, 111),
		["Back"] = Color3.fromRGB(46, 80, 57),
		["Dark"] = Color3.fromRGB(19, 27, 22)
	},
	["Unique"] = {
		["Main"] = Color3.fromRGB(58, 147, 255),
		["Back"] = Color3.fromRGB(34, 65, 80),
		["Dark"] = Color3.fromRGB(17, 24, 27)
	},
	["Rare"] = {
		["Main"] = Color3.fromRGB(255, 153, 51),
		["Back"] = Color3.fromRGB(80, 60, 38),
		["Dark"] = Color3.fromRGB(27, 25, 21)
	},
	["Mythical"] = {
		["Main"] = Color3.fromRGB(144, 47, 255),
		["Back"] = Color3.fromRGB(64, 44, 80),
		["Dark"] = Color3.fromRGB(20, 19, 27)
	},
	["Exclusive"] = {
		["Main"] = Color3.fromRGB(255, 85, 88),
		["Back"] = Color3.fromRGB(80, 0, 1),
		["Dark"] = Color3.fromRGB(20, 19, 27)
	},
	["Gamepass"] = {
		["Main"] = Color3.fromRGB(161, 186, 216),
		["Back"] = Color3.fromRGB(71, 76, 85),
		["Dark"] = Color3.fromRGB(31, 42, 43)
	},
	["Outfit"] = {
		["Main"] = Color3.fromRGB(239, 255, 55),
		["Back"] = Color3.fromRGB(47, 50, 10),
		["Dark"] = Color3.fromRGB(22, 24, 4)
	},
	["Special"] = {
		["Main"] = Color3.fromRGB(0, 255, 191),
		["Back"] = Color3.fromRGB(26, 70, 62),
		["Dark"] = Color3.fromRGB(14, 33, 32)
	},
	["Accursed"] = {
		["Main"] = Color3.fromRGB(180, 0, 165),
		["Back"] = Color3.fromRGB(65, 30, 64),
		["Dark"] = Color3.fromRGB(22, 24, 4)
	}
}
v_u_15.RarityColors = v58
local v59 = {
	["Typical"] = 70,
	["Unique"] = 25,
	["Rare"] = 4,
	["Mythical"] = 1
}
local v60 = {
	["Typical"] = 0,
	["Unique"] = 54,
	["Rare"] = 40,
	["Mythical"] = 6
}
local v61 = {
	["Primary"] = {
		["Price"] = 1000,
		["DisplayName"] = "Primary Lootbox",
		["Tier"] = "Typical",
		["Slot"] = "Primary",
		["ProbabilityTable"] = nil,
		["ImageId"] = "rbxassetid://72839976474351",
		["ProbabilityTable"] = v59
	},
	["Secondary"] = {
		["Price"] = 1000,
		["DisplayName"] = "Secondary Lootbox",
		["Tier"] = "Typical",
		["Slot"] = "Secondary",
		["ProbabilityTable"] = nil,
		["ImageId"] = "rbxassetid://80110776180934",
		["ProbabilityTable"] = v59
	},
	["Melee"] = {
		["Price"] = 1800,
		["DisplayName"] = "Melee Lootbox",
		["Tier"] = "Typical",
		["Slot"] = "Melee",
		["ProbabilityTable"] = nil,
		["ImageId"] = "rbxassetid://112880363964063",
		["ProbabilityTable"] = v59
	},
	["MythicalPrimary"] = {
		["Price"] = 5000,
		["DisplayName"] = "Primary Lootbox",
		["Tier"] = "Mythical",
		["Slot"] = "Primary",
		["ProbabilityTable"] = nil,
		["ImageId"] = "rbxassetid://79087028007940",
		["ProbabilityTable"] = v60
	},
	["MythicalSecondary"] = {
		["Price"] = 5000,
		["DisplayName"] = "Secondary Lootbox",
		["Tier"] = "Mythical",
		["Slot"] = "Secondary",
		["ProbabilityTable"] = nil,
		["ImageId"] = "rbxassetid://81696562116264",
		["ProbabilityTable"] = v60
	},
	["MythicalMelee"] = {
		["Price"] = 9000,
		["DisplayName"] = "Melee Lootbox",
		["Tier"] = "Mythical",
		["Slot"] = "Melee",
		["ProbabilityTable"] = nil,
		["ImageId"] = "rbxassetid://94501769745526",
		["ProbabilityTable"] = v60
	},
	["Outfit"] = {
		["Price"] = 3000,
		["DisplayName"] = "Outfit Lootbox",
		["Tier"] = "Outfit",
		["Slot"] = "Outfit",
		["ProbabilityTable"] = nil,
		["ImageId"] = "rbxassetid://132639764670163",
		["ProbabilityTable"] = {
			["Outfit"] = 100
		}
	},
	["Arcade"] = {
		["Price"] = 2500,
		["DisplayName"] = "Arcade Lootbox",
		["Tier"] = "Special",
		["Slot"] = "Arcade",
		["ProbabilityTable"] = nil,
		["ImageId"] = "rbxassetid://74786715491271",
		["ProbabilityTable"] = v59
	},
	["WorldCup"] = {
		["Price"] = 3000,
		["DisplayName"] = "World Cup Lootbox",
		["Tier"] = "Special",
		["Slot"] = "WorldCup",
		["IsLimited"] = true,
		["EndTimestamp"] = 1785715200,
		["ProbabilityTable"] = nil,
		["ImageId"] = "rbxassetid://124117881922761",
		["ProbabilityTable"] = {
			["Rare"] = 100
		}
	}
}
v_u_15.LootBoxes = v61
v_u_15.DefaultProbabilityTable = v59
v_u_15.MythicalProbabilityTable = v60
v_u_15.probabilityTable = v59
return v_u_15