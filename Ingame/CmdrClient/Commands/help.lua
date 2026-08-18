local v1 = game.ReplicatedStorage.common:WaitForChild("CmdrShared")
local v_u_2 = require(v1:WaitForChild("PermissionsHandler"))
return {
	["Name"] = "help",
	["Description"] = "Displays a list of all commands, or inspects one command.",
	["Group"] = "Help",
	["Args"] = nil,
	["ClientRun"] = nil,
	["Args"] = {
		{
			["Type"] = "command",
			["Name"] = "Command",
			["Description"] = "The command to view information on",
			["Optional"] = true
		}
	},
	["ClientRun"] = function(p3, p4) -- name: ClientRun
		-- upvalues: (copy) v_u_2
		if p4 then
			local v5 = p3.Cmdr.Registry:GetCommand(p4)
			if v_u_2:HasCommand(p3.Executor, v5.Group) then
				p3:Reply(("Command: %s"):format(v5.Name), Color3.fromRGB(230, 126, 34))
				if v5.Aliases and #v5.Aliases > 0 then
					p3:Reply(("Aliases: %s"):format(table.concat(v5.Aliases, ", ")), Color3.fromRGB(230, 230, 230))
				end
				p3:Reply(v5.Description, Color3.fromRGB(230, 230, 230))
				for v6, v7 in ipairs(v5.Args) do
					p3:Reply(("#%d %s%s: %s - %s"):format(v6, v7.Name, v7.Optional == true and "?" or "", v7.Type, v7.Description))
				end
			else
				local v8 = v_u_2:GetRequiredRank(v5.Group)
				p3:Reply(("You don\'t have permission to run command \'%s\'. Min rank: $i"):format(v5.Name, v8), Color3.fromRGB(230, 34, 34))
			end
		else
			local v9 = p3.Cmdr.Registry:GetCommands()
			p3:Reply("Argument Shorthands\n-------------------\n.   Me/Self\n*   All/Everyone\n**  Others\n?   Random\n?N  List of N random values\n\nCommand List\n-------------------")
			for _, v10 in pairs(v9) do
				if v_u_2:HasCommand(p3.Executor, v10.Group) then
					p3:Reply(("%s - %s"):format(v10.Name, v10.Description))
				end
			end
		end
		return ""
	end
}