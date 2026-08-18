local v1 = script.Parent.Parent
require(v1.PubTypes)
require(v1.Types)
local v_u_2 = require(v1.Animation.TweenScheduler)
local v_u_3 = require(v1.Dependencies.useDependency)
local v_u_4 = require(v1.Dependencies.initDependency)
local v_u_5 = require(v1.Logging.logError)
local v_u_6 = require(v1.Logging.logErrorNonFatal)
local v_u_7 = require(v1.Utility.xtypeof)
local v8 = {}
local v_u_9 = {
	["__index"] = v8
}
local v_u_10 = {
	["__mode"] = "k"
}
function v8.get(p11, p12) -- name: get
	-- upvalues: (copy) v_u_3
	if p12 ~= false then
		v_u_3(p11)
	end
	return p11._currentValue
end
function v8.update(p13) -- name: update
	-- upvalues: (copy) v_u_6, (copy) v_u_2
	local v14 = p13._goalState:get(false)
	if v14 == p13._nextValue and not p13._currentlyAnimating then
		return false
	end
	local v15 = p13._tweenInfo
	if p13._tweenInfoIsState then
		v15 = v15:get()
	end
	if typeof(v15) ~= "TweenInfo" then
		v_u_6("mistypedTweenInfo", nil, (typeof(v15)))
		return false
	end
	p13._prevValue = p13._currentValue
	p13._nextValue = v14
	p13._currentTweenStartTime = os.clock()
	p13._currentTweenInfo = v15
	local v16 = v15.DelayTime + v15.Time
	if v15.Reverses then
		v16 = v16 + v15.Time
	end
	p13._currentTweenDuration = v16 * (v15.RepeatCount + 1)
	v_u_2.add(p13)
	return false
end
return function(p17, p18) -- name: Tween
	-- upvalues: (copy) v_u_7, (copy) v_u_5, (copy) v_u_10, (copy) v_u_9, (copy) v_u_4
	local v19 = p17:get(false)
	if p18 == nil then
		p18 = TweenInfo.new()
	end
	local v20 = {
		[p17] = true
	}
	local v21 = v_u_7(p18) == "State"
	if v21 then
		v20[p18] = true
	end
	local v22
	if v21 then
		v22 = p18:get()
	else
		v22 = p18
	end
	if typeof(v22) ~= "TweenInfo" then
		v_u_5("mistypedTweenInfo", nil, (typeof(v22)))
	end
	local v23 = {
		["type"] = "State",
		["kind"] = "Tween",
		["dependencySet"] = nil,
		["dependentSet"] = nil,
		["_goalState"] = nil,
		["_tweenInfo"] = nil,
		["_tweenInfoIsState"] = nil,
		["_prevValue"] = nil,
		["_nextValue"] = nil,
		["_currentValue"] = nil,
		["_currentTweenInfo"] = nil,
		["_currentTweenDuration"] = 0,
		["_currentTweenStartTime"] = 0,
		["_currentlyAnimating"] = false,
		["dependencySet"] = v20
	}
	local v24 = v_u_10
	v23.dependentSet = setmetatable({}, v24)
	v23._goalState = p17
	v23._tweenInfo = p18
	v23._tweenInfoIsState = v21
	v23._prevValue = v19
	v23._nextValue = v19
	v23._currentValue = v19
	v23._currentTweenInfo = p18
	local v25 = v_u_9
	local v26 = setmetatable(v23, v25)
	v_u_4(v26)
	p17.dependentSet[v26] = true
	return v26
end