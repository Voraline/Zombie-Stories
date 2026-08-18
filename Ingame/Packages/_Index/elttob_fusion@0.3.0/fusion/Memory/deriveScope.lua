local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.ExternalDebug)
local v_u_3 = require(v1.Memory.deriveScopeImpl)
return function(...) -- name: deriveScope
	-- upvalues: (copy) v_u_3, (copy) v_u_2
	local v4 = v_u_3(...)
	v_u_2.trackScope(v4)
	return v4
end