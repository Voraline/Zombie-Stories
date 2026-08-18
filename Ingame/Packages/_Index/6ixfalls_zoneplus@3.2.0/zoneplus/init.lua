local v1 = game:GetService("Players")
local v_u_2 = game:GetService("RunService")
local v_u_3 = v_u_2.Heartbeat
local v_u_4 = v_u_2:IsClient()
if v_u_4 then
	v_u_4 = v1.LocalPlayer
end
game:GetService("ReplicatedStorage")
local v_u_5 = game:GetService("HttpService")
local v_u_6 = require(script.Enum).enums
local v_u_7 = require(script.Janitor)
local v_u_8 = require(script.Signal)
local v9 = require(script.ZonePlusReference)
local v10 = v9.getObject()
local v11 = script.ZoneController
local v_u_12 = v11.Tracker
local v_u_13 = v11.CollectiveWorldModel
local v_u_14 = require(v11)
local v15 = game:GetService("RunService"):IsClient() and "Client" or "Server"
local v16
if v10 then
	v16 = v10:FindFirstChild(v15)
else
	v16 = v10
end
if v16 then
	return require(v10.Value)
end
local v_u_17 = {}
v_u_17.__index = v_u_17
if not v16 then
	v9.addToReplicatedStorage()
end
v_u_17.enum = v_u_6
function v_u_17.new(p18) -- name: new
	-- upvalues: (copy) v_u_17, (copy) v_u_6, (copy) v_u_7, (copy) v_u_5, (copy) v_u_14, (copy) v_u_8, (copy) v_u_4
	local v_u_19 = {}
	local v20 = v_u_17
	setmetatable(v_u_19, v20)
	local v21 = typeof(p18)
	if v21 ~= "table" and v21 ~= "Instance" then
		error("The zone container must be a model, folder, basepart or table!")
	end
	v_u_19.accuracy = v_u_6.Accuracy.High
	v_u_19.autoUpdate = true
	v_u_19.respectUpdateQueue = true
	local v22 = v_u_7.new()
	v_u_19.janitor = v22
	v_u_19._updateConnections = v22:add(v_u_7.new(), "destroy")
	v_u_19.container = p18
	v_u_19.zoneParts = {}
	v_u_19.overlapParams = {}
	v_u_19.region = nil
	v_u_19.volume = nil
	v_u_19.boundMin = nil
	v_u_19.boundMax = nil
	v_u_19.recommendedMaxParts = nil
	v_u_19.zoneId = v_u_5:GenerateGUID()
	v_u_19.activeTriggers = {}
	v_u_19.occupants = {}
	v_u_19.trackingTouchedTriggers = {}
	v_u_19.enterDetection = v_u_6.Detection.Centre
	v_u_19.exitDetection = v_u_6.Detection.Centre
	v_u_19._currentEnterDetection = nil
	v_u_19._currentExitDetection = nil
	v_u_19.totalPartVolume = 0
	v_u_19.allZonePartsAreBlocks = true
	v_u_19.trackedItems = {}
	v_u_19.settingsGroupName = nil
	v_u_19.worldModel = workspace
	v_u_19.onItemDetails = {}
	v_u_19.itemsToUntrack = {}
	v_u_14.updateDetection(v_u_19)
	v_u_19.updated = v22:add(v_u_8.new(), "destroy")
	local v23 = {
		"player",
		"part",
		"localPlayer",
		"item"
	}
	local v24 = { "entered", "exited" }
	for _, v_u_25 in pairs(v23) do
		local v_u_26 = 0
		local v_u_27 = 0
		for _, v28 in pairs(v24) do
			local v29 = v22:add(v_u_8.new(true), "destroy")
			local v_u_30 = v28:sub(1, 1):upper() .. v28:sub(2)
			v_u_19[v_u_25 .. v_u_30] = v29
			v29.connectionsChanged:Connect(function(p31)
				-- upvalues: (copy) v_u_25, (ref) v_u_4, (copy) v_u_30, (ref) v_u_26, (ref) v_u_27, (ref) v_u_14, (copy) v_u_19
				if v_u_25 == "localPlayer" and (not v_u_4 and p31 == 1) then
					error(("Can only connect to \'localPlayer%s\' on the client!"):format(v_u_30))
				end
				v_u_26 = v_u_27
				v_u_27 = v_u_27 + p31
				if v_u_26 == 0 and v_u_27 > 0 then
					v_u_14._registerConnection(v_u_19, v_u_25, v_u_30)
				elseif v_u_26 > 0 and v_u_27 == 0 then
					v_u_14._deregisterConnection(v_u_19, v_u_25)
				end
			end)
		end
	end
	v_u_17.touchedConnectionActions = {}
	for _, v32 in pairs(v23) do
		local v_u_33 = v_u_19[("_%sTouchedZone"):format(v32)]
		if v_u_33 then
			v_u_19.trackingTouchedTriggers[v32] = {}
			v_u_17.touchedConnectionActions[v32] = function(p34)
				-- upvalues: (copy) v_u_33, (copy) v_u_19
				v_u_33(v_u_19, p34)
			end
		end
	end
	v_u_19:_update()
	v_u_14._registerZone(v_u_19)
	v22:add(function()
		-- upvalues: (ref) v_u_14, (copy) v_u_19
		v_u_14._deregisterZone(v_u_19)
	end, true)
	return v_u_19
end
function v_u_17.fromRegion(p35, p36) -- name: fromRegion
	-- upvalues: (copy) v_u_17
	local v_u_37 = Instance.new("Model")
	local function v_u_43(p38, p39) -- name: createCube
		-- upvalues: (copy) v_u_43, (copy) v_u_37
		if p39.X > 2024 or (p39.Y > 2024 or p39.Z > 2024) then
			local v40 = p39 * 0.25
			local v41 = p39 * 0.5
			v_u_43(p38 * CFrame.new(-v40.X, -v40.Y, -v40.Z), v41)
			v_u_43(p38 * CFrame.new(-v40.X, -v40.Y, v40.Z), v41)
			v_u_43(p38 * CFrame.new(-v40.X, v40.Y, -v40.Z), v41)
			v_u_43(p38 * CFrame.new(-v40.X, v40.Y, v40.Z), v41)
			v_u_43(p38 * CFrame.new(v40.X, -v40.Y, -v40.Z), v41)
			v_u_43(p38 * CFrame.new(v40.X, -v40.Y, v40.Z), v41)
			v_u_43(p38 * CFrame.new(v40.X, v40.Y, -v40.Z), v41)
			v_u_43(p38 * CFrame.new(v40.X, v40.Y, v40.Z), v41)
		else
			local v42 = Instance.new("Part")
			v42.CFrame = p38
			v42.Size = p39
			v42.Anchored = true
			v42.Parent = v_u_37
		end
	end
	v_u_43(p35, p36)
	local v44 = v_u_17.new(v_u_37)
	v44:relocate()
	return v44
end
function v_u_17._calculateRegion(_, p45, p46) -- name: _calculateRegion
	local v47 = {
		["Min"] = {},
		["Max"] = {}
	}
	for v_u_48, v49 in pairs(v47) do
		v49.Values = {}
		function v49.parseCheck(p50, p51) -- name: parseCheck
			-- upvalues: (copy) v_u_48
			if v_u_48 == "Min" then
				return p50 <= p51
			end
			if v_u_48 == "Max" then
				return p51 <= p50
			end
		end
		function v49.parse(p52, p53) -- name: parse
			for v54, v55 in pairs(p53) do
				local v56 = p52.Values[v54] or v55
				if p52.parseCheck(v55, v56) then
					p52.Values[v54] = v55
				end
			end
		end
	end
	for _, v57 in pairs(p45) do
		local v58 = v57.Size * 0.5
		local v59 = {
			v57.CFrame * CFrame.new(-v58.X, -v58.Y, -v58.Z),
			v57.CFrame * CFrame.new(-v58.X, -v58.Y, v58.Z),
			v57.CFrame * CFrame.new(-v58.X, v58.Y, -v58.Z),
			v57.CFrame * CFrame.new(-v58.X, v58.Y, v58.Z),
			v57.CFrame * CFrame.new(v58.X, -v58.Y, -v58.Z),
			v57.CFrame * CFrame.new(v58.X, -v58.Y, v58.Z),
			v57.CFrame * CFrame.new(v58.X, v58.Y, -v58.Z),
			v57.CFrame * CFrame.new(v58.X, v58.Y, v58.Z)
		}
		for _, v60 in pairs(v59) do
			local v61, v62, v63 = v60:GetComponents()
			local v64 = { v61, v62, v63 }
			v47.Min:parse(v64)
			v47.Max:parse(v64)
		end
	end
	local v65 = {}
	local v66 = {}
	for v67, v68 in pairs(v47) do
		for _, v72 in pairs(v68.Values) do
			local v70 = v67 == "Min" and v66 and v66 or v65
			if not p46 then
				local v71 = (v72 + (v67 == "Min" and -2 or 2) + 2) / 4
				local v72 = math.floor(v71) * 4
			end
			table.insert(v70, v72)
		end
	end
	local v73 = unpack
	local v74 = Vector3.new(v73(v66))
	local v75 = unpack
	local v76 = Vector3.new(v75(v65))
	return Region3.new(v74, v76), v74, v76
end
function v_u_17._displayBounds(p77) -- name: _displayBounds
	if not p77.displayBoundParts then
		p77.displayBoundParts = true
		local v78 = {
			["BoundMin"] = p77.boundMin,
			["BoundMax"] = p77.boundMax
		}
		for v79, v80 in pairs(v78) do
			local v81 = Instance.new("Part")
			v81.Anchored = true
			v81.CanCollide = false
			v81.Transparency = 0.5
			v81.Size = Vector3.new(1, 1, 1)
			v81.Color = Color3.fromRGB(255, 0, 0)
			v81.CFrame = CFrame.new(v80)
			v81.Name = v79
			v81.Parent = workspace
			p77.janitor:add(v81, "Destroy")
		end
	end
end
function v_u_17._update(p_u_82) -- name: _update
	-- upvalues: (copy) v_u_2
	local v83 = p_u_82.container
	local v84 = {}
	local v_u_85 = 0
	p_u_82._updateConnections:clean()
	local v86 = typeof(v83)
	local v87 = {}
	if v86 == "table" then
		for _, v88 in pairs(v83) do
			if v88:IsA("BasePart") then
				table.insert(v84, v88)
			end
		end
	elseif v86 == "Instance" then
		if v83:IsA("BasePart") then
			table.insert(v84, v83)
		else
			table.insert(v87, v83)
			for _, v89 in pairs(v83:GetDescendants()) do
				if v89:IsA("BasePart") then
					table.insert(v84, v89)
				else
					table.insert(v87, v89)
				end
			end
		end
	end
	p_u_82.zoneParts = v84
	p_u_82.overlapParams = {}
	local v90 = true
	for _, v_u_91 in pairs(v84) do
		local _, v92 = pcall(function()
			-- upvalues: (copy) v_u_91
			return v_u_91.Shape.Name
		end)
		if v92 ~= "Block" then
			v90 = false
		end
	end
	p_u_82.allZonePartsAreBlocks = v90
	local v93 = OverlapParams.new()
	v93.FilterType = Enum.RaycastFilterType.Whitelist
	v93.MaxParts = #v84
	v93.FilterDescendantsInstances = v84
	p_u_82.overlapParams.zonePartsWhitelist = v93
	local v94 = OverlapParams.new()
	v94.FilterType = Enum.RaycastFilterType.Blacklist
	v94.FilterDescendantsInstances = v84
	p_u_82.overlapParams.zonePartsIgnorelist = v94
	local function v97() -- name: update
		-- upvalues: (copy) p_u_82, (ref) v_u_85, (ref) v_u_2
		if p_u_82.autoUpdate then
			local v_u_95 = os.clock()
			if p_u_82.respectUpdateQueue then
				v_u_85 = v_u_85 + 1
				v_u_95 = v_u_95 + 0.1
			end
			local v_u_96 = nil
			v_u_96 = v_u_2.Heartbeat:Connect(function()
				-- upvalues: (ref) v_u_95, (ref) v_u_96, (ref) p_u_82, (ref) v_u_85
				if v_u_95 <= os.clock() then
					v_u_96:Disconnect()
					if p_u_82.respectUpdateQueue then
						v_u_85 = v_u_85 - 1
					end
					if v_u_85 == 0 and p_u_82.zoneId then
						p_u_82:_update()
					end
				end
			end)
		end
	end
	local v98 = { "Size", "Position" }
	for _, v_u_99 in pairs(v84) do
		for _, v100 in pairs(v98) do
			p_u_82._updateConnections:add(v_u_99:GetPropertyChangedSignal(v100):Connect(v97), "Disconnect")
		end
		if v_u_99.CollisionGroupId ~= 0 then
			error("Zone parts must belong to the \'Default\' (0) CollisionGroup! Consider using zone:relocate() if you wish to move zones outside of workspace to prevent them interacting with other parts.")
		end
		p_u_82._updateConnections:add(v_u_99:GetPropertyChangedSignal("CollisionGroupId"):Connect(function()
			-- upvalues: (copy) v_u_99
			if v_u_99.CollisionGroupId ~= 0 then
				error("Zone parts must belong to the \'Default\' (0) CollisionGroup! Consider using zone:relocate() if you wish to move zones outside of workspace to prevent them interacting with other parts.")
			end
		end), "Disconnect")
	end
	local v101 = { "ChildAdded", "ChildRemoved" }
	for _, _ in pairs(v87) do
		for _, v102 in pairs(v101) do
			p_u_82._updateConnections:add(p_u_82.container[v102]:Connect(function(p103)
				-- upvalues: (copy) p_u_82, (ref) v_u_85, (ref) v_u_2
				if p103:IsA("BasePart") and p_u_82.autoUpdate then
					local v_u_104 = os.clock()
					if p_u_82.respectUpdateQueue then
						v_u_85 = v_u_85 + 1
						v_u_104 = v_u_104 + 0.1
					end
					local v_u_105 = nil
					v_u_105 = v_u_2.Heartbeat:Connect(function()
						-- upvalues: (ref) v_u_104, (ref) v_u_105, (ref) p_u_82, (ref) v_u_85
						if v_u_104 <= os.clock() then
							v_u_105:Disconnect()
							if p_u_82.respectUpdateQueue then
								v_u_85 = v_u_85 - 1
							end
							if v_u_85 == 0 and p_u_82.zoneId then
								p_u_82:_update()
							end
						end
					end)
				end
			end), "Disconnect")
		end
	end
	local v106, v107, v108 = p_u_82:_calculateRegion(v84)
	local v109, _, _ = p_u_82:_calculateRegion(v84, true)
	p_u_82.region = v106
	p_u_82.exactRegion = v109
	p_u_82.boundMin = v107
	p_u_82.boundMax = v108
	local v110 = v106.Size
	p_u_82.volume = v110.X * v110.Y * v110.Z
	p_u_82:_updateTouchedConnections()
	p_u_82.updated:Fire()
end
function v_u_17._updateOccupants(p111, p112, p113) -- name: _updateOccupants
	local v114 = p111.occupants[p112]
	if not v114 then
		v114 = {}
		p111.occupants[p112] = v114
	end
	local v115 = {}
	for v116, v117 in pairs(v114) do
		local v118 = p113[v116]
		if v118 == nil or v118 ~= v117 then
			v114[v116] = nil
			if not v115.exited then
				v115.exited = {}
			end
			local v119 = v115.exited
			table.insert(v119, v116)
		end
	end
	for v120, _ in pairs(p113) do
		if v114[v120] == nil then
			v114[v120] = v120:IsA("Player") and (v120.Character or true) or true
			if not v115.entered then
				v115.entered = {}
			end
			local v121 = v115.entered
			table.insert(v121, v120)
		end
	end
	return v115
end
function v_u_17._formTouchedConnection(p122, p123) -- name: _formTouchedConnection
	-- upvalues: (copy) v_u_7
	local v124 = "_touchedJanitor" .. p123
	local v125 = p122[v124]
	if v125 then
		v125:clean()
	else
		p122[v124] = p122.janitor:add(v_u_7.new(), "destroy")
	end
	p122:_updateTouchedConnection(p123)
end
function v_u_17._updateTouchedConnection(p126, p127) -- name: _updateTouchedConnection
	local v128 = p126["_touchedJanitor" .. p127]
	if v128 then
		for _, v129 in pairs(p126.zoneParts) do
			v128:add(v129.Touched:Connect(p126.touchedConnectionActions[p127], p126), "Disconnect")
		end
	end
end
function v_u_17._updateTouchedConnections(p130) -- name: _updateTouchedConnections
	for v131, _ in pairs(p130.touchedConnectionActions) do
		local v132 = p130["_touchedJanitor" .. v131]
		if v132 then
			v132:cleanup()
			p130:_updateTouchedConnection(v131)
		end
	end
end
function v_u_17._disconnectTouchedConnection(p133, p134) -- name: _disconnectTouchedConnection
	local v135 = "_touchedJanitor" .. p134
	local v136 = p133[v135]
	if v136 then
		v136:cleanup()
		p133[v135] = nil
	end
end
function v_u_17._partTouchedZone(p_u_137, p_u_138) -- name: _partTouchedZone
	-- upvalues: (copy) v_u_7, (copy) v_u_3, (copy) v_u_6
	local v_u_139 = p_u_137.trackingTouchedTriggers.part
	if not v_u_139[p_u_138] then
		local v_u_140 = 0
		local v_u_141 = false
		local v_u_142 = p_u_138.Position
		local v_u_143 = os.clock()
		local v_u_144 = p_u_137.janitor:add(v_u_7.new(), "destroy")
		v_u_139[p_u_138] = v_u_144
		if not ({
			["Seat"] = true,
			["VehicleSeat"] = true
		})[p_u_138.ClassName] and ({
			["HumanoidRootPart"] = true
		})[p_u_138.Name] then
			p_u_138.CanTouch = false
		end
		local v145 = p_u_138.Size.X * p_u_138.Size.Y * p_u_138.Size.Z * 100000
		local v_u_146 = math.round(v145) * 0.00001
		p_u_137.totalPartVolume = p_u_137.totalPartVolume + v_u_146
		v_u_144:add(v_u_3:Connect(function()
			-- upvalues: (ref) v_u_140, (ref) v_u_6, (copy) p_u_137, (copy) p_u_138, (ref) v_u_141, (ref) v_u_142, (ref) v_u_143, (copy) v_u_144
			local v147 = os.clock()
			if v_u_140 <= v147 then
				local v148 = v_u_6.Accuracy.getProperty(p_u_137.accuracy)
				v_u_140 = v147 + v148
				local v149 = p_u_137:findPoint(p_u_138.CFrame) or p_u_137:findPart(p_u_138)
				if v_u_141 then
					if not v149 then
						v_u_141 = false
						v_u_142 = p_u_138.Position
						v_u_143 = os.clock()
						p_u_137.partExited:Fire(p_u_138)
					end
				else
					if v149 then
						v_u_141 = true
						p_u_137.partEntered:Fire(p_u_138)
						return
					end
					if (p_u_138.Position - v_u_142).Magnitude > 1.5 and v148 <= v147 - v_u_143 then
						v_u_144:cleanup()
						return
					end
				end
			end
		end), "Disconnect")
		v_u_144:add(function()
			-- upvalues: (copy) v_u_139, (copy) p_u_138, (copy) p_u_137, (copy) v_u_146
			v_u_139[p_u_138] = nil
			p_u_138.CanTouch = true
			local v150 = p_u_137
			local v151 = (p_u_137.totalPartVolume - v_u_146) * 100000
			v150.totalPartVolume = math.round(v151) * 0.00001
		end, true)
	end
end
local v_u_155 = {
	["Ball"] = function(p152)
		return "GetPartBoundsInRadius", { p152.Position, p152.Size.X }
	end,
	["Block"] = function(p153)
		return "GetPartBoundsInBox", { p153.CFrame, p153.Size }
	end,
	["Other"] = function(p154)
		return "GetPartsInPart", { p154 }
	end
}
function v_u_17._getRegionConstructor(p156, p_u_157, p158) -- name: _getRegionConstructor
	-- upvalues: (copy) v_u_155
	local v159, v160 = pcall(function()
		-- upvalues: (copy) p_u_157
		return p_u_157.Shape.Name
	end)
	local v161 = nil
	local v162 = nil
	if v159 and p156.allZonePartsAreBlocks then
		local v163 = v_u_155[v160]
		if v163 then
			v161, v162 = v163(p_u_157)
		end
	end
	if not v161 then
		v162 = { p_u_157 }
		v161 = "GetPartsInPart"
	end
	if p158 then
		table.insert(v162, p158)
	end
	return v161, v162
end
function v_u_17.findLocalPlayer(p164) -- name: findLocalPlayer
	-- upvalues: (copy) v_u_4
	if not v_u_4 then
		error("Can only call \'findLocalPlayer\' on the client!")
	end
	return p164:findPlayer(v_u_4)
end
function v_u_17._find(p165, p166, p167) -- name: _find
	-- upvalues: (copy) v_u_14
	v_u_14.updateDetection(p165)
	local v168 = v_u_14.trackers[p166]
	local v169 = v_u_14.getTouchingZones(p167, false, p165._currentEnterDetection, v168)
	for _, v170 in pairs(v169) do
		if v170 == p165 then
			return true
		end
	end
	return false
end
function v_u_17.findPlayer(p171, p172) -- name: findPlayer
	local v173 = p172.Character
	if v173 then
		v173 = v173:FindFirstChildOfClass("Humanoid")
	end
	if v173 then
		return p171:_find("player", p172.Character)
	else
		return false
	end
end
function v_u_17.findItem(p174, p175) -- name: findItem
	return p174:_find("item", p175)
end
function v_u_17.findPart(p176, p177) -- name: findPart
	local v178, v179 = p176:_getRegionConstructor(p177, p176.overlapParams.zonePartsWhitelist)
	local v180 = p176.worldModel[v178](p176.worldModel, unpack(v179))
	if #v180 > 0 then
		return true, v180
	else
		return false
	end
end
function v_u_17.getCheckerPart(p181) -- name: getCheckerPart
	-- upvalues: (copy) v_u_14
	local v182 = p181.checkerPart
	if not v182 then
		v182 = p181.janitor:add(Instance.new("Part"), "Destroy")
		v182.Size = Vector3.new(0.1, 0.1, 0.1)
		v182.Name = "ZonePlusCheckerPart"
		v182.Anchored = true
		v182.Transparency = 1
		v182.CanCollide = false
		p181.checkerPart = v182
	end
	local v183 = p181.worldModel
	if v183 == workspace then
		v183 = v_u_14.getWorkspaceContainer()
	end
	if v182.Parent ~= v183 then
		v182.Parent = v183
	end
	return v182
end
function v_u_17.findPoint(p184, p185) -- name: findPoint
	if typeof(p185) == "Vector3" then
		p185 = CFrame.new(p185)
	end
	local v186 = p184:getCheckerPart()
	v186.CFrame = p185
	local v187, v188 = p184:_getRegionConstructor(v186, p184.overlapParams.zonePartsWhitelist)
	local v189 = p184.worldModel[v187](p184.worldModel, unpack(v188))
	if #v189 > 0 then
		return true, v189
	else
		return false
	end
end
function v_u_17._getAll(p190, p191) -- name: _getAll
	-- upvalues: (copy) v_u_14
	v_u_14.updateDetection(p190)
	local v192 = {}
	local v193 = v_u_14._getZonesAndItems(p191, {
		["self"] = true
	}, p190.volume, false, p190._currentEnterDetection)[p190]
	if v193 then
		for v194, _ in pairs(v193) do
			table.insert(v192, v194)
		end
	end
	return v192
end
function v_u_17.getPlayers(p195) -- name: getPlayers
	return p195:_getAll("player")
end
function v_u_17.getItems(p196) -- name: getItems
	return p196:_getAll("item")
end
function v_u_17.getParts(p197) -- name: getParts
	local v198 = {}
	if p197.activeTriggers.part then
		local v199 = p197.trackingTouchedTriggers.part
		for v200, _ in pairs(v199) do
			table.insert(v198, v200)
		end
		return v198
	else
		local v201 = p197.worldModel:GetPartBoundsInBox(p197.region.CFrame, p197.region.Size, p197.overlapParams.zonePartsIgnorelist)
		for _, v202 in pairs(v201) do
			if p197:findPart(v202) then
				table.insert(v198, v202)
			end
		end
		return v198
	end
end
function v_u_17.getRandomPoint(p203) -- name: getRandomPoint
	local v204 = p203.exactRegion
	local v205 = v204.Size
	local v206 = v204.CFrame
	local v207 = Random.new()
	local v208 = nil
	repeat
		local v209 = v206 * CFrame.new(v207:NextNumber(-v205.X / 2, v205.X / 2), v207:NextNumber(-v205.Y / 2, v205.Y / 2), v207:NextNumber(-v205.Z / 2, v205.Z / 2))
		local v210, v211 = p203:findPoint(v209)
		v208 = v210 and true or v208
	until v208
	return v209.Position, v211
end
function v_u_17.setAccuracy(p212, p213) -- name: setAccuracy
	-- upvalues: (copy) v_u_6
	local v214 = tonumber(p213)
	if v214 then
		if not v_u_6.Accuracy.getName(v214) then
			error(("%s is an invalid enumId!"):format(v214))
		end
	else
		v214 = v_u_6.Accuracy[p213]
		if not v214 then
			error(("\'%s\' is an invalid enumName!"):format(p213))
		end
	end
	p212.accuracy = v214
end
function v_u_17.setDetection(p215, p216) -- name: setDetection
	-- upvalues: (copy) v_u_6
	local v217 = tonumber(p216)
	if v217 then
		if not v_u_6.Detection.getName(v217) then
			error(("%s is an invalid enumId!"):format(v217))
		end
	else
		v217 = v_u_6.Detection[p216]
		if not v217 then
			error(("\'%s\' is an invalid enumName!"):format(p216))
		end
	end
	p215.enterDetection = v217
	p215.exitDetection = v217
end
function v_u_17.trackItem(p_u_218, p_u_219) -- name: trackItem
	-- upvalues: (copy) v_u_7, (copy) v_u_12
	local v220 = p_u_219:IsA("BasePart")
	local v221
	if v220 then
		v221 = false
	else
		v221 = p_u_219:FindFirstChildOfClass("Humanoid")
		if v221 then
			v221 = p_u_219:FindFirstChild("HumanoidRootPart")
		end
	end
	assert(v220 or v221, "Only BaseParts or Characters/NPCs can be tracked!")
	if not p_u_218.trackedItems[p_u_219] then
		if p_u_218.itemsToUntrack[p_u_219] then
			p_u_218.itemsToUntrack[p_u_219] = nil
		end
		local v222 = p_u_218.janitor:add(v_u_7.new(), "destroy")
		local v223 = {
			["janitor"] = v222,
			["item"] = p_u_219,
			["isBasePart"] = v220,
			["isCharacter"] = v221
		}
		p_u_218.trackedItems[p_u_219] = v223
		v222:add(p_u_219.AncestryChanged:Connect(function()
			-- upvalues: (copy) p_u_219, (copy) p_u_218
			if not p_u_219:IsDescendantOf(game) then
				p_u_218:untrackItem(p_u_219)
			end
		end), "Disconnect")
		require(v_u_12).itemAdded:Fire(v223)
	end
end
function v_u_17.untrackItem(p224, p225) -- name: untrackItem
	-- upvalues: (copy) v_u_12
	local v226 = p224.trackedItems[p225]
	if v226 then
		v226.janitor:destroy()
	end
	p224.trackedItems[p225] = nil
	require(v_u_12).itemRemoved:Fire(v226)
end
function v_u_17.bindToGroup(p227, p228) -- name: bindToGroup
	-- upvalues: (copy) v_u_14
	p227:unbindFromGroup()
	(v_u_14.getGroup(p228) or v_u_14.setGroup(p228))._memberZones[p227.zoneId] = p227
	p227.settingsGroupName = p228
end
function v_u_17.unbindFromGroup(p229) -- name: unbindFromGroup
	-- upvalues: (copy) v_u_14
	if p229.settingsGroupName then
		local v230 = v_u_14.getGroup(p229.settingsGroupName)
		if v230 then
			v230._memberZones[p229.zoneId] = nil
		end
		p229.settingsGroupName = nil
	end
end
function v_u_17.relocate(p231) -- name: relocate
	-- upvalues: (copy) v_u_13
	if not p231.hasRelocated then
		local v232 = require(v_u_13).setupWorldModel(p231)
		p231.worldModel = v232
		p231.hasRelocated = true
		local v233 = p231.container
		if typeof(v233) == "table" then
			v233 = Instance.new("Folder")
			for _, v234 in pairs(p231.zoneParts) do
				v234.Parent = v233
			end
		end
		p231.relocationContainer = p231.janitor:add(v233, "Destroy", "RelocationContainer")
		v233.Parent = v232
	end
end
function v_u_17._onItemCallback(p_u_235, p236, p237, p_u_238, p_u_239) -- name: _onItemCallback
	local v240 = p_u_235.onItemDetails[p_u_238]
	if not v240 then
		v240 = {}
		p_u_235.onItemDetails[p_u_238] = v240
	end
	if #v240 == 0 then
		p_u_235.itemsToUntrack[p_u_238] = true
	end
	table.insert(v240, p_u_238)
	p_u_235:trackItem(p_u_238)
	if p_u_235:findItem(p_u_238) == p237 then
		p_u_239()
		if p_u_235.itemsToUntrack[p_u_238] then
			p_u_235.itemsToUntrack[p_u_238] = nil
			p_u_235:untrackItem(p_u_238)
			return
		end
	else
		local v_u_241 = nil
		v_u_241 = p_u_235[p236]:Connect(function(p242)
			-- upvalues: (ref) v_u_241, (copy) p_u_238, (copy) p_u_239, (copy) p_u_235
			if v_u_241 and p242 == p_u_238 then
				v_u_241:Disconnect()
				v_u_241 = nil
				p_u_239()
				if p_u_235.itemsToUntrack[p_u_238] then
					p_u_235.itemsToUntrack[p_u_238] = nil
					p_u_235:untrackItem(p_u_238)
				end
			end
		end)
	end
end
function v_u_17.onItemEnter(p243, ...) -- name: onItemEnter
	p243:_onItemCallback("itemEntered", true, ...)
end
function v_u_17.onItemExit(p244, ...) -- name: onItemExit
	p244:_onItemCallback("itemExited", false, ...)
end
function v_u_17.destroy(p245) -- name: destroy
	p245:unbindFromGroup()
	p245.janitor:destroy()
end
v_u_17.Destroy = v_u_17.destroy
return v_u_17