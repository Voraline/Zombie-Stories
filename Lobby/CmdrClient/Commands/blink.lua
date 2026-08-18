return {
	["Name"] = "blink",
	["Aliases"] = nil,
	["Description"] = "Teleports you to where your mouse is hovering.",
	["Group"] = "Debug",
	["Args"] = nil,
	["ClientRun"] = nil,
	["Aliases"] = { "b" },
	["Args"] = {},
	["ClientRun"] = function(p1) -- name: ClientRun
		local v2 = p1.Executor:GetMouse()
		local v3 = p1.Executor.Character
		if not v3 then
			return "You don\'t have a character."
		end
		local v4 = workspace:FindFirstChild("Ignore")
		if v4 then
			v2.TargetFilter = v4
		end
		v3:MoveTo(v2.Hit.p)
		return "Blinked!"
	end
}