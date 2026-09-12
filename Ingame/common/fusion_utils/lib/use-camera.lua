local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local v1 = Fusion.scoped(Fusion)
local CurrentCamera = Workspace.CurrentCamera
local u20 = v1:Value(CurrentCamera)
;(workspace:GetPropertyChangedSignal("CurrentCamera")):Connect(function() -- Line: 9 -- upvalues: u20 (val)
    if workspace.CurrentCamera then
        local v1 = u20
        local CurrentCamera = workspace.CurrentCamera
        v1:set(CurrentCamera)
    end
end)
return function() -- Line: 15 -- upvalues: u20 (val)
    return u20
end