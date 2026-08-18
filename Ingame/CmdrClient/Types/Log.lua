return function(p1)
	if game:GetService("RunService"):IsClient() then
		p1:RegisterHook("AfterRun", function(_) end)
	else
		local v2 = game:GetService("ServerScriptService")
		local v3 = game:GetService("ReplicatedStorage").common:WaitForChild("CmdrShared")
		local v_u_4 = require(v3:WaitForChild("PermissionsHandler"))
		local v_u_5 = require(v2.common.ZS_Server.Services.LoggingService)
		p1:RegisterHook("AfterRun", function(p6)
			-- upvalues: (copy) v_u_4, (copy) v_u_5
			if v_u_4:HasCommand(p6.Executor, p6.Group) then
				v_u_5.LogCommand(p6)
			end
		end)
	end
end