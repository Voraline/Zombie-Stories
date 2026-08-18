local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("RunService")
local v_u_3 = nil
local v_u_4 = nil
local v_u_5 = nil
local v_u_6 = nil
local v_u_7 = nil
local v_u_8 = nil
local v_u_9 = nil
local v_u_10 = nil
local v_u_11 = nil
local _ = {
	CFrame.Angles(0, 0, 0),
	CFrame.Angles(1.5707963267948966, 0, 0),
	CFrame.Angles(0, 3.141592653589793, 3.141592653589793),
	CFrame.Angles(-1.5707963267948966, 0, 0),
	CFrame.Angles(0, 3.141592653589793, 1.5707963267948966),
	CFrame.Angles(0, 1.5707963267948966, 1.5707963267948966),
	CFrame.Angles(0, 0, 1.5707963267948966),
	CFrame.Angles(0, -1.5707963267948966, 1.5707963267948966),
	CFrame.Angles(-1.5707963267948966, -1.5707963267948966, 0),
	CFrame.Angles(0, -1.5707963267948966, 0),
	CFrame.Angles(1.5707963267948966, -1.5707963267948966, 0),
	CFrame.Angles(0, 1.5707963267948966, 3.141592653589793),
	CFrame.Angles(0, -1.5707963267948966, 3.141592653589793),
	CFrame.Angles(0, 3.141592653589793, 0),
	CFrame.Angles(-1.5707963267948966, -3.141592653589793, 0),
	CFrame.Angles(0, 0, 3.141592653589793),
	CFrame.Angles(1.5707963267948966, 3.141592653589793, 0),
	CFrame.Angles(0, 0, -1.5707963267948966),
	CFrame.Angles(0, -1.5707963267948966, -1.5707963267948966),
	CFrame.Angles(0, -3.141592653589793, -1.5707963267948966),
	CFrame.Angles(0, 1.5707963267948966, -1.5707963267948966),
	CFrame.Angles(1.5707963267948966, 1.5707963267948966, 0),
	CFrame.Angles(0, 1.5707963267948966, 0),
	CFrame.Angles(-1.5707963267948966, 1.5707963267948966, 0)
}
local function v_u_14(p12) -- name: alloc
	-- upvalues: (ref) v_u_4, (ref) v_u_5, (ref) v_u_3, (ref) v_u_7
	if v_u_5 < v_u_4 + p12 then
		while v_u_5 < v_u_4 + p12 do
			v_u_5 = v_u_5 * 2
		end
		local v13 = buffer.create(v_u_5)
		buffer.copy(v13, 0, v_u_3, 0, v_u_4)
		v_u_3 = v13
	end
	v_u_7 = v_u_4
	v_u_4 = v_u_4 + p12
	return v_u_7
end
v_u_3 = buffer.create(64)
v_u_4 = 0
v_u_5 = 64
v_u_6 = {}
local v15 = {}
if not v2:IsRunning() then
	local function v16() end
	local v17 = table.freeze
	local v18 = {
		["SendEvents"] = v16,
		["InitUser"] = table.freeze({
			["On"] = v16
		}),
		["UpdateValue"] = table.freeze({
			["On"] = v16
		}),
		["RemoveIndex"] = table.freeze({
			["On"] = v16
		}),
		["InsertIndex"] = table.freeze({
			["On"] = v16
		}),
		["InsertKey"] = table.freeze({
			["On"] = v16
		}),
		["RemoveKey"] = table.freeze({
			["On"] = v16
		}),
		["StartSelection"] = table.freeze({
			["On"] = v16
		}),
		["UpdateSelectionTimer"] = table.freeze({
			["On"] = v16
		}),
		["UpdatePlayerSelection"] = table.freeze({
			["On"] = v16
		}),
		["EndSelection"] = table.freeze({
			["On"] = v16
		}),
		["SelectionVote"] = table.freeze({
			["Fire"] = v16
		}),
		["StatusMessage"] = table.freeze({
			["On"] = v16
		}),
		["BannerMessage"] = table.freeze({
			["On"] = v16
		}),
		["RefreshServers"] = table.freeze({
			["Fire"] = v16
		}),
		["ServerList"] = table.freeze({
			["On"] = v16
		}),
		["JoinServer"] = table.freeze({
			["Fire"] = v16
		}),
		["JoinServerResponse"] = table.freeze({
			["On"] = v16
		}),
		["SetupPodium"] = table.freeze({
			["On"] = v16
		}),
		["TellServerLoaded"] = table.freeze({
			["Fire"] = v16
		}),
		["OpenGamemodeEndScoreboard"] = table.freeze({
			["On"] = v16
		}),
		["CloseGamemodeEndScoreboard"] = table.freeze({
			["On"] = v16
		}),
		["PreloadWeapons"] = table.freeze({
			["On"] = v16
		}),
		["ClearPreloadedWeapons"] = table.freeze({
			["On"] = v16
		}),
		["StartPrivateServer"] = table.freeze({
			["Fire"] = v16
		}),
		["PrivateServerCreated"] = table.freeze({
			["On"] = v16
		}),
		["JoinPrivateServer"] = table.freeze({
			["Fire"] = v16
		}),
		["PositionChangedEvent"] = table.freeze({
			["On"] = v16
		}),
		["UpdateLookAngle"] = table.freeze({
			["Fire"] = v16
		}),
		["LookAngleEvent"] = table.freeze({
			["On"] = v16
		}),
		["NPCRegistryEvent"] = table.freeze({
			["On"] = v16
		}),
		["TogglePointsUIEvent"] = table.freeze({
			["On"] = v16
		}),
		["ToggleSurvivalShopUIEvent"] = table.freeze({
			["On"] = v16
		}),
		["InitSurvivalShopEvent"] = table.freeze({
			["On"] = v16
		}),
		["TriggerSelfExplosionEvent"] = table.freeze({
			["Fire"] = v16
		}),
		["RenderExplosionEvent"] = table.freeze({
			["On"] = v16
		}),
		["Reloading"] = table.freeze({
			["Fire"] = v16
		}),
		["SetGameStateKey"] = table.freeze({
			["On"] = v16
		}),
		["SetGameStateVariable"] = table.freeze({
			["On"] = v16
		}),
		["InitGameState"] = table.freeze({
			["On"] = v16
		}),
		["InitQuests"] = table.freeze({
			["On"] = v16
		}),
		["UpdateQuestCategory"] = table.freeze({
			["On"] = v16
		}),
		["UpdateQuestProgress"] = table.freeze({
			["On"] = v16
		}),
		["ChristmasGiftCollected"] = table.freeze({
			["On"] = v16
		}),
		["FocusDeactivated"] = table.freeze({
			["On"] = v16
		}),
		["InitSkillTree"] = table.freeze({
			["On"] = v16
		}),
		["UpdateSkillRank"] = table.freeze({
			["On"] = v16
		}),
		["RespecSkillTree"] = table.freeze({
			["Fire"] = v16
		}),
		["SyncSkillTreeEconomy"] = table.freeze({
			["On"] = v16
		}),
		["RequestPrestige"] = table.freeze({
			["Fire"] = v16
		}),
		["HitRegClaim"] = table.freeze({
			["Fire"] = v16
		}),
		["RushNpcAttacking"] = table.freeze({
			["On"] = v16
		}),
		["RushNpcParried"] = table.freeze({
			["Fire"] = v16
		}),
		["RushPhaseChanged"] = table.freeze({
			["On"] = v16
		}),
		["RushPtsUpdate"] = table.freeze({
			["On"] = v16
		}),
		["RushVoteState"] = table.freeze({
			["On"] = v16
		}),
		["RushMissionResult"] = table.freeze({
			["On"] = v16
		}),
		["RushBossResult"] = table.freeze({
			["On"] = v16
		}),
		["RushContinueChoice"] = table.freeze({
			["Fire"] = v16
		}),
		["HintSystemMessage"] = table.freeze({
			["On"] = v16
		}),
		["RushShopStock"] = table.freeze({
			["On"] = v16
		}),
		["RushShopSync"] = table.freeze({
			["On"] = v16
		}),
		["RushShopBuy"] = table.freeze({
			["Fire"] = v16
		}),
		["RushShopSell"] = table.freeze({
			["Fire"] = v16
		}),
		["RushShopAction"] = table.freeze({
			["Fire"] = v16
		}),
		["ActivateFocus"] = table.freeze({
			["Call"] = v16
		})
	}
	return v17(v18)
end
if v2:IsServer() then
	error("Cannot use the client module on the server!")
end
local v19 = v1:WaitForChild("ZAP")
local v_u_20 = v19:WaitForChild("ZAP_RELIABLE")
local v21 = v_u_20:IsA("RemoteEvent")
assert(v21, "Expected ZAP_RELIABLE to be a RemoteEvent")
local v_u_22 = { v19:WaitForChild("ZAP_UNRELIABLE_0"), v19:WaitForChild("ZAP_UNRELIABLE_1") }
local v23 = v_u_22[1]:IsA("UnreliableRemoteEvent")
assert(v23, "Expected ZAP_UNRELIABLE_0 to be an UnreliableRemoteEvent")
local v24 = v_u_22[2]:IsA("UnreliableRemoteEvent")
assert(v24, "Expected ZAP_UNRELIABLE_1 to be an UnreliableRemoteEvent")
local function v26() -- name: SendEvents
	-- upvalues: (ref) v_u_4, (ref) v_u_3, (copy) v_u_20, (ref) v_u_6, (ref) v_u_5
	if v_u_4 ~= 0 then
		local v25 = buffer.create(v_u_4)
		buffer.copy(v25, 0, v_u_3, 0, v_u_4)
		v_u_20:FireServer(v25, v_u_6)
		v_u_3 = buffer.create(64)
		v_u_4 = 0
		v_u_5 = 64
		table.clear(v_u_6)
	end
end
v2.Heartbeat:Connect(v26)
local v_u_27 = table.create(46)
local v_u_28 = table.create(46)
local v_u_29 = table.create(2)
local v_u_30 = table.create(2)
local v_u_31 = 0
v_u_27[0] = {}
v_u_28[0] = {}
v_u_27[1] = {}
v_u_28[1] = {}
v_u_27[2] = {}
v_u_28[2] = {}
v_u_27[3] = {}
v_u_28[3] = {}
v_u_27[4] = {}
v_u_28[4] = {}
v_u_27[5] = {}
v_u_28[5] = {}
v_u_27[6] = {}
v_u_28[6] = {}
v_u_27[7] = {}
v_u_28[7] = {}
v_u_27[8] = {}
v_u_28[8] = {}
v_u_27[9] = {}
v_u_28[9] = {}
v_u_27[10] = {}
v_u_28[10] = {}
v_u_27[11] = {}
v_u_28[11] = {}
v_u_27[12] = {}
v_u_28[12] = {}
v_u_27[13] = {}
v_u_28[13] = {}
v_u_27[14] = {}
v_u_28[14] = {}
v_u_27[15] = {}
v_u_28[15] = {}
v_u_27[16] = {}
v_u_28[16] = {}
v_u_27[17] = {}
v_u_28[17] = {}
v_u_27[18] = {}
v_u_28[18] = {}
v_u_27[19] = {}
v_u_28[19] = {}
v_u_29[0] = {}
v_u_30[0] = {}
v_u_29[1] = {}
v_u_30[1] = {}
v_u_27[20] = {}
v_u_28[20] = {}
v_u_27[21] = {}
v_u_28[21] = {}
v_u_27[22] = {}
v_u_28[22] = {}
v_u_27[23] = {}
v_u_28[23] = {}
v_u_27[24] = {}
v_u_28[24] = {}
v_u_27[25] = {}
v_u_28[25] = {}
v_u_27[26] = {}
v_u_28[26] = {}
v_u_27[27] = {}
v_u_28[27] = {}
v_u_27[28] = {}
v_u_28[28] = {}
v_u_27[29] = {}
v_u_28[29] = {}
v_u_27[30] = {}
v_u_28[30] = {}
v_u_27[31] = {}
v_u_28[31] = {}
v_u_27[32] = {}
v_u_28[32] = {}
v_u_27[33] = {}
v_u_28[33] = {}
v_u_27[34] = {}
v_u_28[34] = {}
v_u_27[35] = {}
v_u_28[35] = {}
v_u_27[36] = {}
v_u_28[36] = {}
v_u_27[37] = {}
v_u_28[37] = {}
v_u_27[38] = {}
v_u_28[38] = {}
v_u_27[39] = {}
v_u_28[39] = {}
v_u_27[40] = {}
v_u_28[40] = {}
v_u_27[41] = {}
v_u_28[41] = {}
v_u_27[42] = {}
v_u_28[42] = {}
v_u_27[43] = {}
v_u_28[43] = {}
v_u_27[44] = {}
v_u_28[44] = {}
v_u_28[45] = table.create(255)
v_u_20.OnClientEvent:Connect(function(p32, p33)
	-- upvalues: (ref) v_u_8, (ref) v_u_10, (ref) v_u_9, (ref) v_u_11, (copy) v_u_27, (copy) v_u_28
	v_u_8 = p32
	v_u_10 = p33
	v_u_9 = 0
	v_u_11 = 0
	local v34 = buffer.len(p32)
	while v_u_9 < v34 do
		local v35 = v_u_9
		v_u_9 = v_u_9 + 1
		local v36 = buffer.readu8(p32, v35)
		if v36 == 0 then
			local v37 = {}
			local v38 = v_u_8
			local v39 = v_u_9
			v_u_9 = v_u_9 + 1
			if buffer.readu8(v38, v39) == 1 then
				v_u_11 = v_u_11 + 1
				v37.Data = v_u_10[v_u_11]
			else
				v37.Data = nil
			end
			local v40 = v_u_8
			local v41 = v_u_9
			v_u_9 = v_u_9 + 1
			if buffer.readu8(v40, v41) == 1 then
				v_u_11 = v_u_11 + 1
				v37.State = v_u_10[v_u_11]
			else
				v37.State = nil
			end
			local v42 = v_u_8
			local v43 = v_u_9
			v_u_9 = v_u_9 + 1
			if buffer.readu8(v42, v43) == 1 then
				v_u_11 = v_u_11 + 1
				v37.Game = v_u_10[v_u_11]
			else
				v37.Game = nil
			end
			if v_u_27[0][1] then
				for _, v44 in v_u_27[0] do
					task.spawn(v44, v37)
				end
			else
				local v45 = v_u_28[0]
				table.insert(v45, v37)
				if #v_u_28[0] > 64 then
					warn((("[ZAP] %* events in queue for InitUser. Did you forget to attach a listener?"):format(#v_u_28[0])))
				end
			end
		elseif v36 == 1 then
			local v46 = {}
			local v47 = v_u_8
			local v48 = v_u_9
			v_u_9 = v_u_9 + 1
			if buffer.readu8(v47, v48) == 1 then
				v_u_11 = v_u_11 + 1
				v46.value = v_u_10[v_u_11]
			else
				v46.value = nil
			end
			local v49 = v_u_8
			local v50 = v_u_9
			v_u_9 = v_u_9 + 2
			local v51 = buffer.readu16(v49, v50)
			local v52 = buffer.readstring
			local v53 = v_u_8
			local v54 = v_u_9
			v_u_9 = v_u_9 + v51
			v46.path = v52(v53, v54, v51)
			if v_u_27[1][1] then
				for _, v55 in v_u_27[1] do
					task.spawn(v55, v46)
				end
			else
				local v56 = v_u_28[1]
				table.insert(v56, v46)
				if #v_u_28[1] > 64 then
					warn((("[ZAP] %* events in queue for UpdateValue. Did you forget to attach a listener?"):format(#v_u_28[1])))
				end
			end
		elseif v36 == 2 then
			local v57 = {}
			local v58 = v_u_8
			local v59 = v_u_9
			v_u_9 = v_u_9 + 2
			local v60 = buffer.readu16(v58, v59)
			local v61 = buffer.readstring
			local v62 = v_u_8
			local v63 = v_u_9
			v_u_9 = v_u_9 + v60
			v57.path = v61(v62, v63, v60)
			local v64 = v_u_8
			local v65 = v_u_9
			v_u_9 = v_u_9 + 4
			v57.index = buffer.readi32(v64, v65)
			if v_u_27[2][1] then
				for _, v66 in v_u_27[2] do
					task.spawn(v66, v57)
				end
			else
				local v67 = v_u_28[2]
				table.insert(v67, v57)
				if #v_u_28[2] > 64 then
					warn((("[ZAP] %* events in queue for RemoveIndex. Did you forget to attach a listener?"):format(#v_u_28[2])))
				end
			end
		elseif v36 == 3 then
			local v68 = {}
			local v69 = v_u_8
			local v70 = v_u_9
			v_u_9 = v_u_9 + 2
			local v71 = buffer.readu16(v69, v70)
			local v72 = buffer.readstring
			local v73 = v_u_8
			local v74 = v_u_9
			v_u_9 = v_u_9 + v71
			v68.path = v72(v73, v74, v71)
			local v75 = v_u_8
			local v76 = v_u_9
			v_u_9 = v_u_9 + 4
			v68.index = buffer.readi32(v75, v76)
			local v77 = v_u_8
			local v78 = v_u_9
			v_u_9 = v_u_9 + 1
			if buffer.readu8(v77, v78) == 1 then
				v_u_11 = v_u_11 + 1
				v68.value = v_u_10[v_u_11]
			else
				v68.value = nil
			end
			if v_u_27[3][1] then
				for _, v79 in v_u_27[3] do
					task.spawn(v79, v68)
				end
			else
				local v80 = v_u_28[3]
				table.insert(v80, v68)
				if #v_u_28[3] > 64 then
					warn((("[ZAP] %* events in queue for InsertIndex. Did you forget to attach a listener?"):format(#v_u_28[3])))
				end
			end
		elseif v36 == 4 then
			local v81 = {}
			local v82 = v_u_8
			local v83 = v_u_9
			v_u_9 = v_u_9 + 2
			local v84 = buffer.readu16(v82, v83)
			local v85 = buffer.readstring
			local v86 = v_u_8
			local v87 = v_u_9
			v_u_9 = v_u_9 + v84
			v81.path = v85(v86, v87, v84)
			local v88 = v_u_8
			local v89 = v_u_9
			v_u_9 = v_u_9 + 2
			local v90 = buffer.readu16(v88, v89)
			local v91 = buffer.readstring
			local v92 = v_u_8
			local v93 = v_u_9
			v_u_9 = v_u_9 + v90
			v81.key = v91(v92, v93, v90)
			local v94 = v_u_8
			local v95 = v_u_9
			v_u_9 = v_u_9 + 1
			if buffer.readu8(v94, v95) == 1 then
				v_u_11 = v_u_11 + 1
				v81.value = v_u_10[v_u_11]
			else
				v81.value = nil
			end
			if v_u_27[4][1] then
				for _, v96 in v_u_27[4] do
					task.spawn(v96, v81)
				end
			else
				local v97 = v_u_28[4]
				table.insert(v97, v81)
				if #v_u_28[4] > 64 then
					warn((("[ZAP] %* events in queue for InsertKey. Did you forget to attach a listener?"):format(#v_u_28[4])))
				end
			end
		elseif v36 == 5 then
			local v98 = {}
			local v99 = v_u_8
			local v100 = v_u_9
			v_u_9 = v_u_9 + 2
			local v101 = buffer.readu16(v99, v100)
			local v102 = buffer.readstring
			local v103 = v_u_8
			local v104 = v_u_9
			v_u_9 = v_u_9 + v101
			v98.path = v102(v103, v104, v101)
			local v105 = v_u_8
			local v106 = v_u_9
			v_u_9 = v_u_9 + 2
			local v107 = buffer.readu16(v105, v106)
			local v108 = buffer.readstring
			local v109 = v_u_8
			local v110 = v_u_9
			v_u_9 = v_u_9 + v107
			v98.key = v108(v109, v110, v107)
			if v_u_27[5][1] then
				for _, v111 in v_u_27[5] do
					task.spawn(v111, v98)
				end
			else
				local v112 = v_u_28[5]
				table.insert(v112, v98)
				if #v_u_28[5] > 64 then
					warn((("[ZAP] %* events in queue for RemoveKey. Did you forget to attach a listener?"):format(#v_u_28[5])))
				end
			end
		elseif v36 == 6 then
			local v113 = {}
			local v114 = v_u_8
			local v115 = v_u_9
			v_u_9 = v_u_9 + 1
			if buffer.readu8(v114, v115) == 1 then
				v_u_11 = v_u_11 + 1
				v113.Maps = v_u_10[v_u_11]
			else
				v113.Maps = nil
			end
			local v116 = v_u_8
			local v117 = v_u_9
			v_u_9 = v_u_9 + 1
			if buffer.readu8(v116, v117) == 1 then
				v_u_11 = v_u_11 + 1
				v113.Difficulties = v_u_10[v_u_11]
			else
				v113.Difficulties = nil
			end
			local v118 = v_u_8
			local v119 = v_u_9
			v_u_9 = v_u_9 + 1
			if buffer.readu8(v118, v119) == 1 then
				v_u_11 = v_u_11 + 1
				v113.Timer = v_u_10[v_u_11]
			else
				v113.Timer = nil
			end
			local v120 = v_u_8
			local v121 = v_u_9
			v_u_9 = v_u_9 + 1
			if buffer.readu8(v120, v121) == 1 then
				v_u_11 = v_u_11 + 1
				v113.Selections = v_u_10[v_u_11]
			else
				v113.Selections = nil
			end
			if v_u_27[6][1] then
				for _, v122 in v_u_27[6] do
					task.spawn(v122, v113)
				end
			else
				local v123 = v_u_28[6]
				table.insert(v123, v113)
				if #v_u_28[6] > 64 then
					warn((("[ZAP] %* events in queue for StartSelection. Did you forget to attach a listener?"):format(#v_u_28[6])))
				end
			end
		elseif v36 == 7 then
			local v124 = {}
			local v125 = v_u_8
			local v126 = v_u_9
			v_u_9 = v_u_9 + 8
			v124.Timer = buffer.readf64(v125, v126)
			if v_u_27[7][1] then
				for _, v127 in v_u_27[7] do
					task.spawn(v127, v124)
				end
			else
				local v128 = v_u_28[7]
				table.insert(v128, v124)
				if #v_u_28[7] > 64 then
					warn((("[ZAP] %* events in queue for UpdateSelectionTimer. Did you forget to attach a listener?"):format(#v_u_28[7])))
				end
			end
		elseif v36 == 8 then
			local v129 = {}
			local v130 = v_u_8
			local v131 = v_u_9
			v_u_9 = v_u_9 + 8
			v129.PlayerID = buffer.readf64(v130, v131)
			local v132 = v_u_8
			local v133 = v_u_9
			v_u_9 = v_u_9 + 2
			local v134 = buffer.readu16(v132, v133)
			local v135 = buffer.readstring
			local v136 = v_u_8
			local v137 = v_u_9
			v_u_9 = v_u_9 + v134
			v129.Type = v135(v136, v137, v134)
			local v138 = v_u_8
			local v139 = v_u_9
			v_u_9 = v_u_9 + 2
			local v140 = buffer.readu16(v138, v139)
			local v141 = buffer.readstring
			local v142 = v_u_8
			local v143 = v_u_9
			v_u_9 = v_u_9 + v140
			v129.Value = v141(v142, v143, v140)
			if v_u_27[8][1] then
				for _, v144 in v_u_27[8] do
					task.spawn(v144, v129)
				end
			else
				local v145 = v_u_28[8]
				table.insert(v145, v129)
				if #v_u_28[8] > 64 then
					warn((("[ZAP] %* events in queue for UpdatePlayerSelection. Did you forget to attach a listener?"):format(#v_u_28[8])))
				end
			end
		elseif v36 == 9 then
			local v146 = {}
			local v147 = v_u_8
			local v148 = v_u_9
			v_u_9 = v_u_9 + 2
			local v149 = buffer.readu16(v147, v148)
			local v150 = buffer.readstring
			local v151 = v_u_8
			local v152 = v_u_9
			v_u_9 = v_u_9 + v149
			v146.Map = v150(v151, v152, v149)
			local v153 = v_u_8
			local v154 = v_u_9
			v_u_9 = v_u_9 + 2
			local v155 = buffer.readu16(v153, v154)
			local v156 = buffer.readstring
			local v157 = v_u_8
			local v158 = v_u_9
			v_u_9 = v_u_9 + v155
			v146.Difficulty = v156(v157, v158, v155)
			if v_u_27[9][1] then
				for _, v159 in v_u_27[9] do
					task.spawn(v159, v146)
				end
			else
				local v160 = v_u_28[9]
				table.insert(v160, v146)
				if #v_u_28[9] > 64 then
					warn((("[ZAP] %* events in queue for EndSelection. Did you forget to attach a listener?"):format(#v_u_28[9])))
				end
			end
		elseif v36 == 10 then
			local v161 = {}
			local v162 = v_u_8
			local v163 = v_u_9
			v_u_9 = v_u_9 + 1
			v161.type = buffer.readu8(v162, v163)
			local v164 = v_u_8
			local v165 = v_u_9
			v_u_9 = v_u_9 + 2
			local v166 = buffer.readu16(v164, v165)
			local v167 = buffer.readstring
			local v168 = v_u_8
			local v169 = v_u_9
			v_u_9 = v_u_9 + v166
			v161.message = v167(v168, v169, v166)
			if v_u_27[10][1] then
				for _, v170 in v_u_27[10] do
					task.spawn(v170, v161)
				end
			else
				local v171 = v_u_28[10]
				table.insert(v171, v161)
				if #v_u_28[10] > 64 then
					warn((("[ZAP] %* events in queue for StatusMessage. Did you forget to attach a listener?"):format(#v_u_28[10])))
				end
			end
		elseif v36 == 11 then
			local v172 = {}
			local v173 = v_u_8
			local v174 = v_u_9
			v_u_9 = v_u_9 + 1
			v172.type = buffer.readu8(v173, v174)
			local v175 = v_u_8
			local v176 = v_u_9
			v_u_9 = v_u_9 + 2
			local v177 = buffer.readu16(v175, v176)
			local v178 = buffer.readstring
			local v179 = v_u_8
			local v180 = v_u_9
			v_u_9 = v_u_9 + v177
			v172.header = v178(v179, v180, v177)
			local v181 = v_u_8
			local v182 = v_u_9
			v_u_9 = v_u_9 + 2
			local v183 = buffer.readu16(v181, v182)
			local v184 = buffer.readstring
			local v185 = v_u_8
			local v186 = v_u_9
			v_u_9 = v_u_9 + v183
			v172.message = v184(v185, v186, v183)
			if v_u_27[11][1] then
				for _, v187 in v_u_27[11] do
					task.spawn(v187, v172)
				end
			else
				local v188 = v_u_28[11]
				table.insert(v188, v172)
				if #v_u_28[11] > 64 then
					warn((("[ZAP] %* events in queue for BannerMessage. Did you forget to attach a listener?"):format(#v_u_28[11])))
				end
			end
		elseif v36 == 12 then
			local v189 = {}
			local v190 = v_u_8
			local v191 = v_u_9
			v_u_9 = v_u_9 + 2
			local v192 = buffer.readu16(v190, v191)
			local v193 = buffer.readstring
			local v194 = v_u_8
			local v195 = v_u_9
			v_u_9 = v_u_9 + v192
			v189.ServerType = v193(v194, v195, v192)
			local v196 = v_u_8
			local v197 = v_u_9
			v_u_9 = v_u_9 + 1
			if buffer.readu8(v196, v197) == 1 then
				v_u_11 = v_u_11 + 1
				v189.Servers = v_u_10[v_u_11]
			else
				v189.Servers = nil
			end
			if v_u_27[12][1] then
				for _, v198 in v_u_27[12] do
					task.spawn(v198, v189)
				end
			else
				local v199 = v_u_28[12]
				table.insert(v199, v189)
				if #v_u_28[12] > 64 then
					warn((("[ZAP] %* events in queue for ServerList. Did you forget to attach a listener?"):format(#v_u_28[12])))
				end
			end
		elseif v36 == 13 then
			local v200 = {}
			local v201 = v_u_8
			local v202 = v_u_9
			v_u_9 = v_u_9 + 2
			local v203 = buffer.readu16(v201, v202)
			local v204 = buffer.readstring
			local v205 = v_u_8
			local v206 = v_u_9
			v_u_9 = v_u_9 + v203
			v200.Message = v204(v205, v206, v203)
			if v_u_27[13][1] then
				for _, v207 in v_u_27[13] do
					task.spawn(v207, v200)
				end
			else
				local v208 = v_u_28[13]
				table.insert(v208, v200)
				if #v_u_28[13] > 64 then
					warn((("[ZAP] %* events in queue for JoinServerResponse. Did you forget to attach a listener?"):format(#v_u_28[13])))
				end
			end
		elseif v36 == 14 then
			local v209 = {}
			local v210 = v_u_8
			local v211 = v_u_9
			v_u_9 = v_u_9 + 1
			if buffer.readu8(v210, v211) == 1 then
				v_u_11 = v_u_11 + 1
				v209.Players = v_u_10[v_u_11]
			else
				v209.Players = nil
			end
			if v_u_27[14][1] then
				for _, v212 in v_u_27[14] do
					task.spawn(v212, v209)
				end
			else
				local v213 = v_u_28[14]
				table.insert(v213, v209)
				if #v_u_28[14] > 64 then
					warn((("[ZAP] %* events in queue for SetupPodium. Did you forget to attach a listener?"):format(#v_u_28[14])))
				end
			end
		elseif v36 == 15 then
			local v214 = {}
			local v215 = v_u_8
			local v216 = v_u_9
			v_u_9 = v_u_9 + 1
			if buffer.readu8(v215, v216) == 1 then
				v_u_11 = v_u_11 + 1
				v214.Players = v_u_10[v_u_11]
			else
				v214.Players = nil
			end
			if v_u_27[15][1] then
				for _, v217 in v_u_27[15] do
					task.spawn(v217, v214)
				end
			else
				local v218 = v_u_28[15]
				table.insert(v218, v214)
				if #v_u_28[15] > 64 then
					warn((("[ZAP] %* events in queue for OpenGamemodeEndScoreboard. Did you forget to attach a listener?"):format(#v_u_28[15])))
				end
			end
		elseif v36 == 16 then
			local v219 = v_u_8
			local v220 = v_u_9
			v_u_9 = v_u_9 + 1
			local v221
			if buffer.readu8(v219, v220) == 1 then
				v_u_11 = v_u_11 + 1
				v221 = v_u_10[v_u_11]
			else
				v221 = nil
			end
			if v_u_27[16][1] then
				for _, v222 in v_u_27[16] do
					task.spawn(v222, v221)
				end
			else
				local v223 = v_u_28[16]
				table.insert(v223, v221)
				if #v_u_28[16] > 64 then
					warn((("[ZAP] %* events in queue for CloseGamemodeEndScoreboard. Did you forget to attach a listener?"):format(#v_u_28[16])))
				end
			end
		elseif v36 == 17 then
			local v224 = {}
			local v225 = v_u_8
			local v226 = v_u_9
			v_u_9 = v_u_9 + 1
			if buffer.readu8(v225, v226) == 1 then
				v_u_11 = v_u_11 + 1
				v224.Weapons = v_u_10[v_u_11]
			else
				v224.Weapons = nil
			end
			if v_u_27[17][1] then
				for _, v227 in v_u_27[17] do
					task.spawn(v227, v224)
				end
			else
				local v228 = v_u_28[17]
				table.insert(v228, v224)
				if #v_u_28[17] > 64 then
					warn((("[ZAP] %* events in queue for PreloadWeapons. Did you forget to attach a listener?"):format(#v_u_28[17])))
				end
			end
		elseif v36 == 18 then
			local v229 = v_u_8
			local v230 = v_u_9
			v_u_9 = v_u_9 + 1
			local v231
			if buffer.readu8(v229, v230) == 1 then
				v_u_11 = v_u_11 + 1
				v231 = v_u_10[v_u_11]
			else
				v231 = nil
			end
			if v_u_27[18][1] then
				for _, v232 in v_u_27[18] do
					task.spawn(v232, v231)
				end
			else
				local v233 = v_u_28[18]
				table.insert(v233, v231)
				if #v_u_28[18] > 64 then
					warn((("[ZAP] %* events in queue for ClearPreloadedWeapons. Did you forget to attach a listener?"):format(#v_u_28[18])))
				end
			end
		elseif v36 == 19 then
			local v234 = {}
			local v235 = v_u_8
			local v236 = v_u_9
			v_u_9 = v_u_9 + 2
			local v237 = buffer.readu16(v235, v236)
			local v238 = buffer.readstring
			local v239 = v_u_8
			local v240 = v_u_9
			v_u_9 = v_u_9 + v237
			v234.PrivateServerId = v238(v239, v240, v237)
			if v_u_27[19][1] then
				for _, v241 in v_u_27[19] do
					task.spawn(v241, v234)
				end
			else
				local v242 = v_u_28[19]
				table.insert(v242, v234)
				if #v_u_28[19] > 64 then
					warn((("[ZAP] %* events in queue for PrivateServerCreated. Did you forget to attach a listener?"):format(#v_u_28[19])))
				end
			end
		elseif v36 == 20 then
			local v243 = {}
			local v244 = v_u_8
			local v245 = v_u_9
			v_u_9 = v_u_9 + 8
			v243.UID = buffer.readf64(v244, v245)
			local v246 = v_u_8
			local v247 = v_u_9
			v_u_9 = v_u_9 + 2
			local v248 = buffer.readu16(v246, v247)
			local v249 = buffer.readstring
			local v250 = v_u_8
			local v251 = v_u_9
			v_u_9 = v_u_9 + v248
			v243.Type = v249(v250, v251, v248)
			if v_u_27[20][1] then
				for _, v252 in v_u_27[20] do
					task.spawn(v252, v243)
				end
			else
				local v253 = v_u_28[20]
				table.insert(v253, v243)
				if #v_u_28[20] > 64 then
					warn((("[ZAP] %* events in queue for NPCRegistryEvent. Did you forget to attach a listener?"):format(#v_u_28[20])))
				end
			end
		elseif v36 == 21 then
			local v254 = {}
			local v255 = v_u_8
			local v256 = v_u_9
			v_u_9 = v_u_9 + 1
			v254.IsVisible = buffer.readu8(v255, v256) == 1
			if v_u_27[21][1] then
				for _, v257 in v_u_27[21] do
					task.spawn(v257, v254)
				end
			else
				local v258 = v_u_28[21]
				table.insert(v258, v254)
				if #v_u_28[21] > 64 then
					warn((("[ZAP] %* events in queue for TogglePointsUIEvent. Did you forget to attach a listener?"):format(#v_u_28[21])))
				end
			end
		elseif v36 == 22 then
			local v259 = {}
			local v260 = v_u_8
			local v261 = v_u_9
			v_u_9 = v_u_9 + 1
			v259.IsVisible = buffer.readu8(v260, v261) == 1
			if v_u_27[22][1] then
				for _, v262 in v_u_27[22] do
					task.spawn(v262, v259)
				end
			else
				local v263 = v_u_28[22]
				table.insert(v263, v259)
				if #v_u_28[22] > 64 then
					warn((("[ZAP] %* events in queue for ToggleSurvivalShopUIEvent. Did you forget to attach a listener?"):format(#v_u_28[22])))
				end
			end
		elseif v36 == 23 then
			local v264 = {}
			local v265 = v_u_8
			local v266 = v_u_9
			v_u_9 = v_u_9 + 1
			if buffer.readu8(v265, v266) == 1 then
				v_u_11 = v_u_11 + 1
				v264.SurvivalShopItemsInfo = v_u_10[v_u_11]
			else
				v264.SurvivalShopItemsInfo = nil
			end
			if v_u_27[23][1] then
				for _, v267 in v_u_27[23] do
					task.spawn(v267, v264)
				end
			else
				local v268 = v_u_28[23]
				table.insert(v268, v264)
				if #v_u_28[23] > 64 then
					warn((("[ZAP] %* events in queue for InitSurvivalShopEvent. Did you forget to attach a listener?"):format(#v_u_28[23])))
				end
			end
		elseif v36 == 24 then
			local v269 = {}
			local v270 = v_u_8
			local v271 = v_u_9
			v_u_9 = v_u_9 + 2
			local v272 = buffer.readu16(v270, v271)
			local v273 = buffer.readstring
			local v274 = v_u_8
			local v275 = v_u_9
			v_u_9 = v_u_9 + v272
			v269.ExplosionType = v273(v274, v275, v272)
			local v276 = v_u_8
			local v277 = v_u_9
			v_u_9 = v_u_9 + 4
			local v278 = buffer.readf32(v276, v277)
			local v279 = v_u_8
			local v280 = v_u_9
			v_u_9 = v_u_9 + 4
			local v281 = buffer.readf32(v279, v280)
			local v282 = v_u_8
			local v283 = v_u_9
			v_u_9 = v_u_9 + 4
			local v284 = buffer.readf32(v282, v283)
			v269.Position = vector.create(v278, v281, v284)
			local v285 = v_u_8
			local v286 = v_u_9
			v_u_9 = v_u_9 + 8
			v269.BlastRadius = buffer.readf64(v285, v286)
			if v_u_27[24][1] then
				for _, v287 in v_u_27[24] do
					task.spawn(v287, v269)
				end
			else
				local v288 = v_u_28[24]
				table.insert(v288, v269)
				if #v_u_28[24] > 64 then
					warn((("[ZAP] %* events in queue for RenderExplosionEvent. Did you forget to attach a listener?"):format(#v_u_28[24])))
				end
			end
		elseif v36 == 25 then
			local v289 = {}
			local v290 = v_u_8
			local v291 = v_u_9
			v_u_9 = v_u_9 + 2
			local v292 = buffer.readu16(v290, v291)
			local v293 = buffer.readstring
			local v294 = v_u_8
			local v295 = v_u_9
			v_u_9 = v_u_9 + v292
			v289.Key = v293(v294, v295, v292)
			local v296 = v_u_8
			local v297 = v_u_9
			v_u_9 = v_u_9 + 1
			if buffer.readu8(v296, v297) == 1 then
				v_u_11 = v_u_11 + 1
				v289.Value = v_u_10[v_u_11]
			else
				v289.Value = nil
			end
			if v_u_27[25][1] then
				for _, v298 in v_u_27[25] do
					task.spawn(v298, v289)
				end
			else
				local v299 = v_u_28[25]
				table.insert(v299, v289)
				if #v_u_28[25] > 64 then
					warn((("[ZAP] %* events in queue for SetGameStateKey. Did you forget to attach a listener?"):format(#v_u_28[25])))
				end
			end
		elseif v36 == 26 then
			local v300 = {}
			local v301 = v_u_8
			local v302 = v_u_9
			v_u_9 = v_u_9 + 2
			local v303 = buffer.readu16(v301, v302)
			local v304 = buffer.readstring
			local v305 = v_u_8
			local v306 = v_u_9
			v_u_9 = v_u_9 + v303
			v300.Key = v304(v305, v306, v303)
			local v307 = v_u_8
			local v308 = v_u_9
			v_u_9 = v_u_9 + 1
			if buffer.readu8(v307, v308) == 1 then
				v_u_11 = v_u_11 + 1
				v300.Value = v_u_10[v_u_11]
			else
				v300.Value = nil
			end
			if v_u_27[26][1] then
				for _, v309 in v_u_27[26] do
					task.spawn(v309, v300)
				end
			else
				local v310 = v_u_28[26]
				table.insert(v310, v300)
				if #v_u_28[26] > 64 then
					warn((("[ZAP] %* events in queue for SetGameStateVariable. Did you forget to attach a listener?"):format(#v_u_28[26])))
				end
			end
		elseif v36 == 27 then
			local v311 = v_u_8
			local v312 = v_u_9
			v_u_9 = v_u_9 + 1
			local v313
			if buffer.readu8(v311, v312) == 1 then
				v_u_11 = v_u_11 + 1
				v313 = v_u_10[v_u_11]
			else
				v313 = nil
			end
			if v_u_27[27][1] then
				for _, v314 in v_u_27[27] do
					task.spawn(v314, v313)
				end
			else
				local v315 = v_u_28[27]
				table.insert(v315, v313)
				if #v_u_28[27] > 64 then
					warn((("[ZAP] %* events in queue for InitGameState. Did you forget to attach a listener?"):format(#v_u_28[27])))
				end
			end
		elseif v36 == 28 then
			local v316 = v_u_8
			local v317 = v_u_9
			v_u_9 = v_u_9 + 1
			local v318
			if buffer.readu8(v316, v317) == 1 then
				v_u_11 = v_u_11 + 1
				v318 = v_u_10[v_u_11]
			else
				v318 = nil
			end
			if v_u_27[28][1] then
				for _, v319 in v_u_27[28] do
					task.spawn(v319, v318)
				end
			else
				local v320 = v_u_28[28]
				table.insert(v320, v318)
				if #v_u_28[28] > 64 then
					warn((("[ZAP] %* events in queue for InitQuests. Did you forget to attach a listener?"):format(#v_u_28[28])))
				end
			end
		elseif v36 == 29 then
			local v321 = {}
			local v322 = v_u_8
			local v323 = v_u_9
			v_u_9 = v_u_9 + 2
			local v324 = buffer.readu16(v322, v323)
			local v325 = buffer.readstring
			local v326 = v_u_8
			local v327 = v_u_9
			v_u_9 = v_u_9 + v324
			v321.Category = v325(v326, v327, v324)
			local v328 = v_u_8
			local v329 = v_u_9
			v_u_9 = v_u_9 + 1
			if buffer.readu8(v328, v329) == 1 then
				v_u_11 = v_u_11 + 1
				v321.Quests = v_u_10[v_u_11]
			else
				v321.Quests = nil
			end
			if v_u_27[29][1] then
				for _, v330 in v_u_27[29] do
					task.spawn(v330, v321)
				end
			else
				local v331 = v_u_28[29]
				table.insert(v331, v321)
				if #v_u_28[29] > 64 then
					warn((("[ZAP] %* events in queue for UpdateQuestCategory. Did you forget to attach a listener?"):format(#v_u_28[29])))
				end
			end
		elseif v36 == 30 then
			local v332 = {}
			local v333 = v_u_8
			local v334 = v_u_9
			v_u_9 = v_u_9 + 2
			local v335 = buffer.readu16(v333, v334)
			local v336 = buffer.readstring
			local v337 = v_u_8
			local v338 = v_u_9
			v_u_9 = v_u_9 + v335
			v332.Category = v336(v337, v338, v335)
			local v339 = v_u_8
			local v340 = v_u_9
			v_u_9 = v_u_9 + 2
			local v341 = buffer.readu16(v339, v340)
			local v342 = buffer.readstring
			local v343 = v_u_8
			local v344 = v_u_9
			v_u_9 = v_u_9 + v341
			v332.QuestKey = v342(v343, v344, v341)
			local v345 = v_u_8
			local v346 = v_u_9
			v_u_9 = v_u_9 + 8
			v332.Progress = buffer.readf64(v345, v346)
			if v_u_27[30][1] then
				for _, v347 in v_u_27[30] do
					task.spawn(v347, v332)
				end
			else
				local v348 = v_u_28[30]
				table.insert(v348, v332)
				if #v_u_28[30] > 64 then
					warn((("[ZAP] %* events in queue for UpdateQuestProgress. Did you forget to attach a listener?"):format(#v_u_28[30])))
				end
			end
		elseif v36 == 31 then
			local v349 = {}
			v_u_11 = v_u_11 + 1
			v349.Player = v_u_10[v_u_11]
			local v350 = v349.Player ~= nil
			assert(v350)
			local v351 = v_u_8
			local v352 = v_u_9
			v_u_9 = v_u_9 + 4
			local v353 = buffer.readf32(v351, v352)
			local v354 = v_u_8
			local v355 = v_u_9
			v_u_9 = v_u_9 + 4
			local v356 = buffer.readf32(v354, v355)
			local v357 = v_u_8
			local v358 = v_u_9
			v_u_9 = v_u_9 + 4
			local v359 = buffer.readf32(v357, v358)
			local v360 = Vector3.new(v353, v356, v359)
			local v361 = v_u_8
			local v362 = v_u_9
			v_u_9 = v_u_9 + 4
			local v363 = buffer.readf32(v361, v362)
			local v364 = v_u_8
			local v365 = v_u_9
			v_u_9 = v_u_9 + 4
			local v366 = buffer.readf32(v364, v365)
			local v367 = v_u_8
			local v368 = v_u_9
			v_u_9 = v_u_9 + 4
			local v369 = buffer.readf32(v367, v368)
			local v370 = Vector3.new(v363, v366, v369)
			local v371 = v370.Magnitude
			if v371 == 0 then
				v349.Gift = CFrame.new(v360)
			else
				v349.Gift = CFrame.fromAxisAngle(v370, v371) + v360
			end
			if v_u_27[31][1] then
				for _, v372 in v_u_27[31] do
					task.spawn(v372, v349)
				end
			else
				local v373 = v_u_28[31]
				table.insert(v373, v349)
				if #v_u_28[31] > 64 then
					warn((("[ZAP] %* events in queue for ChristmasGiftCollected. Did you forget to attach a listener?"):format(#v_u_28[31])))
				end
			end
		elseif v36 == 32 then
			local v374 = {}
			if v_u_27[32][1] then
				for _, v375 in v_u_27[32] do
					task.spawn(v375, v374)
				end
			else
				local v376 = v_u_28[32]
				table.insert(v376, v374)
				if #v_u_28[32] > 64 then
					warn((("[ZAP] %* events in queue for FocusDeactivated. Did you forget to attach a listener?"):format(#v_u_28[32])))
				end
			end
		elseif v36 == 33 then
			local v377 = {}
			local v378 = v_u_8
			local v379 = v_u_9
			v_u_9 = v_u_9 + 2
			for _ = 1, buffer.readu16(v378, v379) do
				local v380 = v_u_8
				local v381 = v_u_9
				v_u_9 = v_u_9 + 2
				local v382 = buffer.readu16(v380, v381)
				local v383 = buffer.readstring
				local v384 = v_u_8
				local v385 = v_u_9
				v_u_9 = v_u_9 + v382
				local v386 = v383(v384, v385, v382)
				local v387 = v_u_8
				local v388 = v_u_9
				v_u_9 = v_u_9 + 2
				v377[v386] = buffer.readi16(v387, v388)
			end
			if v_u_27[33][1] then
				for _, v389 in v_u_27[33] do
					task.spawn(v389, v377)
				end
			else
				local v390 = v_u_28[33]
				table.insert(v390, v377)
				if #v_u_28[33] > 64 then
					warn((("[ZAP] %* events in queue for InitSkillTree. Did you forget to attach a listener?"):format(#v_u_28[33])))
				end
			end
		elseif v36 == 34 then
			local v391 = {}
			local v392 = v_u_8
			local v393 = v_u_9
			v_u_9 = v_u_9 + 2
			local v394 = buffer.readu16(v392, v393)
			local v395 = buffer.readstring
			local v396 = v_u_8
			local v397 = v_u_9
			v_u_9 = v_u_9 + v394
			v391.SkillId = v395(v396, v397, v394)
			local v398 = v_u_8
			local v399 = v_u_9
			v_u_9 = v_u_9 + 2
			v391.Rank = buffer.readi16(v398, v399)
			if v_u_27[34][1] then
				for _, v400 in v_u_27[34] do
					task.spawn(v400, v391)
				end
			else
				local v401 = v_u_28[34]
				table.insert(v401, v391)
				if #v_u_28[34] > 64 then
					warn((("[ZAP] %* events in queue for UpdateSkillRank. Did you forget to attach a listener?"):format(#v_u_28[34])))
				end
			end
		elseif v36 == 35 then
			local v402 = {}
			local v403 = v_u_8
			local v404 = v_u_9
			v_u_9 = v_u_9 + 2
			v402.SP = buffer.readi16(v403, v404)
			local v405 = v_u_8
			local v406 = v_u_9
			v_u_9 = v_u_9 + 2
			v402.SPCap = buffer.readi16(v405, v406)
			local v407 = v_u_8
			local v408 = v_u_9
			v_u_9 = v_u_9 + 2
			v402.SPSpent = buffer.readi16(v407, v408)
			local v409 = v_u_8
			local v410 = v_u_9
			v_u_9 = v_u_9 + 4
			v402.XPBar = buffer.readi32(v409, v410)
			local v411 = v_u_8
			local v412 = v_u_9
			v_u_9 = v_u_9 + 2
			v402.DailyEarned = buffer.readi16(v411, v412)
			local v413 = v_u_8
			local v414 = v_u_9
			v_u_9 = v_u_9 + 2
			v402.DailyEarnCap = buffer.readi16(v413, v414)
			local v415 = v_u_8
			local v416 = v_u_9
			v_u_9 = v_u_9 + 2
			v402.PrestigeLevel = buffer.readi16(v415, v416)
			local v417 = v_u_8
			local v418 = v_u_9
			v_u_9 = v_u_9 + 4
			v402.ZBucks = buffer.readi32(v417, v418)
			local v419 = v_u_8
			local v420 = v_u_9
			v_u_9 = v_u_9 + 4
			v402.ZBucksInvested = buffer.readi32(v419, v420)
			if v_u_27[35][1] then
				for _, v421 in v_u_27[35] do
					task.spawn(v421, v402)
				end
			else
				local v422 = v_u_28[35]
				table.insert(v422, v402)
				if #v_u_28[35] > 64 then
					warn((("[ZAP] %* events in queue for SyncSkillTreeEconomy. Did you forget to attach a listener?"):format(#v_u_28[35])))
				end
			end
		elseif v36 == 36 then
			local v423 = {}
			local v424 = v_u_8
			local v425 = v_u_9
			v_u_9 = v_u_9 + 4
			v423.entityId = buffer.readu32(v424, v425)
			if v_u_27[36][1] then
				for _, v426 in v_u_27[36] do
					task.spawn(v426, v423)
				end
			else
				local v427 = v_u_28[36]
				table.insert(v427, v423)
				if #v_u_28[36] > 64 then
					warn((("[ZAP] %* events in queue for RushNpcAttacking. Did you forget to attach a listener?"):format(#v_u_28[36])))
				end
			end
		elseif v36 == 37 then
			local v428 = {}
			local v429 = v_u_8
			local v430 = v_u_9
			v_u_9 = v_u_9 + 2
			local v431 = buffer.readu16(v429, v430)
			local v432 = buffer.readstring
			local v433 = v_u_8
			local v434 = v_u_9
			v_u_9 = v_u_9 + v431
			v428.phase = v432(v433, v434, v431)
			local v435 = v_u_8
			local v436 = v_u_9
			v_u_9 = v_u_9 + 1
			v428.cycle = buffer.readu8(v435, v436)
			local v437 = v_u_8
			local v438 = v_u_9
			v_u_9 = v_u_9 + 1
			v428.missionIndex = buffer.readu8(v437, v438)
			local v439 = v_u_8
			local v440 = v_u_9
			v_u_9 = v_u_9 + 1
			v428.livesRemaining = buffer.readu8(v439, v440)
			if v_u_27[37][1] then
				for _, v441 in v_u_27[37] do
					task.spawn(v441, v428)
				end
			else
				local v442 = v_u_28[37]
				table.insert(v442, v428)
				if #v_u_28[37] > 64 then
					warn((("[ZAP] %* events in queue for RushPhaseChanged. Did you forget to attach a listener?"):format(#v_u_28[37])))
				end
			end
		elseif v36 == 38 then
			local v443 = {}
			local v444 = v_u_8
			local v445 = v_u_9
			v_u_9 = v_u_9 + 4
			v443.pts = buffer.readi32(v444, v445)
			if v_u_27[38][1] then
				for _, v446 in v_u_27[38] do
					task.spawn(v446, v443)
				end
			else
				local v447 = v_u_28[38]
				table.insert(v447, v443)
				if #v_u_28[38] > 64 then
					warn((("[ZAP] %* events in queue for RushPtsUpdate. Did you forget to attach a listener?"):format(#v_u_28[38])))
				end
			end
		elseif v36 == 39 then
			local v448 = {}
			local v449 = v_u_8
			local v450 = v_u_9
			v_u_9 = v_u_9 + 1
			v448.pad1Count = buffer.readu8(v449, v450)
			local v451 = v_u_8
			local v452 = v_u_9
			v_u_9 = v_u_9 + 1
			v448.pad2Count = buffer.readu8(v451, v452)
			local v453 = v_u_8
			local v454 = v_u_9
			v_u_9 = v_u_9 + 1
			v448.pad3Count = buffer.readu8(v453, v454)
			local v455 = v_u_8
			local v456 = v_u_9
			v_u_9 = v_u_9 + 4
			v448.countdown = buffer.readf32(v455, v456)
			local v457 = v_u_8
			local v458 = v_u_9
			v_u_9 = v_u_9 + 1
			v448.isCountingDown = buffer.readu8(v457, v458) == 1
			local v459 = v_u_8
			local v460 = v_u_9
			v_u_9 = v_u_9 + 2
			local v461 = buffer.readu16(v459, v460)
			local v462 = buffer.readstring
			local v463 = v_u_8
			local v464 = v_u_9
			v_u_9 = v_u_9 + v461
			v448.pad1Label = v462(v463, v464, v461)
			local v465 = v_u_8
			local v466 = v_u_9
			v_u_9 = v_u_9 + 2
			local v467 = buffer.readu16(v465, v466)
			local v468 = buffer.readstring
			local v469 = v_u_8
			local v470 = v_u_9
			v_u_9 = v_u_9 + v467
			v448.pad2Label = v468(v469, v470, v467)
			local v471 = v_u_8
			local v472 = v_u_9
			v_u_9 = v_u_9 + 2
			local v473 = buffer.readu16(v471, v472)
			local v474 = buffer.readstring
			local v475 = v_u_8
			local v476 = v_u_9
			v_u_9 = v_u_9 + v473
			v448.pad3Label = v474(v475, v476, v473)
			if v_u_27[39][1] then
				for _, v477 in v_u_27[39] do
					task.spawn(v477, v448)
				end
			else
				local v478 = v_u_28[39]
				table.insert(v478, v448)
				if #v_u_28[39] > 64 then
					warn((("[ZAP] %* events in queue for RushVoteState. Did you forget to attach a listener?"):format(#v_u_28[39])))
				end
			end
		elseif v36 == 40 then
			local v479 = {}
			local v480 = v_u_8
			local v481 = v_u_9
			v_u_9 = v_u_9 + 1
			v479.success = buffer.readu8(v480, v481) == 1
			local v482 = v_u_8
			local v483 = v_u_9
			v_u_9 = v_u_9 + 4
			v479.ptsEarned = buffer.readi32(v482, v483)
			if v_u_27[40][1] then
				for _, v484 in v_u_27[40] do
					task.spawn(v484, v479)
				end
			else
				local v485 = v_u_28[40]
				table.insert(v485, v479)
				if #v_u_28[40] > 64 then
					warn((("[ZAP] %* events in queue for RushMissionResult. Did you forget to attach a listener?"):format(#v_u_28[40])))
				end
			end
		elseif v36 == 41 then
			local v486 = {}
			local v487 = v_u_8
			local v488 = v_u_9
			v_u_9 = v_u_9 + 1
			v486.success = buffer.readu8(v487, v488) == 1
			local v489 = v_u_8
			local v490 = v_u_9
			v_u_9 = v_u_9 + 4
			v486.zbucksEarned = buffer.readi32(v489, v490)
			if v_u_27[41][1] then
				for _, v491 in v_u_27[41] do
					task.spawn(v491, v486)
				end
			else
				local v492 = v_u_28[41]
				table.insert(v492, v486)
				if #v_u_28[41] > 64 then
					warn((("[ZAP] %* events in queue for RushBossResult. Did you forget to attach a listener?"):format(#v_u_28[41])))
				end
			end
		elseif v36 == 42 then
			local v493 = {}
			local v494 = v_u_8
			local v495 = v_u_9
			v_u_9 = v_u_9 + 2
			local v496 = buffer.readu16(v494, v495)
			local v497 = buffer.readstring
			local v498 = v_u_8
			local v499 = v_u_9
			v_u_9 = v_u_9 + v496
			v493.message = v497(v498, v499, v496)
			local v500 = v_u_8
			local v501 = v_u_9
			v_u_9 = v_u_9 + 1
			if buffer.readu8(v500, v501) == 1 then
				local v502 = v_u_8
				local v503 = v_u_9
				v_u_9 = v_u_9 + 4
				v493.duration = buffer.readf32(v502, v503)
			else
				v493.duration = nil
			end
			local v504 = v_u_8
			local v505 = v_u_9
			v_u_9 = v_u_9 + 1
			if buffer.readu8(v504, v505) == 1 then
				local v506 = v_u_8
				local v507 = v_u_9
				v_u_9 = v_u_9 + 2
				local v508 = buffer.readu16(v506, v507)
				local v509 = buffer.readstring
				local v510 = v_u_8
				local v511 = v_u_9
				v_u_9 = v_u_9 + v508
				v493.key = v509(v510, v511, v508)
			else
				v493.key = nil
			end
			if v_u_27[42][1] then
				for _, v512 in v_u_27[42] do
					task.spawn(v512, v493)
				end
			else
				local v513 = v_u_28[42]
				table.insert(v513, v493)
				if #v_u_28[42] > 64 then
					warn((("[ZAP] %* events in queue for HintSystemMessage. Did you forget to attach a listener?"):format(#v_u_28[42])))
				end
			end
		elseif v36 == 43 then
			local v514 = {
				["primary"] = {}
			}
			local v515 = v_u_8
			local v516 = v_u_9
			v_u_9 = v_u_9 + 2
			for v517 = 1, buffer.readu16(v515, v516) do
				local v518 = v_u_8
				local v519 = v_u_9
				v_u_9 = v_u_9 + 2
				local v520 = buffer.readu16(v518, v519)
				local v521 = buffer.readstring
				local v522 = v_u_8
				local v523 = v_u_9
				v_u_9 = v_u_9 + v520
				local v524 = v521(v522, v523, v520)
				v514.primary[v517] = v524
			end
			v514.secondary = {}
			local v525 = v_u_8
			local v526 = v_u_9
			v_u_9 = v_u_9 + 2
			for v527 = 1, buffer.readu16(v525, v526) do
				local v528 = v_u_8
				local v529 = v_u_9
				v_u_9 = v_u_9 + 2
				local v530 = buffer.readu16(v528, v529)
				local v531 = buffer.readstring
				local v532 = v_u_8
				local v533 = v_u_9
				v_u_9 = v_u_9 + v530
				local v534 = v531(v532, v533, v530)
				v514.secondary[v527] = v534
			end
			v514.melee = {}
			local v535 = v_u_8
			local v536 = v_u_9
			v_u_9 = v_u_9 + 2
			for v537 = 1, buffer.readu16(v535, v536) do
				local v538 = v_u_8
				local v539 = v_u_9
				v_u_9 = v_u_9 + 2
				local v540 = buffer.readu16(v538, v539)
				local v541 = buffer.readstring
				local v542 = v_u_8
				local v543 = v_u_9
				v_u_9 = v_u_9 + v540
				local v544 = v541(v542, v543, v540)
				v514.melee[v537] = v544
			end
			if v_u_27[43][1] then
				for _, v545 in v_u_27[43] do
					task.spawn(v545, v514)
				end
			else
				local v546 = v_u_28[43]
				table.insert(v546, v514)
				if #v_u_28[43] > 64 then
					warn((("[ZAP] %* events in queue for RushShopStock. Did you forget to attach a listener?"):format(#v_u_28[43])))
				end
			end
		elseif v36 == 44 then
			local v547 = {}
			local v548 = v_u_8
			local v549 = v_u_9
			v_u_9 = v_u_9 + 1
			if buffer.readu8(v548, v549) == 1 then
				v_u_11 = v_u_11 + 1
				v547.ownedWeapons = v_u_10[v_u_11]
			else
				v547.ownedWeapons = nil
			end
			local v550 = v_u_8
			local v551 = v_u_9
			v_u_9 = v_u_9 + 1
			if buffer.readu8(v550, v551) == 1 then
				v_u_11 = v_u_11 + 1
				v547.equippedWeapons = v_u_10[v_u_11]
			else
				v547.equippedWeapons = nil
			end
			local v552 = v_u_8
			local v553 = v_u_9
			v_u_9 = v_u_9 + 1
			if buffer.readu8(v552, v553) == 1 then
				v_u_11 = v_u_11 + 1
				v547.weaponUpgrades = v_u_10[v_u_11]
			else
				v547.weaponUpgrades = nil
			end
			local v554 = v_u_8
			local v555 = v_u_9
			v_u_9 = v_u_9 + 1
			if buffer.readu8(v554, v555) == 1 then
				v_u_11 = v_u_11 + 1
				v547.purchasedAttachments = v_u_10[v_u_11]
			else
				v547.purchasedAttachments = nil
			end
			local v556 = v_u_8
			local v557 = v_u_9
			v_u_9 = v_u_9 + 1
			if buffer.readu8(v556, v557) == 1 then
				v_u_11 = v_u_11 + 1
				v547.weaponAttachments = v_u_10[v_u_11]
			else
				v547.weaponAttachments = nil
			end
			local v558 = v_u_8
			local v559 = v_u_9
			v_u_9 = v_u_9 + 1
			if buffer.readu8(v558, v559) == 1 then
				v_u_11 = v_u_11 + 1
				v547.weaponInvestment = v_u_10[v_u_11]
			else
				v547.weaponInvestment = nil
			end
			if v_u_27[44][1] then
				for _, v560 in v_u_27[44] do
					task.spawn(v560, v547)
				end
			else
				local v561 = v_u_28[44]
				table.insert(v561, v547)
				if #v_u_28[44] > 64 then
					warn((("[ZAP] %* events in queue for RushShopSync. Did you forget to attach a listener?"):format(#v_u_28[44])))
				end
			end
		elseif v36 == 45 then
			local v562 = v_u_8
			local v563 = v_u_9
			v_u_9 = v_u_9 + 1
			local v564 = buffer.readu8(v562, v563)
			local v565 = v_u_8
			local v566 = v_u_9
			v_u_9 = v_u_9 + 1
			local v567 = buffer.readu8(v565, v566) == 1
			local v568 = v_u_28[45][v564]
			if v568 then
				task.spawn(v568, v567)
			end
			v_u_28[45][v564] = nil
		else
			error("Unknown event id")
		end
	end
end)
v_u_22[1].OnClientEvent:Connect(function(p569, p570)
	-- upvalues: (ref) v_u_8, (ref) v_u_10, (ref) v_u_9, (ref) v_u_11, (copy) v_u_29, (copy) v_u_30
	v_u_8 = p569
	v_u_10 = p570
	v_u_9 = 0
	v_u_11 = 0
	local v571 = {
		["NPCs"] = {}
	}
	local v572 = v_u_8
	local v573 = v_u_9
	v_u_9 = v_u_9 + 2
	for _ = 1, buffer.readu16(v572, v573) do
		local v574 = v_u_8
		local v575 = v_u_9
		v_u_9 = v_u_9 + 2
		local v576 = buffer.readu16(v574, v575)
		local v577 = v_u_8
		local v578 = v_u_9
		v_u_9 = v_u_9 + 4
		local v579 = buffer.readf32(v577, v578)
		local v580 = v_u_8
		local v581 = v_u_9
		v_u_9 = v_u_9 + 4
		local v582 = buffer.readf32(v580, v581)
		local v583 = v_u_8
		local v584 = v_u_9
		v_u_9 = v_u_9 + 4
		local v585 = buffer.readf32(v583, v584)
		local v586 = vector.create(v579, v582, v585)
		v571.NPCs[v576] = v586
	end
	local v587 = v_u_8
	local v588 = v_u_9
	v_u_9 = v_u_9 + 8
	v571.ServerTick = buffer.readf64(v587, v588)
	local v589 = v_u_8
	local v590 = v_u_9
	v_u_9 = v_u_9 + 1
	v571.GroupIndex = buffer.readu8(v589, v590)
	if v_u_29[0][1] then
		for _, v591 in v_u_29[0] do
			task.spawn(v591, v571)
		end
	else
		local v592 = v_u_30[0]
		table.insert(v592, v571)
		if #v_u_30[0] > 64 then
			warn((("[ZAP] %* events in queue for PositionChangedEvent. Did you forget to attach a listener?"):format(#v_u_30[0])))
		end
	end
end)
v_u_22[2].OnClientEvent:Connect(function(p593, p594)
	-- upvalues: (ref) v_u_8, (ref) v_u_10, (ref) v_u_9, (ref) v_u_11, (copy) v_u_29, (copy) v_u_30
	v_u_8 = p593
	v_u_10 = p594
	v_u_9 = 0
	v_u_11 = 0
	local v595 = {}
	local v596 = v_u_8
	local v597 = v_u_9
	v_u_9 = v_u_9 + 4
	v595.Pitch = buffer.readf32(v596, v597)
	local v598 = v_u_8
	local v599 = v_u_9
	v_u_9 = v_u_9 + 4
	v595.Yaw = buffer.readf32(v598, v599)
	local v600 = v_u_8
	local v601 = v_u_9
	v_u_9 = v_u_9 + 8
	v595.ClientTick = buffer.readf64(v600, v601)
	v_u_11 = v_u_11 + 1
	v595.Player = v_u_10[v_u_11]
	local v602 = v595.Player ~= nil
	assert(v602)
	if v_u_29[1][1] then
		for _, v603 in v_u_29[1] do
			task.spawn(v603, v595)
		end
	else
		local v604 = v_u_30[1]
		table.insert(v604, v595)
		if #v_u_30[1] > 64 then
			warn((("[ZAP] %* events in queue for LookAngleEvent. Did you forget to attach a listener?"):format(#v_u_30[1])))
		end
	end
end)
table.freeze(v15)
local v917 = {
	["SendEvents"] = v26,
	["SelectionVote"] = {
		["Fire"] = function(p605) -- name: Fire
			-- upvalues: (copy) v_u_14, (ref) v_u_3, (ref) v_u_7
			v_u_14(1)
			local v606 = v_u_3
			local v607 = v_u_7
			buffer.writeu8(v606, v607, 0)
			local v608 = #p605.Type
			v_u_14(2)
			local v609 = v_u_3
			local v610 = v_u_7
			buffer.writeu16(v609, v610, v608)
			v_u_14(v608)
			buffer.writestring(v_u_3, v_u_7, p605.Type, v608)
			local v611 = #p605.Value
			v_u_14(2)
			local v612 = v_u_3
			local v613 = v_u_7
			buffer.writeu16(v612, v613, v611)
			v_u_14(v611)
			buffer.writestring(v_u_3, v_u_7, p605.Value, v611)
		end
	},
	["RefreshServers"] = {
		["Fire"] = function(p614) -- name: Fire
			-- upvalues: (copy) v_u_14, (ref) v_u_3, (ref) v_u_7
			v_u_14(1)
			local v615 = v_u_3
			local v616 = v_u_7
			buffer.writeu8(v615, v616, 1)
			local v617 = #p614.ServerType
			v_u_14(2)
			local v618 = v_u_3
			local v619 = v_u_7
			buffer.writeu16(v618, v619, v617)
			v_u_14(v617)
			buffer.writestring(v_u_3, v_u_7, p614.ServerType, v617)
		end
	},
	["JoinServer"] = {
		["Fire"] = function(p620) -- name: Fire
			-- upvalues: (copy) v_u_14, (ref) v_u_3, (ref) v_u_7
			v_u_14(1)
			local v621 = v_u_3
			local v622 = v_u_7
			buffer.writeu8(v621, v622, 2)
			local v623 = #p620.ServerType
			v_u_14(2)
			local v624 = v_u_3
			local v625 = v_u_7
			buffer.writeu16(v624, v625, v623)
			v_u_14(v623)
			buffer.writestring(v_u_3, v_u_7, p620.ServerType, v623)
			local v626 = #p620.ServerID
			v_u_14(2)
			local v627 = v_u_3
			local v628 = v_u_7
			buffer.writeu16(v627, v628, v626)
			v_u_14(v626)
			buffer.writestring(v_u_3, v_u_7, p620.ServerID, v626)
		end
	},
	["TellServerLoaded"] = {
		["Fire"] = function(p629) -- name: Fire
			-- upvalues: (copy) v_u_14, (ref) v_u_3, (ref) v_u_7, (ref) v_u_6
			v_u_14(1)
			local v630 = v_u_3
			local v631 = v_u_7
			buffer.writeu8(v630, v631, 3)
			if p629 == nil then
				v_u_14(1)
				local v632 = v_u_3
				local v633 = v_u_7
				buffer.writeu8(v632, v633, 0)
			else
				v_u_14(1)
				local v634 = v_u_3
				local v635 = v_u_7
				buffer.writeu8(v634, v635, 1)
				local v636 = v_u_6
				table.insert(v636, p629)
			end
		end
	},
	["StartPrivateServer"] = {
		["Fire"] = function(_) -- name: Fire
			-- upvalues: (copy) v_u_14, (ref) v_u_3, (ref) v_u_7
			v_u_14(1)
			local v637 = v_u_3
			local v638 = v_u_7
			buffer.writeu8(v637, v638, 4)
		end
	},
	["JoinPrivateServer"] = {
		["Fire"] = function(p639) -- name: Fire
			-- upvalues: (copy) v_u_14, (ref) v_u_3, (ref) v_u_7
			v_u_14(1)
			local v640 = v_u_3
			local v641 = v_u_7
			buffer.writeu8(v640, v641, 5)
			local v642 = #p639.PrivateServerId
			v_u_14(2)
			local v643 = v_u_3
			local v644 = v_u_7
			buffer.writeu16(v643, v644, v642)
			v_u_14(v642)
			buffer.writestring(v_u_3, v_u_7, p639.PrivateServerId, v642)
		end
	},
	["UpdateLookAngle"] = {
		["Fire"] = function(p645) -- name: Fire
			-- upvalues: (ref) v_u_3, (ref) v_u_4, (ref) v_u_5, (ref) v_u_6, (copy) v_u_14, (ref) v_u_7, (copy) v_u_22
			local v646 = {
				["buff"] = v_u_3,
				["used"] = v_u_4,
				["size"] = v_u_5,
				["inst"] = v_u_6
			}
			v_u_3 = buffer.create(64)
			v_u_4 = 0
			v_u_5 = 64
			v_u_6 = {}
			v_u_14(4)
			local v647 = v_u_3
			local v648 = v_u_7
			local v649 = p645.Pitch
			buffer.writef32(v647, v648, v649)
			v_u_14(4)
			local v650 = v_u_3
			local v651 = v_u_7
			local v652 = p645.Yaw
			buffer.writef32(v650, v651, v652)
			v_u_14(8)
			local v653 = v_u_3
			local v654 = v_u_7
			local v655 = p645.ClientTick
			buffer.writef64(v653, v654, v655)
			local v656 = buffer.create(v_u_4)
			buffer.copy(v656, 0, v_u_3, 0, v_u_4)
			v_u_22[1]:FireServer(v656, v_u_6)
			v_u_3 = v646.buff
			v_u_4 = v646.used
			v_u_5 = v646.size
			v_u_6 = v646.inst
		end
	},
	["TriggerSelfExplosionEvent"] = {
		["Fire"] = function(p657) -- name: Fire
			-- upvalues: (copy) v_u_14, (ref) v_u_3, (ref) v_u_7
			v_u_14(1)
			local v658 = v_u_3
			local v659 = v_u_7
			buffer.writeu8(v658, v659, 6)
			local v660 = #p657.ExplosionType
			v_u_14(2)
			local v661 = v_u_3
			local v662 = v_u_7
			buffer.writeu16(v661, v662, v660)
			v_u_14(v660)
			buffer.writestring(v_u_3, v_u_7, p657.ExplosionType, v660)
		end
	},
	["Reloading"] = {
		["Fire"] = function(p663) -- name: Fire
			-- upvalues: (copy) v_u_14, (ref) v_u_3, (ref) v_u_7
			v_u_14(1)
			local v664 = v_u_3
			local v665 = v_u_7
			buffer.writeu8(v664, v665, 7)
			v_u_14(2)
			local v666 = v_u_3
			local v667 = v_u_7
			local v668 = p663.Slot
			buffer.writeu16(v666, v667, v668)
		end
	},
	["RespecSkillTree"] = {
		["Fire"] = function(_) -- name: Fire
			-- upvalues: (copy) v_u_14, (ref) v_u_3, (ref) v_u_7
			v_u_14(1)
			local v669 = v_u_3
			local v670 = v_u_7
			buffer.writeu8(v669, v670, 8)
		end
	},
	["RequestPrestige"] = {
		["Fire"] = function(_) -- name: Fire
			-- upvalues: (copy) v_u_14, (ref) v_u_3, (ref) v_u_7
			v_u_14(1)
			local v671 = v_u_3
			local v672 = v_u_7
			buffer.writeu8(v671, v672, 9)
		end
	},
	["HitRegClaim"] = {
		["Fire"] = function(p673) -- name: Fire
			-- upvalues: (copy) v_u_14, (ref) v_u_3, (ref) v_u_7
			v_u_14(1)
			local v674 = v_u_3
			local v675 = v_u_7
			buffer.writeu8(v674, v675, 10)
			v_u_14(1)
			local v676 = v_u_3
			local v677 = v_u_7
			local v678 = p673.moduleId
			buffer.writeu8(v676, v677, v678)
			local v679 = #p673.hits
			v_u_14(2)
			local v680 = v_u_3
			local v681 = v_u_7
			buffer.writeu16(v680, v681, v679)
			for v682 = 1, v679 do
				local v683 = p673.hits[v682]
				local v684 = #v683.partName
				v_u_14(2)
				local v685 = v_u_3
				local v686 = v_u_7
				buffer.writeu16(v685, v686, v684)
				v_u_14(v684)
				buffer.writestring(v_u_3, v_u_7, v683.partName, v684)
				v_u_14(4)
				local v687 = v_u_3
				local v688 = v_u_7
				local v689 = v683.hitPos.x
				buffer.writef32(v687, v688, v689)
				v_u_14(4)
				local v690 = v_u_3
				local v691 = v_u_7
				local v692 = v683.hitPos.y
				buffer.writef32(v690, v691, v692)
				v_u_14(4)
				local v693 = v_u_3
				local v694 = v_u_7
				local v695 = v683.hitPos.z
				buffer.writef32(v693, v694, v695)
				v_u_14(4)
				local v696 = v_u_3
				local v697 = v_u_7
				local v698 = v683.origin.x
				buffer.writef32(v696, v697, v698)
				v_u_14(4)
				local v699 = v_u_3
				local v700 = v_u_7
				local v701 = v683.origin.y
				buffer.writef32(v699, v700, v701)
				v_u_14(4)
				local v702 = v_u_3
				local v703 = v_u_7
				local v704 = v683.origin.z
				buffer.writef32(v702, v703, v704)
				v_u_14(4)
				local v705 = v_u_3
				local v706 = v_u_7
				local v707 = v683.targetId
				buffer.writeu32(v705, v706, v707)
				v_u_14(2)
				local v708 = v_u_3
				local v709 = v_u_7
				local v710 = v683.bullet
				buffer.writeu16(v708, v709, v710)
				if v683.hitPosDiff == nil then
					v_u_14(1)
					local v711 = v_u_3
					local v712 = v_u_7
					buffer.writeu8(v711, v712, 0)
				else
					v_u_14(1)
					local v713 = v_u_3
					local v714 = v_u_7
					buffer.writeu8(v713, v714, 1)
					v_u_14(4)
					local v715 = v_u_3
					local v716 = v_u_7
					local v717 = v683.hitPosDiff.x
					buffer.writef32(v715, v716, v717)
					v_u_14(4)
					local v718 = v_u_3
					local v719 = v_u_7
					local v720 = v683.hitPosDiff.y
					buffer.writef32(v718, v719, v720)
					v_u_14(4)
					local v721 = v_u_3
					local v722 = v_u_7
					local v723 = v683.hitPosDiff.z
					buffer.writef32(v721, v722, v723)
				end
			end
		end
	},
	["RushNpcParried"] = {
		["Fire"] = function(p724) -- name: Fire
			-- upvalues: (copy) v_u_14, (ref) v_u_3, (ref) v_u_7
			v_u_14(1)
			local v725 = v_u_3
			local v726 = v_u_7
			buffer.writeu8(v725, v726, 11)
			v_u_14(4)
			local v727 = v_u_3
			local v728 = v_u_7
			local v729 = p724.entityId
			buffer.writeu32(v727, v728, v729)
		end
	},
	["RushContinueChoice"] = {
		["Fire"] = function(p730) -- name: Fire
			-- upvalues: (copy) v_u_14, (ref) v_u_3, (ref) v_u_7
			v_u_14(1)
			local v731 = v_u_3
			local v732 = v_u_7
			buffer.writeu8(v731, v732, 12)
			v_u_14(1)
			local v733 = v_u_3
			local v734 = v_u_7
			local v735 = p730.continueRun and 1 or 0
			buffer.writeu8(v733, v734, v735)
		end
	},
	["RushShopBuy"] = {
		["Fire"] = function(p736) -- name: Fire
			-- upvalues: (copy) v_u_14, (ref) v_u_3, (ref) v_u_7
			v_u_14(1)
			local v737 = v_u_3
			local v738 = v_u_7
			buffer.writeu8(v737, v738, 13)
			local v739 = #p736.weaponName
			v_u_14(2)
			local v740 = v_u_3
			local v741 = v_u_7
			buffer.writeu16(v740, v741, v739)
			v_u_14(v739)
			buffer.writestring(v_u_3, v_u_7, p736.weaponName, v739)
		end
	},
	["RushShopSell"] = {
		["Fire"] = function(p742) -- name: Fire
			-- upvalues: (copy) v_u_14, (ref) v_u_3, (ref) v_u_7
			v_u_14(1)
			local v743 = v_u_3
			local v744 = v_u_7
			buffer.writeu8(v743, v744, 14)
			local v745 = #p742.weaponId
			v_u_14(2)
			local v746 = v_u_3
			local v747 = v_u_7
			buffer.writeu16(v746, v747, v745)
			v_u_14(v745)
			buffer.writestring(v_u_3, v_u_7, p742.weaponId, v745)
		end
	},
	["RushShopAction"] = {
		["Fire"] = function(p748) -- name: Fire
			-- upvalues: (copy) v_u_14, (ref) v_u_3, (ref) v_u_7
			v_u_14(1)
			local v749 = v_u_3
			local v750 = v_u_7
			buffer.writeu8(v749, v750, 15)
			local v751 = #p748.action
			v_u_14(2)
			local v752 = v_u_3
			local v753 = v_u_7
			buffer.writeu16(v752, v753, v751)
			v_u_14(v751)
			buffer.writestring(v_u_3, v_u_7, p748.action, v751)
			local v754 = #p748.weaponId
			v_u_14(2)
			local v755 = v_u_3
			local v756 = v_u_7
			buffer.writeu16(v755, v756, v754)
			v_u_14(v754)
			buffer.writestring(v_u_3, v_u_7, p748.weaponId, v754)
			if p748.param == nil then
				v_u_14(1)
				local v757 = v_u_3
				local v758 = v_u_7
				buffer.writeu8(v757, v758, 0)
			else
				v_u_14(1)
				local v759 = v_u_3
				local v760 = v_u_7
				buffer.writeu8(v759, v760, 1)
				local v761 = #p748.param
				v_u_14(2)
				local v762 = v_u_3
				local v763 = v_u_7
				buffer.writeu16(v762, v763, v761)
				v_u_14(v761)
				buffer.writestring(v_u_3, v_u_7, p748.param, v761)
			end
			if p748.cost == nil then
				v_u_14(1)
				local v764 = v_u_3
				local v765 = v_u_7
				buffer.writeu8(v764, v765, 0)
			else
				v_u_14(1)
				local v766 = v_u_3
				local v767 = v_u_7
				buffer.writeu8(v766, v767, 1)
				v_u_14(4)
				local v768 = v_u_3
				local v769 = v_u_7
				local v770 = p748.cost
				buffer.writei32(v768, v769, v770)
			end
		end
	},
	["InitUser"] = {
		["On"] = function(p_u_771) -- name: On
			-- upvalues: (copy) v_u_27, (copy) v_u_28
			local v772 = v_u_27[0]
			table.insert(v772, p_u_771)
			for _, v773 in v_u_28[0] do
				task.spawn(p_u_771, v773)
			end
			v_u_28[0] = {}
			return function()
				-- upvalues: (ref) v_u_27, (copy) p_u_771
				table.remove(v_u_27[0], table.find(v_u_27[0], p_u_771))
			end
		end
	},
	["UpdateValue"] = {
		["On"] = function(p_u_774) -- name: On
			-- upvalues: (copy) v_u_27, (copy) v_u_28
			local v775 = v_u_27[1]
			table.insert(v775, p_u_774)
			for _, v776 in v_u_28[1] do
				task.spawn(p_u_774, v776)
			end
			v_u_28[1] = {}
			return function()
				-- upvalues: (ref) v_u_27, (copy) p_u_774
				table.remove(v_u_27[1], table.find(v_u_27[1], p_u_774))
			end
		end
	},
	["RemoveIndex"] = {
		["On"] = function(p_u_777) -- name: On
			-- upvalues: (copy) v_u_27, (copy) v_u_28
			local v778 = v_u_27[2]
			table.insert(v778, p_u_777)
			for _, v779 in v_u_28[2] do
				task.spawn(p_u_777, v779)
			end
			v_u_28[2] = {}
			return function()
				-- upvalues: (ref) v_u_27, (copy) p_u_777
				table.remove(v_u_27[2], table.find(v_u_27[2], p_u_777))
			end
		end
	},
	["InsertIndex"] = {
		["On"] = function(p_u_780) -- name: On
			-- upvalues: (copy) v_u_27, (copy) v_u_28
			local v781 = v_u_27[3]
			table.insert(v781, p_u_780)
			for _, v782 in v_u_28[3] do
				task.spawn(p_u_780, v782)
			end
			v_u_28[3] = {}
			return function()
				-- upvalues: (ref) v_u_27, (copy) p_u_780
				table.remove(v_u_27[3], table.find(v_u_27[3], p_u_780))
			end
		end
	},
	["InsertKey"] = {
		["On"] = function(p_u_783) -- name: On
			-- upvalues: (copy) v_u_27, (copy) v_u_28
			local v784 = v_u_27[4]
			table.insert(v784, p_u_783)
			for _, v785 in v_u_28[4] do
				task.spawn(p_u_783, v785)
			end
			v_u_28[4] = {}
			return function()
				-- upvalues: (ref) v_u_27, (copy) p_u_783
				table.remove(v_u_27[4], table.find(v_u_27[4], p_u_783))
			end
		end
	},
	["RemoveKey"] = {
		["On"] = function(p_u_786) -- name: On
			-- upvalues: (copy) v_u_27, (copy) v_u_28
			local v787 = v_u_27[5]
			table.insert(v787, p_u_786)
			for _, v788 in v_u_28[5] do
				task.spawn(p_u_786, v788)
			end
			v_u_28[5] = {}
			return function()
				-- upvalues: (ref) v_u_27, (copy) p_u_786
				table.remove(v_u_27[5], table.find(v_u_27[5], p_u_786))
			end
		end
	},
	["StartSelection"] = {
		["On"] = function(p_u_789) -- name: On
			-- upvalues: (copy) v_u_27, (copy) v_u_28
			local v790 = v_u_27[6]
			table.insert(v790, p_u_789)
			for _, v791 in v_u_28[6] do
				task.spawn(p_u_789, v791)
			end
			v_u_28[6] = {}
			return function()
				-- upvalues: (ref) v_u_27, (copy) p_u_789
				table.remove(v_u_27[6], table.find(v_u_27[6], p_u_789))
			end
		end
	},
	["UpdateSelectionTimer"] = {
		["On"] = function(p_u_792) -- name: On
			-- upvalues: (copy) v_u_27, (copy) v_u_28
			local v793 = v_u_27[7]
			table.insert(v793, p_u_792)
			for _, v794 in v_u_28[7] do
				task.spawn(p_u_792, v794)
			end
			v_u_28[7] = {}
			return function()
				-- upvalues: (ref) v_u_27, (copy) p_u_792
				table.remove(v_u_27[7], table.find(v_u_27[7], p_u_792))
			end
		end
	},
	["UpdatePlayerSelection"] = {
		["On"] = function(p_u_795) -- name: On
			-- upvalues: (copy) v_u_27, (copy) v_u_28
			local v796 = v_u_27[8]
			table.insert(v796, p_u_795)
			for _, v797 in v_u_28[8] do
				task.spawn(p_u_795, v797)
			end
			v_u_28[8] = {}
			return function()
				-- upvalues: (ref) v_u_27, (copy) p_u_795
				table.remove(v_u_27[8], table.find(v_u_27[8], p_u_795))
			end
		end
	},
	["EndSelection"] = {
		["On"] = function(p_u_798) -- name: On
			-- upvalues: (copy) v_u_27, (copy) v_u_28
			local v799 = v_u_27[9]
			table.insert(v799, p_u_798)
			for _, v800 in v_u_28[9] do
				task.spawn(p_u_798, v800)
			end
			v_u_28[9] = {}
			return function()
				-- upvalues: (ref) v_u_27, (copy) p_u_798
				table.remove(v_u_27[9], table.find(v_u_27[9], p_u_798))
			end
		end
	},
	["StatusMessage"] = {
		["On"] = function(p_u_801) -- name: On
			-- upvalues: (copy) v_u_27, (copy) v_u_28
			local v802 = v_u_27[10]
			table.insert(v802, p_u_801)
			for _, v803 in v_u_28[10] do
				task.spawn(p_u_801, v803)
			end
			v_u_28[10] = {}
			return function()
				-- upvalues: (ref) v_u_27, (copy) p_u_801
				table.remove(v_u_27[10], table.find(v_u_27[10], p_u_801))
			end
		end
	},
	["BannerMessage"] = {
		["On"] = function(p_u_804) -- name: On
			-- upvalues: (copy) v_u_27, (copy) v_u_28
			local v805 = v_u_27[11]
			table.insert(v805, p_u_804)
			for _, v806 in v_u_28[11] do
				task.spawn(p_u_804, v806)
			end
			v_u_28[11] = {}
			return function()
				-- upvalues: (ref) v_u_27, (copy) p_u_804
				table.remove(v_u_27[11], table.find(v_u_27[11], p_u_804))
			end
		end
	},
	["ServerList"] = {
		["On"] = function(p_u_807) -- name: On
			-- upvalues: (copy) v_u_27, (copy) v_u_28
			local v808 = v_u_27[12]
			table.insert(v808, p_u_807)
			for _, v809 in v_u_28[12] do
				task.spawn(p_u_807, v809)
			end
			v_u_28[12] = {}
			return function()
				-- upvalues: (ref) v_u_27, (copy) p_u_807
				table.remove(v_u_27[12], table.find(v_u_27[12], p_u_807))
			end
		end
	},
	["JoinServerResponse"] = {
		["On"] = function(p_u_810) -- name: On
			-- upvalues: (copy) v_u_27, (copy) v_u_28
			local v811 = v_u_27[13]
			table.insert(v811, p_u_810)
			for _, v812 in v_u_28[13] do
				task.spawn(p_u_810, v812)
			end
			v_u_28[13] = {}
			return function()
				-- upvalues: (ref) v_u_27, (copy) p_u_810
				table.remove(v_u_27[13], table.find(v_u_27[13], p_u_810))
			end
		end
	},
	["SetupPodium"] = {
		["On"] = function(p_u_813) -- name: On
			-- upvalues: (copy) v_u_27, (copy) v_u_28
			local v814 = v_u_27[14]
			table.insert(v814, p_u_813)
			for _, v815 in v_u_28[14] do
				task.spawn(p_u_813, v815)
			end
			v_u_28[14] = {}
			return function()
				-- upvalues: (ref) v_u_27, (copy) p_u_813
				table.remove(v_u_27[14], table.find(v_u_27[14], p_u_813))
			end
		end
	},
	["OpenGamemodeEndScoreboard"] = {
		["On"] = function(p_u_816) -- name: On
			-- upvalues: (copy) v_u_27, (copy) v_u_28
			local v817 = v_u_27[15]
			table.insert(v817, p_u_816)
			for _, v818 in v_u_28[15] do
				task.spawn(p_u_816, v818)
			end
			v_u_28[15] = {}
			return function()
				-- upvalues: (ref) v_u_27, (copy) p_u_816
				table.remove(v_u_27[15], table.find(v_u_27[15], p_u_816))
			end
		end
	},
	["CloseGamemodeEndScoreboard"] = {
		["On"] = function(p_u_819) -- name: On
			-- upvalues: (copy) v_u_27, (copy) v_u_28
			local v820 = v_u_27[16]
			table.insert(v820, p_u_819)
			for _, v821 in v_u_28[16] do
				task.spawn(p_u_819, v821)
			end
			v_u_28[16] = {}
			return function()
				-- upvalues: (ref) v_u_27, (copy) p_u_819
				table.remove(v_u_27[16], table.find(v_u_27[16], p_u_819))
			end
		end
	},
	["PreloadWeapons"] = {
		["On"] = function(p_u_822) -- name: On
			-- upvalues: (copy) v_u_27, (copy) v_u_28
			local v823 = v_u_27[17]
			table.insert(v823, p_u_822)
			for _, v824 in v_u_28[17] do
				task.spawn(p_u_822, v824)
			end
			v_u_28[17] = {}
			return function()
				-- upvalues: (ref) v_u_27, (copy) p_u_822
				table.remove(v_u_27[17], table.find(v_u_27[17], p_u_822))
			end
		end
	},
	["ClearPreloadedWeapons"] = {
		["On"] = function(p_u_825) -- name: On
			-- upvalues: (copy) v_u_27, (copy) v_u_28
			local v826 = v_u_27[18]
			table.insert(v826, p_u_825)
			for _, v827 in v_u_28[18] do
				task.spawn(p_u_825, v827)
			end
			v_u_28[18] = {}
			return function()
				-- upvalues: (ref) v_u_27, (copy) p_u_825
				table.remove(v_u_27[18], table.find(v_u_27[18], p_u_825))
			end
		end
	},
	["PrivateServerCreated"] = {
		["On"] = function(p_u_828) -- name: On
			-- upvalues: (copy) v_u_27, (copy) v_u_28
			local v829 = v_u_27[19]
			table.insert(v829, p_u_828)
			for _, v830 in v_u_28[19] do
				task.spawn(p_u_828, v830)
			end
			v_u_28[19] = {}
			return function()
				-- upvalues: (ref) v_u_27, (copy) p_u_828
				table.remove(v_u_27[19], table.find(v_u_27[19], p_u_828))
			end
		end
	},
	["PositionChangedEvent"] = {
		["On"] = function(p_u_831) -- name: On
			-- upvalues: (copy) v_u_29, (copy) v_u_30
			local v832 = v_u_29[0]
			table.insert(v832, p_u_831)
			for _, v833 in v_u_30[0] do
				task.spawn(p_u_831, v833)
			end
			v_u_30[0] = {}
			return function()
				-- upvalues: (ref) v_u_29, (copy) p_u_831
				table.remove(v_u_29[0], table.find(v_u_29[0], p_u_831))
			end
		end
	},
	["LookAngleEvent"] = {
		["On"] = function(p_u_834) -- name: On
			-- upvalues: (copy) v_u_29, (copy) v_u_30
			local v835 = v_u_29[1]
			table.insert(v835, p_u_834)
			for _, v836 in v_u_30[1] do
				task.spawn(p_u_834, v836)
			end
			v_u_30[1] = {}
			return function()
				-- upvalues: (ref) v_u_29, (copy) p_u_834
				table.remove(v_u_29[1], table.find(v_u_29[1], p_u_834))
			end
		end
	},
	["NPCRegistryEvent"] = {
		["On"] = function(p_u_837) -- name: On
			-- upvalues: (copy) v_u_27, (copy) v_u_28
			local v838 = v_u_27[20]
			table.insert(v838, p_u_837)
			for _, v839 in v_u_28[20] do
				task.spawn(p_u_837, v839)
			end
			v_u_28[20] = {}
			return function()
				-- upvalues: (ref) v_u_27, (copy) p_u_837
				table.remove(v_u_27[20], table.find(v_u_27[20], p_u_837))
			end
		end
	},
	["TogglePointsUIEvent"] = {
		["On"] = function(p_u_840) -- name: On
			-- upvalues: (copy) v_u_27, (copy) v_u_28
			local v841 = v_u_27[21]
			table.insert(v841, p_u_840)
			for _, v842 in v_u_28[21] do
				task.spawn(p_u_840, v842)
			end
			v_u_28[21] = {}
			return function()
				-- upvalues: (ref) v_u_27, (copy) p_u_840
				table.remove(v_u_27[21], table.find(v_u_27[21], p_u_840))
			end
		end
	},
	["ToggleSurvivalShopUIEvent"] = {
		["On"] = function(p_u_843) -- name: On
			-- upvalues: (copy) v_u_27, (copy) v_u_28
			local v844 = v_u_27[22]
			table.insert(v844, p_u_843)
			for _, v845 in v_u_28[22] do
				task.spawn(p_u_843, v845)
			end
			v_u_28[22] = {}
			return function()
				-- upvalues: (ref) v_u_27, (copy) p_u_843
				table.remove(v_u_27[22], table.find(v_u_27[22], p_u_843))
			end
		end
	},
	["InitSurvivalShopEvent"] = {
		["On"] = function(p_u_846) -- name: On
			-- upvalues: (copy) v_u_27, (copy) v_u_28
			local v847 = v_u_27[23]
			table.insert(v847, p_u_846)
			for _, v848 in v_u_28[23] do
				task.spawn(p_u_846, v848)
			end
			v_u_28[23] = {}
			return function()
				-- upvalues: (ref) v_u_27, (copy) p_u_846
				table.remove(v_u_27[23], table.find(v_u_27[23], p_u_846))
			end
		end
	},
	["RenderExplosionEvent"] = {
		["On"] = function(p_u_849) -- name: On
			-- upvalues: (copy) v_u_27, (copy) v_u_28
			local v850 = v_u_27[24]
			table.insert(v850, p_u_849)
			for _, v851 in v_u_28[24] do
				task.spawn(p_u_849, v851)
			end
			v_u_28[24] = {}
			return function()
				-- upvalues: (ref) v_u_27, (copy) p_u_849
				table.remove(v_u_27[24], table.find(v_u_27[24], p_u_849))
			end
		end
	},
	["SetGameStateKey"] = {
		["On"] = function(p_u_852) -- name: On
			-- upvalues: (copy) v_u_27, (copy) v_u_28
			local v853 = v_u_27[25]
			table.insert(v853, p_u_852)
			for _, v854 in v_u_28[25] do
				task.spawn(p_u_852, v854)
			end
			v_u_28[25] = {}
			return function()
				-- upvalues: (ref) v_u_27, (copy) p_u_852
				table.remove(v_u_27[25], table.find(v_u_27[25], p_u_852))
			end
		end
	},
	["SetGameStateVariable"] = {
		["On"] = function(p_u_855) -- name: On
			-- upvalues: (copy) v_u_27, (copy) v_u_28
			local v856 = v_u_27[26]
			table.insert(v856, p_u_855)
			for _, v857 in v_u_28[26] do
				task.spawn(p_u_855, v857)
			end
			v_u_28[26] = {}
			return function()
				-- upvalues: (ref) v_u_27, (copy) p_u_855
				table.remove(v_u_27[26], table.find(v_u_27[26], p_u_855))
			end
		end
	},
	["InitGameState"] = {
		["On"] = function(p_u_858) -- name: On
			-- upvalues: (copy) v_u_27, (copy) v_u_28
			local v859 = v_u_27[27]
			table.insert(v859, p_u_858)
			for _, v860 in v_u_28[27] do
				task.spawn(p_u_858, v860)
			end
			v_u_28[27] = {}
			return function()
				-- upvalues: (ref) v_u_27, (copy) p_u_858
				table.remove(v_u_27[27], table.find(v_u_27[27], p_u_858))
			end
		end
	},
	["InitQuests"] = {
		["On"] = function(p_u_861) -- name: On
			-- upvalues: (copy) v_u_27, (copy) v_u_28
			local v862 = v_u_27[28]
			table.insert(v862, p_u_861)
			for _, v863 in v_u_28[28] do
				task.spawn(p_u_861, v863)
			end
			v_u_28[28] = {}
			return function()
				-- upvalues: (ref) v_u_27, (copy) p_u_861
				table.remove(v_u_27[28], table.find(v_u_27[28], p_u_861))
			end
		end
	},
	["UpdateQuestCategory"] = {
		["On"] = function(p_u_864) -- name: On
			-- upvalues: (copy) v_u_27, (copy) v_u_28
			local v865 = v_u_27[29]
			table.insert(v865, p_u_864)
			for _, v866 in v_u_28[29] do
				task.spawn(p_u_864, v866)
			end
			v_u_28[29] = {}
			return function()
				-- upvalues: (ref) v_u_27, (copy) p_u_864
				table.remove(v_u_27[29], table.find(v_u_27[29], p_u_864))
			end
		end
	},
	["UpdateQuestProgress"] = {
		["On"] = function(p_u_867) -- name: On
			-- upvalues: (copy) v_u_27, (copy) v_u_28
			local v868 = v_u_27[30]
			table.insert(v868, p_u_867)
			for _, v869 in v_u_28[30] do
				task.spawn(p_u_867, v869)
			end
			v_u_28[30] = {}
			return function()
				-- upvalues: (ref) v_u_27, (copy) p_u_867
				table.remove(v_u_27[30], table.find(v_u_27[30], p_u_867))
			end
		end
	},
	["ChristmasGiftCollected"] = {
		["On"] = function(p_u_870) -- name: On
			-- upvalues: (copy) v_u_27, (copy) v_u_28
			local v871 = v_u_27[31]
			table.insert(v871, p_u_870)
			for _, v872 in v_u_28[31] do
				task.spawn(p_u_870, v872)
			end
			v_u_28[31] = {}
			return function()
				-- upvalues: (ref) v_u_27, (copy) p_u_870
				table.remove(v_u_27[31], table.find(v_u_27[31], p_u_870))
			end
		end
	},
	["FocusDeactivated"] = {
		["On"] = function(p_u_873) -- name: On
			-- upvalues: (copy) v_u_27, (copy) v_u_28
			local v874 = v_u_27[32]
			table.insert(v874, p_u_873)
			for _, v875 in v_u_28[32] do
				task.spawn(p_u_873, v875)
			end
			v_u_28[32] = {}
			return function()
				-- upvalues: (ref) v_u_27, (copy) p_u_873
				table.remove(v_u_27[32], table.find(v_u_27[32], p_u_873))
			end
		end
	},
	["InitSkillTree"] = {
		["On"] = function(p_u_876) -- name: On
			-- upvalues: (copy) v_u_27, (copy) v_u_28
			local v877 = v_u_27[33]
			table.insert(v877, p_u_876)
			for _, v878 in v_u_28[33] do
				task.spawn(p_u_876, v878)
			end
			v_u_28[33] = {}
			return function()
				-- upvalues: (ref) v_u_27, (copy) p_u_876
				table.remove(v_u_27[33], table.find(v_u_27[33], p_u_876))
			end
		end
	},
	["UpdateSkillRank"] = {
		["On"] = function(p_u_879) -- name: On
			-- upvalues: (copy) v_u_27, (copy) v_u_28
			local v880 = v_u_27[34]
			table.insert(v880, p_u_879)
			for _, v881 in v_u_28[34] do
				task.spawn(p_u_879, v881)
			end
			v_u_28[34] = {}
			return function()
				-- upvalues: (ref) v_u_27, (copy) p_u_879
				table.remove(v_u_27[34], table.find(v_u_27[34], p_u_879))
			end
		end
	},
	["SyncSkillTreeEconomy"] = {
		["On"] = function(p_u_882) -- name: On
			-- upvalues: (copy) v_u_27, (copy) v_u_28
			local v883 = v_u_27[35]
			table.insert(v883, p_u_882)
			for _, v884 in v_u_28[35] do
				task.spawn(p_u_882, v884)
			end
			v_u_28[35] = {}
			return function()
				-- upvalues: (ref) v_u_27, (copy) p_u_882
				table.remove(v_u_27[35], table.find(v_u_27[35], p_u_882))
			end
		end
	},
	["RushNpcAttacking"] = {
		["On"] = function(p_u_885) -- name: On
			-- upvalues: (copy) v_u_27, (copy) v_u_28
			local v886 = v_u_27[36]
			table.insert(v886, p_u_885)
			for _, v887 in v_u_28[36] do
				task.spawn(p_u_885, v887)
			end
			v_u_28[36] = {}
			return function()
				-- upvalues: (ref) v_u_27, (copy) p_u_885
				table.remove(v_u_27[36], table.find(v_u_27[36], p_u_885))
			end
		end
	},
	["RushPhaseChanged"] = {
		["On"] = function(p_u_888) -- name: On
			-- upvalues: (copy) v_u_27, (copy) v_u_28
			local v889 = v_u_27[37]
			table.insert(v889, p_u_888)
			for _, v890 in v_u_28[37] do
				task.spawn(p_u_888, v890)
			end
			v_u_28[37] = {}
			return function()
				-- upvalues: (ref) v_u_27, (copy) p_u_888
				table.remove(v_u_27[37], table.find(v_u_27[37], p_u_888))
			end
		end
	},
	["RushPtsUpdate"] = {
		["On"] = function(p_u_891) -- name: On
			-- upvalues: (copy) v_u_27, (copy) v_u_28
			local v892 = v_u_27[38]
			table.insert(v892, p_u_891)
			for _, v893 in v_u_28[38] do
				task.spawn(p_u_891, v893)
			end
			v_u_28[38] = {}
			return function()
				-- upvalues: (ref) v_u_27, (copy) p_u_891
				table.remove(v_u_27[38], table.find(v_u_27[38], p_u_891))
			end
		end
	},
	["RushVoteState"] = {
		["On"] = function(p_u_894) -- name: On
			-- upvalues: (copy) v_u_27, (copy) v_u_28
			local v895 = v_u_27[39]
			table.insert(v895, p_u_894)
			for _, v896 in v_u_28[39] do
				task.spawn(p_u_894, v896)
			end
			v_u_28[39] = {}
			return function()
				-- upvalues: (ref) v_u_27, (copy) p_u_894
				table.remove(v_u_27[39], table.find(v_u_27[39], p_u_894))
			end
		end
	},
	["RushMissionResult"] = {
		["On"] = function(p_u_897) -- name: On
			-- upvalues: (copy) v_u_27, (copy) v_u_28
			local v898 = v_u_27[40]
			table.insert(v898, p_u_897)
			for _, v899 in v_u_28[40] do
				task.spawn(p_u_897, v899)
			end
			v_u_28[40] = {}
			return function()
				-- upvalues: (ref) v_u_27, (copy) p_u_897
				table.remove(v_u_27[40], table.find(v_u_27[40], p_u_897))
			end
		end
	},
	["RushBossResult"] = {
		["On"] = function(p_u_900) -- name: On
			-- upvalues: (copy) v_u_27, (copy) v_u_28
			local v901 = v_u_27[41]
			table.insert(v901, p_u_900)
			for _, v902 in v_u_28[41] do
				task.spawn(p_u_900, v902)
			end
			v_u_28[41] = {}
			return function()
				-- upvalues: (ref) v_u_27, (copy) p_u_900
				table.remove(v_u_27[41], table.find(v_u_27[41], p_u_900))
			end
		end
	},
	["HintSystemMessage"] = {
		["On"] = function(p_u_903) -- name: On
			-- upvalues: (copy) v_u_27, (copy) v_u_28
			local v904 = v_u_27[42]
			table.insert(v904, p_u_903)
			for _, v905 in v_u_28[42] do
				task.spawn(p_u_903, v905)
			end
			v_u_28[42] = {}
			return function()
				-- upvalues: (ref) v_u_27, (copy) p_u_903
				table.remove(v_u_27[42], table.find(v_u_27[42], p_u_903))
			end
		end
	},
	["RushShopStock"] = {
		["On"] = function(p_u_906) -- name: On
			-- upvalues: (copy) v_u_27, (copy) v_u_28
			local v907 = v_u_27[43]
			table.insert(v907, p_u_906)
			for _, v908 in v_u_28[43] do
				task.spawn(p_u_906, v908)
			end
			v_u_28[43] = {}
			return function()
				-- upvalues: (ref) v_u_27, (copy) p_u_906
				table.remove(v_u_27[43], table.find(v_u_27[43], p_u_906))
			end
		end
	},
	["RushShopSync"] = {
		["On"] = function(p_u_909) -- name: On
			-- upvalues: (copy) v_u_27, (copy) v_u_28
			local v910 = v_u_27[44]
			table.insert(v910, p_u_909)
			for _, v911 in v_u_28[44] do
				task.spawn(p_u_909, v911)
			end
			v_u_28[44] = {}
			return function()
				-- upvalues: (ref) v_u_27, (copy) p_u_909
				table.remove(v_u_27[44], table.find(v_u_27[44], p_u_909))
			end
		end
	},
	["ActivateFocus"] = {
		["Call"] = function() -- name: Call
			-- upvalues: (copy) v_u_14, (ref) v_u_3, (ref) v_u_7, (ref) v_u_31, (copy) v_u_28
			v_u_14(1)
			local v912 = v_u_3
			local v913 = v_u_7
			buffer.writeu8(v912, v913, 16)
			v_u_31 = v_u_31 + 1
			v_u_31 = v_u_31 % 256
			if v_u_28[45][v_u_31] then
				v_u_31 = v_u_31 - 1
				error("Zap has more than 256 calls awaiting a response, and therefore this packet has been dropped")
			end
			v_u_14(1)
			local v914 = v_u_3
			local v915 = v_u_7
			local v916 = v_u_31
			buffer.writeu8(v914, v915, v916)
			v_u_28[45][v_u_31] = coroutine.running()
			return coroutine.yield()
		end
	}
}
return v917