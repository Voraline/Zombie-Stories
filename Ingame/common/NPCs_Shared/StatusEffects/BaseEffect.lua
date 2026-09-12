local ReplicatedStorage = game:GetService("ReplicatedStorage")
local u7 = require("@game/ReplicatedStorage/common/Janitor")
local StatusEvent = require(ReplicatedStorage.common.RedEvents.NPC.StatusEvent)
local u16 = require("@game/ReplicatedStorage/common/NPCRegistry")
local u24 = game:GetService("RunService"):IsServer()
local u25 = {}
u25.__index = u25
u25.TickRate = 1

function u25:UpdateIcon() -- Line: 23 -- upvalues: u24 (val), StatusEvent (val)
    if u24 then
        local UID = (self.getNPC()).UID
        local v1 = StatusEvent
        local v2 = {
            Type = "UpdateIcon",
            UID = UID,
            status = self._Name,
            packetTime = workspace:GetServerTimeNow(),
            args = {self.Potency, self.Count},
        }
        v1:FireAllClients(v2)
        return
    end
    if self.Label then
        local Label = self.Label
        local Count = Label.Count
        local Potency = Label.Potency
        Count.Text = self.Count
        Potency.Text = self.Potency
    end
end

function u25.extend(p1, p2) end

if not u24 then
    StatusEvent:SetClientListener(function(p1) -- Line: 48 -- upvalues: u16 (val)
        if p1.Type == "UpdateIcon" then
            local packetTime = p1.packetTime
            local args = p1.args
            local v1, v2 = table.unpack(args)
            local v3 = u16
            local UID = p1.UID
            local NPC = v3:GetNPC(UID)
            if NPC.CurrentEffects then
                local v4 = NPC.CurrentEffects[p1.status]
                if v4 then
                    if v4._lastUpdate and not (v4._lastUpdate < packetTime) then
                        if packetTime < v4._lastUpdate then
                            return
                        end
                        v4.Count = v2
                        v4.Potency = v1
                        v4:UpdateIcon(v1, v2)
                        return
                    end
                    v4._lastUpdate = packetTime
                    v4.Count = v2
                    v4.Potency = v1
                    v4:UpdateIcon(v1, v2)
                end
            end
        end
    end)
end
return function(p1, p2) -- Line: 71 -- upvalues: u25 (val), u7 (val)
    local v1 = u25
    local u5 = setmetatable({}, v1)
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
        local v1 = os.clock()
        local v2 = u5._lastTick < v1
        if not p1 and v2 then
            u5._lastTick = os.clock() + (u5.TickRate or 1)
        end
        return v2
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