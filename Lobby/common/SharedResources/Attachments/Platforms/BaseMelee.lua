require(script.Parent.Parent:WaitForChild("AttachmentProperties"))
local v1 = {
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
local v2 = require("../Extensions/Charm")
v1[1].PotentialAttachments = v2.PotentialAttachments
local v3 = require("../Extensions/Sticker")
v1[2].PotentialAttachments = v3.PotentialAttachments
v1[3].PotentialAttachments = v3.PotentialAttachments
return v1