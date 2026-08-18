local v1 = require(script.Parent.Parent:WaitForChild("AttachmentProperties"))
return {
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