local v1 = script.Parent.Parent
require(v1.PubTypes)
require(v1.Types)
local v_u_2 = require(v1.Dependencies.captureDependencies)
local v_u_3 = require(v1.Dependencies.initDependency)
local v_u_4 = require(v1.Dependencies.useDependency)
local v_u_5 = require(v1.Logging.parseError)
local v_u_6 = require(v1.Logging.logErrorNonFatal)
local v_u_7 = require(v1.Logging.logWarn)
local v_u_8 = require(v1.Utility.cleanup)
local v_u_9 = require(v1.Utility.needsDestruction)
local v10 = {}
local v_u_11 = {
	["__index"] = v10
}
local v_u_12 = {
	["__mode"] = "k"
}
function v10.get(p13, p14) -- name: get
	-- upvalues: (copy) v_u_4
	if p14 ~= false then
		v_u_4(p13)
	end
	return p13._outputTable
end
function v10.update(p15) -- name: update
	-- upvalues: (copy) v_u_12, (copy) v_u_2, (copy) v_u_9, (copy) v_u_7, (copy) v_u_8, (copy) v_u_5, (copy) v_u_6
	local v16 = p15._inputIsState
	local v17
	if v16 then
		v17 = p15._inputTable:get(false)
	else
		v17 = p15._inputTable
	end
	local v18 = p15._valueCache
	local v19 = p15._oldValueCache
	p15._oldValueCache = v18
	p15._valueCache = v19
	local v20 = p15._valueCache
	local v21 = p15._oldValueCache
	table.clear(v20)
	local v22 = {}
	local v23 = false
	for v24 in pairs(p15.dependencySet) do
		v24.dependentSet[p15] = nil
	end
	local v25 = p15.dependencySet
	local v26 = p15._oldDependencySet
	p15._oldDependencySet = v25
	p15.dependencySet = v26
	table.clear(p15.dependencySet)
	if v16 then
		p15._inputTable.dependentSet[p15] = true
		p15.dependencySet[p15._inputTable] = true
	end
	for v27, v28 in pairs(v17) do
		local v29 = v21[v28]
		local v30 = v29 == nil
		local v31 = nil
		local v32 = nil
		local v33 = nil
		if type(v29) == "table" and #v29 > 0 then
			local v34 = table.remove(v29, #v29)
			v31 = v34.value
			v32 = v34.valueData
			v33 = v34.meta
			if #v29 <= 0 then
				v21[v28] = nil
			end
		elseif v29 ~= nil then
			v21[v28] = nil
			v30 = true
		end
		if v32 == nil then
			v32 = {}
			local v35 = v_u_12
			v32.dependencySet = setmetatable({}, v35)
			local v36 = v_u_12
			v32.oldDependencySet = setmetatable({}, v36)
			local v37 = v_u_12
			v32.dependencyValues = setmetatable({}, v37)
		end
		if v30 == false then
			for v38, v39 in pairs(v32.dependencyValues) do
				if v39 ~= v38:get(false) then
					v30 = true
					break
				end
			end
		end
		local v40, v41
		if v30 then
			local v42 = v32.dependencySet
			local v43 = v32.oldDependencySet
			v32.oldDependencySet = v42
			v32.dependencySet = v43
			table.clear(v32.dependencySet)
			local v44
			v44, v40, v41 = v_u_2(v32.dependencySet, p15._processor, v28)
			if v44 then
				if p15._destructor == nil and (v_u_9(v40) or v_u_9(v41)) then
					v_u_7("destructorNeededForValues")
				end
				if v31 == nil then
					v23 = true
				else
					local v45, v46 = xpcall(p15._destructor or v_u_8, v_u_5, v31, v33)
					if v45 then
						v23 = true
					else
						v_u_6("forValuesDestructorError", v46)
						v23 = true
					end
				end
			else
				local v47 = v32.dependencySet
				local v48 = v32.oldDependencySet
				v32.oldDependencySet = v47
				v32.dependencySet = v48
				v_u_6("forValuesProcessorError", v40)
				v41 = v33
				v40 = v31
			end
		else
			v41 = v33
			v40 = v31
		end
		local v49 = v20[v28]
		if v49 == nil then
			v49 = {}
			v20[v28] = v49
		end
		table.insert(v49, {
			["value"] = v40,
			["valueData"] = v32,
			["meta"] = v41
		})
		v22[v27] = v40
		for v50 in pairs(v32.dependencySet) do
			v32.dependencyValues[v50] = v50:get(false)
			p15.dependencySet[v50] = true
			v50.dependentSet[p15] = true
		end
	end
	for _, v51 in pairs(v21) do
		for _, v52 in ipairs(v51) do
			local v53 = v52.value
			local v54 = v52.meta
			local v55, v56 = xpcall(p15._destructor or v_u_8, v_u_5, v53, v54)
			if not v55 then
				v_u_6("forValuesDestructorError", v56)
			end
			v23 = true
		end
		table.clear(v51)
	end
	p15._outputTable = v22
	return v23
end
return function(p57, p58, p59) -- name: ForValues
	-- upvalues: (copy) v_u_12, (copy) v_u_11, (copy) v_u_3
	local v60
	if p57.type == "State" then
		local v61 = p57.get
		v60 = typeof(v61) == "function"
	else
		v60 = false
	end
	local v62 = {
		["type"] = "State",
		["kind"] = "ForValues",
		["dependencySet"] = nil,
		["dependentSet"] = nil,
		["_oldDependencySet"] = nil,
		["_processor"] = nil,
		["_destructor"] = nil,
		["_inputIsState"] = nil,
		["_inputTable"] = nil,
		["_outputTable"] = nil,
		["_valueCache"] = nil,
		["_oldValueCache"] = nil,
		["dependencySet"] = {}
	}
	local v63 = v_u_12
	v62.dependentSet = setmetatable({}, v63)
	v62._oldDependencySet = {}
	v62._processor = p58
	v62._destructor = p59
	v62._inputIsState = v60
	v62._inputTable = p57
	v62._outputTable = {}
	v62._valueCache = {}
	v62._oldValueCache = {}
	local v64 = v_u_11
	local v65 = setmetatable(v62, v64)
	v_u_3(v65)
	v65:update()
	return v65
end