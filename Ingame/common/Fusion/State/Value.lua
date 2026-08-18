local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.Dependencies.useDependency)
local v_u_3 = require(v1.Dependencies.initDependency)
local v_u_4 = require(v1.Dependencies.updateAll)
local v_u_5 = require(v1.Utility.isSimilar)
local v6 = {}
local v_u_7 = {
	["__index"] = v6
}
local v_u_8 = {
	["__mode"] = "k"
}
function v6.get(p9, p10) -- name: get
	-- upvalues: (copy) v_u_2
	if p10 ~= false then
		v_u_2(p9)
	end
	return p9._value
end
function v6.set(p11, p12, p13) -- name: set
	-- upvalues: (copy) v_u_5, (copy) v_u_4
	if p13 or not v_u_5(p11._value, p12) then
		p11._value = p12
		v_u_4(p11)
	end
end
return function(p14) -- name: Value
	-- upvalues: (copy) v_u_8, (copy) v_u_7, (copy) v_u_3
	local v15 = {
		["type"] = "State",
		["kind"] = "Value",
		["dependentSet"] = nil,
		["_value"] = nil
	}
	local v16 = v_u_8
	v15.dependentSet = setmetatable({}, v16)
	v15._value = p14
	local v17 = v_u_7
	local v18 = setmetatable(v15, v17)
	v_u_3(v18)
	return v18
end