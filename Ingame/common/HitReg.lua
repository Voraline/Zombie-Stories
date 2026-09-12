local ReplicatedStorage = game:GetService("ReplicatedStorage")
local zap = require(ReplicatedStorage.common.zap)
local v1 = {}
local u10 = {}
local u11 = {}

function v1.Register(p1, p2) -- Line: 23 -- upvalues: u10 (val)
    local v1 = u10
    table.insert(v1, p2)
end

function v1.ProcessHit(p1, p2, p3, p4) -- Line: 29 -- upvalues: u10 (val), u11 (val)
    local v1, v2, v3
    local Instance = p2.Instance
    if not Instance then
        return nil
    end
    local v4 = u10
    local v5 = nil
    local v6 = nil
    for i, j in v4, v5, v6 do
        if j.validate(Instance) then
            v1 = j.onHitClient(p2, p3)
            if not p4 then
                v2 = j.buildNetworkData(p2, p3)
                if v2 then
                    if not u11[j.moduleId] then
                        u11[j.moduleId] = {}
                    end
                    v3 = u11[j.moduleId]
                    table.insert(v3, v2)
                end
            end
            return v1
        end
    end
    return nil
end

function v1.ProcessNetworkQueue(p1) -- Line: 59 -- upvalues: u11 (val), zap (val)
    local v1
    local v2 = u11
    local v3 = nil
    local v4 = nil
    for i, j in v2, v3, v4 do
        if 0 < #j then
            v1 = zap
            v1.HitRegClaim.Fire({moduleId = i, hits = j})
        end
    end
    table.clear(u11)
end

return v1