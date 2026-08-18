local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = require(v1.Graph.change)
local v_u_4 = require(v1.Utility.nicknames)
local v_u_5 = {
	["type"] = "State",
	["kind"] = "ExternalTime",
	["timeliness"] = "lazy",
	["dependencySet"] = table.freeze({}),
	["_EXTREMELY_DANGEROUS_usedAsValue"] = v_u_2.lastUpdateStep()
}
local v_u_6 = table.freeze({
	["__index"] = v_u_5
})
local v_u_7 = {}
function v_u_5._evaluate(_) -- name: _evaluate
	return true
end
v_u_2.bindToUpdateStep(function(_)
	-- upvalues: (copy) v_u_5, (copy) v_u_2, (copy) v_u_7, (copy) v_u_3
	v_u_5._EXTREMELY_DANGEROUS_usedAsValue = v_u_2.lastUpdateStep()
	for _, v8 in v_u_7 do
		v_u_3(v8)
	end
end)
return function(p9) -- name: ExternalTime
	-- upvalues: (copy) v_u_6, (copy) v_u_7, (copy) v_u_4
	local v10 = {
		["createdAt"] = nil,
		["dependentSet"] = nil,
		["lastChange"] = nil,
		["scope"] = nil,
		["validity"] = "invalid",
		["createdAt"] = os.clock(),
		["dependentSet"] = {},
		["scope"] = p9
	}
	local v11 = v_u_6
	local v_u_12 = setmetatable(v10, v11)
	local function v14()
		-- upvalues: (copy) v_u_12, (ref) v_u_7
		v_u_12.scope = nil
		local v13 = table.find(v_u_7, v_u_12)
		if v13 ~= nil then
			table.remove(v_u_7, v13)
		end
	end
	v_u_12.oldestTask = v14
	v_u_4[v_u_12.oldestTask] = "ExternalTime"
	table.insert(p9, v14)
	local v15 = v_u_7
	table.insert(v15, v_u_12)
	return v_u_12
end