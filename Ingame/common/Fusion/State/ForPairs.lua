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
	local v20 = p16._keyIOMap
	local v21 = p16._meta
	local v22 = false
	for v23 in pairs(p16.dependencySet) do
		v23.dependentSet[p16] = nil
	end
	local v24 = p16.dependencySet
	local v25 = p16._oldDependencySet
	p16._oldDependencySet = v24
	p16.dependencySet = v25
	table.clear(p16.dependencySet)
	if v17 then
		p16._inputTable.dependentSet[p16] = true
		p16.dependencySet[p16._inputTable] = true
	end
	local v26 = p16._outputTable
	local v27 = p16._oldOutputTable
	p16._oldOutputTable = v26
	p16._outputTable = v27
	local v28 = p16._oldOutputTable
	local v29 = p16._outputTable
	table.clear(v29)
	for v30, v31 in pairs(v18) do
		local v32 = p16._keyData[v30]
		if v32 == nil then
			v32 = {}
			local v33 = v_u_13
			v32.dependencySet = setmetatable({}, v33)
			local v34 = v_u_13
			v32.oldDependencySet = setmetatable({}, v34)
			local v35 = v_u_13
			v32.dependencyValues = setmetatable({}, v35)
			p16._keyData[v30] = v32
		end
		local v36 = v19[v30] ~= v31
		if v36 == false then
			for v37, v38 in pairs(v32.dependencyValues) do
				if v38 ~= v37:get(false) then
					v36 = true
					break
				end
			end
		end
		if v36 then
			local v39 = v32.dependencySet
			local v40 = v32.oldDependencySet
			v32.oldDependencySet = v39
			v32.dependencySet = v40
			table.clear(v32.dependencySet)
			local v41, v42, v43, v44 = v_u_2(v32.dependencySet, p16._processor, v30, v31)
			if v41 then
				if p16._destructor == nil and (v_u_10(v42) or (v_u_10(v43) or v_u_10(v44))) then
					v_u_8("destructorNeededForPairs")
				end
				if v29[v42] ~= nil then
					local v45 = nil
					local v46 = nil
					for v47, v48 in pairs(v20) do
						if v48 == v42 then
							v45 = v18[v47]
							if v45 ~= nil then
								v46 = v47
								break
							end
						end
					end
					if v46 ~= nil then
						v_u_7("forPairsKeyCollision", nil, tostring(v42), tostring(v46), tostring(v45), tostring(v30), (tostring(v31)))
					end
				end
				local v49 = v28[v42]
				if v49 ~= v43 then
					local v50 = v21[v42]
					if v49 ~= nil then
						local v51, v52 = xpcall(p16._destructor or v_u_9, v_u_5, v42, v49, v50)
						if not v51 then
							v_u_6("forPairsDestructorError", v52)
						end
					end
					v28[v42] = nil
				end
				v19[v30] = v31
				v20[v30] = v42
				v21[v42] = v44
				v29[v42] = v43
				v22 = true
			else
				local v53 = v32.dependencySet
				local v54 = v32.oldDependencySet
				v32.oldDependencySet = v53
				v32.dependencySet = v54
				v_u_6("forPairsProcessorError", v42)
			end
		else
			local v55 = v20[v30]
			if v29[v55] ~= nil then
				local v56 = nil
				local v57 = nil
				for v58, v59 in pairs(v20) do
					if v55 == v59 then
						v56 = v18[v58]
						if v56 ~= nil then
							v57 = v58
							break
						end
					end
				end
				if v57 ~= nil then
					v_u_7("forPairsKeyCollision", nil, tostring(v55), tostring(v57), tostring(v56), tostring(v30), (tostring(v31)))
				end
			end
			v29[v55] = v28[v55]
		end
		for v60 in pairs(v32.dependencySet) do
			v32.dependencyValues[v60] = v60:get(false)
			p16.dependencySet[v60] = true
			v60.dependentSet[p16] = true
		end
	end
	for v61, v62 in pairs(v28) do
		if v29[v61] ~= v62 then
			local v63 = v21[v61]
			if v62 ~= nil then
				local v64, v65 = xpcall(p16._destructor or v_u_9, v_u_5, v61, v62, v63)
				if not v64 then
					v_u_6("forPairsDestructorError", v65)
				end
			end
			if v29[v61] == nil then
				v21[v61] = nil
				p16._keyData[v61] = nil
			end
			v22 = true
		end
	end
	for v66 in pairs(v19) do
		if v18[v66] == nil then
			v19[v66] = nil
			v20[v66] = nil
		end
	end
	return v22
end
return function(p67, p68, p69) -- name: ForPairs
	-- upvalues: (copy) v_u_13, (copy) v_u_12, (copy) v_u_3
	local v70
	if p67.type == "State" then
		local v71 = p67.get
		v70 = typeof(v71) == "function"
	else
		v70 = false
	end
	local v72 = {
		["type"] = "State",
		["kind"] = "ForPairs",
		["dependencySet"] = nil,
		["dependentSet"] = nil,
		["_oldDependencySet"] = nil,
		["_processor"] = nil,
		["_destructor"] = nil,
		["_inputIsState"] = nil,
		["_inputTable"] = nil,
		["_oldInputTable"] = nil,
		["_outputTable"] = nil,
		["_oldOutputTable"] = nil,
		["_keyIOMap"] = nil,
		["_keyData"] = nil,
		["_meta"] = nil,
		["dependencySet"] = {}
	}
	local v73 = v_u_13
	v72.dependentSet = setmetatable({}, v73)
	v72._oldDependencySet = {}
	v72._processor = p68
	v72._destructor = p69
	v72._inputIsState = v70
	v72._inputTable = p67
	v72._oldInputTable = {}
	v72._outputTable = {}
	v72._oldOutputTable = {}
	v72._keyIOMap = {}
	v72._keyData = {}
	v72._meta = {}
	local v74 = v_u_12
	local v75 = setmetatable(v72, v74)
	v_u_3(v75)
	v75:update()
	return v75
end