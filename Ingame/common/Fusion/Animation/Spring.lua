local v1 = script.Parent.Parent
require(v1.PubTypes)
require(v1.Types)
local v_u_2 = require(v1.Logging.logError)
local v_u_3 = require(v1.Logging.logErrorNonFatal)
local v_u_4 = require(v1.Animation.unpackType)
local v_u_5 = require(v1.Animation.SpringScheduler)
local v_u_6 = require(v1.Dependencies.useDependency)
local v_u_7 = require(v1.Dependencies.initDependency)
local v_u_8 = require(v1.Dependencies.updateAll)
local v_u_9 = require(v1.Utility.xtypeof)
local v_u_10 = require(v1.State.unwrap)
local v11 = {}
local v_u_12 = {
	["__index"] = v11
}
local v_u_13 = {
	["__mode"] = "k"
}
function v11.get(p14, p15) -- name: get
	-- upvalues: (copy) v_u_6
	if p15 ~= false then
		v_u_6(p14)
	end
	return p14._currentValue
end
function v11.setPosition(p16, p17) -- name: setPosition
	-- upvalues: (copy) v_u_2, (copy) v_u_4, (copy) v_u_5, (copy) v_u_8
	local v18 = typeof(p17)
	if v18 ~= p16._currentType then
		v_u_2("springTypeMismatch", nil, v18, p16._currentType)
	end
	p16._springPositions = v_u_4(p17, v18)
	p16._currentValue = p17
	v_u_5.add(p16)
	v_u_8(p16)
end
function v11.setVelocity(p19, p20) -- name: setVelocity
	-- upvalues: (copy) v_u_2, (copy) v_u_4, (copy) v_u_5
	local v21 = typeof(p20)
	if v21 ~= p19._currentType then
		v_u_2("springTypeMismatch", nil, v21, p19._currentType)
	end
	p19._springVelocities = v_u_4(p20, v21)
	v_u_5.add(p19)
end
function v11.addVelocity(p22, p23) -- name: addVelocity
	-- upvalues: (copy) v_u_2, (copy) v_u_4, (copy) v_u_5
	local v24 = typeof(p23)
	if v24 ~= p22._currentType then
		v_u_2("springTypeMismatch", nil, v24, p22._currentType)
	end
	local v25 = v_u_4(p23, v24)
	for v26, v27 in ipairs(v25) do
		local v28 = p22._springVelocities
		v28[v26] = v28[v26] + v27
	end
	v_u_5.add(p22)
end
function v11.update(p29) -- name: update
	-- upvalues: (copy) v_u_10, (copy) v_u_3, (copy) v_u_4, (copy) v_u_5
	local v30 = p29._goalState:get(false)
	if v30 == p29._goalValue then
		local v31 = v_u_10(p29._damping)
		if typeof(v31) == "number" then
			if v31 < 0 then
				v_u_3("invalidSpringDamping", nil, v31)
			else
				p29._currentDamping = v31
			end
		else
			v_u_3("mistypedSpringDamping", nil, (typeof(v31)))
		end
		local v32 = v_u_10(p29._speed)
		if typeof(v32) == "number" then
			if v32 < 0 then
				v_u_3("invalidSpringSpeed", nil, v32)
			else
				p29._currentSpeed = v32
			end
		else
			v_u_3("mistypedSpringSpeed", nil, (typeof(v32)))
		end
		return false
	else
		p29._goalValue = v30
		local v33 = p29._currentType
		local v34 = typeof(v30)
		p29._currentType = v34
		local v35 = v_u_4(v30, v34)
		local v36 = #v35
		p29._springGoals = v35
		if v34 == v33 then
			if v36 == 0 then
				p29._currentValue = p29._goalValue
				return true
			else
				v_u_5.add(p29)
				return false
			end
		else
			p29._currentValue = p29._goalValue
			local v37 = table.create(v36, 0)
			local v38 = table.create(v36, 0)
			for v39, v40 in ipairs(v35) do
				v37[v39] = v40
			end
			p29._springPositions = v37
			p29._springVelocities = v38
			v_u_5.remove(p29)
			return true
		end
	end
end
return function(p41, p42, p43) -- name: Spring
	-- upvalues: (copy) v_u_9, (copy) v_u_13, (copy) v_u_10, (copy) v_u_12, (copy) v_u_7
	local v44 = p42 == nil and 10 or p42
	local v45 = p43 == nil and 1 or p43
	local v46 = {
		[p41] = true
	}
	if v_u_9(v44) == "State" then
		v46[v44] = true
	end
	if v_u_9(v45) == "State" then
		v46[v45] = true
	end
	local v47 = {
		["type"] = "State",
		["kind"] = "Spring",
		["dependencySet"] = nil,
		["dependentSet"] = nil,
		["_speed"] = nil,
		["_damping"] = nil,
		["_goalState"] = nil,
		["_goalValue"] = nil,
		["_currentType"] = nil,
		["_currentValue"] = nil,
		["_currentSpeed"] = nil,
		["_currentDamping"] = nil,
		["_springPositions"] = nil,
		["_springGoals"] = nil,
		["_springVelocities"] = nil,
		["dependencySet"] = v46
	}
	local v48 = v_u_13
	v47.dependentSet = setmetatable({}, v48)
	v47._speed = v44
	v47._damping = v45
	v47._goalState = p41
	v47._currentSpeed = v_u_10(v44)
	v47._currentDamping = v_u_10(v45)
	local v49 = v_u_12
	local v50 = setmetatable(v47, v49)
	v_u_7(v50)
	p41.dependentSet[v50] = true
	v50:update()
	return v50
end