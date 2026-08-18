local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = require(v1.Memory.checkLifetime)
local v_u_4 = require(v1.Graph.castToGraph)
local v_u_5 = require(v1.Graph.depend)
local v_u_6 = require(v1.Graph.evaluate)
local v_u_7 = require(v1.Utility.nicknames)
local v8 = {
	["type"] = "Observer",
	["timeliness"] = "eager",
	["dependentSet"] = table.freeze({})
}
local v_u_9 = table.freeze({
	["__index"] = v8
})
function v8.onBind(p10, p11) -- name: onBind
	-- upvalues: (copy) v_u_2
	v_u_2.doTaskImmediate(p11)
	return p10:onChange(p11)
end
function v8.onChange(p_u_12, p13) -- name: onChange
	local v_u_14 = table.freeze({})
	p_u_12._changeListeners[v_u_14] = p13
	return function()
		-- upvalues: (copy) p_u_12, (copy) v_u_14
		p_u_12._changeListeners[v_u_14] = nil
	end
end
function v8._evaluate(p15) -- name: _evaluate
	-- upvalues: (copy) v_u_5, (copy) v_u_2
	if p15._watchingGraph ~= nil then
		v_u_5(p15, p15._watchingGraph)
	end
	for _, v16 in p15._changeListeners do
		v_u_2.doTaskImmediate(v16)
	end
	return true
end
table.freeze(v8)
return function(p17, p18) -- name: Observer
	-- upvalues: (copy) v_u_2, (copy) v_u_4, (copy) v_u_9, (copy) v_u_7, (copy) v_u_3, (copy) v_u_6
	local v19 = os.clock()
	if p18 == nil then
		v_u_2.logError("scopeMissing", nil, "Observers", "myScope:Observer(watching)")
	end
	local v20 = {
		["scope"] = nil,
		["createdAt"] = nil,
		["dependencySet"] = nil,
		["lastChange"] = nil,
		["validity"] = "invalid",
		["_watchingGraph"] = nil,
		["_changeListeners"] = nil,
		["scope"] = p17,
		["createdAt"] = v19,
		["dependencySet"] = {},
		["_watchingGraph"] = v_u_4(p18),
		["_changeListeners"] = {}
	}
	local v21 = v_u_9
	local v_u_22 = setmetatable(v20, v21)
	local function v24()
		-- upvalues: (copy) v_u_22
		v_u_22.scope = nil
		for v23 in pairs(v_u_22.dependencySet) do
			v23.dependentSet[v_u_22] = nil
		end
	end
	v_u_22.oldestTask = v24
	v_u_7[v_u_22.oldestTask] = "Observer"
	table.insert(p17, v24)
	if v_u_22._watchingGraph ~= nil then
		v_u_3.bOutlivesA(p17, v_u_22.oldestTask, v_u_22._watchingGraph.scope, v_u_22._watchingGraph.oldestTask, v_u_3.formatters.observer)
	end
	v_u_6(v_u_22, true)
	return v_u_22
end