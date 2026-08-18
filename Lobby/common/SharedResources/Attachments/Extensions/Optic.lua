local v1 = require(script.Parent.Parent:WaitForChild("AttachmentProperties"))
return {
	["Name"] = "Optic",
	["PotentialAttachments"] = nil,
	["PotentialAttachments"] = {
		v1["Red Dot"],
		v1["OKP-7"],
		v1.Coyote,
		v1.EOTech,
		v1.Aimpoint,
		v1.ACOG,
		v1.Kobra,
		v1.Riser,
		v1["Nocturne LPVO"]
	}
}