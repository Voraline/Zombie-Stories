local v_u_1 = require("../Shared/Util")
local v_u_2 = game:GetService("Players")
local v_u_3 = {}
local v_u_13 = {
	["DisplayName"] = "Full Player Name",
	["Prefixes"] = "# integer",
	["Transform"] = nil,
	["ValidateOnce"] = nil,
	["Autocomplete"] = nil,
	["Parse"] = nil,
	["Default"] = nil,
	["ArgumentOperatorAliases"] = nil,
	["Transform"] = function(p4) -- name: Transform
		-- upvalues: (copy) v_u_1, (copy) v_u_2
		return p4, v_u_1.MakeFuzzyFinder(v_u_2:GetPlayers())(p4)
	end,
	["ValidateOnce"] = function(p5) -- name: ValidateOnce
		-- upvalues: (copy) v_u_3, (copy) v_u_2
		local v6
		if v_u_3[p5] then
			v6 = v_u_3[p5]
		elseif v_u_2:FindFirstChild(p5) then
			v_u_3[p5] = v_u_2[p5].UserId
			v6 = v_u_2[p5].UserId
		else
			local v7
			v7, v6 = pcall(v_u_2.GetUserIdFromNameAsync, v_u_2, p5)
			if v7 then
				v_u_3[p5] = v6
			else
				v6 = nil
			end
		end
		return v6 ~= nil, "No player with that name could be found."
	end,
	["Autocomplete"] = function(_, p8) -- name: Autocomplete
		-- upvalues: (copy) v_u_1
		return v_u_1.GetNames(p8)
	end,
	["Parse"] = function(p9) -- name: Parse
		-- upvalues: (copy) v_u_3, (copy) v_u_2
		if v_u_3[p9] then
			return v_u_3[p9]
		end
		if v_u_2:FindFirstChild(p9) then
			v_u_3[p9] = v_u_2[p9].UserId
			return v_u_2[p9].UserId
		end
		local v10, v11 = pcall(v_u_2.GetUserIdFromNameAsync, v_u_2, p9)
		if not v10 then
			return nil
		end
		v_u_3[p9] = v11
		return v11
	end,
	["Default"] = function(p12) -- name: Default
		return p12.Name
	end,
	["ArgumentOperatorAliases"] = {
		["me"] = ".",
		["all"] = "*",
		["others"] = "**",
		["random"] = "?"
	}
}
return function(p14)
	-- upvalues: (copy) v_u_13, (copy) v_u_1
	p14:RegisterType("playerId", v_u_13)
	p14:RegisterType("playerIds", v_u_1.MakeListableType(v_u_13, {
		["Prefixes"] = "# integers"
	}))
end