local v1 = script.Parent.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = require(v1.Graph.depend)
local v_u_4 = require(v1.State.peek)
local v_u_5 = require(v1.State.castToState)
require(v1.State.For.ForTypes)
local v_u_6 = require(v1.Memory.doCleanup)
local v_u_7 = require(v1.Memory.deriveScope)
local v_u_8 = require(v1.Memory.scopePool)
local v_u_9 = require(v1.Utility.nameOf)
local v_u_10 = require(v1.Utility.nicknames)
local v11 = {
	["type"] = "Graph",
	["kind"] = "For.Disassembly",
	["timeliness"] = "lazy"
}
local v_u_12 = table.freeze({
	["__index"] = v11
})
function v11.populate(p13, p14, p15) -- name: populate
	-- upvalues: (copy) v_u_2
	local v16 = (1 / 0)
	local v17 = (-1 / 0)
	local v18 = false
	for v19 in p13._subObjects do
		local v20, v21 = v19:useOutputPair(p14)
		if v20 == nil or v21 == nil then
			v18 = true
		elseif p15[v20] == nil then
			p15[v20] = v21
			if typeof(v20) == "number" then
				v16 = math.min(v16, v20)
				v17 = math.max(v17, v20)
			end
		else
			v_u_2.logErrorNonFatal("forKeyCollision", nil, (tostring(v20)))
		end
	end
	if v18 and v16 < v17 then
		for v22 = v16, v17 do
			local v23 = p15[v22]
			if v23 ~= nil then
				p15[v22] = nil
				p15[v16] = v23
				v16 = v16 + 1
			end
		end
	end
end
function v11._evaluate(p24) -- name: _evaluate
	-- upvalues: (copy) v_u_5, (copy) v_u_2, (copy) v_u_9, (copy) v_u_3, (copy) v_u_4, (copy) v_u_6, (copy) v_u_7, (copy) v_u_8
	local v25 = p24.scope
	local v26 = v_u_5(p24._inputTable)
	if v26 ~= nil then
		if v26.scope == nil then
			v_u_2.logError("useAfterDestroy", nil, ("The input %*"):format((v_u_9(v26, "table"))), "the For object that is watching it")
		end
		v_u_3(p24, v26)
	end
	local v27 = {}
	for v28, v29 in v_u_4(p24._inputTable) do
		v27[v28] = v29
	end
	local v30 = {}
	for v31 in p24._subObjects do
		local v32 = false
		local v33 = v31.inputKey
		local v34 = v31.inputValue
		local v35 = nil
		if v31.roamKeys or v27[v33] == nil then
			for v36, v37 in v27 do
				v32 = true
				if v31.roamValues or v37 == v34 then
					v35 = v36
					break
				end
				v35 = v36
			end
		else
			v35 = v33
			v32 = true
		end
		if v32 then
			local v38 = v27[v35]
			v30[v31] = true
			if v35 ~= v33 then
				v31.inputKey = v35
				v31:invalidateInputKey()
			end
			if v38 ~= v34 then
				v31.inputValue = v38
				v31:invalidateInputValue()
			end
			v27[v35] = nil
		elseif v31.maybeScope ~= nil then
			v_u_6(v31.maybeScope)
			v31.maybeScope = nil
		end
	end
	for v39, v40 in v27 do
		local v41 = p24._constructor(v_u_7(v25), v39, v40)
		if v41.maybeScope ~= nil then
			v41.maybeScope = v_u_8.giveIfEmpty(v41.maybeScope)
		end
		v30[v41] = true
	end
	p24._subObjects = v30
	return true
end
table.freeze(v11)
return function(p42, p43, p44) -- name: Disassembly
	-- upvalues: (copy) v_u_12, (copy) v_u_6, (copy) v_u_10
	local v45 = {
		["createdAt"] = nil,
		["dependencySet"] = nil,
		["dependentSet"] = nil,
		["scope"] = nil,
		["validity"] = "invalid",
		["_inputTable"] = nil,
		["_constructor"] = nil,
		["_subObjects"] = nil,
		["createdAt"] = os.clock(),
		["dependencySet"] = {},
		["dependentSet"] = {},
		["scope"] = p42,
		["_inputTable"] = p43,
		["_constructor"] = p44,
		["_subObjects"] = {}
	}
	local v46 = v_u_12
	local v_u_47 = setmetatable(v45, v46)
	local function v50()
		-- upvalues: (copy) v_u_47, (ref) v_u_6
		v_u_47.scope = nil
		for v48 in pairs(v_u_47.dependencySet) do
			v48.dependentSet[v_u_47] = nil
		end
		for v49 in v_u_47._subObjects do
			if v49.maybeScope ~= nil then
				v_u_6(v49.maybeScope)
				v49.maybeScope = nil
			end
		end
	end
	v_u_47.oldestTask = v50
	v_u_10[v_u_47.oldestTask] = "For (internal disassembler)"
	table.insert(p42, v50)
	return v_u_47
end