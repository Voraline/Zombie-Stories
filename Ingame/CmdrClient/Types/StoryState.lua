if workspace.Values:FindFirstChild("IsLobby") and workspace.Values.IsLobby.Value then
	return function() end
end
local _ = game.ReplicatedStorage.common
local v_u_1 = require("../Shared/Util")
local v2 = game.ReplicatedStorage.common.RedEvents
local v_u_3 = {}
local v_u_4 = {}
local v_u_5 = require(v2.Story.StateListEvent)
if game:GetService("RunService"):IsServer() then
	local v_u_6 = game.ReplicatedStorage.common:FindFirstChild("StoryData")
	local function v_u_10() -- name: updateStateList
		-- upvalues: (ref) v_u_6, (ref) v_u_4, (copy) v_u_5
		local v7 = require(v_u_6).StateModules
		v_u_4 = {}
		if v7 then
			for v8, v9 in v7 do
				v_u_4[v8] = v9.Name
			end
		end
		v_u_5:FireAllClients(v_u_4)
	end
	if v_u_6 then
		v_u_10()
	else
		game.ServerStorage.ChildAdded:Connect(function(p11)
			-- upvalues: (ref) v_u_6, (copy) v_u_10
			if p11.Name == "StoryData" then
				v_u_6 = p11
				v_u_10()
			end
		end)
	end
	v_u_5:SetServerListener(function(p12)
		-- upvalues: (copy) v_u_3, (copy) v_u_5, (ref) v_u_4
		if not v_u_3[p12] then
			v_u_5:FireClient(p12, v_u_4)
			v_u_3[p12] = true
		end
	end)
else
	v_u_5:SetClientListener(function(p13)
		-- upvalues: (ref) v_u_4
		v_u_4 = p13
	end)
	v_u_5:FireServer()
end
local v_u_21 = {
	["DisplayName"] = "Story state",
	["Prefixes"] = "",
	["Transform"] = nil,
	["Validate"] = nil,
	["Autocomplete"] = nil,
	["Parse"] = nil,
	["Transform"] = function(p14) -- name: Transform
		-- upvalues: (copy) v_u_1, (ref) v_u_4
		local v15 = v_u_1.MakeFuzzyFinder(v_u_4)(p14)
		return #v15 == 0 and { v_u_4[tonumber(p14)] } or v15
	end,
	["Validate"] = function(p16) -- name: Validate
		return #p16 > 0, "No state with that identifier exists."
	end,
	["Autocomplete"] = function(p17) -- name: Autocomplete
		-- upvalues: (copy) v_u_1
		return v_u_1.GetNames(p17)
	end,
	["Parse"] = function(p18) -- name: Parse
		-- upvalues: (ref) v_u_4
		local v19 = p18[1]
		local v20 = tonumber(v19)
		if v20 then
			return v_u_4[v20]
		else
			return v19
		end
	end
}
return function(p22)
	-- upvalues: (copy) v_u_21
	p22:RegisterType("storyState", v_u_21)
end