local v_u_1 = game:GetService("RunService"):IsServer()
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game.ReplicatedStorage.common:WaitForChild("NPCs_Shared"):WaitForChild("AIClasses")
local v4 = game.ReplicatedStorage.common
local v5 = game.ReplicatedStorage.common.RedEvents
local v_u_6 = {}
local function v_u_13(p7) -- name: findClientClass
	-- upvalues: (copy) v_u_6, (copy) v_u_3, (copy) v_u_2
	if v_u_6[p7] then
		return v_u_6[p7]
	end
	local v8 = v_u_3:FindFirstChild(p7)
	if not v8 then
		for _, v9 in { "place", "arc", "chapter" } do
			local v10 = v_u_2:FindFirstChild(v9)
			if v10 then
				local v11 = v10:FindFirstChild("NPCs_Shared")
				if v11 then
					local v12 = v11:FindFirstChild("AIClasses")
					if v12 then
						v8 = v12:FindFirstChild(p7)
						if v8 then
							break
						end
					end
				end
			end
		end
	end
	if v8 then
		v_u_6[p7] = v8
	end
	return v8
end
local v_u_14 = require(v4.NPCRegistry)
local v_u_15 = require("@self/CompatibilityPatcher")
local v_u_16 = require(v_u_2.common.ZS_Shared.Data.GameState)
local v_u_17 = require(v5.NPC.CreateMirrorClassEvent)
local v18 = require(v5.NPC.RequestExistingNPCs)
local v_u_19 = require(v5.NPC.NPCReflectionEvent)
local v_u_20 = {}
local v_u_21 = {}
local v_u_22 = {}
local v_u_23 = {}
local v_u_24 = {}
local v_u_25 = {}
local v_u_26 = {}
if not v_u_1 then
	local v_u_27 = false
	local v_u_28 = 0
	game:GetService("RunService").Heartbeat:Connect(function(p29)
		-- upvalues: (copy) v_u_16, (copy) v_u_14, (ref) v_u_27, (ref) v_u_28
		debug.profilebegin("Client NPC")
		local v30 = v_u_16.LocalState.NPCRotation
		local v31 = v_u_14:GetAllNPCs()
		v_u_27 = not v_u_27
		local v32 = {}
		local v33 = {}
		for _, v34 in v31 do
			if v34.MoveTo and not v34.Ragdolling then
				local v35 = nil
				if v34.AlignDirection then
					v35 = v34.AlignDirection.Rotation
				elseif v34.RotateTowards then
					local v36 = v34.RotateTowards.Position.X
					local v37 = v34.HRP.Position.Y
					local v38 = v34.RotateTowards.Position.Z
					local v39 = Vector3.new(v36, v37, v38)
					local v40 = CFrame.new(v34.HRP.Position, v39)
					v35 = v40 - v40.Position
				end
				if v35 then
					if v34.Rotation then
						v34.Rotation = v34.Rotation:Lerp(v35, p29 * 5)
					else
						v34.Rotation = v35
					end
				end
				local v41 = v34.HRP
				table.insert(v32, v41)
				local v42 = v34.HRP.CFrame
				local v43 = CFrame.new(v34.MoveTo) * v30 * (v34.Rotation or CFrame.new())
				local v44 = p29 * (v34.WalkSpeed / 2)
				local v45 = math.clamp(v44, 0, 1)
				table.insert(v33, v42:Lerp(v43, v45))
			end
		end
		if #v32 > 0 then
			workspace:BulkMoveTo(v32, v33, Enum.BulkMoveMode.FireCFrameChanged)
		end
		local v46 = p29 + v_u_28
		for _, v47 in v31 do
			if v47.FastThink then
				v47:FastThink(p29)
				local v48 = ((not v_u_27 or v47.UID % 2 ~= 1) and true or false) and not v_u_27
				if v48 then
					v48 = v47.UID % 2 == 0
				end
				if v48 then
					v47:ClientThink(v46)
				end
			end
		end
		v_u_28 = p29
		debug.profileend()
	end)
end
local function v_u_55(p49, p50, p51) -- name: handleReflection
	-- upvalues: (copy) v_u_22, (copy) v_u_20
	local v52 = p49 ~= nil
	assert(v52, "Must pass NPC object")
	local v53 = p49.UID
	if p49[p50] then
		local v54 = p49[p50]
		if typeof(v54) == "function" then
			if p51[1] == "_useself" then
				p51[1] = p49
			end
			if not p49._Destroyed then
				p49[p50](unpack(p51))
			end
		end
	end
	if p50 == "Destroy" or p49._Destroyed then
		v_u_22[p49.Model] = nil
		v_u_20[v53] = nil
	end
end
local function v_u_62(p56, p57, p58) -- name: addToReflectionQueue
	-- upvalues: (copy) v_u_23, (copy) v_u_24, (copy) v_u_14, (copy) v_u_55
	if not v_u_23[p56] then
		v_u_23[p56] = {}
	end
	local v59 = v_u_23[p56]
	table.insert(v59, { p57, p58 })
	if not v_u_24[p56] then
		v_u_24[p56] = true
		repeat
			local v60 = v_u_14.NPCAdded:Wait()
		until v60.UID == p56
		while #v_u_23[p56] > 0 do
			local v61 = table.remove(v_u_23[p56], 1)
			v_u_55(v60, v61[1], v61[2])
		end
	end
end
if v_u_1 then
	game:GetService("ServerScriptService")
	local v_u_63 = require("@game/ServerScriptService/common/zap")
	local v_u_64 = {}
	game:GetService("Players").PlayerRemoving:Connect(function(p65)
		-- upvalues: (copy) v_u_64
		v_u_64[p65] = nil
	end)
	v18:SetServerListener(function(p66)
		-- upvalues: (copy) v_u_64, (copy) v_u_20, (copy) v_u_17
		if not v_u_64[p66] then
			v_u_64[p66] = true
			local v67 = 1
			while v67 <= #v_u_20 do
				local v68 = v_u_20[v67]
				if v68._Destroyed then
					table.remove(v_u_20, v67)
				else
					v_u_17:FireClient(p66, {
						v68._ClassName,
						v68.UID,
						v68.NoReplicatedModel or v68.Model,
						v68.InitData
					})
					v67 = v67 + 1
				end
			end
		end
	end)
	task.defer(function()
		-- upvalues: (copy) v_u_14, (copy) v_u_63
		local v69 = 0
		local v70 = 0
		while task.wait(0.025) do
			v69 = v69 + 1
			v70 = (v70 + 1) % 4
			local v71 = {}
			for _, v72 in v_u_14:GetAllNPCs() do
				if v72.UID % 4 == v70 and (v72.HRP and not v72.IsCompat) then
					v71[v72.UID] = v72.HRP.Position
				end
			end
			v_u_63.PositionChangedEvent.FireAll({
				["NPCs"] = v71,
				["ServerTick"] = v69,
				["GroupIndex"] = v70
			})
		end
	end)
else
	local v73 = require("@game/ReplicatedStorage/common/zap")
	v_u_17:SetClientListener(function(p74)
		-- upvalues: (copy) v_u_20, (copy) v_u_13, (copy) v_u_14, (copy) v_u_26
		local v75, v76, v77, v78 = unpack(p74)
		if not v_u_20[v76] then
			debug.profilebegin("createMirroredClass")
			local v79 = v_u_13(v75 .. "_Client")
			if v79 and (v76 and v77) then
				local v80 = require(v79).new(v78)
				v80.UID = v76
				v_u_14:AddNPC(v80)
				v80:Init(v77)
				if not v_u_26._Loaded then
					repeat
						task.wait()
					until v_u_26._Loaded
				end
				v_u_26.PrepareMirror(v80, v76)
			end
			debug.profileend()
		end
	end)
	local v_u_81 = {
		[0] = 0,
		[1] = 0,
		[2] = 0,
		[3] = 0,
		[4] = 0,
		[5] = 0,
		[6] = 0,
		[7] = 0,
		[8] = 0,
		[9] = 0,
		[10] = 0,
		[11] = 0,
		[12] = 0,
		[13] = 0,
		[14] = 0,
		[15] = 0,
		[16] = 0,
		[17] = 0,
		[18] = 0,
		[19] = 0,
		[20] = 0
	}
	v73.PositionChangedEvent.On(function(p82)
		-- upvalues: (copy) v_u_81, (copy) v_u_14
		if p82.ServerTick >= v_u_81[p82.GroupIndex] then
			v_u_81[p82.ServerTick] = p82.GroupIndex
			for v83, v84 in p82.NPCs do
				local v85 = v_u_14:GetNPC(v83)
				if v85 and not v85.IsCompat then
					v85:ServerUpdate(v84)
				end
			end
		end
	end)
	v_u_19:SetClientListener(function(p86)
		-- upvalues: (copy) v_u_14, (copy) v_u_25, (copy) v_u_55, (copy) v_u_62
		local v87, v88, v89 = unpack(p86)
		local v90 = v_u_14:GetNPC(v87) or v_u_25[v87]
		if v90 then
			v_u_55(v90, v88, v89)
		else
			v_u_62(v87, v88, v89)
		end
	end)
	v18:FireServer()
	v_u_14.NPCRemoved:Connect(function(p_u_91)
		-- upvalues: (copy) v_u_25
		v_u_25[p_u_91.UID] = p_u_91
		task.delay(60, function()
			-- upvalues: (ref) v_u_25, (copy) p_u_91
			v_u_25[p_u_91.UID] = nil
		end)
	end)
end
function v_u_26.GetObjs(_) -- name: GetObjs
	-- upvalues: (copy) v_u_21
	local v92 = {}
	for _, v93 in v_u_21 do
		if not v93._Destroyed then
			table.insert(v92, v93)
		end
	end
	return v92
end
function v_u_26.CompatiblityPatchModel(_, p_u_94, p95, p96) -- name: CompatiblityPatchModel
	-- upvalues: (copy) v_u_15, (copy) v_u_22
	local v_u_97 = v_u_15:Create(p_u_94, p95, p96)
	v_u_97.Died:Connect(function()
		-- upvalues: (copy) v_u_97, (ref) v_u_22, (copy) p_u_94
		task.delay(10, function()
			-- upvalues: (ref) v_u_97, (ref) v_u_22, (ref) p_u_94
			v_u_97.Died:DisconnectAll()
			v_u_97.PlayerHurtNPC:DisconnectAll()
			v_u_22[p_u_94] = nil
		end)
	end)
	return v_u_97
end
v_u_15.AddedNPC:Connect(function(p98)
	-- upvalues: (copy) v_u_22, (copy) v_u_14
	v_u_22[p98.Model] = p98
	v_u_14:AddNPC(p98)
end)
function v_u_26.GetObjFromModel(_, p99) -- name: GetObjFromModel
	-- upvalues: (copy) v_u_22
	return v_u_22[p99]
end
function v_u_26.GetObjFromId(_, p100) -- name: GetObjFromId
	-- upvalues: (copy) v_u_14
	return v_u_14:GetNPC(p100)
end
function v_u_26.PrepareMirror(p_u_101, p102) -- name: PrepareMirror
	-- upvalues: (copy) v_u_1, (copy) v_u_21, (copy) v_u_19, (copy) v_u_22, (copy) v_u_20
	if v_u_1 then
		local v_u_103 = p_u_101.UID
		if p_u_101.Model then
			v_u_21[v_u_103] = p_u_101
			function p_u_101.Rollback(p104)
				-- upvalues: (ref) v_u_19, (ref) v_u_103, (copy) p_u_101
				v_u_19:FireClient(p104, {
					v_u_103,
					"Rollback",
					{ "_useself", p_u_101.HP }
				})
			end
			function p_u_101.ReconcileDamage(p105, p106, p107)
				-- upvalues: (ref) v_u_19, (ref) v_u_103
				v_u_19:FireClient(p105, {
					v_u_103,
					"ReconcileDamage",
					{ "_useself", p106, p107 }
				})
			end
		end
	else
		v_u_22[p_u_101.Model] = p_u_101
		v_u_20[p102] = p_u_101
	end
end
function v_u_26.CreateMirrorMetamethods(p_u_108) -- name: CreateMirrorMetamethods
	-- upvalues: (copy) v_u_1, (copy) v_u_14, (copy) v_u_26, (copy) v_u_17, (copy) v_u_20, (copy) v_u_13, (copy) v_u_19
	function p_u_108.__index(p_u_109, p_u_110)
		-- upvalues: (ref) v_u_1, (copy) p_u_108, (ref) v_u_14, (ref) v_u_26, (ref) v_u_17, (ref) v_u_20, (ref) v_u_13, (ref) v_u_19
		if p_u_110 == "Init" then
			if v_u_1 then
				return function(...)
					-- upvalues: (ref) p_u_108, (copy) p_u_109, (ref) v_u_14, (ref) v_u_26, (ref) v_u_17, (ref) v_u_20
					local v111 = { ... }
					if v111[10] and v111[10] == "__ParentClass" then
						return p_u_108.Init(...)
					end
					v111[10] = "__ParentClass"
					local v112 = p_u_108.Init(unpack(v111, 1, 10))
					if p_u_109._MirrorRegistered then
						return v112
					end
					p_u_109._MirrorRegistered = true
					v_u_14:AddNPC(p_u_109)
					v_u_26.PrepareMirror(p_u_109)
					v_u_17:FireAllClients({
						p_u_109._ClassName,
						p_u_109.UID,
						p_u_109.NoReplicatedModel or p_u_109.Model,
						p_u_109.InitData
					})
					local v113 = v_u_20
					local v114 = p_u_109
					table.insert(v113, v114)
					return v112
				end
			end
		elseif p_u_110 ~= "new" and rawget(p_u_109, "_Initialized") then
			local v115 = p_u_108[p_u_110]
			if typeof(v115) == "function" then
				return function(...)
					-- upvalues: (copy) p_u_109, (ref) v_u_13, (copy) p_u_110, (ref) v_u_1, (ref) v_u_19, (ref) p_u_108
					local v116 = { ... }
					if v116[1] and v116[1] == p_u_109 then
						v116[1] = "_useself"
					end
					local v117 = v_u_13(p_u_109._ClassName .. "_Client")
					if v117 and (require(v117)[p_u_110] and v_u_1) then
						v_u_19:FireAllClients({ p_u_109.UID, p_u_110, v116 })
					end
					return p_u_108[p_u_110](...)
				end
			end
		end
		return p_u_108[p_u_110]
	end
end
v_u_26._Loaded = true
return v_u_26