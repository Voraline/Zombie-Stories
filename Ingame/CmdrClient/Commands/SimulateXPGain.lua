return {
	["Name"] = "simulatexpgain",
	["Aliases"] = nil,
	["Description"] = "Simulates an XP gain to test the skill XP popup",
	["Group"] = "Debug",
	["Args"] = nil,
	["Aliases"] = { "simxp" },
	["Args"] = {
		{
			["Type"] = "integer",
			["Name"] = "amount",
			["Description"] = "Amount of SP XP to simulate (default: 10)",
			["Optional"] = true
		}
	}
}