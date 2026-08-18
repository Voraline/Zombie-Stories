local v1 = require(game.ReplicatedStorage.Packages.Red)
local v2 = require(game.ReplicatedStorage.Packages.Guard)
local v_u_3 = v2.Or(v2.Vector3, v2.Or(v2.Instance, v2.String))
return v1.SharedEvent("LookAt", function(p4)
	-- upvalues: (copy) v_u_3
	return v_u_3(p4)
end)