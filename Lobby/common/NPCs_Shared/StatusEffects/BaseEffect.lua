local ReplicatedStorage = game:GetService("ReplicatedStorage")
local u7 = require("@game/ReplicatedStorage/common/Janitor")
local StatusEvent = require(ReplicatedStorage.common.RedEvents.NPC.StatusEvent)
local u16 = require("@game/ReplicatedStorage/common/NPCRegistry")
local u24 = game:GetService("RunService"):IsServer()
local u25 = {}
u25.__index = u25
u25.TickRate = 1
function u25:UpdateIcon() -- Line: 23 -- upvalues: u24 (val), StatusEvent (val)
    local Label
    if u24 then
        StatusEvent:FireAllClients({
            Type = "UpdateIcon",
            UID = self.getNPC().UID,
            status = self._Name,
            packetTime = workspace:GetServerTimeNow(),
            args = {self.Potency, self.Count},
        })
        return
    end
    if self.Label then
        Label = self.Label
        Label.Count.Text = self.Count
        Label.Potency.Text = self.Potency
    end
end
function u25.extend(p1, p2) end
if not u24 then
    StatusEvent:SetClientListener(function(p1) -- Line: 48 -- upvalues: u16 (val)
        local v1, v2
        if p1.Type ~= "UpdateIcon" then
            return
        end
        local packetTime = p1.packetTime
        v1, v2 = table.unpack(p1.args)
        local NPC = u16:GetNPC(p1.UID)
        if not NPC.CurrentEffects then
            return
        end
        local v3 = NPC.CurrentEffects[p1.status]
        if not v3 then
            return
        end
        if not v3._lastUpdate or v3._lastUpdate < packetTime then
            v3._lastUpdate = packetTime
            v3.Count = v2
            v3.Potency = v1
            v3:UpdateIcon(v1, v2)
            return
        end
        if packetTime < v3._lastUpdate then
            return
        end
        v3.Count = v2
        v3.Potency = v1
        v3:UpdateIcon(v1, v2)
    end)
end
return function(p1, p2) -- Line: 71 -- upvalues: u25 (val), u7 (val)
    local u5 = setmetatable({}, u25)
    u5.Count = 1
    u5.Potency = 1
    u5._Janitor = u7.new()
    function u5.getNPC() -- Line: 77 -- upvalues: p2 (val)
        return p2
    end
    function u5.contains(p1) -- Line: 79 -- upvalues: p2 (val)
        local CurrentEffects = p2.CurrentEffects
        if not CurrentEffects then
            return nil
        end
        return CurrentEffects[p1]
    end
    function u5.canTick(p1) -- Line: 88 -- upvalues: u5 (val)
        local v1 = u5._lastTick < os.clock()
        if not p1 and v1 then
            u5._lastTick = os.clock() + (u5.TickRate or 1)
        end
        return v1
    end
    function u5.AddConnection(p1) -- Line: 96 -- upvalues: u5 (val)
        u5._Janitor:Add(p1)
    end
    function u5.Destroy() -- Line: 100 -- upvalues: u5 (val)
        if u5._Destroyed then
            return
        end
        u5._Destroyed = true
        u5._Janitor:Destroy()
        if u5.clearFunc then
            u5.clearFunc()
        end
    end
    u5._lastTick = os.clock() + u5.TickRate
    u5.ShowPotency = true
    u5.ShowCount = true
    return u5
end