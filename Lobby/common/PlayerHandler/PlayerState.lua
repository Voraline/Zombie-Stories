local common = game.ReplicatedStorage.common
local RedEvents = game.ReplicatedStorage.common.RedEvents
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TableKit = require(common.TableKit)
local Signal = require(common.Signal)
local u20 = require("./StatusEffects")
local StatusEffectsEvent = require(RedEvents.Framework.StatusEffectsEvent)
local u39 = nil
if game:GetService("RunService"):IsServer() then
    u39 = require(ReplicatedStorage.common.skillTree.SkillTreeData)
end
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
}
u66.LastHit = os.clock()
u66.PreviousDamage = 0
u66.ImmunityTime = 0.05
u66.HP = 100
u66.MaxHP = 100
u66.GodMode = false
u66.IsDead = false
u66.IsDowned = false
u66.InSwanSong = false
u66.SwanSongEndTime = 0
u66.SwanSongUsed = false
u66.SpartanShield = 0
u66.SpartanShieldMax = 0
u66.SpartanShieldRegenDelay = 5
u66.SpartanLastHitTime = 0
u66.SecondWindDamage = 0
u66.SecondWindMaxDamage = 500
u66.SecondWindUsed = false
u66.IsFocused = false
u66.InstantKill = false
u66.BeingRevived = false
u66.Blocking = false
u66.Charging = false
u66.EquippedGun = false
u66.BlockingStart = os.clock()
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
local u130 = {}
u130.StateAdded = Signal.new()

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
    local v2 = error
    local v3 = tostring(p2)
    v2(("%q is not a valid member of playerState"):format(v3), 2)
end

function u130.__newindex(p1, p2, p3) -- Line: 126 -- upvalues: u66 (val), u48 (val), u130 (val)
    local v1 = rawget(p1, p2)
    if u66[p2] ~= nil then
        local v2 = u48
        p1:_SetProperty(p2, p3, not v2)
        return p1
    end
    if v1 ~= nil then
        p1[p2] = p3
        return p1
    end
    u130[p2] = p3
    return p1
end

function u130.new(p1, p2) -- Line: 139
    -- upvalues: u65 (val), TableKit (val), u66 (val), u20 (val), u130 (val), Signal (val), u48 (val)
    -- upvalues: PlayerStateEvent (val)
    if u65[p1] then
        return u65[p1]
    end
    local v1 = p1 ~= nil
    assert(v1, "PlayerState requires player parameter")
    local u12 = {}
    u12.Player = p1
    if not p2 then
        v1 = TableKit.DeepCopy(u66)
    else
        v1 = p2
    end
    u12.Properties = v1
    v1 = {}
    u12._Events = v1
    u12.StatusEffects = u20.new(p1)
    local v2 = u130
    setmetatable(u12, v2)
    local PropertyChangedSignal = u12:GetPropertyChangedSignal("HP")
    rawset(u12, "HPChanged", PropertyChangedSignal)
    local PropertyChangedSignal_2 = u12:GetPropertyChangedSignal("HP")
    rawset(u12, "HealthChanged", PropertyChangedSignal_2)
    local v3 = Signal
    v3 = v3.new()
    rawset(u12, "Died", v3)
    v3 = Signal
    v3 = v3.new()
    rawset(u12, "Downed", v3)
    v3 = Signal
    v3 = v3.new()
    rawset(u12, "Damaged", v3)
    ;(u12:GetPropertyChangedSignal("IsDead")):Connect(function(p1) -- Line: 162 -- upvalues: u12 (val)
        if p1 then
            u12.Died:Fire()
        end
    end)
    ;(u12:GetPropertyChangedSignal("IsDowned")):Connect(function(p1) -- Line: 167 -- upvalues: u12 (val)
        if p1 then
            u12.Downed:Fire()
        end
    end)
    if u48 then
        v1 = PlayerStateEvent
        v3 = createAddPacket(u12)
        v1:FireAllClientsExcept(p1, v3)
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
    local StatusEffects = p1.StatusEffects
    local StatusEffects_2 = p2.StatusEffects
    StatusEffects:CopyEffects(StatusEffects_2)
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
        local v1 = p1.HP + p2
        local MaxHP = p1.MaxHP
        p1.HP = math.clamp(v1, 0, MaxHP)
    end
end

function u130.RefreshMaxHP(p1) -- Line: 218 -- upvalues: u48 (val), u39 (ref)
    if u48 and u39 then
        local v1 = u39
        local v2 = 100 * (v1.getMaxHPMult(p1.Player))
        local v3 = math.floor(v2)
        local MaxHP = p1.MaxHP
        if v3 ~= MaxHP then
            local v4
            local v5 = MaxHP <= p1.HP
            p1.MaxHP = v3
            if v5 then
                p1.HP = v3
            end
            local Character = p1.Player.Character
            if Character then
                local MaxHP_2 = Character:FindFirstChild("MaxHP")
                local HP = Character:FindFirstChild("HP")
                if MaxHP_2 and MaxHP_2:IsA("NumberValue") then
                    MaxHP_2.Value = v3
                end
                if HP and HP:IsA("NumberValue") then
                    HP.Value = p1.HP
                end
            end
            if _G.plrDictionary and _G.plrDictionary[p1.Player] then
                v4 = _G.plrDictionary[p1.Player]
                if v4.MaxHealth then
                    v4.MaxHealth.Value = v3
                end
                if v4.Health then
                    v4.Health.Value = p1.HP
                end
            end
            p1.Player:SetAttribute("Skill_MaxHP", v3)
            local Player_2 = p1.Player
            local HP_2 = p1.HP
            Player_2:SetAttribute("Skill_CurrentHP", HP_2)
            v4 = print
            local Name = p1.Player.Name
            v4((("[PlayerState] %* MaxHP updated: %* -> %*"):format(Name, MaxHP, v3)))
        end
        return
    end
end

function u130.RefreshSpartanShield(p1) -- Line: 269 -- upvalues: u48 (val), u39 (ref)
    if u48 and u39 then
        if not u39.hasTheSpartan(p1.Player) then
            p1.SpartanShieldMax = 0
            p1.SpartanShield = 0
            return
        end
        p1.SpartanShieldMax = 50
        p1.SpartanShield = 50
        p1.SpartanLastHitTime = 0
        local v1 = print
        local Name = p1.Player.Name
        v1((("[PlayerState] %* Spartan Shield initialized: %*"):format(Name, 50)))
        return
    end
end

function u130:ResetSecondWind() -- Line: 288 -- upvalues: u48 (val)
    if not u48 then
        return
    end
    self.SecondWindDamage = 0
end

function u130.AddSecondWindDamage(p1, p2) -- Line: 298 -- upvalues: u48 (val), u39 (ref)
    if u48 and u39 then
        if not p1.IsDowned or not u39.hasSecondWind(p1.Player) or p1.SecondWindUsed then
            return false
        end
        p1.SecondWindDamage = p1.SecondWindDamage + p2
        local SecondWindDamage = p1.SecondWindDamage
        if not (p1.SecondWindMaxDamage <= SecondWindDamage) then
            return false
        end
        p1.SecondWindDamage = 0
        p1.IsDowned = false
        local v1 = p1.MaxHP * 0.25
        p1.HP = math.floor(v1)
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
            ;(game:GetService("Debris")):AddItem(ForceField, 3)
        end
        v1 = print
        local Name = p1.Player.Name
        v1((("[PlayerState] %* triggered Second Wind self-revive!"):format(Name)))
        return true
    end
    return false
end

function u130.UpdateSpartanShield(p1, p2) -- Line: 346 -- upvalues: u48 (val), PlayerStateEvent (val)
    if not u48 or p1.SpartanShieldMax <= 0 then
        return
    end
    local SpartanShield = p1.SpartanShield
    if p1.SpartanShieldMax <= SpartanShield then
        return
    end
    if not p1.IsDowned and not p1.IsDead then
        local v1 = os.clock() - p1.SpartanLastHitTime
        if p1.SpartanShieldRegenDelay <= v1 then
            local v2 = p1.SpartanShieldMax / 3
            local SpartanShield_2 = p1.SpartanShield
            local v3 = p1.SpartanShield + v2 * p2
            local SpartanShieldMax = p1.SpartanShieldMax
            p1.SpartanShield = math.min(v3, SpartanShieldMax)
            if SpartanShield_2 == 0 and 0 < p1.SpartanShield then
                local v4 = PlayerStateEvent
                local v5 = {Type = "ShieldRegenStart", Player = p1.Player}
                v4:FireAllClients(v5)
            end
        end
        return
    end
end

function u130.Damage(p1, p2, p3, p4, p5) -- Line: 369
    -- upvalues: u48 (val), GameState (val), u39 (ref), PlayerStateEvent (val)
    if not u48 then
        return
    end
    if not (p1.HP <= 0) and not p1.GodMode then
        local PlayerDamageTaken_2
        if p4 then
            p1.InstantKill = true
        end
        if os.clock() < p1.LastHit and p2 <= p1.PreviousDamage then
            return
        end
        local ImmunityTime = p1.ImmunityTime
        local v1 = GameState
        local PlayerDamageTaken = v1.Data.Variables.PlayerDamageTaken
        local v2 = ImmunityTime * math.min(4, PlayerDamageTaken)
        p1.LastHit = os.clock() + p1.ImmunityTime
        p1.PreviousDamage = p2
        if p5 then
            PlayerDamageTaken_2 = 1
        else
            PlayerDamageTaken_2 = GameState.Data.Variables.PlayerDamageTaken
        end
        local v3 = p2 * PlayerDamageTaken_2
        if not p4 and not p5 and u39 then
            v3 = v3 * u39.getDamageReductionMult(p1.Player)
        end
        if v3 ~= v3 then
            print("NaN HP detected!")
            v3 = 0
        end
        local v4 = 0
        if not p4 and 0 < p1.SpartanShieldMax then
            p1.SpartanLastHitTime = os.clock()
            if 0 < p1.SpartanShield then
                local SpartanShield = p1.SpartanShield
                v4 = math.min(SpartanShield, v3)
                p1.SpartanShield = p1.SpartanShield - v4
                v3 = v3 - v4
            end
        end
        local v5 = p1.HP - v3
        local MaxHP = p1.MaxHP
        p1.HP = math.clamp(v5, 0, MaxHP)
        local Damaged = p1.Damaged
        local HP = p1.HP
        Damaged:Fire(HP, v3, p3, v4)
        local v6 = PlayerStateEvent
        v1 = {
            Type = "Damaged",
            Player = p1.Player,
            Data = {p1.HP, v3, p3, v4, p1.SpartanShield},
        }
        v6:FireAllClients(v1)
        return
    end
end

function u130:GetPropertyChangedSignal(p2) -- Line: 424 -- upvalues: u66 (val), Signal (val)
    local v1 = u66[p2] ~= nil
    local v2 = ("PlayerState has no property '%s'"):format(p2)
    assert(v1, v2)
    if not self._Events[p2] then
        self._Events[p2] = (Signal.new())
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

function u130:_SetProperty(p2, p3, p4, p5) -- Line: 449
    -- upvalues: u66 (val), u48 (val), Value (val), u39 (ref), u40 (ref), PlayerStateEvent (val), u110 (val)
    if u66[p2] ~= nil then
        local v1, v2
        local v3 = p2 ~= "StatusEffects"
        assert(v3, "Can't set StatusEffects property, please modify the StatusEffects object instead")
        local v4 = self.Properties[p2]
        if v4 == p3 then
            return
        end
        self.Properties[p2] = p3
        v3 = self._Events[p2]
        if v3 then
            v3:Fire(p3, v4)
        end
        if u48 then
            if p2 == "Blocking" then
                if not p3 then
                    v1 = false
                else
                    v1 = os.clock()
                end
                self.BlockingStart = v1
            elseif p2 == "HP" and self.HP == 0 then
                local Downed, v5, v6
                if not Value then
                    Downed = self.StatusEffects.Downed
                    if self.InstantKill then
                        self.IsDead = true
                        self.InstantKill = false
                        if Downed then
                            Downed:ResetRunState()
                        end
                    elseif not Downed then
                        v6 = u39
                        if v6 then
                            v6 = u39.hasSwanSong(self.Player)
                        end
                        if not v6 or self.InSwanSong then
                            if not self.InSwanSong then
                                if not u39 then
                                    v2 = 1
                                else
                                    v2 = u39.getDownedTimeMult(self.Player)
                                    if not v2 then
                                        v2 = 1
                                    end
                                end
                                v5 = 30 * v2
                                self:ApplyStatus("Downed", v5)
                                self.IsDowned = true
                                self:ResetSecondWind()
                            else
                                self.HP = 1
                            end
                        elseif not self.SwanSongUsed then
                            self.InSwanSong = true
                            self.SwanSongUsed = true
                            self.SwanSongEndTime = workspace:GetServerTimeNow() + 4
                            self.HP = 1
                            task.spawn(function() -- Line: 505 -- upvalues: self (val)
                                task.wait(4)
                                if self.InSwanSong then
                                    local v1 = self
                                    if not rawget(v1, "_Destroyed") then
                                        self.InSwanSong = false
                                        self.SwanSongEndTime = 0
                                        self.HP = 0
                                    end
                                end
                            end)
                        elseif not self.InSwanSong then
                            if not u39 then
                                v2 = 1
                            else
                                v2 = u39.getDownedTimeMult(self.Player)
                                if not v2 then
                                    v2 = 1
                                end
                            end
                            v5 = 30 * v2
                            self:ApplyStatus("Downed", v5)
                            self.IsDowned = true
                            self:ResetSecondWind()
                        else
                            self.HP = 1
                        end
                    elseif not Downed._RevivesLeft then
                        v6 = u39
                        if v6 then
                            v6 = u39.hasSwanSong(self.Player)
                        end
                        if not v6 or self.InSwanSong then
                            if not self.InSwanSong then
                                if not u39 then
                                    v2 = 1
                                else
                                    v2 = u39.getDownedTimeMult(self.Player)
                                    if not v2 then
                                        v2 = 1
                                    end
                                end
                                v5 = 30 * v2
                                self:ApplyStatus("Downed", v5)
                                self.IsDowned = true
                                self:ResetSecondWind()
                            else
                                self.HP = 1
                            end
                        elseif not self.SwanSongUsed then
                            self.InSwanSong = true
                            self.SwanSongUsed = true
                            self.SwanSongEndTime = workspace:GetServerTimeNow() + 4
                            self.HP = 1
                            task.spawn(function() -- Line: 505 -- upvalues: self (val)
                                task.wait(4)
                                if self.InSwanSong then
                                    local v1 = self
                                    if not rawget(v1, "_Destroyed") then
                                        self.InSwanSong = false
                                        self.SwanSongEndTime = 0
                                        self.HP = 0
                                    end
                                end
                            end)
                        elseif not self.InSwanSong then
                            if not u39 then
                                v2 = 1
                            else
                                v2 = u39.getDownedTimeMult(self.Player)
                                if not v2 then
                                    v2 = 1
                                end
                            end
                            v5 = 30 * v2
                            self:ApplyStatus("Downed", v5)
                            self.IsDowned = true
                            self:ResetSecondWind()
                        else
                            self.HP = 1
                        end
                    elseif not (Downed._RevivesLeft <= 0) then
                        v6 = u39
                        if v6 then
                            v6 = u39.hasSwanSong(self.Player)
                        end
                        if not v6 or self.InSwanSong then
                            if not self.InSwanSong then
                                if not u39 then
                                    v2 = 1
                                else
                                    v2 = u39.getDownedTimeMult(self.Player)
                                    if not v2 then
                                        v2 = 1
                                    end
                                end
                                v5 = 30 * v2
                                self:ApplyStatus("Downed", v5)
                                self.IsDowned = true
                                self:ResetSecondWind()
                            else
                                self.HP = 1
                            end
                        elseif not self.SwanSongUsed then
                            self.InSwanSong = true
                            self.SwanSongUsed = true
                            self.SwanSongEndTime = workspace:GetServerTimeNow() + 4
                            self.HP = 1
                            task.spawn(function() -- Line: 505 -- upvalues: self (val)
                                task.wait(4)
                                if self.InSwanSong then
                                    local v1 = self
                                    if not rawget(v1, "_Destroyed") then
                                        self.InSwanSong = false
                                        self.SwanSongEndTime = 0
                                        self.HP = 0
                                    end
                                end
                            end)
                        elseif not self.InSwanSong then
                            if not u39 then
                                v2 = 1
                            else
                                v2 = u39.getDownedTimeMult(self.Player)
                                if not v2 then
                                    v2 = 1
                                end
                            end
                            v5 = 30 * v2
                            self:ApplyStatus("Downed", v5)
                            self.IsDowned = true
                            self:ResetSecondWind()
                        else
                            self.HP = 1
                        end
                    else
                        self.IsDead = true
                        self.InstantKill = false
                        if Downed then
                            Downed:ResetRunState()
                        end
                    end
                elseif self.InstantKill then
                    Downed = self.StatusEffects.Downed
                    if self.InstantKill then
                        self.IsDead = true
                        self.InstantKill = false
                        if Downed then
                            Downed:ResetRunState()
                        end
                    elseif not Downed then
                        v6 = u39
                        if v6 then
                            v6 = u39.hasSwanSong(self.Player)
                        end
                        if not v6 or self.InSwanSong then
                            if not self.InSwanSong then
                                if not u39 then
                                    v2 = 1
                                else
                                    v2 = u39.getDownedTimeMult(self.Player)
                                    if not v2 then
                                        v2 = 1
                                    end
                                end
                                v5 = 30 * v2
                                self:ApplyStatus("Downed", v5)
                                self.IsDowned = true
                                self:ResetSecondWind()
                            else
                                self.HP = 1
                            end
                        elseif not self.SwanSongUsed then
                            self.InSwanSong = true
                            self.SwanSongUsed = true
                            self.SwanSongEndTime = workspace:GetServerTimeNow() + 4
                            self.HP = 1
                            task.spawn(function() -- Line: 505 -- upvalues: self (val)
                                task.wait(4)
                                if self.InSwanSong then
                                    local v1 = self
                                    if not rawget(v1, "_Destroyed") then
                                        self.InSwanSong = false
                                        self.SwanSongEndTime = 0
                                        self.HP = 0
                                    end
                                end
                            end)
                        elseif not self.InSwanSong then
                            if not u39 then
                                v2 = 1
                            else
                                v2 = u39.getDownedTimeMult(self.Player)
                                if not v2 then
                                    v2 = 1
                                end
                            end
                            v5 = 30 * v2
                            self:ApplyStatus("Downed", v5)
                            self.IsDowned = true
                            self:ResetSecondWind()
                        else
                            self.HP = 1
                        end
                    elseif not Downed._RevivesLeft then
                        v6 = u39
                        if v6 then
                            v6 = u39.hasSwanSong(self.Player)
                        end
                        if not v6 or self.InSwanSong then
                            if not self.InSwanSong then
                                if not u39 then
                                    v2 = 1
                                else
                                    v2 = u39.getDownedTimeMult(self.Player)
                                    if not v2 then
                                        v2 = 1
                                    end
                                end
                                v5 = 30 * v2
                                self:ApplyStatus("Downed", v5)
                                self.IsDowned = true
                                self:ResetSecondWind()
                            else
                                self.HP = 1
                            end
                        elseif not self.SwanSongUsed then
                            self.InSwanSong = true
                            self.SwanSongUsed = true
                            self.SwanSongEndTime = workspace:GetServerTimeNow() + 4
                            self.HP = 1
                            task.spawn(function() -- Line: 505 -- upvalues: self (val)
                                task.wait(4)
                                if self.InSwanSong then
                                    local v1 = self
                                    if not rawget(v1, "_Destroyed") then
                                        self.InSwanSong = false
                                        self.SwanSongEndTime = 0
                                        self.HP = 0
                                    end
                                end
                            end)
                        elseif not self.InSwanSong then
                            if not u39 then
                                v2 = 1
                            else
                                v2 = u39.getDownedTimeMult(self.Player)
                                if not v2 then
                                    v2 = 1
                                end
                            end
                            v5 = 30 * v2
                            self:ApplyStatus("Downed", v5)
                            self.IsDowned = true
                            self:ResetSecondWind()
                        else
                            self.HP = 1
                        end
                    elseif not (Downed._RevivesLeft <= 0) then
                        v6 = u39
                        if v6 then
                            v6 = u39.hasSwanSong(self.Player)
                        end
                        if not v6 or self.InSwanSong then
                            if not self.InSwanSong then
                                if not u39 then
                                    v2 = 1
                                else
                                    v2 = u39.getDownedTimeMult(self.Player)
                                    if not v2 then
                                        v2 = 1
                                    end
                                end
                                v5 = 30 * v2
                                self:ApplyStatus("Downed", v5)
                                self.IsDowned = true
                                self:ResetSecondWind()
                            else
                                self.HP = 1
                            end
                        elseif not self.SwanSongUsed then
                            self.InSwanSong = true
                            self.SwanSongUsed = true
                            self.SwanSongEndTime = workspace:GetServerTimeNow() + 4
                            self.HP = 1
                            task.spawn(function() -- Line: 505 -- upvalues: self (val)
                                task.wait(4)
                                if self.InSwanSong then
                                    local v1 = self
                                    if not rawget(v1, "_Destroyed") then
                                        self.InSwanSong = false
                                        self.SwanSongEndTime = 0
                                        self.HP = 0
                                    end
                                end
                            end)
                        elseif not self.InSwanSong then
                            if not u39 then
                                v2 = 1
                            else
                                v2 = u39.getDownedTimeMult(self.Player)
                                if not v2 then
                                    v2 = 1
                                end
                            end
                            v5 = 30 * v2
                            self:ApplyStatus("Downed", v5)
                            self.IsDowned = true
                            self:ResetSecondWind()
                        else
                            self.HP = 1
                        end
                    else
                        self.IsDead = true
                        self.InstantKill = false
                        if Downed then
                            Downed:ResetRunState()
                        end
                    end
                elseif not rawget(self, "Revival") then
                    rawset(self, "Revival", true)
                    task.spawn(function() -- Line: 475 -- upvalues: self (val)
                        local HP, v1
                        task.wait(1)
                        repeat
                            task.wait()
                            self.HP = self.HP + 1
                            v1 = self
                            HP = v1.HP
                        until (self.MaxHP or 100) <= HP
                        self.HP = self.MaxHP
                        local v2 = self
                        rawset(v2, "Revival", nil)
                    end)
                end
            end
            if not u40 and p5 then
                return
            end
            v1 = {Type = "PropertyChanged", Player = self.Player, Index = p2, Value = p3}
            if p5 then
                PlayerStateEvent:FireAllClientsExcept(p5, v1)
                return
            end
            PlayerStateEvent:FireAllClients(v1)
            return
        end
        if p4 and u110[p2] ~= nil then
            v1 = PlayerStateEvent
            v2 = {Type = "PropertyChanged", Index = p2, Value = p3}
            v1:FireServer(v2)
        end
    end
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
    v1 = true
    if typeof(p1) ~= "string" then
        v1 = p1 == false
    end
    return v1
end

if not u48 then
    PlayerStateEvent:SetClientListener(function(p1) -- Line: 618 -- upvalues: u65 (val), u130 (val)
        if p1 then
            local v1, v2, v3
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
                if v1 then
                    local Index = p1.Index
                    local Value = p1.Value
                    v1:_SetProperty(Index, Value)
                    return
                end
            elseif Type == "Damaged" then
                v1 = u65[p1.Player]
                if v1 then
                    local v4
                    local Data = p1.Data
                    v4, v2, v3 = unpack(Data)
                    v1.Damaged:Fire(v4, v2, v3)
                end
            end
        end
    end)
    PlayerStateEvent:FireServer()
else
    PlayerStateEvent:SetServerListener(function(p1, p2) -- Line: 580 -- upvalues: u110 (val), u65 (val), PlayerStateEvent (val), StatusEffectsEvent (val)
        local StatusEffects, v1, v2, v3, v4, v5, v6, v7, v8
        if p2 then
            if p2.Type == "PropertyChanged" then
                v4 = u110[p2.Index]
                v5 = u65[p1]
                if v4 then
                    local v9
                    local Value = p2.Value
                    if v4 ~= "string_or_false" then
                        v9 = typeof(Value) == v4
                    else
                        v9 = true
                        if typeof(Value) ~= "string" then
                            v9 = Value == false
                        end
                    end
                    if v9 and v5 then
                        local Index = p2.Index
                        local Value_2 = p2.Value
                        v5:_SetProperty(Index, Value_2, nil, p1)
                        return
                    end
                end
            end
            return
        end
        local v10 = u65
        v4 = nil
        v5 = nil
        for i, j in v10, v4, v5 do
            v6 = PlayerStateEvent
            v1 = createAddPacket(j)
            v6:FireClient(p1, v1)
        end
        v10 = u65
        v4 = nil
        v5 = nil
        for k, n in v10, v4, v5 do
            StatusEffects = n.StatusEffects
            if StatusEffects then
                StatusEffects = n.StatusEffects.EffectObjects
            end
            if StatusEffects then
                v7 = StatusEffects
                v8 = nil
                v1 = nil
                for m, i5 in v7, v8, v1 do
                    if not i5.Inactive then
                        v2 = StatusEffectsEvent
                        v3 = {Type = "StatusApplied", Player = n.Player, Status = m, Params = i5:Serialize()}
                        v2:FireClient(v11, v3)
                    end
                end
            end
        end
    end)
end
return u130