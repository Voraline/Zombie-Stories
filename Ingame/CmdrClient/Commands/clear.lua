local v_u_1 = game:GetService("Players")
return {
	["Name"] = "clear",
	["Aliases"] = nil,
	["Description"] = "Clear all lines above the entry line of the Cmdr window.",
	["Group"] = "DefaultUtil",
	["Args"] = nil,
	["ClientRun"] = nil,
	["Aliases"] = {},
	["Args"] = {},
	["ClientRun"] = function() -- name: ClientRun
		-- upvalues: (copy) v_u_1
		local v2 = v_u_1.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Cmdr")
		local v3 = v2:WaitForChild("Frame")
		if v2 and v3 then
			for _, v4 in pairs(v3:GetChildren()) do
				if v4.Name == "Line" and v4:IsA("TextBox") then
					v4:Destroy()
				end
			end
		end
		return ""
	end
}