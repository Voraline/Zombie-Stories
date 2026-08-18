local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = require(v1.Memory.checkLifetime)
local v_u_4 = require(v1.Graph.depend)
local v_u_5 = require(v1.Graph.evaluate)
local v_u_6 = require(v1.State.castToState)
local v_u_7 = require(v1.State.peek)
local v_u_8 = require(v1.Animation.ExternalTime)
local v_u_9 = require(v1.Animation.Stopwatch)
local v_u_10 = require(v1.Animation.lerpType)
local v_u_11 = require(v1.Animation.getTweenRatio)
local v_u_12 = require(v1.Animation.getTweenDuration)
local v_u_13 = require(v1.Utility.nicknames)
local v14 = {
	["type"] = "State",
	["kind"] = "Tween",
	["timeliness"] = "eager"
}
local v_u_15 = table.freeze({
	["__index"] = v14
})
function v14.get(_) -- name: get
	-- upvalues: (copy) v_u_2
	return v_u_2.logError("stateGetWasRemoved")
end
function v14._evaluate(p16) -- name: _evaluate
	-- upvalues: (copy) v_u_6, (copy) v_u_4, (copy) v_u_7, (copy) v_u_2, (copy) v_u_12, (copy) v_u_11, (copy) v_u_10
	local v17 = v_u_6(p16._goal)
	if v17 == nil then
		p16._EXTREMELY_DANGEROUS_usedAsValue = p16._goal
		return false
	end
	v_u_4(p16, v17)
	local v18 = v_u_7(v17)
	if v18 ~= v18 then
		v_u_2.logWarn("tweenNanGoal")
		return false
	end
	local v19 = p16._stopwatch
	local v20 = v_u_7(p16._tweenInfo)
	if p16._activeTo ~= v18 or p16._activeElapsed < p16._activeDuration and p16._activeTweenInfo ~= v20 then
		p16._activeDuration = v_u_12(v20)
		p16._activeFrom = p16._EXTREMELY_DANGEROUS_usedAsValue
		p16._activeTo = v18
		p16._activeTweenInfo = v20
		v19:zero()
		v19:unpause()
	end
	v_u_4(p16, v19)
	p16._activeElapsed = v_u_7(v19)
	if p16._activeFrom ~= p16._activeTo and p16._activeElapsed < p16._activeDuration then
		local v21 = p16._activeTo
		local v22 = typeof(v21)
		local v23 = p16._activeFrom
		if v22 == typeof(v23) then
			::l12::
			local v24 = v_u_11(v20, p16._activeElapsed)
			local v25 = p16._EXTREMELY_DANGEROUS_usedAsValue
			local v26 = v_u_10(p16._activeFrom, p16._activeTo, v24)
			if v26 ~= v26 then
				v_u_2.logWarn("tweenNanMotion")
				v26 = p16._activeTo
			end
			p16._EXTREMELY_DANGEROUS_usedAsValue = v26
			return v25 ~= v26
		end
	end
	p16._activeFrom = p16._activeTo
	p16._activeElapsed = p16._activeDuration
	v19:pause()
	goto l12
end
table.freeze(v14)
return function(p27, p28, p29) -- name: Tween
	-- upvalues: (copy) v_u_6, (copy) v_u_2, (copy) v_u_9, (copy) v_u_8, (copy) v_u_7, (copy) v_u_15, (copy) v_u_13, (copy) v_u_3, (copy) v_u_5
	local v30 = os.clock()
	if v_u_6(p27) then
		v_u_2.logError("scopeMissing", nil, "Tweens", "myScope:Tween(goalState, tweenInfo)")
	end
	local v31 = v_u_6(p28)
	local v32
	if v31 == nil then
		v32 = nil
	else
		v32 = v_u_9(p27, v_u_8(p27))
	end
	local v33 = {
		["createdAt"] = nil,
		["dependencySet"] = nil,
		["dependentSet"] = nil,
		["lastChange"] = nil,
		["scope"] = nil,
		["validity"] = "invalid",
		["_activeDuration"] = nil,
		["_activeElapsed"] = nil,
		["_activeFrom"] = nil,
		["_activeTo"] = nil,
		["_activeTweenInfo"] = nil,
		["_EXTREMELY_DANGEROUS_usedAsValue"] = nil,
		["_goal"] = nil,
		["_stopwatch"] = nil,
		["_tweenInfo"] = nil,
		["createdAt"] = v30,
		["dependencySet"] = {},
		["dependentSet"] = {},
		["scope"] = p27,
		["_EXTREMELY_DANGEROUS_usedAsValue"] = v_u_7(p28),
		["_goal"] = p28,
		["_stopwatch"] = v32,
		["_tweenInfo"] = p29 or TweenInfo.new()
	}
	local v34 = v_u_15
	local v_u_35 = setmetatable(v33, v34)
	local function v37()
		-- upvalues: (copy) v_u_35
		v_u_35.scope = nil
		for v36 in pairs(v_u_35.dependencySet) do
			v36.dependentSet[v_u_35] = nil
		end
	end
	v_u_35.oldestTask = v37
	v_u_13[v_u_35.oldestTask] = "Tween"
	table.insert(p27, v37)
	if v31 ~= nil then
		v_u_3.bOutlivesA(p27, v_u_35.oldestTask, v31.scope, v31.oldestTask, v_u_3.formatters.animationGoal)
	end
	local v38 = v_u_6(p29)
	if v38 ~= nil then
		v_u_3.bOutlivesA(p27, v_u_35.oldestTask, v38.scope, v38.oldestTask, v_u_3.formatters.parameter, "tween info")
	end
	v_u_5(v_u_35, true)
	return v_u_35
end