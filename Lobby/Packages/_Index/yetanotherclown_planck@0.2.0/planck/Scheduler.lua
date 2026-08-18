local v_u_1 = require(script.Parent.DependencyGraph)
local v_u_2 = require(script.Parent.Pipeline)
local v_u_3 = require(script.Parent.Phase)
local v_u_4 = require(script.Parent.utils)
local v_u_5 = require(script.Parent.hooks)
local v_u_6 = require(script.Parent.conditions)
local v_u_7 = v_u_4.getSystem
local v_u_8 = v_u_4.getSystemName
local v_u_9 = v_u_4.isPhase
local v_u_10 = v_u_4.isPipeline
local v_u_11 = v_u_4.isValidEvent
local v_u_12 = v_u_4.getEventIdentifier
local v_u_13 = {}
local v_u_14 = os.clock()
local v_u_15 = {}
v_u_15.__index = v_u_15
v_u_15.Hooks = v_u_5.Hooks
function v_u_15.addPlugin(p16, p17) -- name: addPlugin
	p17:build(p16)
	local v18 = p16._plugins
	table.insert(v18, p17)
	return p16
end
function v_u_15._addHook(p19, p20, p21) -- name: _addHook
	local v22 = p19._hooks[p20]
	local v23 = ("Unknown Hook: %*"):format(p20)
	assert(v22, v23)
	local v24 = p19._hooks[p20]
	table.insert(v24, p21)
end
function v_u_15.getDeltaTime(p25) -- name: getDeltaTime
	local v26 = debug.info(2, "f")
	if not (v26 and p25._systemInfo[v26]) then
		error("Scheduler:getDeltaTime() must be used within a registered system")
	end
	return p25._systemInfo[v26].deltaTime or 0
end
function v_u_15._handleLogs(_, p27) -- name: _handleLogs
	if not p27.timeLastLogged then
		p27.timeLastLogged = os.clock()
	end
	if not p27.recentLogs then
		p27.recentLogs = {}
	end
	if os.clock() - p27.timeLastLogged > 10 then
		p27.timeLastLogged = os.clock()
		p27.recentLogs = {}
	end
	local v28 = debug.info(p27.system, "n")
	for _, v29 in p27.logs do
		if not p27.recentLogs[v29] then
			task.spawn(error, v29, 0)
			warn((("Planck: Error occurred in system%*, this error will be ignored for 10 seconds"):format(string.len(v28) > 0 and ((" \'%*\'"):format(v28) or "") or "")))
			p27.recentLogs[v29] = true
		end
	end
	table.clear(p27.logs)
end
function v_u_15.runSystem(p_u_30, p_u_31) -- name: runSystem
	-- upvalues: (copy) v_u_5, (ref) v_u_14, (ref) v_u_13
	if p_u_30:_canRun(p_u_31) ~= false then
		local v_u_32 = p_u_30._systemInfo[p_u_31]
		local v33 = os.clock()
		v_u_32.deltaTime = v33 - (v_u_32.lastTime or v33)
		v_u_32.lastTime = v33
		if not p_u_30._thread then
			p_u_30._thread = coroutine.create(function()
				-- upvalues: (copy) p_u_30
				while true do
					local v34 = coroutine.yield()
					p_u_30._yielded = true
					v34()
					p_u_30._yielded = false
				end
			end)
			coroutine.resume(p_u_30._thread)
		end
		local v_u_35 = false
		local function v_u_53() -- name: systemCall
			-- upvalues: (copy) p_u_30, (copy) p_u_31, (ref) v_u_35, (copy) v_u_32, (ref) v_u_5
			local function v52() -- name: noYield
				-- upvalues: (ref) p_u_30, (ref) p_u_31, (ref) v_u_35, (ref) v_u_32, (ref) v_u_5
				local v_u_36 = nil
				local v_u_37 = nil
				coroutine.resume(p_u_30._thread, function()
					-- upvalues: (ref) v_u_36, (ref) v_u_37, (ref) p_u_31, (ref) p_u_30
					local v38 = xpcall
					local v39 = p_u_31
					local v40 = p_u_30._vargs
					local v42, v43 = v38(v39, function(p41)
						return debug.traceback(p41)
					end, table.unpack(v40))
					v_u_36 = v42
					v_u_37 = v43
				end)
				if v_u_36 == false then
					v_u_35 = true
					local v44 = v_u_32.logs
					local v45 = v_u_37
					table.insert(v44, v45)
					v_u_5.systemError(p_u_30, v_u_32, v_u_37)
				elseif p_u_30._yielded then
					v_u_35 = true
					local v46, v47 = debug.info(p_u_30._thread, 1, "sl")
					local v48 = ("%*:%*: System yielded"):format(v46, v47)
					local v49 = v_u_32.logs
					local v50 = debug.traceback
					local v51 = p_u_30._thread
					table.insert(v49, v50(v51, v48, 2))
					v_u_5.systemError(p_u_30, v_u_32, debug.traceback(p_u_30._thread, v48, 2))
				end
			end
			v_u_5.systemCall(p_u_30, "SystemCall", v_u_32, v52)
		end
		local function v_u_54() -- name: inner
			-- upvalues: (ref) v_u_5, (copy) p_u_30, (copy) v_u_32, (copy) v_u_53
			v_u_5.systemCall(p_u_30, "InnerSystemCall", v_u_32, v_u_53)
		end
		local function v55() -- name: outer
			-- upvalues: (ref) v_u_5, (copy) p_u_30, (copy) v_u_32, (copy) v_u_54
			v_u_5.systemCall(p_u_30, "OuterSystemCall", v_u_32, v_u_54)
		end
		if os.clock() - v_u_14 > 10 then
			v_u_14 = os.clock()
			v_u_13 = {}
		end
		local v56, v57 = pcall(v55)
		if not (v56 or v_u_13[v57]) then
			task.spawn(error, v57, 0)
			warn("Planck: Error occurred while running hooks, this error will be ignored for 10 seconds")
			v_u_5.systemError(p_u_30, v_u_32, (("Error occurred while running hooks: %*"):format(v57)))
			v_u_13[v57] = true
		end
		if v_u_35 then
			coroutine.close(p_u_30._thread)
			p_u_30._thread = coroutine.create(function()
				-- upvalues: (copy) p_u_30
				while true do
					local v58 = coroutine.yield()
					p_u_30._yielded = true
					v58()
					p_u_30._yielded = false
				end
			end)
			coroutine.resume(p_u_30._thread)
		end
		p_u_30:_handleLogs(v_u_32)
	end
end
function v_u_15.runPhase(p59, p60) -- name: runPhase
	-- upvalues: (copy) v_u_5
	if p59:_canRun(p60) ~= false then
		v_u_5.phaseBegan(p59, p60)
		if not p59._phaseToSystems[p60] then
			p59._phaseToSystems[p60] = {}
		end
		for _, v61 in p59._phaseToSystems[p60] do
			p59:runSystem(v61)
		end
	end
end
function v_u_15.runPipeline(p62, p63) -- name: runPipeline
	if p62:_canRun(p63) ~= false then
		local v64 = p63.dependencyGraph:getOrderedList()
		local v65 = ("Pipeline %* contains a circular dependency, check it\'s Phases"):format(p63)
		assert(v64, v65)
		for _, v66 in v64 do
			p62:runPhase(v66)
		end
	end
end
function v_u_15._canRun(p67, p68) -- name: _canRun
	local v69 = p67._runIfConditions[p68]
	if v69 then
		for _, v70 in v69 do
			local v71 = p67._vargs
			if v70(table.unpack(v71)) == false then
				return false
			end
		end
	end
	return true
end
function v_u_15.run(p72, p73) -- name: run
	-- upvalues: (copy) v_u_2, (copy) v_u_7, (copy) v_u_9, (copy) v_u_10
	if not p73 then
		error("No dependent specified in Scheduler:run(_)")
	end
	p72:runPipeline(v_u_2.Startup)
	if v_u_7(p73) then
		p72:runSystem(p73)
		return p72
	elseif v_u_9(p73) then
		p72:runPhase(p73)
		return p72
	elseif v_u_10(p73) then
		p72:runPipeline(p73)
		return p72
	else
		error("Unknown dependent passed into Scheduler:run(unknown)")
		return p72
	end
end
function v_u_15.runAll(p74) -- name: runAll
	local v75 = p74._defaultDependencyGraph:getOrderedList()
	assert(v75, "Default Group contains a circular dependency, check your Pipelines/Phases")
	for _, v76 in v75 do
		p74:run(v76)
	end
	for v77, v78 in p74._eventDependencyGraphs do
		local v79 = v78:getOrderedList()
		local v80 = ("Event Group \'%*\' contains a circular dependency, check your Pipelines/Phases"):format(v77)
		assert(v75, v80)
		for _, v81 in v79 do
			p74:run(v81)
		end
	end
	return p74
end
function v_u_15.insert(p82, p83, p84, p85) -- name: insert
	-- upvalues: (copy) v_u_9, (copy) v_u_10, (copy) v_u_11, (copy) v_u_5
	local v86 = v_u_9(p83) or v_u_10(p83)
	assert(v86, "Unknown dependency passed to Scheduler:insert(unknown, _, _)")
	if p84 then
		local v87 = v_u_11(p84, p85)
		assert(v87, "Unknown instance/event passed to Scheduler:insert(_, instance, event)")
		p82:_getEventDependencyGraph(p84, p85):insert(p83)
	else
		p82._defaultDependencyGraph:insertBefore(p83, p82._defaultPhase)
	end
	if v_u_9(p83) then
		p82._phaseToSystems[p83] = {}
		v_u_5.phaseAdd(p82, p83)
	end
	return p82
end
function v_u_15.insertAfter(p88, p89, p90) -- name: insertAfter
	-- upvalues: (copy) v_u_9, (copy) v_u_10, (copy) v_u_5
	local v91 = v_u_9(p90) or v_u_10(p90)
	assert(v91, "Unknown dependency passed in Scheduler:insertAfter(_, unknown)")
	local v92 = v_u_9(p89) or v_u_10(p89)
	assert(v92, "Unknown dependent passed in Scheduler:insertAfter(unknown, _)")
	p88:_getGraphOfDependency(p90):insertAfter(p89, p90)
	if v_u_9(p89) then
		p88._phaseToSystems[p89] = {}
		v_u_5.phaseAdd(p88, p89)
	end
	return p88
end
function v_u_15.insertBefore(p93, p94, p95) -- name: insertBefore
	-- upvalues: (copy) v_u_9, (copy) v_u_10, (copy) v_u_5
	local v96 = v_u_9(p95) or v_u_10(p95)
	assert(v96, "Unknown dependency passed in Scheduler:insertBefore(_, unknown)")
	local v97 = v_u_9(p94) or v_u_10(p94)
	assert(v97, "Unknown dependent passed in Scheduler:insertBefore(unknown, _)")
	p93:_getGraphOfDependency(p95):insertBefore(p94, p95)
	if v_u_9(p94) then
		p93._phaseToSystems[p94] = {}
		v_u_5.phaseAdd(p93, p94)
	end
	return p93
end
function v_u_15.addSystem(p98, p99, p100) -- name: addSystem
	-- upvalues: (copy) v_u_7, (copy) v_u_8, (copy) v_u_5
	local v101 = v_u_7(p99)
	if not v101 then
		error("Unknown system passed to Scheduler:addSystem(unknown, phase?)")
	end
	local v102 = v_u_8(v101)
	if type(p99) == "table" and p99.name then
		v102 = p99.name
	end
	local v103 = {
		["system"] = v101,
		["phase"] = p100,
		["name"] = v102,
		["logs"] = {}
	}
	if not p100 then
		if type(p99) == "table" and p99.phase then
			v103.phase = p99.phase
		else
			v103.phase = p98._defaultPhase
		end
	end
	p98._systemInfo[v101] = v103
	if not p98._phaseToSystems[v103.phase] then
		p98._phaseToSystems[v103.phase] = {}
	end
	local v104 = p98._phaseToSystems[v103.phase]
	table.insert(v104, v101)
	v_u_5.systemAdd(p98, v103)
	if type(p99) == "table" and p99.runConditions then
		for _, v105 in p99.runConditions do
			p98:addRunCondition(v101, v105)
		end
	end
	return p98
end
function v_u_15.addSystems(p106, p107, p108) -- name: addSystems
	-- upvalues: (copy) v_u_7
	if type(p107) ~= "table" then
		error("Unknown systems passed to Scheduler:addSystems(unknown, phase?)")
	end
	local v109 = 0
	local v110 = false
	for _, v111 in p107 do
		v109 = v109 + 1
		if v_u_7(v111) then
			p106:addSystem(v111, p108)
			v110 = true
		end
	end
	if v109 == 0 then
		error("Empty table passed to Scheduler:addSystems({ }, phase?)")
	end
	if not v110 then
		error("Unknown table passed to Scheduler:addSystems({ unknown }, phase?)")
	end
	return p106
end
function v_u_15.editSystem(p112, p113, p114) -- name: editSystem
	-- upvalues: (copy) v_u_7
	local v115 = v_u_7(p113)
	local v116 = p112._systemInfo[v115]
	assert(v116, "Attempt to remove a non-exist system in Scheduler:removeSystem(_)")
	local _ = p114 and p112._phaseToSystems[p114] ~= nil
	local v117 = true
	assert(v117, "Phase never initialized before using Scheduler:editSystem(_, Phase)")
	local v118 = p112._phaseToSystems[v116.phase]
	local v119 = table.find(v118, v115)
	assert(v119, "Unable to find system within phase")
	table.remove(v118, v119)
	if not p112._phaseToSystems[p114] then
		p112._phaseToSystems[p114] = {}
	end
	local v120 = p112._phaseToSystems[p114]
	table.insert(v120, v115)
	v116.phase = p114
	return p112
end
function v_u_15._removeCondition(p121, p122, p123) -- name: _removeCondition
	-- upvalues: (copy) v_u_6
	p121._runIfConditions[p122] = nil
	for _, v124 in p121._runIfConditions do
		if table.find(v124, p123) then
			return
		end
	end
	v_u_6.cleanupCondition(p123)
end
function v_u_15.removeSystem(p125, p126) -- name: removeSystem
	-- upvalues: (copy) v_u_7, (copy) v_u_5
	local v127 = v_u_7(p126)
	local v128 = p125._systemInfo[v127]
	assert(v128, "Attempt to remove a non-exist system in Scheduler:removeSystem(_)")
	local v129 = p125._phaseToSystems[v128.phase]
	local v130 = table.find(v129, v127)
	assert(v130, "Unable to find system within phase")
	table.remove(v129, v130)
	p125._systemInfo[v127] = nil
	if p125._runIfConditions[p126] then
		for _, v131 in p125._runIfConditions[p126] do
			p125:_removeCondition(p126, v131)
		end
		p125._runIfConditions[p126] = nil
	end
	v_u_5.systemRemove(p125, v128)
	return p125
end
function v_u_15.replaceSystem(p132, p133, p134) -- name: replaceSystem
	-- upvalues: (copy) v_u_7, (copy) v_u_8, (copy) v_u_5
	local v135 = v_u_7(p133)
	local v136 = p132._systemInfo[v135]
	assert(v136, "Attempt to replace a non-existent system in Scheduler:replaceSystem(unknown, _)")
	local v137 = v_u_7(p134)
	assert(v137, "Attempt to pass non-system in Scheduler:replaceSystem(_, unknown)")
	local v138 = p132._phaseToSystems[v136.phase]
	local v139 = table.find(v138, v135)
	assert(v139, "Unable to find system within phase")
	table.remove(v138, v139)
	table.insert(v138, v139, v137)
	local v140 = table.clone(v136)
	v136.system = v137
	v136.name = v_u_8(v137)
	v_u_5.systemReplace(p132, v140, v136)
	p132._systemInfo[v137] = p132._systemInfo[v135]
	p132._systemInfo[v135] = nil
	return p132
end
function v_u_15.addRunCondition(p141, p142, p143) -- name: addRunCondition
	-- upvalues: (copy) v_u_7, (copy) v_u_9, (copy) v_u_10
	local v144 = v_u_7(p142)
	local v145 = v144 or p142
	local v146 = v144 or (v_u_9(v145) or v_u_10(v145))
	assert(v146, "Attempt to pass unknown dependent into Scheduler:addRunCondition(unknown, _)")
	if not p141._runIfConditions[v145] then
		p141._runIfConditions[v145] = {}
	end
	local v147 = p141._runIfConditions[v145]
	table.insert(v147, p143)
	return p141
end
function v_u_15._addBuiltins(p148) -- name: _addBuiltins
	-- upvalues: (copy) v_u_3, (copy) v_u_1, (copy) v_u_2, (copy) v_u_6
	p148._defaultPhase = v_u_3.new("Default")
	p148._defaultDependencyGraph = v_u_1.new()
	p148._defaultDependencyGraph:insert(v_u_2.Startup)
	p148._defaultDependencyGraph:insert(p148._defaultPhase)
	p148:addRunCondition(v_u_2.Startup, v_u_6.runOnce())
	for _, v149 in v_u_2.Startup.dependencyGraph.nodes do
		p148:addRunCondition(v149, v_u_6.runOnce())
	end
end
function v_u_15._scheduleEvent(p_u_150, p151, p152) -- name: _scheduleEvent
	-- upvalues: (copy) v_u_4, (copy) v_u_12, (copy) v_u_1, (ref) v_u_13
	local v153 = v_u_4.getConnectFunction(p151, p152)
	assert(v153, "Couldn\'t connect to event as no valid connect methods were found! Ensure the passed event has a \'Connect\' or an \'on\' method!")
	local v_u_154 = v_u_12(p151, p152)
	local v_u_155 = v_u_1.new()
	local function v159()
		-- upvalues: (copy) v_u_155, (copy) v_u_154, (ref) v_u_13, (copy) p_u_150
		local v156 = v_u_155:getOrderedList()
		if v156 == nil then
			local v157 = ("Event Group \'%*\' contains a circular dependency, check your Pipelines/Phases"):format(v_u_154)
			if not v_u_13[v157] then
				task.spawn(error, v157, 0)
				warn("Planck: Error occurred while running event, this error will be ignored for 10 seconds")
				v_u_13[v157] = true
			end
		end
		for _, v158 in v156 do
			p_u_150:run(v158)
		end
	end
	p_u_150._connectedEvents[v_u_154] = v153(v159)
	p_u_150._eventDependencyGraphs[v_u_154] = v_u_155
end
function v_u_15._getEventDependencyGraph(p160, p161, p162) -- name: _getEventDependencyGraph
	-- upvalues: (copy) v_u_12
	local v163 = v_u_12(p161, p162)
	if not p160._connectedEvents[v163] then
		p160:_scheduleEvent(p161, p162)
	end
	return p160._eventDependencyGraphs[v163]
end
function v_u_15._getGraphOfDependency(p164, p165) -- name: _getGraphOfDependency
	if table.find(p164._defaultDependencyGraph.nodes, p165) then
		return p164._defaultDependencyGraph
	end
	for _, v166 in p164._eventDependencyGraphs do
		if table.find(v166.nodes, p165) then
			return v166
		end
	end
	error("Dependency does not belong to a DependencyGraph")
end
function v_u_15.cleanup(p167) -- name: cleanup
	-- upvalues: (copy) v_u_4, (copy) v_u_6
	for _, v168 in p167._connectedEvents do
		v_u_4.disconnectEvent(v168)
	end
	for _, v169 in p167._plugins do
		if v169.cleanup then
			v169:cleanup()
		end
	end
	if p167._thread then
		coroutine.close(p167._thread)
	end
	for _, v170 in p167._runIfConditions do
		for _, v171 in v170 do
			v_u_6.cleanupCondition(v171)
		end
	end
end
function v_u_15.new(...) -- name: new
	-- upvalues: (copy) v_u_15, (copy) v_u_5
	local v172 = {
		["_hooks"] = {},
		["_vargs"] = { ... },
		["_eventDependencyGraphs"] = {},
		["_connectedEvents"] = {},
		["_phaseToSystems"] = {},
		["_systemInfo"] = {},
		["_runIfConditions"] = {},
		["_plugins"] = {}
	}
	local v173 = v_u_15
	setmetatable(v172, v173)
	for _, v174 in v_u_5.Hooks do
		if not v172._hooks[v174] then
			v172._hooks[v174] = {}
		end
	end
	v172:_addBuiltins()
	return v172
end
return v_u_15