local Players = game:GetService("Players")
local common = game.ReplicatedStorage.common
local RedEvents = game.ReplicatedStorage.common.RedEvents
require(common.TableKit)
local Signal = require(common.Signal)
local u18 = {}
local u19 = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local u32 = game:GetService("RunService"):IsServer()
local StatusEffectsEvent = require(RedEvents.Framework.StatusEffectsEvent)
local u37 = {Downed = true}
local u39 = {}
u39.StateAdded = Signal.new()

function u39.__index(p1, p2) -- Line: 40 -- upvalues: u39 (val), u37 (val)
    local v1 = rawget(p1, p2)
    if p1.EffectObjects[p2] ~= nil then
        if p1.EffectObjects[p2].Inactive then
            return false
        end
        return p1.EffectObjects[p2]
    end
    if v1 ~= nil then
        return v1
    end
    if u39[p2] then
        return u39[p2]
    end
    if u37[p2] then
        return nil
    end
    return nil
end

function u39.new(p1, p2) -- Line: 74 -- upvalues: u39 (val), u18 (val), u37 (val), ReplicatedStorage (val), u19 (val)
    local v1
    local v2 = {Player = p1, _Events = {}, EffectObjects = {}}
    local v3 = u39
    setmetatable(v2, v3)
    u18[p1] = v2
    local v4 = u37
    local v5 = nil
    v3 = nil
    for i, j in v4, v5, v3 do
        v1 = ReplicatedStorage.common.StatusEffects:FindFirstChild(i, true)
        u19[i] = v1
        require(v1)
    end
    return v2
end

function u39.CopyEffects(p1, p2) -- Line: 94
    local v1, v2
    local EffectObjects = p1.EffectObjects
    local v3 = nil
    local v4 = nil
    for i in EffectObjects, v3, v4 do
        p1:RemoveStatus(i)
    end
    local EffectObjects_2 = p2.EffectObjects
    v3 = nil
    v4 = nil
    for j, k in EffectObjects_2, v3, v4 do
        v1 = getStatusModule(j)
        v2 = require(v1).new(p1)
        p1.EffectObjects[j] = v2
        v2:CopyStatus(k, p1)
    end
end

function u39:Apply(p2, ...) -- Line: 106 -- upvalues: u32 (val), StatusEffectsEvent (val)
    local v1, v2
    if not self.EffectObjects[p2] then
        v1 = getStatusModule(p2)
        self.EffectObjects[p2] = (require(v1).new(self))
        self.EffectObjects[p2]:Apply(self, ...)
    elseif self.EffectObjects[p2].Apply then
        self.EffectObjects[p2]:Apply(self, ...)
    end
    v1 = self._Events[p2]
    if v1 then
        v2 = self[p2]
        v1:Fire(v2)
    end
    if u32 then
        local v3 = StatusEffectsEvent
        v2 = {
            Type = "StatusApplied",
            Player = self.Player,
            Status = p2,
            Params = {...},
        }
        v3:FireAllClients(v2)
    end
end

function u39:RemoveStatus(p2) -- Line: 133 -- upvalues: u32 (val), StatusEffectsEvent (val)
    local v1 = self.EffectObjects[p2]
    if v1 then
        v1:Destroy()
        self.EffectObjects[p2] = nil
    end
    if u32 then
        local v2 = StatusEffectsEvent
        local v3 = {Type = "StatusRemoved", Player = self.Player, Status = p2}
        v2:FireAllClients(v3)
    end
end

function u39:Update(p2) -- Line: 148
    local EffectObjects = self.EffectObjects
    local v1 = nil
    local v2 = nil
    for i, j in EffectObjects, v1, v2 do
        if not j.Inactive and j.Update then
            j:Update(p2)
        end
    end
end

function u39:Destroy() -- Line: 155 -- upvalues: u18 (val)
    u18[self.Player] = nil
    rawset(self, "_Destroyed", true)
    local EffectObjects = self.EffectObjects
    local v1 = nil
    local v2 = nil
    for i, j in EffectObjects, v1, v2 do
        j:Destroy()
    end
    local _Events = self._Events
    v1 = nil
    v2 = nil
    for k, n in _Events, v1, v2 do
        n:DisconnectAll()
    end
end

function getStatusModule(p1) -- Line: 169 -- upvalues: u19 (val), ReplicatedStorage (val)
    local v1 = u19[p1]
    if not v1 then
        v1 = ReplicatedStorage.common.StatusEffects:FindFirstChild(p1, true)
    end
    local v2 = ("Status Module %s does not exist"):format(p1)
    assert(v1, v2)
    if not u19[p1] then
        u19[p1] = v1
    end
    return v1
end

if u32 then
    return u39
end
local u50 = {}
local u51 = {}

local function handlePacket(p1, p2) -- Line: 213
    local Type = p1.Type
    if Type ~= "StatusApplied" then
        if Type == "StatusRemoved" then
            local Status_2 = p1.Status
            p2:RemoveStatus(Status_2)
        end
        return
    end
    local Status = p1.Status
    local Params = p1.Params
    if not Params then
        Params = {}
    end
    local v1 = unpack(Params)
    p2:Apply(Status, v1)
end

local function tryFlushPending(p1) -- Line: 223 -- upvalues: u18 (val), u51 (val), u50 (val), handlePacket (val)
    local v1 = u18[p1]
    if not v1 or not u51[p1] then
        return
    end
    local v2 = u50[p1]
    if v2 then
        local v3 = v2
        local v4 = nil
        local v5 = nil
        for i, j in v3, v4, v5 do
            handlePacket(j, v1)
        end
        u50[p1] = nil
    end
end

StatusEffectsEvent:SetClientListener(function(p1) -- Line: 240 -- upvalues: u18 (val), u51 (val), handlePacket (val), u50 (val)
    if not p1 then
        return
    end
    local Player = p1.Player
    local v1 = u18[Player]
    local v2 = u51
    local v3 = v2[Player]
    if v1 and v3 then
        handlePacket(p1, v1)
        return
    end
    v2 = u50
    local v4 = u50[Player]
    if not v4 then
        v4 = {}
    end
    v2[Player] = v4
    v4 = u50[Player]
    table.insert(v4, p1)
end)
u39.StateAdded:Connect(function(p1) -- Line: 261 -- upvalues: u51 (val), u18 (val), u50 (val), handlePacket (val)
    u51[p1.Player] = true
    local Player = p1.Player
    local v1 = u18[Player]
    if not v1 or not u51[Player] then
        return
    end
    local v2 = u50[Player]
    if v2 then
        local v3 = v2
        local v4 = nil
        local v5 = nil
        for i, j in v3, v4, v5 do
            handlePacket(j, v1)
        end
        u50[Player] = nil
    end
end)
Players.PlayerRemoving:Connect(function(p1) -- Line: 267 -- upvalues: u50 (val), u51 (val)
    u50[p1] = nil
    u51[p1] = nil
end)
return u39