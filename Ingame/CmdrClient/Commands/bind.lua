local v_u_1 = game:GetService("UserInputService")
return {
	["Name"] = "bind",
	["Aliases"] = nil,
	["Description"] = "Binds a command string to a key or mouse input.",
	["Group"] = "DefaultUtil",
	["Args"] = nil,
	["ClientRun"] = nil,
	["Aliases"] = {},
	["Args"] = {
		{
			["Type"] = "userInput ! bindableResource @ player",
			["Name"] = "Input",
			["Description"] = "The key or input type you\'d like to bind the command to."
		},
		{
			["Type"] = "command",
			["Name"] = "Command",
			["Description"] = "The command you want to run on this input"
		},
		{
			["Type"] = "string",
			["Name"] = "Arguments",
			["Description"] = "The arguments for the command",
			["Default"] = ""
		}
	},
	["ClientRun"] = function(p_u_2, p_u_3, p4, p5) -- name: ClientRun
		-- upvalues: (copy) v_u_1
		local v6 = p_u_2:GetStore("CMDR_Binds")
		local v_u_7 = p4 .. " " .. p5
		if v6[p_u_3] then
			v6[p_u_3]:Disconnect()
		end
		local v8 = p_u_2:GetArgument(1).Type.Name
		if v8 == "userInput" then
			v6[p_u_3] = v_u_1.InputBegan:Connect(function(p9, p10)
				-- upvalues: (copy) p_u_3, (copy) p_u_2, (ref) v_u_7
				if not p10 then
					if p9.UserInputType == p_u_3 or p9.KeyCode == p_u_3 then
						p_u_2:Reply(p_u_2.Dispatcher:EvaluateAndRun(p_u_2.Cmdr.Util.RunEmbeddedCommands(p_u_2.Dispatcher, v_u_7)))
					end
				end
			end)
		else
			if v8 == "bindableResource" then
				return "Unimplemented..."
			end
			if v8 == "player" then
				v6[p_u_3] = p_u_3.Chatted:Connect(function(p11)
					-- upvalues: (copy) p_u_2, (ref) v_u_7, (copy) p_u_3
					local v12 = p_u_2.Cmdr.Util.RunEmbeddedCommands(p_u_2.Dispatcher, p_u_2.Cmdr.Util.SubstituteArgs(v_u_7, { p11 }))
					p_u_2:Reply(("%s $ %s : %s"):format(p_u_3.Name, v12, p_u_2.Dispatcher:EvaluateAndRun(v12)), Color3.fromRGB(244, 92, 66))
				end)
			end
		end
		return "Bound command to input."
	end
}