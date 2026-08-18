local v1 = script.Parent.Parent
require(v1.PubTypes)
local v_u_2 = require(v1.Logging.parseError)
local v_u_3 = require(v1.Dependencies.sharedState)
local v_u_4 = v_u_3.initialisedStack
local v_u_5 = 0
return function(p6, p7, ...) -- name: captureDependencies
	-- upvalues: (copy) v_u_3, (ref) v_u_5, (copy) v_u_4, (copy) v_u_2
	local v8 = v_u_3.dependencySet
	v_u_3.dependencySet = p6
	local v9 = v_u_3
	v9.initialisedStackSize = v9.initialisedStackSize + 1
	local v10 = v_u_3.initialisedStackSize
	if v_u_5 < v10 then
		v_u_4[v10] = {}
		v_u_5 = v10
	else
		local v11 = v_u_4[v10]
		table.clear(v11)
	end
	local v12 = table.pack(xpcall(p7, v_u_2, ...))
	v_u_3.dependencySet = v8
	local v13 = v_u_3
	v13.initialisedStackSize = v13.initialisedStackSize - 1
	local v14 = v12.n
	return table.unpack(v12, 1, v14)
end