local common = game.ReplicatedStorage.common
local RedEvents = game.ReplicatedStorage.common.RedEvents
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TableKit = require(common.TableKit)
local Signal = require(common.Signal)
local u20 = require("./StatusEffects")
local StatusEffectsEvent = require(RedEvents.Framework.StatusEffectsEvent)
local u39 = if game:GetService("RunService"):IsServer() then require(ReplicatedStorage.common.skillTree.SkillTreeData) else nil
local u40 = true
local u48 = game:GetService("RunService"):IsServer()
local GameState = require(ReplicatedStorage.common.ZS_Shared.Data.GameState)
local Value = workspace.Values.IsLobby.Value
local PlayerStateEvent = require(RedEvents.Framework.PlayerStateEvent)
local u65 = {}
local u66 = {
    Sprinting = false,
    Crouching = false,
    Proning = false,
    Sliding = false,
    Jogging = false,
    Diving = false,
    Aiming = false,
    Equipped = false,
    WepId = false,
    SecondaryEquipped = false,
    SecondaryWepId = false,
    QuickSwapActive = false,
    DualWieldActive = false,
    OffHandActive = false,
    OffHandEquipped = false,
    OffHandWepId = false,
    LastHit = os.clock(),
    PreviousDamage = 0,
    ImmunityTime = 0.05,
    HP = 100,
    MaxHP = 100,
    GodMode = false,
    IsDead = false,
    IsDowned = false,
    InSwanSong = false,
    SwanSongEndTime = 0,
    SwanSongUsed = false,
    SpartanShield = 0,
    SpartanShieldMax = 0,
    SpartanShieldRegenDelay = 5,
    SpartanLastHitTime = 0,
    SecondWindDamage = 0,
    SecondWindMaxDamage = 500,
    SecondWindUsed = false,
    IsFocused = false,
    InstantKill = false,
    BeingRevived = false,
    Blocking = false,
    Charging = false,
    EquippedGun = false,
    BlockingStart = os.clock(),
}
local u110 = {
    Sprinting = "boolean",
    Crouching = "boolean",
    Proning = "boolean",
    Sliding = "boolean",
    Jogging = "boolean",
    Diving = "boolean",
    Aiming = "boolean",
    Charging = "boolean",
    Blocking = "boolean",
    QuickSwapActive = "boolean",
    DualWieldActive = "boolean",
    SecondaryEquipped = "string_or_false",
    SecondaryWepId = "string_or_false",
    OffHandActive = "boolean",
    OffHandEquipped = "string_or_false",
    OffHandWepId = "string_or_false",
}
local v1 = {Equipped = true, WepId = true}
local u130 = {StateAdded = Signal.new()}
function u130.__index(p1, p2) -- Line: 112 -- upvalues: u66 (val), u130 (val)
    local v1 = rawget(p1, p2)
    if u66[p2] ~= nil then
        return rawget(p1, "Properties")[p2]
    end
    if v1 ~= nil then
        return v1
    end
    if u130[p2] then
        return u130[p2]
    end
    local v2 = ("%q is not a valid member of playerState"):format((tostring(p2)))
    error(v2, 2)
end
function u130.__newindex(p1, p2, p3) -- Line: 126 -- upvalues: u66 (val), u48 (val), u130 (val)
    local v1 = rawget(p1, p2)
    if u66[p2] ~= nil then
        p1:_SetProperty(p2, p3, not u48)
        return p1
    end
    if v1 ~= nil then
        p1[p2] = p3
        return p1
    end
    u130[p2] = p3
    return p1
end
function u130.new(p1, p2) -- Line: 139 -- upvalues: u65 (val), TableKit (val), u66 (val), u20 (val), u130 (val), Signal (val), u48 (val), PlayerStateEvent (val)
    if u65[p1] then
        return u65[p1]
    end
    local v1 = p1 ~= nil
    assert(v1, "PlayerState requires player parameter")
    local u12 = {Player = p1}
    if not p2 then
        v1 = TableKit.DeepCopy(u66)
    else
        v1 = p2
    end
    u12.Properties = v1
    u12._Events = {}
    u12.StatusEffects = u20.new(p1)
    setmetatable(u12, u130)
    rawset(u12, "HPChanged", u12:GetPropertyChangedSignal("HP"))
    rawset(u12, "HealthChanged", u12:GetPropertyChangedSignal("HP"))
    rawset(u12, "Died", Signal.new())
    rawset(u12, "Downed", Signal.new())
    rawset(u12, "Damaged", Signal.new())
    local PropertyChangedSignal = u12:GetPropertyChangedSignal("IsDead")
    PropertyChangedSignal:Connect(function(p1) -- Line: 162 -- upvalues: u12 (val)
        if p1 then
            u12.Died:Fire()
        end
    end)
    local PropertyChangedSignal_2 = u12:GetPropertyChangedSignal("IsDowned")
    PropertyChangedSignal_2:Connect(function(p1) -- Line: 167 -- upvalues: u12 (val)
        if p1 then
            u12.Downed:Fire()
        end
    end)
    if u48 then
        PlayerStateEvent:FireAllClientsExcept(p1, createAddPacket(u12))
    end
    u65[p1] = u12
    u130.StateAdded:Fire(u12)
    u20.StateAdded:Fire(u12)
    return u12
end
function u130.CopyState(p1, p2) -- Line: 189 -- upvalues: u66 (val)
    local v1 = u66
    local v2 = nil
    local v3 = nil
    for i in v1, v2, v3 do
        if i ~= "StatusEffects" then
            p1[i] = p2.Properties[i]
        end
    end
    p1.StatusEffects:CopyEffects(p2.StatusEffects)
end
function u130.SetPeerReplicationEnabled(p1) -- Line: 198 -- upvalues: u40 (ref)
    u40 = p1
end
function u130:ApplyStatus(p2, ...) -- Line: 202 -- upvalues: u48 (val)
    if u48 then
        self.StatusEffects:Apply(p2, ...)
    end
end
function u130.Heal(p1, p2) -- Line: 208 -- upvalues: u48 (val)
    if u48 then
        p1.HP = math.clamp(p1.HP + p2, 0, p1.MaxHP)
    end
end
function u130.RefreshMaxHP(p1) -- Line: 218 -- upvalues: u48 (val), u39 (ref)
    if not u48 or not u39 then
        return
    end
    local v1 = math.floor(100 * u39.getMaxHPMult(p1.Player))
    local MaxHP = p1.MaxHP
    if v1 ~= MaxHP then
        local HP
        local v2 = MaxHP <= p1.HP
        p1.MaxHP = v1
        if v2 then
            p1.HP = v1
        end
        local Character = p1.Player.Character
        if Character then
            local MaxHP_2 = Character:FindFirstChild("MaxHP")
            HP = Character:FindFirstChild("HP")
            if MaxHP_2 and MaxHP_2:IsA("NumberValue") then
                MaxHP_2.Value = v1
            end
            if HP and HP:IsA("NumberValue") then
                HP.Value = p1.HP
            end
        end
        if _G.plrDictionary and _G.plrDictionary[p1.Player] then
            local v3 = _G.plrDictionary[p1.Player]
            if v3.MaxHealth then
                v3.MaxHealth.Value = v1
            end
            if v3.Health then
                v3.Health.Value = p1.HP
            end
        end
        p1.Player:SetAttribute("Skill_MaxHP", v1)
        p1.Player:SetAttribute("Skill_CurrentHP", p1.HP)
        print((("[PlayerState] %* MaxHP updated: %* -> %*"):format(p1.Player.Name, MaxHP, v1)))
    end
end
function u130.RefreshSpartanShield(p1) -- Line: 269 -- upvalues: u48 (val), u39 (ref)
    if not u48 or not u39 then
        return
    end
    if not (u39.hasTheSpartan(p1.Player)) then
        p1.SpartanShieldMax = 0
        p1.SpartanShield = 0
        return
    end
    p1.SpartanShieldMax = 50
    p1.SpartanShield = 50
    p1.SpartanLastHitTime = 0
    print((("[PlayerState] %* Spartan Shield initialized: %*"):format(p1.Player.Name, 50)))
end
function u130:ResetSecondWind() -- Line: 288 -- upvalues: u48 (val)
    if not u48 then
        return
    end
    self.SecondWindDamage = 0
end
function u130.AddSecondWindDamage(p1, p2) -- Line: 298 -- upvalues: u48 (val), u39 (ref)
    if not u48 or not u39 or not p1.IsDowned or not (u39.hasSecondWind(p1.Player)) or p1.SecondWindUsed then
        return false
    end
    p1.SecondWindDamage = p1.SecondWindDamage + p2
    if p1.SecondWindMaxDamage > p1.SecondWindDamage then
        return false
    end
    p1.SecondWindDamage = 0
    p1.IsDowned = false
    p1.HP = math.floor(p1.MaxHP * 0.25)
    p1.SecondWindUsed = true
    p1.GodMode = true
    task.delay(3, function() -- Line: 324 -- upvalues: p1 (val)
        if 0 < p1.HP and not p1.IsDead then
            p1.GodMode = false
        end
    end)
    local Character = p1.Player.Character
    if Character then
        local ForceField = Instance.new("ForceField")
        ForceField.Parent = Character
        local Debris = game:GetService("Debris")
        Debris:AddItem(ForceField, 3)
    end
    print((("[PlayerState] %* triggered Second Wind self-revive!"):format(p1.Player.Name)))
    return true
end
function u130.UpdateSpartanShield(p1, p2) -- Line: 346 -- upvalues: u48 (val), PlayerStateEvent (val)
    local SpartanShield
    if not u48 or p1.SpartanShieldMax <= 0 or p1.SpartanShieldMax <= p1.SpartanShield or p1.IsDowned or p1.IsDead then
        return
    end
    local v1 = os.clock() - p1.SpartanLastHitTime
    if p1.SpartanShieldRegenDelay <= v1 then
        SpartanShield = p1.SpartanShield
        p1.SpartanShield = math.min(p1.SpartanShield + p1.SpartanShieldMax / 3 * p2, p1.SpartanShieldMax)
        if SpartanShield == 0 and 0 < p1.SpartanShield then
            PlayerStateEvent:FireAllClients({Type = "ShieldRegenStart", Player = p1.Player})
        end
    end
end
function u130.Damage(p1, p2, p3, p4, p5) -- Line: 369 -- upvalues: u48 (val), GameState (val), u39 (ref), PlayerStateEvent (val)
    if not u48 then
        return
    elseif p1.HP <= 0 then
        return
    else
        if p1.GodMode then
            return
        end
        if p4 then
            p1.InstantKill = true
        end
        if os.clock() >= p1.LastHit then
            local PlayerDamageTaken
            p1.LastHit = os.clock() + p1.ImmunityTime
            p1.PreviousDamage = p2
            if p5 then
                PlayerDamageTaken = 1
            else
                PlayerDamageTaken = GameState.Data.Variables.PlayerDamageTaken
            end
            local v1 = p2 * PlayerDamageTaken
            if not p4 and not p5 and u39 then
                v1 = v1 * u39.getDamageReductionMult(p1.Player)
            end
            if v1 ~= v1 then
                print("NaN HP detected!")
                v1 = 0
            end
            local v2 = 0
            if not p4 and 0 < p1.SpartanShieldMax then
                p1.SpartanLastHitTime = os.clock()
                if 0 < p1.SpartanShield then
                    v2 = math.min(p1.SpartanShield, v1)
                    p1.SpartanShield = p1.SpartanShield - v2
                    v1 = v1 - v2
                end
            end
            p1.HP = math.clamp(p1.HP - v1, 0, p1.MaxHP)
            p1.Damaged:Fire(p1.HP, v1, p3, v2)
            PlayerStateEvent:FireAllClients({
                Type = "Damaged",
                Player = p1.Player,
                Data = {
                    p1.HP,
                    v1,
                    p3,
                    v2,
                    p1.SpartanShield,
                },
            })
            return
        elseif p2 <= p1.PreviousDamage then
            return
        end
    end
end
function u130:GetPropertyChangedSignal(p2) -- Line: 424 -- upvalues: u66 (val), Signal (val)
    local v1 = u66[p2] ~= nil
    assert(v1, ("PlayerState has no property '%s'"):format(p2))
    if not (self._Events[p2]) then
        self._Events[p2] = Signal.new()
    end
    return self._Events[p2]
end
function u130.GetStatusChangedSignal(p1, p2) -- Line: 432
    return p1.StatusEffects:GetPropertyChangedSignal(p2)
end
function u130:Destroy() -- Line: 436 -- upvalues: u65 (val)
    u65[self.Player] = nil
    rawset(self, "_Destroyed", true)
    self.Died:DisconnectAll()
    self.Downed:DisconnectAll()
    self.Damaged:DisconnectAll()
    local _Events = self._Events
    local v1 = nil
    local v2 = nil
    for i, j in _Events, v1, v2 do
        j:DisconnectAll()
    end
    self.StatusEffects:Destroy()
end
function u130:_SetProperty(p2, p3, p4, p5) -- Line: 449 -- upvalues: u66 (val), u48 (val), Value (val), u39 (ref), u40 (ref), PlayerStateEvent (val), u110 (val)
    local v1
    if u66[p2] == nil then
        return
    end
    local v2 = p2 ~= "StatusEffects"
    assert(v2, "Can't set StatusEffects property, please modify the StatusEffects object instead")
    local v3 = self.Properties[p2]
    if v3 == p3 then
        return
    end
    self.Properties[p2] = p3
    v2 = self._Events[p2]
    if v2 then
        v2:Fire(p3, v3)
    end
    if not u48 then
        if p4 and u110[p2] ~= nil then
            PlayerStateEvent:FireServer({Type = "PropertyChanged", Index = p2, Value = p3})
        end
        return
    end
    if p2 == "Blocking" then
        if not p3 then
            v1 = false
        else
            v1 = os.clock()
        end
        self.BlockingStart = v1
    elseif p2 == "HP" and self.HP == 0 then
        if not Value then
            local Downed = self.StatusEffects.Downed
            if self.InstantKill then
                self.IsDead = true
                self.InstantKill = false
                if Downed then
                    Downed:ResetRunState()
                end
            elseif not Downed then
                local v4 = u39
                if v4 then
                    v4 = u39.hasSwanSong(self.Player)
                end
                if not v4 then
                    if not self.InSwanSong then
                        local v5
                        if not u39 then
                            v5 = 1
                        else
                            v5 = u39.getDownedTimeMult(self.Player)
                        end
                        self:ApplyStatus("Downed", 30 * v5)
                        self.IsDowned = true
                        self:ResetSecondWind()
                    else
                        self.HP = 1
                    end
                elseif not self.InSwanSong and not self.SwanSongUsed then
                    self.InSwanSong = true
                    self.SwanSongUsed = true
                    self.SwanSongEndTime = workspace:GetServerTimeNow() + 4
                    self.HP = 1
                    task.spawn(function() -- Line: 505 -- upvalues: self (val)
                        task.wait(4)
                        if self.InSwanSong and not (rawget(self, "_Destroyed")) then
                            self.InSwanSong = false
                            self.SwanSongEndTime = 0
                            self.HP = 0
                        end
                    end)
                end
            elseif Downed._RevivesLeft and Downed._RevivesLeft > 0 then
            end
        elseif not self.InstantKill and not (rawget(self, "Revival")) then
            rawset(self, "Revival", true)
            task.spawn(function() -- Line: 475 -- upvalues: self (val)
                task.wait(1)
                while true do
                    task.wait()
                    self.HP = self.HP + 1
                    if self.MaxHP or 100 <= self.HP then
                        break
                    end
                end
                self.HP = self.MaxHP
                rawset(self, "Revival", nil)
            end)
        end
    end
    if u40 then
        v1 = {Type = "PropertyChanged", Player = self.Player, Index = p2, Value = p3}
        if p5 then
            PlayerStateEvent:FireAllClientsExcept(p5, v1)
            return
        end
        PlayerStateEvent:FireAllClients(v1)
        return
    end
    if p5 then
        return
    end
    v1 = {Type = "PropertyChanged", Player = self.Player, Index = p2, Value = p3}
    if p5 then
        PlayerStateEvent:FireAllClientsExcept(p5, v1)
        return
    end
    PlayerStateEvent:FireAllClients(v1)
end
function createAddPacket(p1) -- Line: 559
    return {Type = "Add", Player = p1.Player, Properties = p1.Properties}
end
local function isValidPropertyType(p1, p2) -- Line: 570
    local v1
    if p2 ~= "string_or_false" then
        v1 = typeof(p1) == p2
        return v1
    end
    v1 = if typeof(p1) ~= "string" then p1 == false else true
    return v1
end
if not u48 then
    PlayerStateEvent:SetClientListener(function(p1) -- Line: 618 -- upvalues: u65 (val), u130 (val)
        local v1, v2, v3
        if not p1 then
            return
        end
        local Type = p1.Type
        if Type == "Add" then
            v1 = u65[p1.Player]
            if not v1 then
                u130.new(p1.Player, p1.Properties)
                return
            end
            local Properties = p1.Properties
            v2 = nil
            v3 = nil
            for i, j in Properties, v2, v3 do
                if v1.Properties[i] ~= j then
                    v1:_SetProperty(i, j)
                end
            end
            return
        end
        if Type == "PropertyChanged" then
            v1 = u65[p1.Player]
            if not v1 then
                return
            end
            v1:_SetProperty(p1.Index, p1.Value)
            return
        end
        if Type == "Damaged" then
            v1 = u65[p1.Player]
            if v1 then
                local v4
                v4, v2, v3 = unpack(p1.Data)
                v1.Damaged:Fire(v4, v2, v3)
            end
        end
    end)
    PlayerStateEvent:FireServer()
else
    PlayerStateEvent:SetServerListener(function(p1, p2) -- Line: 580 -- upvalues: u110 (val), u65 (val), PlayerStateEvent (val), StatusEffectsEvent (val)
        local StatusEffects, v1, v2, v3, v4, v5
        if p2 then
            local v6
            if p2.Type ~= "PropertyChanged" then
                return
            end
            v2 = u110[p2.Index]
            v3 = u65[p1]
            if not v2 then
                return
            end
            local Value = p2.Value
            if v2 ~= "string_or_false" then
                v6 = typeof(Value) == v2
            else
                v6 = if typeof(Value) ~= "string" then Value == false else true
            end
            if not v6 or not v3 then
                return
            end
            v3:_SetProperty(p2.Index, p2.Value, nil, p1)
            return
        end
        local v7 = u65
        v2 = nil
        v3 = nil
        for i, j in v7, v2, v3 do
            PlayerStateEvent:FireClient(p1, createAddPacket(j))
        end
        v7 = u65
        v2 = nil
        v3 = nil
        for k, n in v7, v2, v3 do
            StatusEffects = n.StatusEffects
            if StatusEffects then
                StatusEffects = n.StatusEffects.EffectObjects
            end
            if StatusEffects then
                v4 = StatusEffects
                v5 = nil
                v1 = nil
                for m, i5 in v4, v5, v1 do
                    if not i5.Inactive then
                        StatusEffectsEvent:FireClient(v8, {Type = "StatusApplied", Player = n.Player, Status = m, Params = i5:Serialize()})
                    end
                end
            end
        end
    end)
end
return u130