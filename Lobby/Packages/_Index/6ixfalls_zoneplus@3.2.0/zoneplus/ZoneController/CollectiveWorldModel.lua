local v1 = {}
local u1 = nil
local RunService = game:GetService("RunService")
function v1.setupWorldModel(p1) -- Line: 8 -- upvalues: u1 (ref), RunService (val)
    local v1
    if u1 then
        return u1
    end
    if not (RunService:IsClient()) then
        v1 = "ServerStorage"
    else
        v1 = "ReplicatedStorage"
    end
    u1 = Instance.new("WorldModel")
    u1.Name = "ZonePlusWorldModel"
    u1.Parent = game:GetService(v1)
    return u1
end
function v1._getCombinedResults(p1, p2, ...) -- Line: 22 -- upvalues: u1 (ref)
    local v1 = workspace[p2](workspace, ...)
    if u1 then
        local v2 = u1[p2](u1, ...)
        for k, v in pairs(v2) do
            table.insert(v1, v)
        end
    end
    return v1
end
function v1.GetPartBoundsInBox(p1, p2, p3, p4) -- Line: 33
    return p1:_getCombinedResults("GetPartBoundsInBox", p2, p3, p4)
end
function v1.GetPartBoundsInRadius(p1, p2, p3, p4) -- Line: 37
    return p1:_getCombinedResults("GetPartBoundsInRadius", p2, p3, p4)
end
function v1.GetPartsInPart(p1, p2, p3) -- Line: 41
    return p1:_getCombinedResults("GetPartsInPart", p2, p3)
end
return v1