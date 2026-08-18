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
	},
	{
		["Name"] = "Perk",
		["PotentialAttachments"] = nil,
		["PotentialAttachments"] = { v1.Hammer_LightweightCore, v1.Hammer_HeavyweightCore }
	}
}
local v3 = require("../Extensions/Charm")
v2[1].PotentialAttachments = v3.PotentialAttachments
local v4 = require("../Extensions/Sticker")
v2[2].PotentialAttachments = v4.PotentialAttachments
v2[3].PotentialAttachments = v4.PotentialAttachments
return v2