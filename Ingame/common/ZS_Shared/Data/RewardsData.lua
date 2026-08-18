game:GetService("ReplicatedStorage")
local v1 = require("@game/ReplicatedStorage/common/ItemData")
local v2 = {
	["ZBucks"] = {
		["Image"] = "rbxassetid://123456789",
		["LayoutOrder"] = 1,
		["Tier1"] = nil,
		["Tier2"] = nil,
		["Tier3"] = nil,
		["Tier1"] = {
			["Image"] = "rbxassetid://4936288857",
			["Amount"] = 500
		},
		["Tier2"] = {
			["Image"] = "rbxassetid://4936350857",
			["Amount"] = 1000
		},
		["Tier3"] = {
			["Image"] = "rbxassetid://4936401476",
			["Amount"] = 3000
		}
	},
	["ClassXP"] = {
		["LayoutOrder"] = 2,
		["Assault"] = nil,
		["Support"] = nil,
		["Sniper"] = nil,
		["Medic"] = nil,
		["Assault"] = {
			["Image"] = "rbxassetid://4458718282",
			["Text"] = "XP",
			["TextOffset"] = -0.1
		},
		["Support"] = {
			["Image"] = "rbxassetid://2706886028",
			["Text"] = "XP",
			["TextOffset"] = -0.1
		},
		["Sniper"] = {
			["Image"] = "rbxassetid://4458692655",
			["Text"] = "XP",
			["TextOffset"] = -0.1
		},
		["Medic"] = {
			["Image"] = "rbxassetid://2706886795",
			["Text"] = "XP",
			["TextOffset"] = -0.1
		}
	},
	["SP"] = {
		["Image"] = nil,
		["LayoutOrder"] = 4,
		["Image"] = require("@game/ReplicatedStorage/common/Assets/assets").Images.SkillTree.skillPointIcon
	}
}
local v3 = {
	["LayoutOrder"] = 3,
	["Primary"] = nil,
	["Secondary"] = nil,
	["Melee"] = nil,
	["Arcade"] = nil,
	["MythicalPrimary"] = nil,
	["MythicalSecondary"] = nil,
	["MythicalMelee"] = nil,
	["Primary"] = {
		["Image"] = nil,
		["Text"] = "Primary",
		["TextRotation"] = -5,
		["TextOffset"] = -0.2,
		["Image"] = v1.LootBoxes.Primary.ImageId
	},
	["Secondary"] = {
		["Image"] = nil,
		["Text"] = "Secondary",
		["TextRotation"] = -5,
		["TextOffset"] = -0.2,
		["Image"] = v1.LootBoxes.Secondary.ImageId
	},
	["Melee"] = {
		["Image"] = nil,
		["Text"] = "Melee",
		["TextRotation"] = -5,
		["TextOffset"] = -0.2,
		["Image"] = v1.LootBoxes.Melee.ImageId
	},
	["Arcade"] = {
		["Image"] = nil,
		["Text"] = "Arcade",
		["TextRotation"] = -5,
		["TextOffset"] = -0.2,
		["Image"] = v1.LootBoxes.Arcade.ImageId
	},
	["MythicalPrimary"] = {
		["Image"] = nil,
		["Text"] = "Primary",
		["TextRotation"] = -5,
		["TextOffset"] = -0.2,
		["Image"] = v1.LootBoxes.MythicalPrimary.ImageId
	},
	["MythicalSecondary"] = {
		["Image"] = nil,
		["Text"] = "Secondary",
		["TextRotation"] = -5,
		["TextOffset"] = -0.2,
		["Image"] = v1.LootBoxes.MythicalSecondary.ImageId
	},
	["MythicalMelee"] = {
		["Image"] = nil,
		["Text"] = "Melee",
		["TextRotation"] = -5,
		["TextOffset"] = -0.2,
		["Image"] = v1.LootBoxes.MythicalMelee.ImageId
	}
}
v2.Crate = v3
return v2