local common = game.ReplicatedStorage.common
local HttpService = game:GetService("HttpService")
local CollectionService = game:GetService("CollectionService")
local RedEvents = game.ReplicatedStorage.common.RedEvents
local Sounds = script.Sounds
local ProximityPromptZS = require(common.ProximityPromptZS)
local Signal = require(common.Signal)
local u42 = nil
local u26 = {}
local u34 = game:GetService("RunService"):IsServer()
local AmmoBox = require(RedEvents.General.AmmoBox)
if u34 then
    u42 = require("@game/ServerStorage/common/WepHandler")
end
local u43 = {}
local u44 = {UseLimit = true, RefillTime = true, InteractPart = true, Uses = true}

function u43.ResetAll() end

function u43.__index(p1, p2) -- Line: 33 -- upvalues: u44 (val), u43 (val)
    local v1 = rawget(p1, p2)
    if u44[p2] then
        return rawget(p1, "Properties")[p2]
    end
    if v1 ~= nil then
        return v1
    end
    return u43[p2]
end

function u43.__newindex(p1, p2, p3) -- Line: 45 -- upvalues: u44 (val), u43 (val)
    local v1 = rawget(p1, p2)
    if u44[p2] then
        p1:_SetProperty(p2, p3)
        return p1
    end
    if v1 ~= nil then
        p1[p2] = p3
        return p1
    end
    u43[p2] = p3
    return p1
end

function u43.new(p1, p2) -- Line: 57
    -- upvalues: u34 (val), Sounds (val), HttpService (val), CollectionService (val), Signal (val), u26 (val), u43 (val)
    -- upvalues: ProximityPromptZS (val), AmmoBox (val)
    local Value, Value_2, v1
    if not u34 then
        if not p1.InteractPart then
            p1.InteractPart = getUnreplicatedPart(p2)
        end
        p1.Uses = p1.UseLimit
        local u82 = {_CoolingDown = false}
        u82._Identifier = p2
        u82.Properties = p1
        u82.Used = Signal.new()
        u82.CooldownStarted = Signal.new()
        u82.CooldownFinished = Signal.new()
        local v2 = ProximityPromptZS
        local u97 = v2.new({
            ActionText = "REFILL",
            ObjectText = "",
            Obstructable = false,
            Range = 7,
            Enabled = true,
            LocalOnly = true,
            Part = p1.InteractPart,
        })
        u82._Prompt = u97
        u43._UpdateUseText(u82)
        u97.Triggered:Connect(function() -- Line: 122
            -- upvalues: p1 (val), Sounds (upval), AmmoBox (upval), p2 (ref), u82 (val), u43 (upval), u97 (val)
            if p1.Replenishing then
                Sounds.Error:Play()
                return
            end
            p1.Replenishing = true
            local v1 = AmmoBox
            local v2 = {Type = "RequestRefill", Identifier = p2}
            v1:FireServer(v2)
            v1 = u82
            local Used = v1.Used
            local LocalPlayer = game.Players.LocalPlayer
            Used:Fire(LocalPlayer)
            v1 = p1
            v1.Uses = v1.Uses - 1
            u43._UpdateUseText(u82)
            if not (0 < p1.Uses) then
                u97.ActionText = "EMPTY"
                return
            end
            u82.CooldownStarted:Fire()
            u82._CoolingDown = true
            local v3 = p1
            local RefillTime = v3.RefillTime
            v1 = math.floor(RefillTime)
            u97.ActionText = "COOLDOWN... " .. v1
            repeat
                task.wait(1)
                v1 = v1 - 1
                u97.ActionText = "COOLDOWN... " .. v1
            until v1 <= 0 or not p1.Replenishing
            u97.ActionText = "REFILL"
            p1.Replenishing = false
            u82._CoolingDown = false
            u82.CooldownFinished:Fire()
        end)
        u26[p2] = u82
        v1 = u43
        return (setmetatable(u82, v1))
    end
    local UseLimit = p1:FindFirstChild("UseLimit")
    local RefillTime = p1:FindFirstChild("RefillTime")
    local Interact = p1:FindFirstChild("Interact")
    assert(Interact, "Missing \"Interact\" Part")
    if not Interact:FindFirstChild("Ammo") then
        Sounds.Ammo:Clone().Parent = Interact
    end
    local v3 = HttpService:GenerateGUID(false)
    local v4 = CollectionService
    local v5 = v3
    v4:AddTag(Interact, v5)
    v4 = {}
    if not UseLimit then
        Value = 3
    else
        Value = UseLimit.Value
    end
    v4.UseLimit = Value
    if not RefillTime then
        Value_2 = 15
    else
        Value_2 = RefillTime.Value
    end
    v4.RefillTime = Value_2
    v4.InteractPart = Interact
    v1 = {_Identifier = v3, Properties = v4, PlayerUses = {}, Used = Signal.new()}
    u26[v3] = v1
    sendAddPacket(game.Players:GetPlayers(), v3, v4)
    local v6 = u43
    return (setmetatable(v1, v6))
end

function u43:GiveAmmo(p2) -- Line: 162 -- upvalues: u42 (ref)
    local UseLimit = self.PlayerUses[p2]
    if not UseLimit then
        UseLimit = self.UseLimit
    end
    if 0 < UseLimit then
        local v1 = UseLimit - 1
        self.PlayerUses[p2] = v1
        self.InteractPart.Ammo:Play()
        u42:RefillAmmo(p2)
        self.Used:Fire(p2)
    end
end

function u43:Reset() -- Line: 173 -- upvalues: u34 (val), u26 (val)
    if u34 then
        local v1 = u26[self._Identifier]
        v1.PlayerUses = {}
        u26[self._Identifier]._SetProperty(self, "Uses", 3)
    end
end

function u43:_UpdateUseText() -- Line: 180
    local _Prompt = self._Prompt
    local Uses = self.Properties.Uses
    local UseLimit = self.Properties.UseLimit
    _Prompt.ObjectText = ("AMMO %d/%d USES"):format(Uses, UseLimit)
end

function u43:_SetProperty(p2, p3) -- Line: 184 -- upvalues: u44 (val), u34 (val), AmmoBox (val)
    if u44[p2] then
        self.Properties[p2] = p3
        if u34 then
            local v1 = AmmoBox
            local v2 = {Type = "PropertyChanged", Identifier = self._Identifier, Index = p2, Value = p3}
            v1:FireAllClients(v2)
            return
        end
        if p2 == "UseLimit" then
            self:_UpdateUseText()
            return
        end
        if p2 == "Uses" then
            self:_UpdateUseText()
            self._Prompt.ActionText = "REFILL"
            self.Properties.Replenishing = false
        end
    end
end

function init() -- Line: 207 -- upvalues: u34 (val), u26 (val), u43 (val), AmmoBox (val)
    local v1
    if u34 then
        function u43.ResetAll() -- Line: 210 -- upvalues: u26 (upval)
            local v1 = u26
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                j:Reset()
            end
        end

        v1 = AmmoBox
        v1:SetServerListener(function(p1, p2) -- Line: 215 -- upvalues: u26 (upval)
            local v1
            if p2 then
                if p2.Type == "RequestRefill" then
                    v1 = u26[p2.Identifier]
                    if v1 then
                        v1:GiveAmmo(p1)
                        return
                    end
                end
                return
            end
            v1 = u26
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                sendAddPacket({p1}, i, j)
            end
        end)
        return
    end
    v1 = AmmoBox
    v1:SetClientListener(function(p1) -- Line: 231 -- upvalues: u43 (upval), u26 (upval)
        if p1 then
            local v1
            if p1.Type == "Add" then
                v1 = u43
                v1.new(
                    {UseLimit = p1.UseLimit, RefillTime = p1.RefillTime, InteractPart = p1.InteractPart},
                    p1.Identifier
                )
                return
            end
            if p1.Type == "PropertyChanged" then
                v1 = u26[p1.Identifier]
                if v1 then
                    local Index = p1.Index
                    local Value = p1.Value
                    v1:_SetProperty(Index, Value)
                end
            end
        end
    end)
    AmmoBox:FireServer()
end

function sendAddPacket(p1, p2, p3) -- Line: 254 -- upvalues: AmmoBox (val)
    local v1 = AmmoBox
    local v2 = {
        Type = "Add",
        Identifier = p2,
        UseLimit = p3.UseLimit,
        RefillTime = p3.RefillTime,
        InteractPart = p3.InteractPart,
    }
    v1:FireClients(p1, v2)
end

function getUnreplicatedPart(p1) -- Line: 264 -- upvalues: CollectionService (val)
    local v1 = CollectionService:GetTagged(p1)[1]
    while v1 == nil do
        v1 = CollectionService:GetInstanceAddedSignal(p1):Wait()
    end
    return v1
end

init()
return u43