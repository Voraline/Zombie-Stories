local v_u_1 = {}
local v_u_2 = game:GetService("RunService"):IsStudio()
local v_u_3 = game.GameId == 1970013852
local v_u_4 = {
	["AlexRouger"] = 100,
	["ExpressSurvival"] = 100,
	["Huskrri"] = 100,
	["Seanjacksepticeyem"] = 100
}
local v_u_5 = {
	["DefaultAdmin"] = 201,
	["DefaultDebug"] = 250,
	["DefaultUtil"] = 200,
	["UserAlias"] = 200,
	["Ingame"] = 250,
	["Items"] = 250,
	["Lobby"] = 250,
	["Moderation"] = 200,
	["EventManager"] = 100,
	["Progression"] = 250,
	["Debug"] = 250,
	["Help"] = 0
}
local v_u_6 = {}
function v_u_1.GetRank(_, p7) -- name: GetRank
	-- upvalues: (copy) v_u_6, (copy) v_u_4
	if not v_u_6[p7] then
		v_u_6[p7] = v_u_4[p7.Name] or p7:GetRankInGroup(3532462)
	end
	return v_u_6[p7]
end
function v_u_1.GetRequiredRank(_, p8) -- name: GetRequiredRank
	-- upvalues: (copy) v_u_5
	return v_u_5[p8] or 254
end
function v_u_1.HasCommand(_, p9, p10) -- name: HasCommand
	-- upvalues: (copy) v_u_1, (copy) v_u_2, (copy) v_u_3
	return v_u_1:GetRank(p9) >= v_u_1:GetRequiredRank(p10) and true or (v_u_2 or v_u_3)
end
return v_u_1