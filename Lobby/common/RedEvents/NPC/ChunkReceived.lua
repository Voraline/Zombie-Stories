local v1 = require(game.ReplicatedStorage.Packages.Red)
local v_u_2 = require(game.ReplicatedStorage.Packages.Guard)
return v1.Event("ChunkReceived", function(p3)
	-- upvalues: (copy) v_u_2
	return v_u_2.Instance(p3)
end)