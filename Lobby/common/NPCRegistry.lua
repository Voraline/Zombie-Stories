local u7 = nil
local Signal = require(game.ReplicatedStorage.common.Signal)
local u11 = {}
local u19 = game:GetService("RunService"):IsServer()
local u20 = {NPCAdded = Signal.new(), NPCRemoved = Signal.new()}
function u20.AddNPC(p1, p2) -- Line: 19 -- upvalues: u11 (val), u20 (val), u19 (val), u7 (ref)
    local UID = p2.UID
    if UID ~= nil then
        local u11
        u11[UID] = p2
        u20.NPCAdded:Fire(p2)
        if u19 then
            u11 = nil
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
    while true do
        v3 = v3 + task.wait(0.1)
        v2 = u11[p2]
        if v1 <= v3 or v2 ~= nil then
            break
        end
    end
    return v2
end
if u19 then
    game:GetService("ServerScriptService")
end
if not u19 then
    game:GetService("ReplicatedStorage")
    u7 = require("@game/ReplicatedStorage/common/zap")
    local function removeNPC(p1) -- Line: 78 -- upvalues: u20 (val), u11 (val)
        u20.NPCRemoved:Fire(u11[p1])
        u11[p1] = nil
    end
    u7.NPCRegistryEvent.On(function(p1) -- Line: 83 -- upvalues: u11 (val), u20 (val)
        local UID = p1.UID
        if p1.Type ~= "RemoveNPC" then
            return
        end
        if u11[UID] then
            u20.NPCRemoved:Fire(u11[UID])
            u11[UID] = nil
            return
        end
        local v1 = 0
        while not (u11[UID]) do
            if v1 >= 5 then
                break
            end
            v1 = v1 + 1
            task.wait(2)
        end
        task.wait(3)
        if not (u11[UID]) then
            warn("NPCRegistry:RemoveNPC - Could not find NPC after 5 tries.")
            return
        end
        u20.NPCRemoved:Fire(u11[UID])
        u11[UID] = nil
    end)
end
return u20