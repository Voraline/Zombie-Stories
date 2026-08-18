local v1 = script.Parent.Parent
require(v1.PubTypes)
require(v1.Types)
local v_u_2 = require(v1.Dependencies.captureDependencies)
local v_u_3 = require(v1.Dependencies.initDependency)
local v_u_4 = require(v1.Dependencies.useDependency)
local v_u_5 = require(v1.Logging.parseError)
local v_u_6 = require(v1.Logging.logErrorNonFatal)
local v_u_7 = require(v1.Logging.logError)
local v_u_8 = require(v1.Logging.logWarn)
local v_u_9 = require(v1.Utility.cleanup)
local v_u_10 = require(v1.Utility.needsDestruction)
local v11 = {}
local v_u_12 = {
	["__index"] = v11
}
local v_u_13 = {
	["__mode"] = "k"
}
function v11.get(p14, p15) -- name: get
	-- upvalues: (copy) v_u_4
	if p15 ~= false then
		v_u_4(p14)
	end
	return p14._outputTable
end
function v11.update(p16) -- name: update
	-- upvalues: (copy) v_u_13, (copy) v_u_2, (copy) v_u_10, (copy) v_u_8, (copy) v_u_7, (copy) v_u_9, (copy) v_u_5, (copy) v_u_6
	local v17 = p16._inputIsState
	local v18
	if v17 then
		v18 = p16._inputTable:get(false)
	else
		v18 = p16._inputTable
	end
	local v19 = p16._oldInputTable
	local v20 = p16._outputTable
	local v21 = p16._keyOIMap
	local v22 = p16._keyIOMap
	local v23 = p16._meta
	local v24 = false
	for v25 in pairs(p16.dependencySet) do
		v25.dependentSet[p16] = nil
	end
	local v26 = p16.dependencySet
	local v27 = p16._oldDependencySet
	p16._oldDependencySet = v26
	p16.dependencySet = v27
	table.clear(p16.dependencySet)
	if v17 then
		p16._inputTable.dependentSet[p16] = true
		p16.dependencySet[p16._inputTable] = true
	end
	for v28, v29 in pairs(v18) do
		local v30 = p16._keyData[v28]
		if v30 == nil then
			v30 = {}
			local v31 = v_u_13
			v30.dependencySet = setmetatable({}, v31)
			local v32 = v_u_13
			v30.oldDependencySet = setmetatable({}, v32)
			local v33 = v_u_13
			v30.dependencyValues = setmetatable({}, v33)
			p16._keyData[v28] = v30
		end
		local v34 = v19[v28] == nil
		if v34 == false then
			for v35, v36 in pairs(v30.dependencyValues) do
				if v36 ~= v35:get(false) then
					v34 = true
					break
				end
			end
		end
		if v34 then
			local v37 = v30.dependencySet
			local v38 = v30.oldDependencySet
			v30.oldDependencySet = v37
			v30.dependencySet = v38
			table.clear(v30.dependencySet)
			local v39, v40, v41 = v_u_2(v30.dependencySet, p16._processor, v28)
			if v39 then
				if p16._destructor == nil and (v_u_10(v40) or v_u_10(v41)) then
					v_u_8("destructorNeededForKeys")
				end
				local v42 = v21[v40]
				local v43 = v22[v28]
				if v42 ~= v28 and v18[v42] ~= nil then
					v_u_7("forKeysKeyCollision", nil, tostring(v40), tostring(v42), (tostring(v40)))
				end
				if v43 ~= v40 and v21[v43] == v28 then
					local v44 = v23[v43]
					local v45, v46 = xpcall(p16._destructor or v_u_9, v_u_5, v43, v44)
					if not v45 then
						v_u_6("forKeysDestructorError", v46)
					end
					v21[v43] = nil
					v20[v43] = nil
					v23[v43] = nil
				end
				v19[v28] = v29
				v23[v40] = v41
				v21[v40] = v28
				v22[v28] = v40
				v20[v40] = v29
				v24 = true
			else
				local v47 = v30.dependencySet
				local v48 = v30.oldDependencySet
				v30.oldDependencySet = v47
				v30.dependencySet = v48
				v_u_6("forKeysProcessorError", v40)
			end
		end
		for v49 in pairs(v30.dependencySet) do
			v30.dependencyValues[v49] = v49:get(false)
			p16.dependencySet[v49] = true
			v49.dependentSet[p16] = true
		end
	end
	for v50, v51 in pairs(v21) do
		if v18[v51] == nil then
			local v52 = v23[v50]
			local v53, v54 = xpcall(p16._destructor or v_u_9, v_u_5, v50, v52)
			if not v53 then
				v_u_6("forKeysDestructorError", v54)
			end
			v19[v51] = nil
			v23[v50] = nil
			v21[v50] = nil
			v22[v51] = nil
			v20[v50] = nil
			p16._keyData[v51] = nil
			v24 = true
		end
	end
	return v24
end
return function(p55, p56, p57) -- name: ForKeys
	-- upvalues: (copy) v_u_13, (copy) v_u_12, (copy) v_u_3
	local v58
	if p55.type == "State" then
		local v59 = p55.get
		v58 = typeof(v59) == "function"
	else
		v58 = false
	end
	local v60 = {
		["type"] = "State",
		["kind"] = "ForKeys",
		["dependencySet"] = nil,
		["dependentSet"] = nil,
		["_oldDependencySet"] = nil,
		["_processor"] = nil,
		["_destructor"] = nil,
		["_inputIsState"] = nil,
		["_inputTable"] = nil,
		["_oldInputTable"] = nil,
		["_outputTable"] = nil,
		["_keyOIMap"] = nil,
		["_keyIOMap"] = nil,
		["_keyData"] = nil,
		["_meta"] = nil,
		["dependencySet"] = {}
	}
	local v61 = v_u_13
	v60.dependentSet = setmetatable({}, v61)
	v60._oldDependencySet = {}
	v60._processor = p56
	v60._destructor = p57
	v60._inputIsState = v58
	v60._inputTable = p55
	v60._oldInputTable = {}
	v60._outputTable = {}
	v60._keyOIMap = {}
	v60._keyIOMap = {}
	v60._keyData = {}
	v60._meta = {}
	local v62 = v_u_12
	local v63 = setmetatable(v60, v62)
	v_u_3(v63)
	v63:update()
	return v63
end