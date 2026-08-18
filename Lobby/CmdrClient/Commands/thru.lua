return {
	["Name"] = "thru",
	["Aliases"] = nil,
	["Description"] = "Teleports you through whatever your mouse is hovering over, placing you equidistantly from the wall.",
	["Group"] = "Debug",
	["Args"] = nil,
	["ClientRun"] = nil,
	["Aliases"] = { "t", "through" },
	["Args"] = {
		{
			["Type"] = "number",
			["Name"] = "Extra distance",
			["Description"] = "Go through the wall an additional X studs.",
			["Default"] = 0
		}
	},
	["ClientRun"] = function(p1, p2) -- name: ClientRun
		local v3 = p1.Executor:GetMouse()
		local v4 = p1.Executor.Character
		if not (v4 and v4:FindFirstChild("HumanoidRootPart")) then
			return "You don\'t have a character."
		end
		local v5 = workspace:FindFirstChild("Ignore")
		if v5 then
			v3.TargetFilter = v5
		end
		local v6 = v4.HumanoidRootPart.Position
		local v7 = v3.Hit.p - v6
		v4:MoveTo(v7 * 2 + v7.unit * p2 + v6)
		return "Blinked!"
	end
}