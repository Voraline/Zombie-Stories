local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.Memory.checkLifetime)
local v_u_3 = require(v1.Graph.depend)
local v_u_4 = require(v1.Graph.change)
local v_u_5 = require(v1.State.peek)
local v_u_6 = require(v1.Utility.nicknames)
local v7 = {
	["type"] = "State",
	["kind"] = "Stopwatch",
	["timeliness"] = "lazy"
}
local v_u_8 = table.freeze({
	["__index"] = v7
})
function v7.zero(p9) -- name: zero
	-- upvalues: (copy) v_u_5, (copy) v_u_4
	local v10 = v_u_5(p9._timer)
	if v10 ~= p9._measureTimeSince then
		p9._measureTimeSince = v10
		p9._EXTREMELY_DANGEROUS_usedAsValue = 0
		v_u_4(p9)
	end
end
function v7.pause(p11) -- name: pause
	-- upvalues: (copy) v_u_4
	if p11._playing == true then
		p11._playing = false
		v_u_4(p11)
	end
end
function v7.unpause(p12) -- name: unpause
	-- upvalues: (copy) v_u_5, (copy) v_u_4
	if p12._playing == false then
		p12._playing = true
		p12._measureTimeSince = v_u_5(p12._timer) - p12._EXTREMELY_DANGEROUS_usedAsValue
		v_u_4(p12)
	end
end
function v7._evaluate(p13) -- name: _evaluate
	-- upvalues: (copy) v_u_3, (copy) v_u_5
	if not p13._playing then
		return false
	end
	v_u_3(p13, p13._timer)
	local v14 = v_u_5(p13._timer)
	local v15 = p13._EXTREMELY_DANGEROUS_usedAsValue
	local v16 = v14 - p13._measureTimeSince
	p13._EXTREMELY_DANGEROUS_usedAsValue = v16
	return v15 ~= v16
end
table.freeze(v7)
return function(p17, p18) -- name: Stopwatch
	-- upvalues: (copy) v_u_8, (copy) v_u_6, (copy) v_u_2, (copy) v_u_3
	local v19 = {
		["awake"] = true,
		["createdAt"] = nil,
		["dependencySet"] = nil,
		["dependentSet"] = nil,
		["lastChange"] = nil,
		["scope"] = nil,
		["validity"] = "invalid",
		["_EXTREMELY_DANGEROUS_usedAsValue"] = 0,
		["_measureTimeSince"] = 0,
		["_playing"] = false,
		["_timer"] = nil,
		["createdAt"] = os.clock(),
		["dependencySet"] = {},
		["dependentSet"] = {},
		["scope"] = p17,
		["_timer"] = p18
	}
	local v20 = v_u_8
	local v_u_21 = setmetatable(v19, v20)
	local function v22()
		-- upvalues: (copy) v_u_21
		v_u_21.scope = nil
	end
	v_u_21.oldestTask = v22
	v_u_6[v_u_21.oldestTask] = "Stopwatch"
	table.insert(p17, v22)
	v_u_2.bOutlivesA(p17, v_u_21.oldestTask, p18.scope, p18.oldestTask, v_u_2.formatters.parameter, "timer")
	v_u_3(v_u_21, p18)
	return v_u_21
end