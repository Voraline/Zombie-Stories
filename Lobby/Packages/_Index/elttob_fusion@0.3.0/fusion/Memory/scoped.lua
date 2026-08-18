local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.ExternalDebug)
local v_u_3 = require(v1.Utility.merge)
local v_u_4 = require(v1.Memory.scopePool)
return function(...) -- name: scoped
	-- upvalues: (copy) v_u_4, (copy) v_u_3, (copy) v_u_2
	local v5 = v_u_4.reuseAny() or {}
	local v6 = {
		["__index"] = v_u_3(false, {}, ...)
	}
	local v7 = setmetatable(v5, v6)
	v_u_2.trackScope(v7)
	return v7
end