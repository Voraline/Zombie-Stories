local RunService = game:GetService("RunService")
local u5 = {_ClassName = script.Parent.Parent}
function u5.new(p1, p2) -- Line: 6 -- upvalues: u5 (val), RunService (val)
    local Model
    local v1 = {}
    setmetatable(v1, u5)
    v1.SettingChanges = {}
    if not (RunService:IsClient()) then
        Model = game.ServerStorage.common.ServerResources.Attachments.Shared.Charms_Shared.Model
    else
        Model = game.ReplicatedStorage.common.SharedResources.Attachments.Shared.Charms_Shared.Model
        if not Model then
            Model = game.ServerStorage.common.ServerResources.Attachments.Shared.Charms_Shared.Model
        end
    end
    v1.BaseModel = Model
    v1.AttModel = p1
    v1.SettingChanges.ChainAtt = p1:FindFirstChild("SwingingPart", true)
    if v1.SettingChanges.ChainAtt then
        v1.SettingChanges.ChainAtt:PivotTo(p1:GetPivot())
    end
    return v1
end
return u5