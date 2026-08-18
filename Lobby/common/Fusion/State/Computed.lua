local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.Dependencies.captureDependencies)
local v_u_3 = require(v1.Dependencies.initDependency)
local v_u_4 = require(v1.Dependencies.useDependency)
local v_u_5 = require(v1.Logging.logErrorNonFatal)
local v_u_6 = require(v1.Logging.logWarn)
local v_u_7 = require(v1.Utility.isSimilar)
local v_u_8 = require(v1.Utility.needsDestruction)
local v9 = {}
local v_u_10 = {
	["__index"] = v9
}
local v_u_11 = {
	["__mode"] = "k"
}
function v9.get(p12, p13) -- name: get
	-- upvalues: (copy) v_u_4
	if p13 ~= false then
		v_u_4(p12)
	end
	return p12._value
end
function v9.update(p14) -- name: update
	-- upvalues: (copy) v_u_2, (copy) v_u_8, (copy) v_u_6, (copy) v_u_7, (copy) v_u_5
	for v15 in pairs(p14.dependencySet) do
		v15.dependentSet[p14] = nil
	end
	local v16 = p14.dependencySet
	local v17 = p14._oldDependencySet
	p14._oldDependencySet = v16
	p14.dependencySet = v17
	table.clear(p14.dependencySet)
	local v18, v19, v20 = v_u_2(p14.dependencySet, p14._processor)
	if not v18 then
		v_u_5("computedCallbackError", v19)
		local v21 = p14.dependencySet
		local v22 = p14._oldDependencySet
		p14._oldDependencySet = v21
		p14.dependencySet = v22
		for v23 in pairs(p14.dependencySet) do
			v23.dependentSet[p14] = true
		end
		return false
	end
	if p14._destructor == nil and v_u_8(v19) then
		v_u_6("destructorNeededComputed")
	end
	if v20 ~= nil then
		v_u_6("multiReturnComputed")
	end
	local v24 = p14._value
	local v25 = v_u_7(v24, v19)
	if p14._destructor ~= nil then
		p14._destructor(v24)
	end
	p14._value = v19
	for v26 in pairs(p14.dependencySet) do
		v26.dependentSet[p14] = true
	end
	return not v25
end
return function(p27, p28) -- name: Computed
	-- upvalues: (copy) v_u_11, (copy) v_u_10, (copy) v_u_3
	local v29 = {
		["type"] = "State",
		["kind"] = "Computed",
		["dependencySet"] = nil,
		["dependentSet"] = nil,
		["_oldDependencySet"] = nil,
		["_processor"] = nil,
		["_destructor"] = nil,
		["_value"] = nil,
		["dependencySet"] = {}
	}
	local v30 = v_u_11
	v29.dependentSet = setmetatable({}, v30)
	v29._oldDependencySet = {}
	v29._processor = p27
	v29._destructor = p28
	local v31 = v_u_10
	local v32 = setmetatable(v29, v31)
	v_u_3(v32)
	v32:update()
	return v32
end