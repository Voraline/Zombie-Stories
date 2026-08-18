local v1 = require(script.Parent.Parent:WaitForChild("AttachmentProperties"))
local v2 = {
	{
		["Name"] = "Charm",
		["PotentialAttachments"] = nil,
		["PotentialAttachments"] = {}
	},
	{
		["Name"] = "Sticker",
		["PotentialAttachments"] = nil,
		["PotentialAttachments"] = {}
	},
	{
		["Name"] = "Sticker 2",
		["PotentialAttachments"] = nil,
		["PotentialAttachments"] = {}
	}
}
local v3 = require("../Extensions/Charm")
v2[1].PotentialAttachments = v3.PotentialAttachments
local v4 = require("../Extensions/Sticker")
v2[2].PotentialAttachments = v4.PotentialAttachments
v2[3].PotentialAttachments = v4.PotentialAttachments
v2[4] = {
	["Name"] = "Perk",
	["PotentialAttachments"] = nil,
	["PotentialAttachments"] = { v1.AP, v1.FNX9_Piercer }
}
v2[5] = {
	["Name"] = "Optic",
	["PotentialAttachments"] = nil,
	["PotentialAttachments"] = { v1["Mini Red Dot"] }
}
v2[6] = {
	["Name"] = "Muzzle",
	["PotentialAttachments"] = nil,
	["PotentialAttachments"] = {
		v1["Light Suppressor"],
		v1["Osprey Suppressor"],
		v1["Pistol Muzzle Brake"],
		v1["Pistol Compensator"]
	}
}
v2[7] = {
	["Name"] = "Bottom Rail",
	["PotentialAttachments"] = nil,
	["PotentialAttachments"] = {
		v1["Angled Grip"],
		v1["Vertical Grip"],
		v1["Stubby Grip"],
		v1["Skeleton Grip"],
		v1["Folding Grip"],
		v1["RK-1 Grip"]
	}
}
v2[8] = {
	["Name"] = "Misc Rail",
	["PotentialAttachments"] = nil,
	["PotentialAttachments"] = { v1["Green Laser"], v1["Small Flashlight"] }
}
v2[9] = {
	["Name"] = "Top Rail",
	["PotentialAttachments"] = nil,
	["PotentialAttachments"] = v2[5].PotentialAttachments
}
v2[10] = {
	["Name"] = "Pistol Rail",
	["PotentialAttachments"] = nil,
	["PotentialAttachments"] = { v1["Small Flashlight"] }
}
for _, v5 in v2[8].PotentialAttachments do
	local v6 = v2[7].PotentialAttachments
	table.insert(v6, v5)
end
return v2