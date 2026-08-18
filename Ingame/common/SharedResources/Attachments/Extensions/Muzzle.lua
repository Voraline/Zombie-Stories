local v1 = require(script.Parent.Parent:WaitForChild("AttachmentProperties"))
return {
	["Name"] = "Muzzle",
	["PotentialAttachments"] = nil,
	["PotentialAttachments"] = {
		v1["AR Suppressor"],
		v1["Light Suppressor"],
		v1["AR Muzzle Brake"],
		v1["AR Compensator"],
		v1["Flash Hider"]
	}
}