local v1 = require(script.Parent.Parent:WaitForChild("AttachmentProperties"))
local v2 = {
	[1] = {
		["Name"] = "Charm",
		["PotentialAttachments"] = nil,
		["PotentialAttachments"] = {}
	},
	[2] = {
		["Name"] = "Sticker",
		["PotentialAttachments"] = nil,
		["PotentialAttachments"] = {}
	},
	[3] = {
		["Name"] = "Sticker 2",
		["PotentialAttachments"] = nil,
		["PotentialAttachments"] = {}
	},
	[13] = {
		["Name"] = "Perk",
		["PotentialAttachments"] = nil,
		["PotentialAttachments"] = {}
	},
	[5] = {
		["Name"] = "Optic",
		["PotentialAttachments"] = nil,
		["PotentialAttachments"] = {}
	},
	[6] = {
		["Name"] = "Muzzle",
		["PotentialAttachments"] = nil,
		["PotentialAttachments"] = {}
	},
	[8] = {
		["Name"] = "Misc Rail",
		["PotentialAttachments"] = nil,
		["PotentialAttachments"] = {}
	},
	[9] = {
		["Name"] = "Top Rail",
		["PotentialAttachments"] = nil,
		["PotentialAttachments"] = {}
	}
}
local v3 = require("../Extensions/Charm")
v2[1].PotentialAttachments = v3.PotentialAttachments
local v4 = require("../Extensions/Sticker")
v2[2].PotentialAttachments = v4.PotentialAttachments
v2[3].PotentialAttachments = v4.PotentialAttachments
local v5 = require("../Extensions/Perk")
v2[13].PotentialAttachments = v5.PotentialAttachments
local v6 = require("../Extensions/Optic")
v2[5].PotentialAttachments = v6.PotentialAttachments
v2[7] = {
	["Name"] = "Bottom Rail",
	["PotentialAttachments"] = nil,
	["PotentialAttachments"] = {
		v1["Angled Grip"],
		v1["Vertical Grip"],
		v1["Stubby Grip"],
		v1["Skeleton Grip"],
		v1["Folding Grip"],
		v1["RK-1 Grip"],
		v1["Grip Bipod"]
	}
}
local v7 = require("../Extensions/MiscRail")
v2[8].PotentialAttachments = v7.PotentialAttachments
v2[9] = {
	["Name"] = "Top Rail",
	["PotentialAttachments"] = nil,
	["PotentialAttachments"] = v2[5].PotentialAttachments
}
v2[10] = {
	["Name"] = "Magazine",
	["PotentialAttachments"] = nil,
	["PotentialAttachments"] = { v1["Nighthaven 9mm Conv"], v1["Nighthaven .50 GI Conv"] }
}
v2[11] = {
	["Name"] = "Handguard",
	["PotentialAttachments"] = nil,
	["PotentialAttachments"] = { v1["Nighthaven Long Handguard"], v1["Nighthaven Integrated Suppressor Kit"] }
}
v2[12] = {
	["Name"] = "Stock",
	["PotentialAttachments"] = nil,
	["PotentialAttachments"] = { v1["Hera CQC Stock"], v1["TCM Badger Stock"], v1["No Stock"] }
}
for _, v8 in v2[8].PotentialAttachments do
	local v9 = v2[7].PotentialAttachments
	table.insert(v9, v8)
end
return v2