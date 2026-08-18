local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = require(v1.Graph.evaluate)
local v_u_4 = require(v1.Utility.nameOf)
return function(p5, p6) -- name: depend
	-- upvalues: (copy) v_u_3, (copy) v_u_2, (copy) v_u_4
	v_u_3(p6, false)
	if table.isfrozen(p5.dependencySet) or table.isfrozen(p6.dependentSet) then
		v_u_2.logError("cannotDepend", nil, v_u_4(p5, "Dependent"), v_u_4(p6, "dependency"))
	end
	p6.dependentSet[p5] = true
	p5.dependencySet[p6] = true
end