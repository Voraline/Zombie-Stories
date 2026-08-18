local v1 = require(script.Parent.Parent:WaitForChild("AttachmentProperties"))
return {
	["Name"] = "Perk",
	["PotentialAttachments"] = nil,
	["PotentialAttachments"] = { v1.AP, v1.HP }
}