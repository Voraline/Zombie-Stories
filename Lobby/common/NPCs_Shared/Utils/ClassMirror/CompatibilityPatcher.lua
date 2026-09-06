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
local u63 = {AddedNPC = u24.new(), MirrorEvent = u47}
function u63.Create(p1, p2, p3, p4, p5) -- Line: 25 -- upvalues: u24 (val), u44 (val), u27 (val), RunService (val), StatusEffect_Util (val), u48 (ref), u47 (val), u33 (val), u62 (val), u63 (val), CollectionService (val), u36 (val), ItemData (val)
    local UID, v1, v2
    local u5 = {DontKill = false, IsCompat = true, Died = u24.new()}
    if not u44 then
        UID = p5
    else
        UID = u27:GetUID()
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
    u5.EffectLoop = RunService.Heartbeat:Connect(function(p1) -- Line: 41 -- upvalues: u5 (ref)
        local CurrentEffects
        if not u5 or not u5.CurrentEffects then
            return
        end
        CurrentEffects = u5.CurrentEffects
        local v1 = nil
        local v2 = nil
        for i, j in CurrentEffects, v1, v2 do
            if j.update then
                j.update(p1)
            end
        end
    end)
    local function disconnectEffectLoop() -- Line: 49 -- upvalues: u5 (ref)
        if u5 and u5.EffectLoop then
            u5.EffectLoop:Disconnect()
            u5.EffectLoop = nil
        end
    end
    function u5.ApplyEffect(p1, ...) -- Line: 55 -- upvalues: StatusEffect_Util (upval), u44 (upval), u48 (upval), u47 (upval), u5 (ref)
        StatusEffect_Util.ApplyEffect(p1, ...)
        if u44 then
            if not u48 then
                u48 = require("@game/ServerStorage/common/WepHandler")
            end
            u47:FireAllClients({
                Type = "ApplyEffect",
                UID = u5.UID,
                args = {...},
            })
        end
    end
    function u5.RemoveEffect(p1, ...) -- Line: 68 -- upvalues: StatusEffect_Util (upval), u44 (upval), u47 (upval), u5 (ref)
        StatusEffect_Util.RemoveEffect(p1, ...)
        if u44 then
            u47:FireAllClients({
                Type = "RemoveEffect",
                UID = u5.UID,
                args = {...},
            })
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
            u47:FireAllClients({Type = "Killable", UID = u5.UID, isKillable = p2})
        end
    end
    if not u44 then
        local function checkModel(p1) -- Line: 156 -- upvalues: u5 (ref), u33 (upval), u47 (upval), u62 (upval), u63 (upval)
            local Attribute = p1:GetAttribute("PatchUID")
            if Attribute ~= u5.UID then
                return false
            end
            u5.Model = p1
            u5.UIDTable = u33:GenUIDTable(p1)
            p1.DescendantAdded:Connect(function(p1) -- Line: 161 -- upvalues: u5 (upval)
                if p1:IsA("BasePart") and p1:GetAttribute("uid") then
                    u5.UIDTable[p1:GetAttribute("uid")] = p1
                end
            end)
            p1.ChildAdded:Connect(function(a1) -- Line: 167 -- upvalues: u5 (upval), u47 (upval), p1 (val)
                if a1:IsA("ForceField") then
                    u5.Immune = true
                    local u7 = nil
                    u7 = a1.Destroying:Once(function() -- Line: 171 -- upvalues: u47 (upval), u7 (ref)
                        u47.Immune = nil
                        u7 = nil
                    end)
                    a1.AncestryChanged:Connect(function(a1_2, p2) -- Line: 176 -- upvalues: a1 (val), p1 (upval), u5 (upval), u7 (ref)
                        if a1_2 == a1 and p2 ~= p1 then
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
            u63.AddedNPC:Fire(u5)
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
            local InstanceAddedSignal = CollectionService:GetInstanceAddedSignal("PatchNPC")
        end
    else
        u5.UIDTable = u33:GenUIDTable(p2)
        p2:AddTag("PatchNPC")
        p2:SetAttribute("PatchUID", u5.UID)
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
                p1.AncestryChanged:Connect(function(a1, a2) -- Line: 107 -- upvalues: u5 (upval), p1 (val), p2 (upval), u8 (ref)
                    if not u5 then
                        return
                    end
                    if a1 == p1 and a2 ~= p2 then
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
        v1 = {Type = "Add", Name = p3, HP = p4, UID = u5.UID}
        u47:FireAllClients(v1)
        u62[u5] = v1
        u63.AddedNPC:Fire(u5)
        function u5.DealDamage(p1, p2, p3, p4) -- Line: 141 -- upvalues: u48 (upval)
            if p1._Destroyed or p1.IsDead or p1.Immune then
                return
            end
            local HP = p1.HP
            p1:ChangeHealth(-p3)
            local v1 = math.max(0, HP - p1.HP)
            u48:CreditDamage(p2, p1, v1, p4)
            if p1.HP <= 0 then
                p1:Kill(p2)
            end
        end
    end
    function u5:Kill(p2, p3) -- Line: 223 -- upvalues: u5 (ref)
        if self.IsDead or self.DontKill then
            return
        end
        self.IsDead = true
        self.Died:Fire(p2, p3)
        if self.EffectLoop and u5 and u5.EffectLoop then
            u5.EffectLoop:Disconnect()
            u5.EffectLoop = nil
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
        if not self.DontKill then
            v1 = 0
        else
            v1 = 1
        end
        self.HP = math.max(self.HP + p2, v1)
        print("Damage Dealt", p2, "NewHP", self.HP)
        if self.HP ~= self.HP then
            self.HealthChanged:Fire(self.HP)
        end
        u47:FireAllClients({Type = "UpdateHealth", UID = u5.UID, HP = u5.HP})
    end
    function u5.ClientChangeHealth(p1) end
    function u5.Hit(p1, p2, p3, p4, p5, p6) -- Line: 265 -- upvalues: u36 (upval), ItemData (upval), u5 (ref)
        if p1._Destroyed or p1.IsDead or p1.Immune then
            return
        end
        local HP = p1.HP
        local v1 = u36(p1, {
            startPos = p2,
            weapon = {Config = p4},
            prevHit = p5,
            shooter = p6,
        }, p3)
        if p1._Destroyed or p1.IsDead then
            return
        end
        p1.LastShotBy = p6
        if p1.HP <= 0 then
            p1:Kill(p6, v1.HitHeadshot)
        elseif p4.OnHitEffect then
            local v2 = table.clone(p4.OnHitEffect)
            v2.Owner = p6
            v2.wepID = ItemData:GetItemIdFromName(p4.WeaponName)
            p1:ApplyEffect(v2.Effect, v2)
        end
        u5.PlayerHurtNPC:Fire(p1.HP, HP - p1.HP, HP, p6, v1)
        return HP - p1.HP, v1
    end
    return u5
end
if not u44 then
    u47:SetClientListener(function(p1) -- Line: 295 -- upvalues: u63 (val), u30 (val)
        local NPC_4
        if not p1 then
            return
        end
        if p1.Type == "Add" then
            u63:Create(nil, p1.Name, p1.HP, p1.UID)
            return
        end
        if p1.Type == "UpdateHealth" then
            local NPC = u30:GetNPC(p1.UID)
            if not NPC then
                return
            end
            NPC.HP = p1.HP
            NPC.HealthChanged:Fire(p1.HP)
            return
        end
        if p1.Type == "ChangeMovementState" then
            local NPC_2 = u30:GetNPC(p1.UID)
            if not NPC_2 then
                return
            end
            NPC_2.MovementStateChanged:Fire(p1.StateKey, p1.Value)
            return
        end
        if p1.Type == "Killable" then
            local NPC_3 = u30:GetNPC(p1.UID)
            if not NPC_3 then
                return
            end
            NPC_3:SetKillable(p1.isKillable)
            return
        end
        if p1.Type == "ApplyEffect" then
            NPC_4 = u30:GetNPC(p1.UID)
            if NPC_4 then
                NPC_4[p1.Type](NPC_4, table.unpack(p1.args))
            end
        elseif p1.Type == "RemoveEffect" then
            NPC_4 = u30:GetNPC(p1.UID)
            if NPC_4 then
                NPC_4[p1.Type](NPC_4, table.unpack(p1.args))
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