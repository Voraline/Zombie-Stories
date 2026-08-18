local v1 = {
	["__index"] = Enum
}
return setmetatable({
	["HumanoidControlType"] = {
		["Default"] = 1,
		["Locked"] = 2,
		["Forced"] = 3,
		["ForcedRespectCamera"] = 4
	},
	["PhysBallType"] = {
		["Default"] = 1,
		["Dive"] = 2
	}
}, v1)