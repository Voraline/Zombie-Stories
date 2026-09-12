local CmdrShared = game.ReplicatedStorage.common:WaitForChild("CmdrShared")
local PermissionsHandler = require(CmdrShared:WaitForChild("PermissionsHandler"))
return function(p1) -- Line: 4 -- upvalues: PermissionsHandler (val)
    p1:RegisterHook("BeforeRun", function(p1) -- Line: 5 -- upvalues: PermissionsHandler (upval)
        local v1 = PermissionsHandler
        local Executor = p1.Executor
        local Group = p1.Group
        if not v1:HasCommand(Executor, Group) then
            return "You don't have permission to run this command"
        end
    end)
end