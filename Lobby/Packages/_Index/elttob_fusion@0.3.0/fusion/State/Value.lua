local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = require(v1.Graph.change)
local v_u_4 = require(v1.Utility.isSimilar)
local v_u_5 = require(v1.Utility.never)
local v_u_6 = require(v1.Utility.nicknames)
local v7 = {
	["type"] = "State",
	["kind"] = "Value",
	["timeliness"] = "lazy",
	["dependencySet"] = table.freeze({})
}
local v_u_8 = table.freeze({
	["__index"] = v7
})
function v7.get(_, _) -- name: get
	-- upvalues: (copy) v_u_2, (copy) v_u_5
	v_u_2.logError("stateGetWasRemoved")
	return v_u_5()
end
function v7.set(p9, p10) -- name: set
	-- upvalues: (copy) v_u_4, (copy) v_u_3
	if not v_u_4(p9._EXTREMELY_DANGEROUS_usedAsValue, p10) then
		p9._EXTREMELY_DANGEROUS_usedAsValue = p10
		v_u_3(p9)
	end
	return p10
end
function v7._evaluate(_) -- name: _evaluate
	return true
end
table.freeze(v7)
return function(p11, p12) -- name: Value
	-- upvalues: (copy) v_u_2, (copy) v_u_8, (copy) v_u_6
	local v13 = os.clock()
	if p12 == nil and (typeof(p11) ~= "table" or p11[1] == nil and next(p11) ~= nil) then
		v_u_2.logError("scopeMissing", nil, "Value", "myScope:Value(initialValue)")
	end
	local v14 = {
		["createdAt"] = nil,
		["dependentSet"] = nil,
		["lastChange"] = nil,
		["scope"] = nil,
		["validity"] = "valid",
		["_EXTREMELY_DANGEROUS_usedAsValue"] = nil,
		["createdAt"] = v13,
		["dependentSet"] = {},
		["lastChange"] = os.clock(),
		["scope"] = p11,
		["_EXTREMELY_DANGEROUS_usedAsValue"] = p12
	}
	local v15 = v_u_8
	local v_u_16 = setmetatable(v14, v15)
	local function v17()
		-- upvalues: (copy) v_u_16
		v_u_16.scope = nil
	end
	v_u_16.oldestTask = v17
	v_u_6[v_u_16.oldestTask] = "Value"
	table.insert(p11, v17)
	return v_u_16
end