local v_u_1 = game:GetService("HttpService")
local v_u_2 = game:GetService("CollectionService")
local v3 = game.ReplicatedStorage.common
local _ = game.Players.LocalPlayer
local v4 = game.ReplicatedStorage.common.RedEvents
local v_u_5 = require("@self/Pathfinder")
local v6 = require(v3.Signal)
local v_u_7 = game:GetService("RunService"):IsServer()
local v_u_8 = require(v4.General.ReplicateObjective)
local v_u_9 = {}
local v_u_10 = {
	["Type"] = true,
	["Text"] = true,
	["IsPrimary"] = true,
	["MarkerMap"] = true,
	["MarkerPositions"] = true,
	["MarkerParts"] = true,
	["Location"] = true,
	["Progress"] = true,
	["ProgressTotal"] = true,
	["TargetPlayers"] = true,
	["ImageID"] = true,
	["AccentColor"] = true,
	["ProgressFormat"] = true,
	["NewSoundId"] = true,
	["CompleteSoundId"] = true
}
local v_u_11
if v_u_7 then
	v_u_11 = nil
else
	local v12 = game:GetService("ReplicatedStorage").common.ZS_Framework.Modules.Controllers.HUDController
	v_u_11 = require(v12.HUDElements.Objectives)
end
local v_u_13 = {}
v_u_13.__index = v_u_13
v_u_13.Completed = v6.new()
function v_u_13.__index(p14, p15) -- name: __index
	-- upvalues: (copy) v_u_10, (copy) v_u_13
	local v16 = rawget(p14, p15)
	if v_u_10[p15] then
		return rawget(p14, "Properties")[p15]
	elseif v16 == nil then
		return v_u_13[p15]
	else
		return v16
	end
end
function v_u_13.__newindex(p17, p18, p19) -- name: __newindex
	-- upvalues: (copy) v_u_10, (copy) v_u_13
	local v20 = rawget(p17, p18)
	if v_u_10[p18] then
		p17:_SetProperty(p18, p19)
		return p17
	elseif v20 == nil then
		v_u_13[p18] = p19
		return p17
	else
		p17[p18] = p19
		return p17
	end
end
function v_u_13.new(p21, p22) -- name: new
	-- upvalues: (copy) v_u_1, (copy) v_u_7, (copy) v_u_9, (copy) v_u_8, (copy) v_u_13, (ref) v_u_11
	local v23 = p22 or v_u_1:GenerateGUID(false)
	if not v_u_7 then
		local _ = v23 == nil
	end
	local v24 = p21 ~= nil
	assert(v24, "Must pass a property table")
	local v25 = p21.Type ~= nil
	assert(v25, "Must pass a Type in the propertyTable")
	local v26 = p21.Text ~= nil
	assert(v26, "Must pass text in the propertyTable")
	p21.MarkerParts = formatMarkerParts(p21.MarkerParts, v23)
	local v27 = {
		["Type"] = p21.Type,
		["Text"] = p21.Text,
		["IsPrimary"] = p21.IsPrimary,
		["MarkerMap"] = p21.MarkerMap,
		["MarkerPositions"] = p21.MarkerPositions,
		["MarkerParts"] = p21.MarkerParts,
		["Location"] = p21.Location,
		["Progress"] = p21.Progress,
		["ProgressTotal"] = p21.ProgressTotal or 1,
		["ImageID"] = p21.ImageID,
		["AccentColor"] = p21.AccentColor,
		["ProgressFormat"] = p21.ProgressFormat,
		["NewSoundId"] = p21.NewSoundId,
		["CompleteSoundId"] = p21.CompleteSoundId
	}
	if not p21.ProgressTotal and (v27.Type == "kill" or (v27.Type == "collect" or (v27.Type == "find" or v27.Type == "interact"))) and not v27.ProgressFormat then
		v27.ProgressFormat = ""
	end
	if v27.MarkerPositions then
		local v28 = true
		local v29 = v27.MarkerPositions
		if typeof(v29) == "table" then
			if v27.MarkerPositions[1] then
				local v30 = v27.MarkerPositions[1]
				if typeof(v30) ~= "Vector3" then
					v28 = false
				end
			else
				v28 = false
			end
		else
			local v31 = v27.MarkerPositions
			if typeof(v31) ~= "Vector3" then
				v28 = false
			end
		end
		if not v28 then
			error("MarkerPositions must be of type Vector3 or array of Vector3")
		end
	elseif not v_u_7 and v27.MarkerParts then
		local v32 = v27.MarkerParts.Count ~= nil
		assert(v32, "MarkerParts table needs a count")
		v27.MarkerParts.Parts = getUnreplicatedParts(v23, v27.MarkerParts.Count)
	end
	if v27.Type == "kill" or (v27.Type == "find" or (v27.Type == "collect" or (v27.Type == "interact" or v27.Type == "money"))) then
		if not v27.Progress then
			v27.Progress = 0
		end
	elseif p21.Type ~= "move" then
		error("Type must be either kill, find, collect, interact, or move")
	end
	if v_u_7 then
		local v33 = {
			["_Identifier"] = nil,
			["_ServerProperties"] = nil,
			["Properties"] = nil,
			["_Destroyed"] = false,
			["_Identifier"] = v23,
			["_ServerProperties"] = {},
			["Properties"] = v27
		}
		v_u_9[v33._Identifier] = v33
		local v34 = {
			["Type"] = "Add",
			["PropertyTable"] = nil,
			["Identifier"] = nil,
			["PropertyTable"] = v27,
			["Identifier"] = v23
		}
		local v35 = p21.TargetPlayers
		if v35 then
			v_u_8:FireClients(v35, v34)
		else
			v_u_8:FireAllClients(v34)
		end
		if v35 then
			v33._ServerProperties.TargetPlayers = v35
		end
		local v36 = v_u_13
		return setmetatable(v33, v36)
	else
		local v37 = {
			["_Identifier"] = nil,
			["Properties"] = nil,
			["_IsLocal"] = nil,
			["_Destroyed"] = false,
			["_Identifier"] = v23,
			["Properties"] = v27,
			["_IsLocal"] = v23 == nil
		}
		local v38 = v_u_13
		setmetatable(v37, v38)
		v_u_9[v37._Identifier] = v37
		v_u_11:AddObjective(v27, v23)
		if v27.Location and not v27.MarkerMap then
			v37:AddMarker(v27.Location)
		elseif v27.MarkerMap then
			v37:_UpdateMarkerMap()
		else
			if v27.MarkerParts then
				v37:AddMarkers(v27.MarkerParts.Parts)
			end
			if v27.MarkerPositions then
				v37:AddMarkers(v27.MarkerPositions)
			end
		end
		if v27.Type == "move" then
			v37:_RunMoveProgressUpdates()
		end
		return v37
	end
end
function v_u_13.AddMarker(p39, p40) -- name: AddMarker
	-- upvalues: (ref) v_u_11
	local v41 = v_u_11:AddMarker(p39.Properties, p40, nil, p39._Identifier)
	if typeof(p40) ~= "Vector3" then
		if typeof(p40) == "Instance" then
			if not p39._MarkerPartIdentifiers then
				p39._MarkerPartIdentifiers = {}
			end
			local v42 = p39._MarkerPartIdentifiers
			table.insert(v42, v41)
		end
		return v41
	end
	if not p39._MarkerPositionIdentifiers then
		p39._MarkerPositionIdentifiers = {}
	end
	local v43 = p39._MarkerPositionIdentifiers
	table.insert(v43, v41)
	return v41
end
function v_u_13.AddMarkers(p44, p45) -- name: AddMarkers
	local v46 = true
	if typeof(p45) == "Vector3" then
		p44:AddMarker(p45)
	elseif typeof(p45) == "table" and p45[1] then
		local v47 = p45[1]
		if typeof(v47) == "Vector3" then
			for _, v48 in p45 do
				p44:AddMarker(v48)
			end
		else
			local v49 = p45[1]
			if typeof(v49) == "Instance" then
				for _, v50 in p45 do
					p44:AddMarker(v50)
				end
			else
				v46 = false
			end
		end
	else
		v46 = false
	end
	if not v46 then
		error("Markers must be of type Vector3, {Vector3}, or {BasePart}")
	end
end
function v_u_13.AppendPlayer(p51, p52) -- name: AppendPlayer
	local v53 = {}
	local v54 = p51._ServerProperties.TargetPlayers
	if v54 then
		for _, v55 in v54.value do
			table.insert(v53, v55)
		end
		if not table.find(v54.value, p52) then
			table.insert(v53, p52)
		end
	else
		table.insert(v53, p52)
	end
	p51.TargetPlayers = v53
end
function v_u_13.Destroy(p56, p57) -- name: Destroy
	-- upvalues: (copy) v_u_13, (copy) v_u_7, (copy) v_u_8, (copy) v_u_9, (ref) v_u_11
	if p57 then
		v_u_13.Completed:Fire(p56)
	end
	if v_u_7 then
		local v58 = {
			["Type"] = "Destroy",
			["Identifier"] = nil,
			["WasCompleted"] = nil,
			["Identifier"] = p56._Identifier,
			["WasCompleted"] = p57 or false
		}
		if p56._ServerProperties.TargetPlayers then
			v_u_8:FireClients(p56._ServerProperties.TargetPlayers, v58)
		else
			v_u_8:FireAllClients(v58)
		end
		v_u_9[p56._Identifier] = nil
	elseif not p56._Destroyed then
		v_u_11:RemoveObjective(p56._Identifier, p57)
		p56:_IterateMarkers(function(p59)
			-- upvalues: (ref) v_u_11
			v_u_11:RemoveMarker(p59)
		end)
		p56:_StopMarkerPathfinding()
		p56:_StopMoveProgressUpdates()
		p56._Destroyed = true
	end
end
function v_u_13.Remove(p60) -- name: Remove
	p60:Destroy()
end
function v_u_13.Complete(p61) -- name: Complete
	p61:Destroy(true)
end
function v_u_13._UpdateMarkerMap(p62) -- name: _UpdateMarkerMap
	-- upvalues: (ref) v_u_11, (copy) v_u_5
	p62:_IterateMarkers(function(p63)
		-- upvalues: (ref) v_u_11
		v_u_11:RemoveMarker(p63)
	end)
	if p62.Properties.MarkerMap then
		v_u_5:Init(p62.Properties.MarkerMap)
		p62:_RunMarkerPathfinding()
	else
		p62:_StopMarkerPathfinding()
	end
end
function v_u_13._RunMarkerPathfinding(p_u_64) -- name: _RunMarkerPathfinding
	-- upvalues: (ref) v_u_11, (copy) v_u_5
	local v65 = p_u_64.Properties.MarkerMap
	assert(v65, "This objective has node map for markers")
	local v_u_66 = tick()
	p_u_64._PathfindingCode = v_u_66
	task.defer(function()
		-- upvalues: (copy) v_u_66, (copy) p_u_64, (ref) v_u_11, (ref) v_u_5
		local v67 = game.Players.LocalPlayer
		local v68 = nil
		while task.wait(0.2) and v_u_66 == p_u_64._PathfindingCode do
			local v69 = v67.Character
			local v70 = nil
			if v69 then
				local v71 = v69:FindFirstChild("HumanoidRootPart")
				if v71 then
					v70 = v71.Position
				end
			end
			local v72 = p_u_64.Properties.Location
			local v73 = nil
			if v72 then
				if typeof(v72) == "Vector3" then
					v73 = v72
				elseif typeof(v72) == "Instance" and v72:IsA("BasePart") then
					v73 = v72.Position
				end
			end
			p_u_64:_IterateMarkers(function(p74)
				-- upvalues: (ref) v_u_11
				v_u_11:RemoveMarker(p74)
			end)
			if v70 and v73 then
				local v75, _ = v_u_5:FindPath(v70, v73)
				local v76 = v75 or {}
				if #v76 >= 1 then
					if (v70 - v76[1]).Magnitude < 10 then
						v68 = table.remove(v76, 1)
					elseif v68 == v76[1] then
						table.remove(v76, 1)
					end
				end
				if #v76 == 0 then
					p_u_64:AddMarker(p_u_64.Properties.Location)
				else
					p_u_64:AddMarker(v76[1])
				end
			end
		end
	end)
end
function v_u_13._StopMarkerPathfinding(p77) -- name: _StopMarkerPathfinding
	p77._PathfindingCode = nil
end
function v_u_13._RunMoveProgressUpdates(p_u_78) -- name: _RunMoveProgressUpdates
	-- upvalues: (ref) v_u_11
	p_u_78._IsMoveProgressRunning = true
	task.defer(function()
		-- upvalues: (copy) p_u_78, (ref) v_u_11
		local v79 = game.Players.LocalPlayer
		while task.wait(0.2) and p_u_78._IsMoveProgressRunning do
			local v80 = v79.Character
			local v81 = nil
			if v80 then
				local v82 = v80:FindFirstChild("HumanoidRootPart")
				if v82 then
					v81 = v82.Position
				end
			end
			local v83 = p_u_78.Properties.Location
			local v84 = nil
			if v83 then
				if typeof(v83) == "Vector3" then
					v84 = v83
				elseif typeof(v83) == "Instance" and v83:IsA("BasePart") then
					v84 = v83.Position
				end
			end
			if v81 and v84 then
				local v85 = v_u_11
				local v86 = p_u_78._Identifier
				local v87 = (v81 - v84).Magnitude * 0.28
				v85:UpdateProgress(v86, (math.floor(v87)))
			end
		end
	end)
end
function v_u_13._StopMoveProgressUpdates(p88) -- name: _StopMoveProgressUpdates
	p88._IsMoveProgressRunning = nil
end
function v_u_13._SetProperty(p89, p90, p_u_91) -- name: _SetProperty
	-- upvalues: (copy) v_u_10, (copy) v_u_7, (copy) v_u_8, (ref) v_u_11
	if v_u_10[p90] then
		if p90 ~= "TargetPlayers" then
			p89.Properties[p90] = p_u_91
		end
		if v_u_7 then
			if p90 == "MarkerParts" then
				p_u_91 = formatMarkerParts(p_u_91, p89._Identifier)
			end
			if p90 == "TargetPlayers" then
				local v92 = nil
				local v93 = p89._ServerProperties.TargetPlayers
				if v93 then
					for _, v94 in p_u_91 do
						if not table.find(v93.value, v94) then
							v92 = v92 or {}
							table.insert(v92, v94)
						end
					end
					for _, v95 in v93.value do
						if not table.find(p_u_91, v95) then
							v_u_8:FireClient(v95, {
								["Type"] = "Destroy",
								["Identifier"] = nil,
								["WasCompleted"] = false,
								["Identifier"] = p89._Identifier
							})
						end
					end
				end
				p89._ServerProperties.TargetPlayers = p_u_91
				if v92 then
					v_u_8:FireClients(v92, {
						["Type"] = "Add",
						["PropertyTable"] = nil,
						["Identifier"] = nil,
						["PropertyTable"] = p89.Properties,
						["Identifier"] = p89._Identifier
					})
				end
				return
			end
			local v96 = {
				["Type"] = "PropertyChanged",
				["Identifier"] = nil,
				["Index"] = nil,
				["Value"] = nil,
				["Identifier"] = p89._Identifier,
				["Index"] = p90,
				["Value"] = p_u_91
			}
			if p89._ServerProperties.TargetPlayers then
				v_u_8:FireClients(p89._ServerProperties.TargetPlayers, v96)
			else
				v_u_8:FireAllClients(v96)
			end
		elseif p90 == "Text" then
			p89:_IterateMarkers(function(p97)
				-- upvalues: (ref) v_u_11, (ref) p_u_91
				v_u_11:SetMarkerText(p97, p_u_91)
			end)
		elseif p90 == "MarkerPositions" and not p89.MarkerMap then
			if p89._MarkerPositionIdentifiers then
				for _, v98 in p89._MarkerPositionIdentifiers do
					v_u_11:RemoveMarker(v98)
				end
			end
			p89:AddMarkers(p_u_91)
		elseif p90 == "MarkerParts" and not p89.MarkerMap then
			local v99 = formatMarkerParts(p_u_91, p89._Identifier)
			p89.Properties[p90] = v99
			v99.Parts = getUnreplicatedParts(p89._Identifier, v99.Count)
			if p89._MarkerPartIdentifiers then
				for _, v100 in p89._MarkerPartIdentifiers do
					v_u_11:RemoveMarker(v100)
				end
			end
			p89:AddMarkers(v99.Parts)
		elseif p90 == "Progress" then
			v_u_11:UpdateProgress(p89._Identifier, p_u_91)
		elseif p90 == "ProgressTotal" then
			v_u_11:UpdateProgress(p89._Identifier, nil, p_u_91)
		elseif p90 == "IsPrimary" then
			v_u_11:SetIsPrimary(p89._Identifier, p_u_91)
		elseif p90 == "MarkerMap" then
			p89:_UpdateMarkerMap()
		elseif p90 == "Location" and (not p89.Properties.MarkerMap and p_u_91 ~= nil) then
			p89:AddMarker(p_u_91)
		end
	end
end
function v_u_13._IterateMarkers(p101, p102) -- name: _IterateMarkers
	if p101._MarkerPositionIdentifiers then
		for _, v103 in p101._MarkerPositionIdentifiers do
			p102(v103)
		end
	end
	if p101._MarkerPartIdentifiers then
		for _, v104 in p101._MarkerPartIdentifiers do
			p102(v104)
		end
	end
end
function getUnreplicatedPart(p105) -- name: getUnreplicatedPart
	-- upvalues: (copy) v_u_2
	local v106 = v_u_2:GetTagged(p105)[1]
	while v106 == nil do
		v106 = v_u_2:GetInstanceAddedSignal(p105):Wait()
	end
	return v106
end
function getUnreplicatedParts(p107, p108) -- name: getUnreplicatedParts
	-- upvalues: (copy) v_u_2
	while true do
		local v109 = v_u_2:GetTagged(p107)
		if #v109 < p108 then
			v_u_2:GetInstanceAddedSignal(p107):Wait()
		end
		if p108 <= #v109 then
			return v109
		end
	end
end
function formatMarkerParts(p110, p111) -- name: formatMarkerParts
	-- upvalues: (copy) v_u_2
	if p110 then
		if typeof(p110) == "table" and not p110.Parts then
			local v112 = p110[1]
			local v113
			if typeof(v112) == "Instance" then
				v113 = p110[1]:IsA("BasePart")
			else
				v113 = false
			end
			assert(v113, "MarkerParts table must be an array of BaseParts")
			p110 = {
				["Parts"] = p110,
				["Count"] = #p110
			}
		elseif typeof(p110) == "Instance" and p110:IsA("BasePart") then
			p110 = {
				["Parts"] = nil,
				["Count"] = 1,
				["Parts"] = { p110 }
			}
		elseif not p110.Parts then
			error("MarkerParts must be {BasePart} or BasePart")
		end
		if typeof(p110) == "Instance" then
			v_u_2:AddTag(p110, p111)
			return p110
		else
			if typeof(p110) == "table" then
				for _, v114 in p110.Parts do
					v_u_2:AddTag(v114, p111)
				end
			end
			return p110
		end
	else
		return nil
	end
end
if v_u_7 then
	v_u_8:SetServerListener(function(p115, _)
		-- upvalues: (copy) v_u_9, (copy) v_u_8
		for v116, v117 in v_u_9 do
			if not v117._ServerProperties.TargetPlayers or table.find(v117._ServerProperties.TargetPlayers.value, p115) then
				v_u_8:FireClient(p115, {
					["Type"] = "Add",
					["PropertyTable"] = nil,
					["Identifier"] = nil,
					["PropertyTable"] = v117.Properties,
					["Identifier"] = v116
				})
			end
		end
	end)
else
	v_u_8:SetClientListener(function(p118)
		-- upvalues: (copy) v_u_13, (copy) v_u_9
		if p118.Type == "Add" then
			v_u_13.new(p118.PropertyTable, p118.Identifier)
		elseif p118.Type == "Destroy" then
			local v119 = v_u_9[p118.Identifier]
			if v119 then
				v119:Destroy(p118.WasCompleted)
				return
			end
		else
			local v120 = p118.Type == "PropertyChanged" and v_u_9[p118.Identifier]
			if v120 then
				v120:_SetProperty(p118.Index, p118.Value)
			end
		end
	end)
	v_u_8:FireServer()
end
return v_u_13