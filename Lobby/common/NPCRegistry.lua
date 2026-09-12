local common = game.ReplicatedStorage.common
local RedEvents = game.ReplicatedStorage.common.RedEvents
local u7 = nil
local Signal = require(common.Signal)
local u11 = {}
local u19 = game:GetService("RunService"):IsServer()
local u20 = {}
u20.NPCAdded = Signal.new()
u20.NPCRemoved = Signal.new()

function u20.AddNPC(p1, p2) -- Line: 19 -- upvalues: u11 (val), u20 (val), u19 (val), u7 (ref)
    local UID = p2.UID
    if UID ~= nil then
        u11[UID] = p2
        u20.NPCAdded:Fire(p2)
        if u19 then
            local u11_2 = nil
            local v1 = p2.Destroyed:Connect(function() -- Line: 27 -- upvalues: u11_2 (ref), u11 (upval), UID (val), u7 (upval)
                u11_2:Disconnect()
                u11[UID] = nil
                local v1 = u7
                v1.NPCRegistryEvent.FireAll({Type = "RemoveNPC", UID = UID})
            end)
        end
    end
end

function u20.GetNPC(p1, p2) -- Line: 37 -- upvalues: u11 (val)
    return u11[p2]
end

function u20.GetAllNPCs(p1) -- Line: 41 -- upvalues: u11 (val)
    return u11
end

function u20.DestroyAll(p1) -- Line: 45 -- upvalues: u11 (val)
    local v1 = u11
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        if j.Destroy ~= nil then
            j:Destroy()
        end
    end
end

function u20.WaitForNPC(p1, p2, p3) -- Line: 53 -- upvalues: u11 (val)
    local v1
    if p3 ~= nil then
        v1 = p3
    else
        v1 = 99999999
    end
    local v2 = u11[p2]
    if v2 ~= nil then
        return v2
    end
    local v3 = 0
    repeat
        v3 = v3 + task.wait(0.1)
        v2 = u11[p2]
    until v1 <= v3 or v2 ~= nil
    return v2
end

if u19 then
    game:GetService("ServerScriptService")
    local v1 = require("@game/ServerScriptService/common/zap")
end
if not u19 then
    game:GetService("ReplicatedStorage")
    u7 = require("@game/ReplicatedStorage/common/zap")

    local function removeNPC(p1) -- Line: 78 -- upvalues: u20 (val), u11 (val)
        local v1 = u20
        local NPCRemoved = v1.NPCRemoved
        local v2 = u11
        local v3 = v2[p1]
        NPCRemoved:Fire(v3)
        u11[p1] = nil
    end

    u7.NPCRegistryEvent.On(function(p1) -- Line: 83 -- upvalues: u11 (val), u20 (val)
        local UID = p1.UID
        if p1.Type == "RemoveNPC" then
            local v1, v2
            if u11[UID] then
                v1 = u20
                local NPCRemoved = v1.NPCRemoved
                v2 = u11
                local v3 = v2[UID]
                NPCRemoved:Fire(v3)
                u11[UID] = nil
                return
            end
            v1 = 0
            while not u11[UID] do
                if not (v1 < 5) then
                    break
                end
                v1 = v1 + 1
                task.wait(2)
            end
            task.wait(3)
            if u11[UID] then
                local v4 = u20
                local NPCRemoved_2 = v4.NPCRemoved
                local v5 = u11
                v2 = v5[UID]
                NPCRemoved_2:Fire(v2)
                u11[UID] = nil
                return
            end
            warn("NPCRegistry:RemoveNPC - Could not find NPC after 5 tries.")
        end
    end)
end
return u20