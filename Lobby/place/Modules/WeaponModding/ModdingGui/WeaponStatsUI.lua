game:GetService("ReplicatedStorage")
game:GetService("ServerScriptService")
require("@game/ReplicatedStorage/common/Fusion/State/Value")
local u15 = require("../../Graph")
local v1 = require("@game/ReplicatedStorage/common/Fusion")
require("../MiscFunctions")
local u24 = require("@game/ReplicatedStorage/common/NPCs_Shared/Utils/DamageFalloffUtil")
local Value = v1.Value
local u28 = {
    Damage = {Min = 0, Max = 250},
    Reload = {Min = 0, Max = 8},
    FireRate = {Min = 0, Max = 1300},
    Spread = {Min = 0, Max = 10},
    Piercing = {Min = 0, Max = 5},
    PierceReduction = {Min = 0, Max = 1},
    Mobility = {Min = 0, Max = 6},
    Control = {Min = 0, Max = 8},
}
local v2 = {Min = 0, Max = 6}
u28.Handling = v2
local u40 = utf8.char(176)
local u41 = {
    Damage = 1,
    Reload = -1,
    FireRate = 1,
    Spread = -1,
    Piercing = 1,
    Mobility = 1,
    Control = 1,
    Handling = 1,
}
local u42 = {}
u42["Pump Action"] = "Single"
u42["Bolt Action"] = "Single"
u42.Auto = "Auto"
u42["Semi-Auto"] = "Single"
u42.Burst = "Burst"
u42.Melee = "Melee"
local u49 = {
    Damage = function(p1) -- Line: 75
        return ("%d"):format((math.round(p1)))
    end,
    FireRate = function(p1) -- Line: 78
        return ("%d"):format((math.round(p1)))
    end,
    Spread = function(p1) -- Line: 81 -- upvalues: u40 (val)
        return ("%.1f" .. u40):format(p1)
    end,
    Piercing = function(p1) -- Line: 84
        return ("%d"):format(p1)
    end,
    Mobility = function(p1) -- Line: 87
        return ("%.1f"):format(p1)
    end,
    Control = function(p1) -- Line: 90
        return ("%.1f"):format(p1)
    end,
    Handling = function(p1) -- Line: 93
        return ("%.1f"):format(p1)
    end,
}
local u57 = nil
local function populateGraph(p1, p2) -- Line: 125 -- upvalues: u57 (ref), u24 (val)
    if not u57 then
        local v1, v2, v3, v4, v5, v6
        u57 = os.clock() + 0.1
        local v7 = {}
        local v8 = {"DMG", "HS DMG"}
        local v9 = nil
        local v10 = nil
        v1, v2 = p1, p2
        for i, j in v8, v9, v10 do
            v5 = {}
            v6 = 100
            v3 = 1
            for k = 1, v6, v3 do
                v4 = u24.CalculateDamageAtDistance(v1, k - 1)
                if j == "HS DMG" then
                    v4 = v4 * v2
                end
                v5[k] = v4
            end
            v7[j] = v5
            task.wait()
        end
        return v7
    elseif os.clock() < u57 then
        return nil
    end
end
local function getAverageSpread(p1) -- Line: 380
    local v1
    local v2 = 1
    local v3 = 1
    local v4 = {
        "CrouchSpreadReduction",
        "ProneSpreadReduction",
        "ADSSpreadReduction",
        "MovementSpread",
        "AirSpread",
        "SlidingSpread",
        "DivingSpread",
        "ShootingSpreadIncrement",
        "ShootingSpreadDecay",
    }
    local v5 = nil
    local v6 = nil
    for i, j in v4, v5, v6 do
        v1 = p1[j]
        if v1 then
            v3 = v3 + v1
            v2 = v2 + 1
        end
    end
    return v3 / v2 * math.deg(p1.BaseSpread)
end
function calculateStats(p1, p2) -- Line: 407 -- upvalues: u42 (val), getAverageSpread (val), u28 (val)
    p2.Damage = p1.Damage
    p2.HeadShotMult = p1.Multipliers.Head or 1
    p2.HeadShotDamage = p1.Damage * p2.HeadShotMult
    if not p1.IsMelee then
        p2.IsMelee = false
        if p1.DamageDropoff then
            p2.DamageDropoff = p1.DamageDropoff
        end
        p2.FireModes = {}
        local FireMode = p1.FireMode
        local v1 = nil
        local v2 = nil
        for i, j in FireMode, v1, v2 do
            p2.FireModes[u42[j]] = true
        end
        if p1.BulletsPerShot then
            p2.Damage = p2.Damage * p1.BulletsPerShot
            p2.HeadShotDamage = p2.HeadShotDamage * p1.BulletsPerShot
        end
        p2.ReloadTime = p1.ReloadTime
        p2.EmptyReloadTime = p1.EmptyReloadTime
        if p1.UsesLoadLoop then
            p2.ReloadTime = p1.LoadStartTime + p1.InsertTime
            p2.EmptyReloadTime = p1.LoadStartTime + p1.InsertTime * p1.Ammo + p1.LoadStopTime
        end
        p2.Spread = getAverageSpread(p1)
        p2.BaseSpread = math.deg(p1.BaseSpread)
        p2.ADSSpreadReduction = p1.ADSSpreadReduction
        p2.Control = u28.Control.Max - (p1.VerticalRecoil + p1.HorizontalRecoil) * 0.5
        p2.Handling = (p1.ADSSpeed + p1.DrawSpeed + p1.HolsterSpeed) / 3 * 2
        p2.Magazine = p1.Ammo
        p2.Reserve = p1.StoredAmmo
    else
        p2.IsMelee = true
        if p1.MaxHitsPerEnemy then
            p2.Damage = p2.Damage * p1.MaxHitsPerEnemy
            p2.HeadShotDamage = p2.HeadShotDamage * p1.MaxHitsPerEnemy
        end
        p2.Handling = (p1.DrawSpeed + p1.HolsterSpeed) / 2 * 2
    end
    p2.Piercing = p1.Penetration
    p2.PierceReduction = p1.PenetrationReduction
    p2.FireRate = 1 / p1.DelayPerShot * 60
    p2.Mobility = (p1.EquippedWalkspeedMultiplier + p1.HolsteredWalkspeedMultiplier) * 0.5 * 3
end
return function(p1) -- Line: 148 -- upvalues: Value (val), u15 (val), populateGraph (val), u41 (val), u28 (val), u49 (val), u40 (val)
    local u3 = Value(false)
    local u6 = Value(false)
    local Ammo = p1.Ammo
    local Modes = p1.Modes
    local Rows = p1.Rows
    game:GetService("RunService"):IsStudio()
    local u20 = os.clock()
    local v1 = require("./CreateGraphFrame")
    local v2 = v1({
        isOpen = u3,
        onClose = function() -- Line: 165 -- upvalues: u3 (val)
            u3:set(false)
        end,
    })
    v2.Parent = p1.Parent
    local u35 = u15.new(v2)
    v1 = require("./CreateButtonList")
    local v3 = {graphOpen = u3}
    local v4 = {Falloff = u6}
    v3.ButtonVisibility = v4
    function v3.onFalloff() -- Line: 175 -- upvalues: u3 (val)
        u3:set(not u3:get())
    end
    v1(v3).Parent = p1
    local u43 = {
        Damage = 30,
        HeadShotDamage = 60,
        ReloadTime = 2.5,
        EmptyReloadTime = 3,
        FireRate = 500,
        Spread = 7,
        Piercing = 1,
        PierceReduction = 0.5,
        Mobility = 2,
        Control = 3.5,
        Handling = 3,
        Magazine = 30,
        Reserve = 180,
    }
    local u46 = table.clone(u43)
    local v5 = {
        UpdatePlacement = function(a1, p2) -- Line: 206 -- upvalues: p1 (val), Ammo (val)
            if p2 == "Nodes" then
                p1.AnchorPoint = Vector2.new(1, 1)
                p1.Position = UDim2.new(0.99, 0, 0.99, 0)
                Ammo.AnchorPoint = Vector2.new(1, 0.5)
                Ammo.Position = UDim2.new(-0.05, 0, 0.5, 0)
                return
            end
            p1.AnchorPoint = Vector2.new(0, 1)
            p1.Position = UDim2.new(0.01, 0, 0.65, 0)
            Ammo.AnchorPoint = Vector2.new(0, 0.5)
            Ammo.Position = UDim2.new(1.05, 0, 0.5, 0)
        end,
        UpdateGraph = function(p1, p2) -- Line: 220 -- upvalues: u20 (ref), u6 (val), populateGraph (upval), u35 (ref), u3 (val)
            local Head
            if os.clock() < u20 then
                return
            end
            u20 = os.clock() + 0.15
            if not p2.DamageDropoff then
                u6:set(false)
                u3:set(false)
                return
            end
            u6:set(true)
            if not p2.Multipliers then
                Head = p2.HeadShotMult
            else
                Head = p2.Multipliers.Head
            end
            local v1 = populateGraph(p2, Head)
            if not v1 then
                return
            end
            u35.Resolution = 10
            u35.Data = v1
        end,
        SetBaseStats = function(p1, p2) -- Line: 244 -- upvalues: u43 (val), u46 (ref)
            calculateStats(p2, u43)
            u46 = table.clone(u43)
            p1:UpdateGraph(p2)
        end,
        UpdateStats = function(p1, p2) -- Line: 251 -- upvalues: u46 (ref)
            calculateStats(p2, u46)
            p1:UpdateGraph(p2)
        end,
    }
    local function updateStatBar(p1, p2, p3) -- Line: 256 -- upvalues: u41 (upval), u28 (upval), Rows (val)
        local GoodBar
        local v1 = u41[p1]
        local v2 = u28[p1]
        local v3 = v2.Max - v2.Min
        local Bar = Rows[p1].Bar
        local v4 = math.clamp((p2 - v2.Min) / v3, 0, 1)
        local v5 = math.clamp((p3 - v2.Min) / v3, 0, 1)
        if math.sign(v5 - v4) ~= v1 then
            GoodBar = Bar.BadBar
            Bar.GoodBar.Visible = false
        else
            GoodBar = Bar.GoodBar
            Bar.BadBar.Visible = false
        end
        GoodBar.Visible = true
        if v4 < v5 then
            Bar.BaseBar.Size = UDim2.new(v4, 0, 1, 0)
            GoodBar.Size = UDim2.new(v5 - v4, 0, 1, 0)
            GoodBar.Position = UDim2.new(v4, 0, 0, 0)
            return
        end
        Bar.BaseBar.Size = UDim2.new(v5, 0, 1, 0)
        GoodBar.Size = UDim2.new(v4 - v5, 0, 1, 0)
        GoodBar.Position = UDim2.new(v5, 0, 0, 0)
    end
    function v5.UpdateDisplay(a1) -- Line: 288 -- upvalues: u46 (ref), u43 (val), Rows (val), updateStatBar (val), u28 (upval), u49 (upval), u40 (upval), Ammo (val), Modes (val), p1 (val)
        local v1, v2
        local Damage = u46.Damage
        local HeadShotDamage = u46.HeadShotDamage
        local v3 = (u43.Damage + u43.HeadShotDamage) * 0.5
        Rows.Damage.Value.Text = ("%d <font color=\"#f2b035\">(%d)</font>"):format(Damage, HeadShotDamage)
        updateStatBar("Damage", v3, (Damage + HeadShotDamage) * 0.5)
        local ReloadTime = u46.ReloadTime
        local EmptyReloadTime = u46.EmptyReloadTime
        local v4 = (u43.ReloadTime + u43.EmptyReloadTime) * 0.5
        Rows.Reload.Value.Text = ("%.1f-%.1fs"):format(ReloadTime, EmptyReloadTime)
        updateStatBar("Reload", v4, (ReloadTime + EmptyReloadTime) * 0.5)
        local Piercing = u46.Piercing
        if Piercing >= 1 then
            v1 = ("%d <font color=\"#f2b035\">(x%.1f)</font>"):format(Piercing, u46.PierceReduction)
        else
            v1 = ("%d"):format(Piercing)
        end
        Rows.Piercing.Value.Text = v1
        updateStatBar("Piercing", u43.Piercing, Piercing)
        local v5 = u43
        v1 = nil
        local v6 = nil
        for i, j in v5, v1, v6 do
            v2 = u46[i]
            if i ~= "Damage" and i ~= "Piercing" and i ~= "PierceReduction" and u28[i] then
                Rows[i].Value.Text = u49[i](v2)
                updateStatBar(i, j, v2)
            end
        end
        if not u46.IsMelee then
            local BaseSpread = u46.BaseSpread
            if u46.ADSSpreadReduction then
                Rows.Spread.Value.Text = ("%.1f" .. u40 .. " <font color=\"#f2b035\">(%.1f" .. u40 .. ")</font>"):format(BaseSpread, BaseSpread * u46.ADSSpreadReduction)
            end
        end
        Ammo.Visible = not u46.IsMelee
        if u43.Magazine < u46.Magazine then
            Ammo.Magazine.AmountLabel.TextColor3 = Color3.fromRGB(112, 216, 107)
        elseif u46.Magazine >= u43.Magazine then
            Ammo.Magazine.AmountLabel.TextColor3 = Color3.new(1, 1, 1)
        else
            Ammo.Magazine.AmountLabel.TextColor3 = Color3.fromRGB(216, 90, 90)
        end
        Ammo.Magazine.AmountLabel.Text = u46.Magazine
        if u43.Reserve < u46.Reserve then
            Ammo.Reserve.AmountLabel.TextColor3 = Color3.fromRGB(112, 216, 107)
        elseif u46.Reserve >= u43.Reserve then
            Ammo.Reserve.AmountLabel.TextColor3 = Color3.new(1, 1, 1)
        else
            Ammo.Reserve.AmountLabel.TextColor3 = Color3.fromRGB(216, 90, 90)
        end
        Ammo.Reserve.AmountLabel.Text = u46.Reserve
        local function colorText(p1) -- Line: 351
            return ("<font color=\"#f2b035\">%s</font>"):format(p1)
        end
        if not u46.IsMelee then
            local v7
            if not u46.FireModes.Single then
                v1 = "SINGLE"
            else
                v1 = ("<font color=\"#f2b035\">%s</font>"):format("SINGLE")
            end
            if not u46.FireModes.Burst then
                v6 = "BURST"
            else
                v6 = ("<font color=\"#f2b035\">%s</font>"):format("BURST")
            end
            if not u46.FireModes.Auto then
                v7 = "AUTO"
            else
                v7 = ("<font color=\"#f2b035\">%s</font>"):format("AUTO")
            end
            Modes.ModesLabel.Text = ("%s | %s | %s"):format(v1, v6, v7)
        else
            Modes.ModesLabel.Text = ("<font color=\"#f2b035\">%s</font>"):format("MELEE")
        end
        Rows.Control.Visible = not u46.IsMelee
        Rows.Reload.Visible = not u46.IsMelee
        Rows.Spread.Visible = not u46.IsMelee
        if u46.IsMelee then
            p1.Size = UDim2.new(0.45, 0, 0.153, 0)
            return
        end
        p1.Size = UDim2.new(0.45, 0, 0.246, 0)
    end
    return v5
end