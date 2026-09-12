return function(p1) -- Line: 1
    if game:GetService("RunService"):IsClient() then
        p1:RegisterHook("AfterRun", function(p1) end)
        return
    end
    local ServerScriptService = game:GetService("ServerScriptService")
    local CmdrShared = game:GetService("ReplicatedStorage").common:WaitForChild("CmdrShared")
    local PermissionsHandler = require(CmdrShared:WaitForChild("PermissionsHandler"))
    local LoggingService = require(ServerScriptService.common.ZS_Server.Services.LoggingService)
    p1:RegisterHook("AfterRun", function(p1) -- Line: 19 -- upvalues: PermissionsHandler (val), LoggingService (val)
        local v1 = PermissionsHandler
        local Executor = p1.Executor
        local Group = p1.Group
        if not v1:HasCommand(Executor, Group) then
            return
        end
        LoggingService.LogCommand(p1)
    end)
end