local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = require(v1.Logging.parseError)
local v_u_4 = require(v1.Utility.isSimilar)
local v_u_5 = require(v1.Utility.never)
local v_u_6 = require(v1.Graph.depend)
local v_u_7 = require(v1.State.castToState)
local v_u_8 = require(v1.State.peek)
local v_u_9 = require(v1.Memory.doCleanup)
local v_u_10 = require(v1.Memory.deriveScope)
local v_u_11 = require(v1.Memory.checkLifetime)
local v_u_12 = require(v1.Memory.scopePool)
local v_u_13 = require(v1.Utility.nicknames)
local v14 = {
	["type"] = "State",
	["kind"] = "Computed",
	["timeliness"] = "lazy"
}
local v_u_15 = table.freeze({
	["__index"] = v14
})
function v14.get(_) -- name: get
	-- upvalues: (copy) v_u_2, (copy) v_u_5
	v_u_2.logError("stateGetWasRemoved")
	return v_u_5()
end
function v14._evaluate(p_u_16) -- name: _evaluate
	-- upvalues: (copy) v_u_10, (copy) v_u_7, (copy) v_u_11, (copy) v_u_6, (copy) v_u_8, (copy) v_u_3, (copy) v_u_12, (copy) v_u_4, (copy) v_u_9, (copy) v_u_2
	if p_u_16.scope == nil then
		return false
	end
	local v_u_17 = p_u_16.scope
	local v18 = v_u_10(v_u_17)
	local function v21(p19) -- name: use
		-- upvalues: (ref) v_u_7, (ref) v_u_11, (copy) v_u_17, (copy) p_u_16, (ref) v_u_6, (ref) v_u_8
		local v20 = v_u_7(p19)
		if v20 ~= nil then
			v_u_11.bOutlivesA(v_u_17, p_u_16.oldestTask, v20.scope, v20.oldestTask, v_u_11.formatters.useFunction)
			v_u_6(p_u_16, v20)
		end
		return v_u_8(p19)
	end
	local v22, v23 = xpcall(p_u_16._processor, v_u_3, v21, v18)
	local v24 = v_u_12.giveIfEmpty(v18)
	if not v22 then
		if v24 ~= nil then
			v_u_9(v24)
		end
		v_u_2.logErrorNonFatal("callbackError", v23)
		return false
	end
	local v25 = v_u_4(p_u_16._EXTREMELY_DANGEROUS_usedAsValue, v23)
	if p_u_16._innerScope ~= nil then
		v_u_9(p_u_16._innerScope)
	end
	p_u_16._innerScope = v24
	p_u_16._EXTREMELY_DANGEROUS_usedAsValue = v23
	return not v25
end
table.freeze(v14)
return function(p26, p27, p28) -- name: Computed
	-- upvalues: (copy) v_u_2, (copy) v_u_15, (copy) v_u_9, (copy) v_u_13
	local v29 = os.clock()
	if typeof(p26) == "function" then
		v_u_2.logError("scopeMissing", nil, "Computeds", "myScope:Computed(function(use, scope) ... end)")
	elseif p28 ~= nil then
		v_u_2.logWarn("destructorRedundant", "Computed")
	end
	local v30 = v_u_15
	local v_u_31 = setmetatable({
		["createdAt"] = nil,
		["dependencySet"] = nil,
		["dependentSet"] = nil,
		["lastChange"] = nil,
		["scope"] = nil,
		["validity"] = "invalid",
		["_EXTREMELY_DANGEROUS_usedAsValue"] = nil,
		["_innerScope"] = nil,
		["_processor"] = nil,
		["createdAt"] = v29,
		["dependencySet"] = {},
		["dependentSet"] = {},
		["scope"] = p26,
		["_processor"] = p27
	}, v30)
	local function v33()
		-- upvalues: (copy) v_u_31, (ref) v_u_9
		v_u_31.scope = nil
		for v32 in pairs(v_u_31.dependencySet) do
			v32.dependentSet[v_u_31] = nil
		end
		if v_u_31._innerScope ~= nil then
			v_u_9(v_u_31._innerScope)
		end
	end
	v_u_31.oldestTask = v33
	v_u_13[v_u_31.oldestTask] = "Computed"
	table.insert(p26, v33)
	return v_u_31
end