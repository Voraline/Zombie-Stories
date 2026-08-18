local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.Utility.merge)
local v_u_3 = require(v1.Memory.scopePool)
return function(p4, p5, ...) -- name: deriveScopeImpl
	-- upvalues: (copy) v_u_2, (copy) v_u_3
	local v6 = getmetatable(p4)
	if p5 ~= nil then
		v6 = table.clone(v6)
		v6.__index = v_u_2(true, {}, v6.__index, v_u_2(false, {}, p5, ...))
	end
	local v7 = v_u_3.reuseAny() or {}
	return setmetatable(v7, v6)
end