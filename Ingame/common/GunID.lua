local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local u17 = RunService:IsClient()
local u20 = RunService:IsServer()
local GetAttachmentData = require(game.ReplicatedStorage.common.RedEvents.Framework.GetAttachmentData)
local u25 = {}
local u26 = {}
local u27 = {}
local u28 = 0
function u25.GenerateUID(p1) -- Line: 15 -- upvalues: u17 (val), u28 (ref)
    if u17 then
        return
    end
    u28 = u28 + 1
    return u28
end
function u25.RegisterGun(p1, p2, p3) -- Line: 21 -- upvalues: u27 (val), u26 (val)
    local v1 = p1:GenerateUID()
    if not (u27[p3]) then
        u27[p3] = {}
    end
    table.insert(u27[p3], v1)
    u26[tostring(v1)] = p2
    return v1
end
function u25.RetrieveAttachmentData(p1, p2, p3) -- Line: 31 -- upvalues: u20 (val), u26 (val), u27 (val), GetAttachmentData (val), HttpService (val)
    if u20 then
        return u26[tostring(p2)]
    end
    if not (u27[p3]) then
        u27[p3] = {}
    end
    if not (u26[tostring(p2)]) then
        local v1, v2
        v1, v2 = GetAttachmentData:Call(p2):Await()
        if not v1 then
            error("Failed to retrieve attachment data")
        else
            if not v2 then
                v2 = {}
            else
                v2 = HttpService:JSONDecode(v2[1])
            end
            u26[tostring(p2)] = v2
            table.insert(u27[p3], p2)
        end
    end
    return u26[tostring(p2)]
end
function u25.RemoveGunData(p1, p2) -- Line: 59 -- upvalues: u26 (val)
    local v1 = tostring(p2)
    u26[v1] = nil
end
function u25.ReleasePlayerGuns(p1, p2) -- Line: 63 -- upvalues: u27 (val), u26 (val)
    local v1
    local v2 = u27[p2]
    if not v2 then
        return
    end
    for i, v in ipairs(v2) do
        v1 = tostring(v)
        u26[v1] = nil
    end
    table.clear(v2)
end
if u20 then
    GetAttachmentData:SetCallback(function(p1, p2) -- Line: 75 -- upvalues: HttpService (val), u26 (val)
        if not p2 then
            return nil
        end
        local v1 = tostring(p2)
        return {HttpService:JSONEncode(u26[v1])}
    end)
    game.Players.PlayerRemoving:Connect(function(p1) -- Line: 83 -- upvalues: u27 (val), u25 (val)
        if u27[p1] then
            u25:ReleasePlayerGuns(p1)
            u27[p1] = nil
        end
    end)
end
return u25