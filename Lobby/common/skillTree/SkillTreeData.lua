game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local u22 = require("./config/SkillConfig")
local u23 = {}
if RunService:IsServer() then
    game:GetService("ServerScriptService")
    require("@game/ServerScriptService/common/zap")
    local u35 = {}

    function u23.initializePlayer(p1) -- Line: 37 -- upvalues: u35 (val), u22 (val)
        local v1
        u35[p1] = {}
        local skills = u22.skills
        local v2 = nil
        local v3 = nil
        for i in skills, v2, v3 do
            v1 = u35[p1]
            v1[i] = 0
        end
    end

    function u23.cleanupPlayer(p1) -- Line: 47 -- upvalues: u35 (val)
        u35[p1] = nil
    end

    function u23.getSkillRank(p1, p2) -- Line: 54 -- upvalues: u35 (val)
        local v1 = u35[p1]
        if not v1 then
            return 0
        end
        return v1[p2] or 0
    end

    function u23.setSkillRank(p1, p2, p3) -- Line: 63 -- upvalues: u35 (val)
        local v1 = u35[p1]
        if v1 then
            v1[p2] = p3
        end
    end

    function u23.getAllSkillRanks(p1) -- Line: 73 -- upvalues: u35 (val)
        local v1 = u35[p1]
        if not v1 then
            v1 = {}
        end
        return v1
    end

    function u23.getReloadSpeedMult(p1) -- Line: 85 -- upvalues: u23 (val)
        return 1 / (1 + 0.04 * u23.getSkillRank(p1, "fastHands"))
    end

    function u23.getRecoilMult(p1) -- Line: 93 -- upvalues: u23 (val)
        return 1 - 0.04 * u23.getSkillRank(p1, "steadyAim")
    end

    function u23.getSwapSpeedMult(p1) -- Line: 101 -- upvalues: u23 (val)
        return 1 + 0.1 * (u23.getSkillRank(p1, "sleightSwitch"))
    end

    function u23.getMaxHPMult(p1) -- Line: 109 -- upvalues: u23 (val)
        local v1 = u23.getSkillRank(p1, "thickSkin")
        local v2 = u23.getSkillRank(p1, "core2")
        return 1 + 0.1 * v1 + 0.1 * v2
    end

    function u23.getDamageReductionMult(p1) -- Line: 118 -- upvalues: u23 (val)
        return 1 - 0.03 * u23.getSkillRank(p1, "grit")
    end

    function u23.getAmmoCapacityMult(p1) -- Line: 126 -- upvalues: u23 (val)
        return 1 + 0.08 * (u23.getSkillRank(p1, "deepPockets"))
    end

    function u23.getInteractSpeedMult(p1) -- Line: 134 -- upvalues: u23 (val)
        return 1 + 0.05 * (u23.getSkillRank(p1, "quickInteract"))
    end

    function u23.getMeleeSwingSpeedMult(p1) -- Line: 142 -- upvalues: u23 (val)
        return 1 + 0.1 * (u23.getSkillRank(p1, "meleeTempo"))
    end

    function u23.getDownedTimeMult(p1) -- Line: 150 -- upvalues: u23 (val)
        return 1 + 0.15 * (u23.getSkillRank(p1, "ironWill"))
    end

    function u23.getHeadshotDamageMult(p1) -- Line: 158 -- upvalues: u23 (val)
        return 1 + 0.05 * (u23.getSkillRank(p1, "core3"))
    end

    function u23.getXPBonusMult(p1) -- Line: 166 -- upvalues: u23 (val)
        return 1 + 0.05 * (u23.getSkillRank(p1, "core1"))
    end

    function u23.getAdrenalineStamina(p1) -- Line: 174 -- upvalues: u23 (val)
        return 5 * (u23.getSkillRank(p1, "adrenaline"))
    end

    function u23.getParryWindowBonus(p1) -- Line: 182 -- upvalues: u23 (val)
        return 0.1 * (u23.getSkillRank(p1, "parryMaster"))
    end

    function u23.getSpartanCooldownMult(p1) -- Line: 190 -- upvalues: u23 (val)
        return 1 - 0.1 * u23.getSkillRank(p1, "theSpartan")
    end

    function u23.hasFury(p1) -- Line: 199 -- upvalues: u23 (val)
        local v1 = 1 <= (u23.getSkillRank(p1, "fury"))
        return v1
    end

    function u23.hasDeadEye(p1) -- Line: 203 -- upvalues: u23 (val)
        local v1 = 1 <= (u23.getSkillRank(p1, "deadEye"))
        return v1
    end

    function u23.hasQuickDraw(p1) -- Line: 207 -- upvalues: u23 (val)
        local v1 = 1 <= (u23.getSkillRank(p1, "quickDraw"))
        return v1
    end

    function u23.hasSecondChance(p1) -- Line: 211 -- upvalues: u23 (val)
        local v1 = 1 <= (u23.getSkillRank(p1, "secondChance"))
        return v1
    end

    function u23.hasSwanSong(p1) -- Line: 215 -- upvalues: u23 (val)
        local v1 = 1 <= (u23.getSkillRank(p1, "swanSong"))
        return v1
    end

    function u23.hasSecondWind(p1) -- Line: 219 -- upvalues: u23 (val)
        local v1 = 1 <= (u23.getSkillRank(p1, "secondWind"))
        return v1
    end

    function u23.hasLastStand(p1) -- Line: 223 -- upvalues: u23 (val)
        local v1 = 1 <= (u23.getSkillRank(p1, "lastStand"))
        return v1
    end

    function u23.hasTheSpartan(p1) -- Line: 227 -- upvalues: u23 (val)
        local v1 = 1 <= (u23.getSkillRank(p1, "theSpartan"))
        return v1
    end

    function u23.getExtraDowns(p1) -- Line: 235 -- upvalues: u23 (val)
        return (u23.getSkillRank(p1, "core4")) + u23.getSkillRank(p1, "secondChance")
    end

    return u23
end
local Packages = ReplicatedStorage:WaitForChild("Packages")
local Fusion = require(Packages:WaitForChild("Fusion"))
local v1 = require("@game/ReplicatedStorage/common/zap")
local v2 = require("@game/ReplicatedStorage/common/Signal")
local v3 = Fusion.scoped(Fusion)
u23.Scope = v3
local u83 = {}
local skills = u22.skills
local v4 = nil
local v5 = nil
for i in skills, v4, v5 do
    u83[i] = (v3:Value(0))
end
u23.SkillRanks = u83
u23.Loaded = v3:Value(false)

function u23.getSkillRankValue(p1) -- Line: 268 -- upvalues: u83 (val)
    return u83[p1]
end

function u23.getSkillRank(p1) -- Line: 275 -- upvalues: u83 (val), Fusion (val)
    local v1
    local v2 = u83[p1]
    if not v2 then
        v1 = 0
    else
        v1 = Fusion.peek(v2)
        if not v1 then
            v1 = 0
        end
    end
    return v1
end

local function setSkillRank(p1, p2) -- Line: 283 -- upvalues: u83 (val)
    local v1 = u83[p1]
    if v1 then
        v1:set(p2)
    end
end

u23.ReloadSpeedMult = v3:Computed(function(p1) -- Line: 295 -- upvalues: u83 (val)
    return 1 / (1 + 0.04 * (p1(u83.fastHands) or 0))
end)
u23.RecoilMult = v3:Computed(function(p1) -- Line: 301 -- upvalues: u83 (val)
    return 1 - 0.04 * (p1(u83.steadyAim) or 0)
end)
u23.SwapSpeedMult = v3:Computed(function(p1) -- Line: 307 -- upvalues: u83 (val)
    return 1 + 0.1 * (p1(u83.sleightSwitch) or 0)
end)
u23.MaxHPMult = v3:Computed(function(p1) -- Line: 313 -- upvalues: u83 (val)
    local v1 = p1(u83.thickSkin) or 0
    local v2 = u83
    local core2 = v2.core2
    local v3 = p1(core2)
    return 1 + 0.1 * v1 + 0.1 * (v3 or 0)
end)
u23.DamageReductionMult = v3:Computed(function(p1) -- Line: 320 -- upvalues: u83 (val)
    return 1 - 0.03 * (p1(u83.grit) or 0)
end)
u23.AmmoCapacityMult = v3:Computed(function(p1) -- Line: 326 -- upvalues: u83 (val)
    return 1 + 0.08 * (p1(u83.deepPockets) or 0)
end)
u23.InteractSpeedMult = v3:Computed(function(p1) -- Line: 332 -- upvalues: u83 (val)
    return 1 + 0.05 * (p1(u83.quickInteract) or 0)
end)
u23.MeleeSwingSpeedMult = v3:Computed(function(p1) -- Line: 338 -- upvalues: u83 (val)
    return 1 + 0.1 * (p1(u83.meleeTempo) or 0)
end)
u23.DownedTimeMult = v3:Computed(function(p1) -- Line: 344 -- upvalues: u83 (val)
    return 1 + 0.15 * (p1(u83.ironWill) or 0)
end)
u23.HeadshotDamageMult = v3:Computed(function(p1) -- Line: 350 -- upvalues: u83 (val)
    return 1 + 0.05 * (p1(u83.core3) or 0)
end)
u23.XPBonusMult = v3:Computed(function(p1) -- Line: 356 -- upvalues: u83 (val)
    return 1 + 0.05 * (p1(u83.core1) or 0)
end)
u23.AdrenalineStamina = v3:Computed(function(p1) -- Line: 362 -- upvalues: u83 (val)
    return 5 * (p1(u83.adrenaline) or 0)
end)
u23.ParryWindowBonus = v3:Computed(function(p1) -- Line: 368 -- upvalues: u83 (val)
    return 0.1 * (p1(u83.parryMaster) or 0)
end)
u23.SpartanCooldownMult = v3:Computed(function(p1) -- Line: 374 -- upvalues: u83 (val)
    return 1 - 0.1 * (p1(u83.theSpartan) or 0)
end)
u23.HasFury = v3:Computed(function(p1) -- Line: 383 -- upvalues: u83 (val)
    local v1 = 1 <= (p1(u83.fury) or 0)
    return v1
end)
u23.HasDeadEye = v3:Computed(function(p1) -- Line: 387 -- upvalues: u83 (val)
    local v1 = 1 <= (p1(u83.deadEye) or 0)
    return v1
end)
u23.HasQuickDraw = v3:Computed(function(p1) -- Line: 391 -- upvalues: u83 (val)
    local v1 = 1 <= (p1(u83.quickDraw) or 0)
    return v1
end)
u23.HasSecondChance = v3:Computed(function(p1) -- Line: 395 -- upvalues: u83 (val)
    local v1 = 1 <= (p1(u83.secondChance) or 0)
    return v1
end)
u23.HasSwanSong = v3:Computed(function(p1) -- Line: 399 -- upvalues: u83 (val)
    local v1 = 1 <= (p1(u83.swanSong) or 0)
    return v1
end)
u23.HasSecondWind = v3:Computed(function(p1) -- Line: 403 -- upvalues: u83 (val)
    local v1 = 1 <= (p1(u83.secondWind) or 0)
    return v1
end)
u23.HasLastStand = v3:Computed(function(p1) -- Line: 407 -- upvalues: u83 (val)
    local v1 = 1 <= (p1(u83.lastStand) or 0)
    return v1
end)
u23.HasTheSpartan = v3:Computed(function(p1) -- Line: 411 -- upvalues: u83 (val)
    local v1 = 1 <= (p1(u83.theSpartan) or 0)
    return v1
end)
u23.ExtraDowns = v3:Computed(function(p1) -- Line: 416 -- upvalues: u83 (val)
    return (p1(u83.core4) or 0) + (p1(u83.secondChance) or 0)
end)
u23.DesperateSprintThreshold = v3:Computed(function(p1) -- Line: 423 -- upvalues: u83 (val)
    return 0.05 * (p1(u83.desperateSprint) or 0)
end)
v4 = require("./config/EconomyConfig")
u23.SP = v3:Value(0)
local BASE_SP_CAP = v4.BASE_SP_CAP
u23.SPCap = v3:Value(BASE_SP_CAP)
u23.SPSpent = v3:Value(0)
u23.XPBar = v3:Value(0)
u23.DailyEarned = v3:Value(0)
local BASE_DAILY_EARN_CAP = v4.BASE_DAILY_EARN_CAP
u23.DailyEarnCap = v3:Value(BASE_DAILY_EARN_CAP)
u23.PrestigeLevel = v3:Value(0)
u23.ZBucks = v3:Value(0)
u23.ZBucksInvested = v3:Value(0)
u23.XPPerSP = v4.SP_XP_PER_SP
u23.XPChanged = v2.new()
u23.AtSPCap = v3:Computed(function(p1) -- Line: 451 -- upvalues: u23 (val)
    local v1 = (p1(u23.SP)) + p1(u23.SPSpent)
    local v2 = p1(u23.SPCap) <= v1
    return v2
end)
u23.AtDailyCap = v3:Computed(function(p1) -- Line: 456 -- upvalues: u23 (val)
    local v1 = p1(u23.DailyEarned)
    local v2 = p1(u23.DailyEarnCap) <= v1
    return v2
end)
u23.CanPrestige = v3:Computed(function(p1) -- Line: 461 -- upvalues: u23 (val)
    local v1 = false
    local v2 = p1(u23.SPSpent)
    if p1(u23.SPCap) <= v2 then
        v1 = p1(u23.SP) == 0
    end
    return v1
end)
v1.InitSkillTree.On(function(p1) -- Line: 470 -- upvalues: u83 (val), u23 (val)
    local v1
    print("[SkillTreeData] Received initial skill data")
    local v2 = p1
    local v3 = nil
    local v4 = nil
    for i, j in v2, v3, v4 do
        v1 = u83[i]
        if v1 then
            v1:set(j)
        end
    end
    u23.Loaded:set(true)
end)
local Sound = Instance.new("Sound")
Sound.SoundId = "rbxassetid://9039999622"
Sound.Parent = SoundService
local Sound_2 = Instance.new("Sound")
Sound_2.SoundId = "rbxassetid://118207534374651"
Sound_2.Parent = SoundService
v1.UpdateSkillRank.On(function(p1) -- Line: 488 -- upvalues: u83 (val), Sound (val), Sound_2 (val)
    local v1 = print
    local SkillId = p1.SkillId
    local Rank = p1.Rank
    v1((("[SkillTreeData] Skill %* updated to rank %*"):format(SkillId, Rank)))
    local SkillId_2 = p1.SkillId
    local Rank_2 = p1.Rank
    local v2 = u83[SkillId_2]
    if v2 then
        v2:set(Rank_2)
    end
    Sound:Play()
    Sound_2:Play()
end)
local u273 = nil
local u274 = nil
v1.SyncSkillTreeEconomy.On(function(p1) -- Line: 499 -- upvalues: u273 (ref), u274 (ref), u23 (val)
    local v1 = u273
    local v2 = u274
    local v3 = u23
    local SP_2 = v3.SP
    local SP_3 = p1.SP
    SP_2:set(SP_3)
    v3 = u23
    local SPCap = v3.SPCap
    local SPCap_2 = p1.SPCap
    SPCap:set(SPCap_2)
    v3 = u23
    local SPSpent = v3.SPSpent
    local SPSpent_2 = p1.SPSpent
    SPSpent:set(SPSpent_2)
    v3 = u23
    local XPBar_2 = v3.XPBar
    local XPBar_3 = p1.XPBar
    XPBar_2:set(XPBar_3)
    v3 = u23
    local DailyEarned = v3.DailyEarned
    local DailyEarned_2 = p1.DailyEarned
    DailyEarned:set(DailyEarned_2)
    v3 = u23
    local DailyEarnCap = v3.DailyEarnCap
    local DailyEarnCap_2 = p1.DailyEarnCap
    DailyEarnCap:set(DailyEarnCap_2)
    v3 = u23
    local PrestigeLevel = v3.PrestigeLevel
    local PrestigeLevel_2 = p1.PrestigeLevel
    PrestigeLevel:set(PrestigeLevel_2)
    v3 = u23
    local ZBucks = v3.ZBucks
    local ZBucks_2 = p1.ZBucks
    ZBucks:set(ZBucks_2)
    v3 = u23
    local ZBucksInvested = v3.ZBucksInvested
    local ZBucksInvested_2 = p1.ZBucksInvested
    ZBucksInvested:set(ZBucksInvested_2)
    if v1 ~= nil and p1.XPBar ~= v1 then
        v3 = u23
        local XPChanged = v3.XPChanged
        local XPBar = p1.XPBar
        local SP = p1.SP
        XPChanged:Fire(v1, XPBar, v2, SP)
    end
    u273 = p1.XPBar
    u274 = p1.SP
end)
task.spawn(function() -- Line: 524 -- upvalues: u23 (val)
    local common = game:GetService("ReplicatedStorage"):WaitForChild("common", 10)
    if not common then
        return
    end
    local Remotes = common:WaitForChild("Remotes", 10)
    if not Remotes then
        return
    end
    local Net = Remotes:WaitForChild("Net", 10)
    if not Net then
        return
    end
    Net.OnClientEvent:Connect(function(p1, p2) -- Line: 541 -- upvalues: u23 (upval)
        if p1 == "UpdateZBucks" then
            local v1 = u23
            local ZBucks = v1.ZBucks
            local v2 = tonumber(p2)
            ZBucks:set(v2 or 0)
        end
    end)
end)
return u23