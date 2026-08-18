local v1 = game.ReplicatedStorage.common:WaitForChild("CmdrShared")
local v_u_2 = require(v1:WaitForChild("PermissionsHandler"))
return function(p3)
	-- upvalues: (copy) v_u_2
	p3:RegisterHook("BeforeRun", function(p4)
		-- upvalues: (ref) v_u_2
		if not v_u_2:HasCommand(p4.Executor, p4.Group) then
			return "You don\'t have permission to run this command"
		end
	end)
end