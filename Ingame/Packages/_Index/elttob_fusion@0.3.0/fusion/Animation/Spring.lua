local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = require(v1.Memory.checkLifetime)
local v_u_4 = require(v1.Graph.depend)
local v_u_5 = require(v1.Graph.change)
local v_u_6 = require(v1.Graph.evaluate)
local v_u_7 = require(v1.State.castToState)
local v_u_8 = require(v1.State.peek)
local v_u_9 = require(v1.Animation.ExternalTime)
local v_u_10 = require(v1.Animation.Stopwatch)
local v_u_11 = require(v1.Animation.packType)
local v_u_12 = require(v1.Animation.unpackType)
local v_u_13 = require(v1.Animation.springCoefficients)
local v_u_14 = require(v1.Utility.nicknames)
local v15 = {
	["type"] = "State",
	["kind"] = "Spring",
	["timeliness"] = "eager"
}
local v_u_16 = table.freeze({
	["__index"] = v15
})
function v15.addVelocity(p17, p18) -- name: addVelocity
	-- upvalues: (copy) v_u_6, (copy) v_u_2, (copy) v_u_12, (copy) v_u_5
	v_u_6(p17, false)
	local v19 = typeof(p18)
	if v19 ~= p17._activeType then
		v_u_2.logError("springTypeMismatch", nil, v19, p17._activeType)
	end
	local v20 = v_u_12(p18, v19)
	for v21, v22 in p17._activeLatestV do
		v20[v21] = v20[v21] + v22
	end
	p17._activeStartP = table.clone(p17._activeLatestP)
	p17._activeStartV = v20
	p17._stopwatch:zero()
	p17._stopwatch:unpause()
	v_u_5(p17)
end
function v15.get(_) -- name: get
	-- upvalues: (copy) v_u_2
	return v_u_2.logError("stateGetWasRemoved")
end
function v15.setPosition(p23, p24) -- name: setPosition
	-- upvalues: (copy) v_u_6, (copy) v_u_2, (copy) v_u_12, (copy) v_u_5
	v_u_6(p23, false)
	local v25 = typeof(p24)
	if v25 ~= p23._activeType then
		v_u_2.logError("springTypeMismatch", nil, v25, p23._activeType)
	end
	p23._activeStartP = v_u_12(p24, v25)
	p23._activeStartV = table.clone(p23._activeLatestV)
	p23._stopwatch:zero()
	p23._stopwatch:unpause()
	v_u_5(p23)
end
function v15.setVelocity(p26, p27) -- name: setVelocity
	-- upvalues: (copy) v_u_6, (copy) v_u_2, (copy) v_u_12, (copy) v_u_5
	v_u_6(p26, false)
	local v28 = typeof(p27)
	if v28 ~= p26._activeType then
		v_u_2.logError("springTypeMismatch", nil, v28, p26._activeType)
	end
	p26._activeStartP = table.clone(p26._activeLatestP)
	p26._activeStartV = v_u_12(p27, v28)
	p26._stopwatch:zero()
	p26._stopwatch:unpause()
	v_u_5(p26)
end
function v15._evaluate(p29) -- name: _evaluate
	-- upvalues: (copy) v_u_7, (copy) v_u_8, (copy) v_u_2, (copy) v_u_4, (copy) v_u_13, (copy) v_u_11, (copy) v_u_12
	local v30 = v_u_7(p29._goal)
	if v30 == nil then
		p29._EXTREMELY_DANGEROUS_usedAsValue = p29._goal
		return false
	end
	local v31 = v_u_8(v30)
	if v31 ~= v31 then
		v_u_2.logWarn("springNanGoal")
		return false
	end
	local v32 = typeof(v31)
	local v33 = v32 ~= p29._activeType
	local v34 = p29._stopwatch
	local v35 = v_u_8(v34)
	v_u_4(p29, v34)
	local v36 = p29._EXTREMELY_DANGEROUS_usedAsValue
	local v37
	if v33 then
		v37 = v31
	elseif v35 <= 0 then
		v37 = v36
	else
		local v38, v39, v40, v41 = v_u_13(v35, p29._activeDamping, p29._activeSpeed)
		local v42 = false
		for v43 = 1, p29._activeNumSprings do
			local v44 = p29._activeStartP[v43]
			local v45 = p29._activeTargetP[v43]
			local v46 = p29._activeStartV[v43]
			local v47 = v44 - v45
			local v48 = v47 * v38 + v46 * v39
			local v49 = v47 * v40 + v46 * v41
			if v48 ~= v48 or v49 ~= v49 then
				v_u_2.logWarn("springNanMotion")
				v48 = 0
				v49 = 0
			end
			v42 = (math.abs(v48) > 0.00001 or math.abs(v49) > 0.00001) and true or v42
			local v50 = v48 + v45
			p29._activeLatestP[v43] = v50
			p29._activeLatestV[v43] = v49
		end
		if not v42 then
			for v51 = 1, p29._activeNumSprings do
				p29._activeLatestP[v51] = p29._activeTargetP[v51]
			end
		end
		v37 = v_u_11(p29._activeLatestP, p29._activeType)
	end
	local v52 = v_u_8(p29._speed)
	local v53 = v_u_8(p29._damping)
	if v33 or (v31 ~= p29._activeGoal or (v52 ~= p29._activeSpeed or v53 ~= p29._activeDamping)) then
		p29._activeTargetP = v_u_12(v31, v32)
		p29._activeNumSprings = #p29._activeTargetP
		if v33 then
			p29._activeStartP = table.clone(p29._activeTargetP)
			p29._activeLatestP = table.clone(p29._activeTargetP)
			p29._activeStartV = table.create(p29._activeNumSprings, 0)
			p29._activeLatestV = table.create(p29._activeNumSprings, 0)
		else
			p29._activeStartP = table.clone(p29._activeLatestP)
			p29._activeStartV = table.clone(p29._activeLatestV)
		end
		p29._activeType = v32
		p29._activeGoal = v31
		p29._activeDamping = v53
		p29._activeSpeed = v52
		v34:zero()
		v34:unpause()
	end
	p29._EXTREMELY_DANGEROUS_usedAsValue = v37
	return v36 ~= v37
end
table.freeze(v15)
return function(p54, p55, p56, p57) -- name: Spring
	-- upvalues: (copy) v_u_7, (copy) v_u_2, (copy) v_u_10, (copy) v_u_9, (copy) v_u_8, (copy) v_u_16, (copy) v_u_14, (copy) v_u_3, (copy) v_u_6
	local v58 = os.clock()
	if typeof(p54) ~= "table" or v_u_7(p54) ~= nil then
		v_u_2.logError("scopeMissing", nil, "Springs", "myScope:Spring(goalState, speed, damping)")
	end
	local v59 = v_u_7(p55)
	local v60
	if v59 == nil then
		v60 = nil
	else
		v60 = v_u_10(p54, v_u_9(p54))
		v60:unpause()
	end
	local v61 = p56 or 10
	local v62 = p57 or 1
	local v63 = {
		["createdAt"] = nil,
		["dependencySet"] = nil,
		["dependentSet"] = nil,
		["lastChange"] = nil,
		["scope"] = nil,
		["validity"] = "invalid",
		["_activeDamping"] = -1,
		["_activeGoal"] = nil,
		["_activeLatestP"] = nil,
		["_activeLatestV"] = nil,
		["_activeNumSprings"] = 0,
		["_activeSpeed"] = -1,
		["_activeStartP"] = nil,
		["_activeStartV"] = nil,
		["_activeTargetP"] = nil,
		["_activeType"] = "",
		["_damping"] = nil,
		["_EXTREMELY_DANGEROUS_usedAsValue"] = nil,
		["_goal"] = nil,
		["_speed"] = nil,
		["_stopwatch"] = nil,
		["createdAt"] = v58,
		["dependencySet"] = {},
		["dependentSet"] = {},
		["scope"] = p54,
		["_activeLatestP"] = {},
		["_activeLatestV"] = {},
		["_activeStartP"] = {},
		["_activeStartV"] = {},
		["_activeTargetP"] = {},
		["_damping"] = v62,
		["_EXTREMELY_DANGEROUS_usedAsValue"] = v_u_8(p55),
		["_goal"] = p55,
		["_speed"] = v61,
		["_stopwatch"] = v60
	}
	local v64 = v_u_16
	local v_u_65 = setmetatable(v63, v64)
	local function v67()
		-- upvalues: (copy) v_u_65
		v_u_65.scope = nil
		for v66 in pairs(v_u_65.dependencySet) do
			v66.dependentSet[v_u_65] = nil
		end
	end
	v_u_65.oldestTask = v67
	v_u_14[v_u_65.oldestTask] = "Spring"
	table.insert(p54, v67)
	if v59 ~= nil then
		v_u_3.bOutlivesA(p54, v_u_65.oldestTask, v59.scope, v59.oldestTask, v_u_3.formatters.animationGoal)
	end
	local v68 = v_u_7(v61)
	if v68 ~= nil then
		v_u_3.bOutlivesA(p54, v_u_65.oldestTask, v68.scope, v68.oldestTask, v_u_3.formatters.parameter, "speed")
	end
	local v69 = v_u_7(v62)
	if v69 ~= nil then
		v_u_3.bOutlivesA(p54, v_u_65.oldestTask, v69.scope, v69.oldestTask, v_u_3.formatters.parameter, "damping")
	end
	v_u_6(v_u_65, true)
	return v_u_65
end