local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = require(v1.Graph.depend)
local v_u_4 = require(v1.State.peek)
local v_u_5 = require(v1.State.castToState)
require(v1.State.For.ForTypes)
local v_u_6 = require(v1.Utility.never)
local v_u_7 = require(v1.Utility.nicknames)
local v_u_8 = require(v1.State.For.Disassembly)
local v9 = {
	["type"] = "State",
	["kind"] = "For",
	["timeliness"] = "lazy"
}
local v_u_10 = table.freeze({
	["__index"] = v9
})
function v9.get(_) -- name: get
	-- upvalues: (copy) v_u_2, (copy) v_u_6
	v_u_2.logError("stateGetWasRemoved")
	return v_u_6()
end
function v9._evaluate(p_u_11) -- name: _evaluate
	-- upvalues: (copy) v_u_3, (copy) v_u_5, (copy) v_u_4
	if p_u_11.scope == nil then
		return false
	end
	local _ = p_u_11.scope
	v_u_3(p_u_11, p_u_11._disassembly)
	table.clear(p_u_11._EXTREMELY_DANGEROUS_usedAsValue)
	p_u_11._disassembly:populate(function(p12)
		-- upvalues: (ref) v_u_5, (ref) v_u_3, (copy) p_u_11, (ref) v_u_4
		local v13 = v_u_5(p12)
		if v13 ~= nil then
			v_u_3(p_u_11, v13)
		end
		return v_u_4(p12)
	end, p_u_11._EXTREMELY_DANGEROUS_usedAsValue)
	return true
end
table.freeze(v9)
return function(p14, p15, p16) -- name: For
	-- upvalues: (copy) v_u_8, (copy) v_u_10, (copy) v_u_7
	local v17 = {
		["createdAt"] = nil,
		["dependencySet"] = nil,
		["dependentSet"] = nil,
		["scope"] = nil,
		["validity"] = "invalid",
		["_EXTREMELY_DANGEROUS_usedAsValue"] = nil,
		["_disassembly"] = nil,
		["createdAt"] = os.clock(),
		["dependencySet"] = {},
		["dependentSet"] = {},
		["scope"] = p14,
		["_EXTREMELY_DANGEROUS_usedAsValue"] = {},
		["_disassembly"] = v_u_8(p14, p15, p16)
	}
	local v18 = v_u_10
	local v_u_19 = setmetatable(v17, v18)
	local function v21()
		-- upvalues: (copy) v_u_19
		v_u_19.scope = nil
		for v20 in pairs(v_u_19.dependencySet) do
			v20.dependentSet[v_u_19] = nil
		end
	end
	v_u_19.oldestTask = v21
	v_u_7[v_u_19.oldestTask] = "For"
	table.insert(p14, v21)
	return v_u_19
end