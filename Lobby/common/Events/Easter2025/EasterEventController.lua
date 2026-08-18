local v_u_1 = game:GetService("BadgeService")
local v_u_2 = require("./EggData")
local v3 = game.ReplicatedStorage.common.RedEvents
local v_u_4 = require(v3.Events.EggTouched)
local v5 = require(v3.Events.EggCollected)
local v_u_6 = game:GetService("Players")
local v_u_25 = {
	["pendingEggs"] = {},
	["GetEligiblePlayers"] = function(_, p_u_7) -- name: GetEligiblePlayers
		-- upvalues: (copy) v_u_6, (copy) v_u_1, (copy) v_u_2
		local v8 = {}
		for _, v_u_9 in v_u_6:GetChildren() do
			local v10, v11 = pcall(function()
				-- upvalues: (ref) v_u_1, (copy) v_u_9, (ref) v_u_2, (copy) p_u_7
				return v_u_1:UserHasBadgeAsync(v_u_9.UserId, v_u_2.EggConfigs[p_u_7].BadgeId)
			end)
			if not v10 then
				warn("Error while checking if player has badge!")
				return
			end
			if not v11 then
				table.insert(v8, v_u_9)
			end
		end
		return v8
	end,
	["RegisterEggTouch"] = function(_, p12, p13) -- name: RegisterEggTouch
		-- upvalues: (copy) v_u_25, (copy) v_u_4
		if p13 ~= "Master" then
			v_u_25.chapterId = p13
		end
		local v14 = p12.UserId
		v_u_25.pendingEggs[p13] = v_u_25.pendingEggs[p13] or {}
		if not v_u_25.pendingEggs[p13][v14] then
			v_u_25.pendingEggs[p13][v14] = true
			print("Server: Player " .. p12.Name .. " collected egg for chapter " .. p13)
			v_u_4:FireClient(p12, p13)
		end
	end,
	["OnChapterCompleted"] = function(_, p_u_15) -- name: OnChapterCompleted
		-- upvalues: (copy) v_u_25, (copy) v_u_2, (copy) v_u_1
		if v_u_25.chapterId == nil then
			v_u_25.chapterId = "Master"
		end
		local v16 = v_u_25.chapterId
		local v_u_17 = p_u_15.UserId
		local function v24(p18) -- name: giveBadge
			-- upvalues: (ref) v_u_25, (copy) v_u_17, (ref) v_u_2, (ref) v_u_1, (copy) p_u_15
			if v_u_25.pendingEggs[p18] and v_u_25.pendingEggs[p18][v_u_17] then
				v_u_25.pendingEggs[p18][v_u_17] = nil
				local v_u_19 = v_u_2.EggConfigs[p18]
				if v_u_19 and v_u_19.BadgeId then
					local v20, v21 = pcall(function()
						-- upvalues: (ref) v_u_1, (ref) p_u_15, (copy) v_u_19
						v_u_1:AwardBadge(p_u_15.UserId, v_u_19.BadgeId)
					end)
					if v20 then
						local v22 = print
						local v23 = v_u_19.BadgeId
						v22("Server: Awarded badge " .. tostring(v23) .. " for chapter " .. p18 .. " to " .. p_u_15.Name)
						return
					end
					warn("Server: Error awarding badge for chapter " .. p18 .. ": " .. tostring(v21))
				end
			end
		end
		v24(v16)
		if v16 ~= "Master" then
			v24("Master")
		end
	end
}
v5:SetServerListener(function(p26, p27)
	-- upvalues: (copy) v_u_25
	v_u_25:RegisterEggTouch(p26, p27)
end)
return v_u_25