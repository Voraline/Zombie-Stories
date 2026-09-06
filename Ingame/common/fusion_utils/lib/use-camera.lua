local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local u20 = Fusion.scoped(Fusion):Value(Workspace.CurrentCamera)
local PropertyChangedSignal = workspace:GetPropertyChangedSignal("CurrentCamera")
PropertyChangedSignal:Connect(function() -- Line: 9 -- upvalues: u20 (val)
    if workspace.CurrentCamera then
        u20:set(workspace.CurrentCamera)
    end
end)
return function() -- Line: 15 -- upvalues: u20 (val)
    return u20
end