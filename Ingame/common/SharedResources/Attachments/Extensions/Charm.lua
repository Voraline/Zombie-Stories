local v1 = require(script.Parent.Parent:WaitForChild("AttachmentProperties"))
return {
	["Name"] = "Charm",
	["PotentialAttachments"] = nil,
	["PotentialAttachments"] = {
		v1.Slasher,
		v1["Jack Carbine"],
		v1.Medkit,
		v1["Ammo Box"],
		v1["Focus Spray"],
		v1.Tix,
		v1["Golden Slasher"],
		v1.Helicopter
	}
}