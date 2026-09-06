local common = game.ReplicatedStorage.common
local HttpService = game:GetService("HttpService")
local CollectionService = game:GetService("CollectionService")
local Sounds = script.Sounds
local ProximityPromptZS = require(common.ProximityPromptZS)
local Signal = require(common.Signal)
local u42 = nil
local u26 = {}
local u34 = game:GetService("RunService"):IsServer()
local AmmoBox = require(game.ReplicatedStorage.common.RedEvents.General.AmmoBox)
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
function u43.new(p1, p2) -- Line: 57 -- upvalues: u34 (val), Sounds (val), HttpService (val), CollectionService (val), Signal (val), u26 (val), u43 (val), ProximityPromptZS (val), AmmoBox (val)
    local Value, Value_2
    if not u34 then
        if not p1.InteractPart then
            p1.InteractPart = getUnreplicatedPart(p2)
        end
        p1.Uses = p1.UseLimit
        local u82 = {
            _CoolingDown = false,
            _Identifier = p2,
            Properties = p1,
            Used = Signal.new(),
            CooldownStarted = Signal.new(),
            CooldownFinished = Signal.new(),
        }
        local u97 = ProximityPromptZS.new({
            ActionText = "REFILL",
            ObjectText = "",
            Obstructable = false,
            Range = 7,
            Enabled = true,
            Part = p1.InteractPart,
        })
        u82._Prompt = u97
        u43._UpdateUseText(u82)
        u97.Triggered:Connect(function() -- Line: 121 -- upvalues: p1 (val), Sounds (upval), AmmoBox (upval), p2 (ref), u82 (val), u43 (upval), u97 (val)
            if p1.Replenishing then
                Sounds.Error:Play()
                return
            end
            p1.Replenishing = true
            AmmoBox:FireServer({Type = "RequestRefill", Identifier = p2})
            u82.Used:Fire(game.Players.LocalPlayer)
            local v1 = p1
            v1.Uses = v1.Uses - 1
            u43._UpdateUseText(u82)
            if 0 >= p1.Uses then
                u97.ActionText = "EMPTY"
                return
            end
            u82.CooldownStarted:Fire()
            u82._CoolingDown = true
            v1 = math.floor(p1.RefillTime)
            u97.ActionText = "COOLDOWN... " .. v1
            while true do
                task.wait(1)
                v1 = v1 - 1
                u97.ActionText = "COOLDOWN... " .. v1
                if v1 <= 0 or not p1.Replenishing then
                    break
                end
            end
            u97.ActionText = "REFILL"
            p1.Replenishing = false
            u82._CoolingDown = false
            u82.CooldownFinished:Fire()
        end)
        u26[p2] = u82
        return (setmetatable(u82, u43))
    end
    local UseLimit = p1:FindFirstChild("UseLimit")
    local RefillTime = p1:FindFirstChild("RefillTime")
    local Interact = p1:FindFirstChild("Interact")
    assert(Interact, "Missing \"Interact\" Part")
    if not (Interact:FindFirstChild("Ammo")) then
        Sounds.Ammo:Clone().Parent = Interact
    end
    local v1 = HttpService:GenerateGUID(false)
    CollectionService:AddTag(Interact, v1)
    local v2 = {}
    if not UseLimit then
        Value = 3
    else
        Value = UseLimit.Value
    end
    v2.UseLimit = Value
    if not RefillTime then
        Value_2 = 15
    else
        Value_2 = RefillTime.Value
    end
    v2.RefillTime = Value_2
    v2.InteractPart = Interact
    local v3 = {_Identifier = v1, Properties = v2, PlayerUses = {}, Used = Signal.new()}
    u26[v1] = v3
    local Players = game.Players:GetPlayers()
    sendAddPacket(Players, v1, v2)
    return (setmetatable(v3, u43))
end
function u43:GiveAmmo(p2) -- Line: 161 -- upvalues: u42 (ref)
    local UseLimit = self.PlayerUses[p2]
    if not UseLimit then
        UseLimit = self.UseLimit
    end
    if 0 < UseLimit then
        self.PlayerUses[p2] = UseLimit - 1
        self.InteractPart.Ammo:Play()
        u42:RefillAmmo(p2)
        self.Used:Fire(p2)
    end
end
function u43:Reset() -- Line: 172 -- upvalues: u34 (val), u26 (val)
    if u34 then
        local v1 = u26[self._Identifier]
        v1.PlayerUses = {}
        u26[self._Identifier]._SetProperty(self, "Uses", 3)
    end
end
function u43:_UpdateUseText() -- Line: 179
    self._Prompt.ObjectText = ("AMMO %d/%d USES"):format(self.Properties.Uses, self.Properties.UseLimit)
end
function u43:_SetProperty(p2, p3) -- Line: 183 -- upvalues: u44 (val), u34 (val), AmmoBox (val)
    if not (u44[p2]) then
        return
    end
    self.Properties[p2] = p3
    if u34 then
        AmmoBox:FireAllClients({Type = "PropertyChanged", Identifier = self._Identifier, Index = p2, Value = p3})
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
function init() -- Line: 206 -- upvalues: u34 (val), u26 (val), u43 (val), AmmoBox (val)
    if u34 then
        function u43.ResetAll() -- Line: 209 -- upvalues: u26 (upval)
            local v1 = u26
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                j:Reset()
            end
        end
        AmmoBox:SetServerListener(function(p1, p2) -- Line: 214 -- upvalues: u26 (upval)
            local v1
            if not p2 then
                v1 = u26
                local v2 = nil
                local v3 = nil
                for i, j in v1, v2, v3 do
                    sendAddPacket({p1}, i, j)
                end
                return
            end
            if p2.Type ~= "RequestRefill" then
                return
            end
            v1 = u26[p2.Identifier]
            if not v1 then
                return
            end
            v1:GiveAmmo(p1)
        end)
        return
    end
    AmmoBox:SetClientListener(function(p1) -- Line: 230 -- upvalues: u43 (upval), u26 (upval)
        if not p1 then
            return
        end
        if p1.Type == "Add" then
            u43.new({UseLimit = p1.UseLimit, RefillTime = p1.RefillTime, InteractPart = p1.InteractPart}, p1.Identifier)
            return
        end
        if p1.Type == "PropertyChanged" then
            local v1 = u26[p1.Identifier]
            if v1 then
                v1:_SetProperty(p1.Index, p1.Value)
            end
        end
    end)
    AmmoBox:FireServer()
end
function sendAddPacket(p1, p2, p3) -- Line: 253 -- upvalues: AmmoBox (val)
    AmmoBox:FireClients(p1, {
        Type = "Add",
        Identifier = p2,
        UseLimit = p3.UseLimit,
        RefillTime = p3.RefillTime,
        InteractPart = p3.InteractPart,
    })
end
function getUnreplicatedPart(p1) -- Line: 263 -- upvalues: CollectionService (val)
    local v1 = CollectionService:GetTagged(p1)[1]
    while v1 == nil do
        v1 = CollectionService:GetInstanceAddedSignal(p1):Wait()
    end
    return v1
end
init()
return u43