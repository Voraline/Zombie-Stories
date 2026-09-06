local ReplicatedStorage = game:GetService("ReplicatedStorage")
local zap = require(ReplicatedStorage.common.zap)
local v1 = {}
local u10 = {}
local u11 = {}
function v1.Register(p1, p2) -- Line: 23 -- upvalues: u10 (val)
    table.insert(u10, p2)
end
function v1.ProcessHit(p1, p2, p3, p4) -- Line: 29 -- upvalues: u10 (val), u11 (val)
    local v1, v2
    local Instance = p2.Instance
    if not Instance then
        return nil
    end
    local v3 = u10
    local v4 = nil
    local v5 = nil
    for i, j in v3, v4, v5 do
        if j.validate(Instance) then
            v1 = j.onHitClient(p2, p3)
            if not p4 then
                v2 = j.buildNetworkData(p2, p3)
                if v2 then
                    if not (u11[j.moduleId]) then
                        u11[j.moduleId] = {}
                    end
                    table.insert(u11[j.moduleId], v2)
                end
            end
            return v1
        end
    end
    return nil
end
function v1.ProcessNetworkQueue(p1) -- Line: 59 -- upvalues: u11 (val), zap (val)
    local v1 = u11
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        if 0 < #j then
            zap.HitRegClaim.Fire({moduleId = i, hits = j})
        end
    end
    table.clear(u11)
end
return v1