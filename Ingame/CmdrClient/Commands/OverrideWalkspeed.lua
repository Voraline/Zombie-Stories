return {
	["Name"] = "overridewalkspeed",
	["Aliases"] = nil,
	["Description"] = "Override player walkspeed to single value.",
	["Group"] = "Debug",
	["Args"] = nil,
	["ClientRun"] = nil,
	["Aliases"] = { "ws" },
	["Args"] = {
		{
			["Type"] = "integer",
			["Name"] = "walkspeed",
			["Description"] = "The walkspeed. Negative number resets."
		}
	},
	["ClientRun"] = function(_, p1) -- name: ClientRun
		local v2 = game:GetService("ReplicatedStorage").common.ZS_Framework
		local v3 = require(v2.Modules.Controllers.LocalPlayerController)
		if p1 < 0 then
			p1 = nil
		end
		v3:SetWalkSpeedOverride(p1)
		return not p1 and "Reset walkspeed" or string.format("Set override walkspeed to %d", p1)
	end
}