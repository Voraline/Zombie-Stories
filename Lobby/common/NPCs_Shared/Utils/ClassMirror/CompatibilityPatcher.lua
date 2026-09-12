local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
game:GetService("ServerStorage")
local NPCs_Shared = game.ReplicatedStorage.common:WaitForChild("NPCs_Shared")
local u24 = require("@game/ReplicatedStorage/common/Signal")
local u27 = require("@game/ReplicatedStorage/common/NPCs_Shared/Utils/UIDManager")
local u30 = require("@game/ReplicatedStorage/common/NPCRegistry")
local u33 = require("@game/ReplicatedStorage/common/NPCs_Shared/Utils/DamageHelper_Util")
local u36 = require("@game/ReplicatedStorage/common/NPCs_Shared/Utils/Hitreg_Util")
local u44 = game:GetService("RunService"):IsServer()
local u47 = require("@game/ReplicatedStorage/common/RedEvents/NPC/CompatEvent")
local u48 = nil
local ItemData = require(game.ReplicatedStorage.common:WaitForChild("ItemData"))
local StatusEffect_Util = require(NPCs_Shared.Utils.StatusEffect_Util)
local u62 = {}
local u63 = {}
u63.AddedNPC = u24.new()
u63.MirrorEvent = u47

function u63.Create(p1, p2, p3, p4, p5) -- Line: 25
    -- upvalues: u24 (val), u44 (val), u27 (val), RunService (val), StatusEffect_Util (val), u48 (ref), u47 (val)
    -- upvalues: u33 (val), u62 (val), u63 (val), CollectionService (val), u36 (val), ItemData (val)
    local UID, v1, v2
    local u5 = {DontKill = false, IsCompat = true}
    u5.Died = u24.new()
    if not u44 then
        UID = p5
    else
        UID = u27:GetUID()
        if not UID then
            UID = p5
        end
    end
    u5.UID = UID
    u5.Name = p3
    u5.Model = p2
    u5.MaxHP = p4
    u5.HP = p4
    u5.PlayerHurtNPC = u24.new()
    u5.Destroyed = u24.new()
    u5.HealthChanged = u24.new()
    u5.MovementStateChanged = u24.new()
    u5.StatusUpdated = u24.new()
    local v3 = RunService
    local Heartbeat = v3.Heartbeat
    u5.EffectLoop = Heartbeat:Connect(function(p1) -- Line: 41 -- upvalues: u5 (ref)
        if u5 and u5.CurrentEffects then
            local CurrentEffects = u5.CurrentEffects
            local v1 = nil
            local v2 = nil
            for i, j in CurrentEffects, v1, v2 do
                if j.update then
                    j.update(p1)
                end
            end
            return
        end
    end)

    local function disconnectEffectLoop() -- Line: 49 -- upvalues: u5 (ref)
        if u5 and u5.EffectLoop then
            u5.EffectLoop:Disconnect()
            u5.EffectLoop = nil
        end
    end

    function u5.ApplyEffect(p1, ...) -- Line: 55
        -- upvalues: StatusEffect_Util (upval), u44 (upval), u48 (upval), u47 (upval), u5 (ref)
        StatusEffect_Util.ApplyEffect(p1, ...)
        if u44 then
            if not u48 then
                u48 = require("@game/ServerStorage/common/WepHandler")
            end
            local v1 = u47
            local v2 = {
                Type = "ApplyEffect",
                UID = u5.UID,
                args = {...},
            }
            v1:FireAllClients(v2)
        end
    end

    function u5.RemoveEffect(p1, ...) -- Line: 68
        -- upvalues: StatusEffect_Util (upval), u44 (upval), u47 (upval), u5 (ref)
        StatusEffect_Util.RemoveEffect(p1, ...)
        if u44 then
            local v1 = u47
            local v2 = {
                Type = "RemoveEffect",
                UID = u5.UID,
                args = {...},
            }
            v1:FireAllClients(v2)
        end
    end

    function u5:SetKillable(p2) -- Line: 79 -- upvalues: u44 (upval), u47 (upval), u5 (ref)
        local v1
        if p2 then
            v1 = nil
        else
            v1 = true
        end
        self.DontKill = v1
        if u44 then
            v1 = u47
            local v2 = {Type = "Killable", UID = u5.UID, isKillable = p2}
            v1:FireAllClients(v2)
        end
    end

    if not u44 then
        local function checkModel(p1) -- Line: 156
            -- upvalues: u5 (ref), u33 (upval), u47 (upval), u62 (upval), u63 (upval)
            if (p1:GetAttribute("PatchUID")) ~= u5.UID then
                return false
            end
            u5.Model = p1
            u5.UIDTable = u33:GenUIDTable(p1)
            p1.DescendantAdded:Connect(function(p1) -- Line: 161 -- upvalues: u5 (upval)
                if p1:IsA("BasePart") and p1:GetAttribute("uid") then
                    u5.UIDTable[p1:GetAttribute("uid")] = p1
                end
            end)
            p1.ChildAdded:Connect(function(p1_2) -- Line: 167 -- upvalues: u5 (upval), u47 (upval), p1 (val)
                if p1_2:IsA("ForceField") then
                    u5.Immune = true
                    local u7 = nil
                    u7 = p1_2.Destroying:Once(function() -- Line: 171 -- upvalues: u47 (upval), u7 (ref)
                        u47.Immune = nil
                        u7 = nil
                    end)
                    p1_2.AncestryChanged:Connect(function(p1_3, p2) -- Line: 176 -- upvalues: p1_2 (val), p1 (upval), u5 (upval), u7 (ref)
                        if p1_3 == p1_2 and p2 ~= p1 then
                            u5.Immune = nil
                            if u7 then
                                u7:Disconnect()
                                u7 = nil
                            end
                        end
                    end)
                end
            end)
            p1.AncestryChanged:Connect(function(p1, p2) -- Line: 188 -- upvalues: u62 (upval), u5 (upval)
                if p2 == nil then
                    u62[u5] = nil
                    if u5 and u5.EffectLoop then
                        u5.EffectLoop:Disconnect()
                        u5.EffectLoop = nil
                    end
                    u5.Destroyed:Fire()
                    u5.Died:Fire()
                    u5 = nil
                end
            end)
            local v1 = u63
            local AddedNPC = v1.AddedNPC
            local v2 = u5
            AddedNPC:Fire(v2)
            return true
        end

        v2 = false
        for i, j in CollectionService:GetTagged("PatchNPC") do
            if checkModel(j) then
                v2 = true
                break
            end
        end
        if not v2 then
            local u120 = nil
            v1 = (CollectionService:GetInstanceAddedSignal("PatchNPC")):Connect(function(p1) -- Line: 212 -- upvalues: checkModel (val), u120 (ref)
                if checkModel(p1) then
                    u120:Disconnect()
                end
            end)
        end
    else
        u5.UIDTable = u33:GenUIDTable(p2)
        p2:AddTag("PatchNPC")
        local UID_2 = u5.UID
        p2:SetAttribute("PatchUID", UID_2)
        p2:SetAttribute("NPCName", p3)
        p2.ChildAdded:Connect(function(p1) -- Line: 96 -- upvalues: u5 (ref), p2 (val)
            if not u5 then
                return
            end
            if p1:IsA("ForceField") then
                u5.Immune = true
                local u8 = nil
                u8 = p1.Destroying:Once(function() -- Line: 101 -- upvalues: u5 (upval), u8 (ref)
                    if not u5 then
                        return
                    end
                    u5.Immune = nil
                    u8 = nil
                end)
                p1.AncestryChanged:Connect(function(p1_2, p2_2) -- Line: 107 -- upvalues: u5 (upval), p1 (val), p2 (upval), u8 (ref)
                    if not u5 then
                        return
                    end
                    if p1_2 == p1 and p2_2 ~= p2 then
                        u5.Immune = nil
                        if u8 then
                            u8:Disconnect()
                            u8 = nil
                        end
                    end
                end)
            end
        end)
        p2.AncestryChanged:Connect(function(p1, p2) -- Line: 121 -- upvalues: u62 (upval), u5 (ref)
            if p2 == nil then
                u62[u5] = nil
                if u5 and u5.EffectLoop then
                    u5.EffectLoop:Disconnect()
                    u5.EffectLoop = nil
                end
                u5.Destroyed:Fire()
                u5.Died:Fire()
                u5 = nil
            end
        end)
        local v4 = {Type = "Add", Name = p3, HP = p4, UID = u5.UID}
        u47:FireAllClients(v4)
        u62[u5] = v4
        v2 = u63
        local AddedNPC = v2.AddedNPC
        v1 = u5
        AddedNPC:Fire(v1)

        function u5.DealDamage(p1, p2, p3, p4) -- Line: 141 -- upvalues: u48 (upval)
            if not p1._Destroyed and not p1.IsDead and not p1.Immune then
                local HP = p1.HP
                local v1 = -p3
                p1:ChangeHealth(v1)
                v1 = HP - p1.HP
                local v2 = math.max(0, v1)
                u48:CreditDamage(p2, p1, v2, p4)
                if p1.HP <= 0 then
                    p1:Kill(p2)
                end
                return
            end
        end
    end

    function u5:Kill(p2, p3) -- Line: 223 -- upvalues: u5 (ref)
        if not self.IsDead and not self.DontKill then
            self.IsDead = true
            self.Died:Fire(p2, p3)
            if self.EffectLoop and u5 and u5.EffectLoop then
                u5.EffectLoop:Disconnect()
                u5.EffectLoop = nil
            end
            return
        end
    end

    function u5.ClientShot(p1, p2) -- Line: 232 -- upvalues: u36 (upval)
        if p1.Immune then
            return
        end
        return (u36(p1, p2))
    end

    function u5:ChangeHealth(p2) -- Line: 244 -- upvalues: u47 (upval), u5 (ref)
        local v1
        local HP = self.HP
        local v2 = self.HP + p2
        if not self.DontKill then
            v1 = 0
        else
            v1 = 1
        end
        self.HP = math.max(v2, v1)
        print("Damage Dealt", p2, "NewHP", self.HP)
        if self.HP ~= HP then
            local HealthChanged = self.HealthChanged
            local HP_2 = self.HP
            HealthChanged:Fire(HP_2)
        end
        local v3 = u47
        v1 = {Type = "UpdateHealth", UID = u5.UID, HP = u5.HP}
        v3:FireAllClients(v1)
    end

    function u5.ClientChangeHealth(p1) end

    function u5.Hit(p1, p2, p3, p4, p5, p6) -- Line: 265 -- upvalues: u36 (upval), ItemData (upval), u5 (ref)
        if not p1._Destroyed and not p1.IsDead and not p1.Immune then
            local HP = p1.HP
            local v1 = u36
            local v2 = {
                startPos = p2,
                weapon = {Config = p4},
                prevHit = p5,
                shooter = p6,
            }
            v1 = v1(p1, v2, p3)
            if not p1._Destroyed and not p1.IsDead then
                local v3
                p1.LastShotBy = p6
                if p1.HP <= 0 then
                    local HitHeadshot = v1.HitHeadshot
                    p1:Kill(p6, HitHeadshot)
                elseif p4.OnHitEffect then
                    v3 = table.clone(p4.OnHitEffect)
                    v3.Owner = p6
                    v2 = ItemData
                    local WeaponName = p4.WeaponName
                    v3.wepID = v2:GetItemIdFromName(WeaponName)
                    local Effect = v3.Effect
                    p1:ApplyEffect(Effect, v3)
                end
                v3 = u5
                local PlayerHurtNPC = v3.PlayerHurtNPC
                local HP_2 = p1.HP
                local v4 = HP - p1.HP
                PlayerHurtNPC:Fire(HP_2, v4, HP, p6, v1)
                return HP - p1.HP, v1
            end
            return
        end
    end

    return u5
end

if not u44 then
    u47:SetClientListener(function(p1) -- Line: 295 -- upvalues: u63 (val), u30 (val)
        if p1 then
            local v1
            if p1.Type == "Add" then
                v1 = u63
                local Name = p1.Name
                local HP = p1.HP
                local UID = p1.UID
                v1:Create(nil, Name, HP, UID)
                return
            end
            if p1.Type == "UpdateHealth" then
                v1 = u30
                local UID_2 = p1.UID
                local NPC = v1:GetNPC(UID_2)
                if NPC then
                    NPC.HP = p1.HP
                    local HealthChanged = NPC.HealthChanged
                    local HP_2 = p1.HP
                    HealthChanged:Fire(HP_2)
                    return
                end
            elseif p1.Type == "ChangeMovementState" then
                v1 = u30
                local UID_3 = p1.UID
                local NPC_2 = v1:GetNPC(UID_3)
                if NPC_2 then
                    local MovementStateChanged = NPC_2.MovementStateChanged
                    local StateKey = p1.StateKey
                    local Value = p1.Value
                    MovementStateChanged:Fire(StateKey, Value)
                    return
                end
            elseif p1.Type == "Killable" then
                v1 = u30
                local UID_4 = p1.UID
                local NPC_3 = v1:GetNPC(UID_4)
                if NPC_3 then
                    local isKillable = p1.isKillable
                    NPC_3:SetKillable(isKillable)
                    return
                end
            elseif p1.Type == "ApplyEffect" or p1.Type == "RemoveEffect" then
                local args = p1.args
                local v2 = u30
                local UID_5 = p1.UID
                local NPC_4 = v2:GetNPC(UID_5)
                if NPC_4 then
                    NPC_4[p1.Type](NPC_4, table.unpack(args))
                end
            end
        end
    end)
else
    game.Players.PlayerAdded:Connect(function(p1) -- Line: 288 -- upvalues: u62 (val), u47 (val)
        local v1 = u62
        local v2 = nil
        local v3 = nil
        for i, j in v1, v2, v3 do
            j.HP = i.HP
            u47:FireClient(p1, j)
        end
    end)
end
return u63