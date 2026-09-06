local DataString = require(script:WaitForChild("DataString"))
local HttpService = game:GetService("HttpService")
local v1 = HttpService:JSONDecode(DataString)
local u23 = game:GetService("RunService"):IsStudio()
local function parseClassAccess(p1) -- Line: 6
    local v1 = {}
    local v2 = string.sub(p1, 1, 1) == "1"
    v1.Assault = v2
    v2 = string.sub(p1, 2, 2) == "1"
    v1.Medic = v2
    v2 = string.sub(p1, 3, 3) == "1"
    v1.Support = v2
    v2 = string.sub(p1, 4, 4) == "1"
    v1.Sniper = v2
    return v1
end
local u28 = (function(p1) -- Line: 16 -- upvalues: u23 (val)
    local ClassAccess, HasHats, Inactive, v1, v2, v3, v4
    local v5 = {}
    for k, v in pairs(p1) do
        for k2, i in pairs(v) do
            if u23 and v5[i.ItemId] then
                error("Duplicate ItemID: You forgot to set an unique ItemId [" .. i.Name .. "] ..... again.")
            end
            v1 = {
                Name = i.Name,
                Id = i.ItemId,
                Rarity = i.Rarity,
                Slot = i.Slot,
                Description = i.Description,
            }
            v2 = string.lower(i.Featureable) == "true"
            v1.Featureable = v2
            v2 = string.lower(i.InBoxes) == "true"
            v1.InBoxes = v2
            if string.lower(i.ArcadeSkin or "") == "true" then
                v2 = true
            else
                v2 = false
            end
            v1.ArcadeSkin = v2
            if string.lower(i.WorldCupSkin or "") == "true" then
                v2 = true
            else
                v2 = false
            end
            v1.WorldCupSkin = v2
            if string.lower(i.CyberpunkSkin or "") == "true" then
                v2 = true
            else
                v2 = false
            end
            v1.CyberpunkSkin = v2
            v1.Price = tonumber(i.Price)
            ClassAccess = i.ClassAccess
            v3 = {}
            v4 = string.sub(ClassAccess, 1, 1) == "1"
            v3.Assault = v4
            v4 = string.sub(ClassAccess, 2, 2) == "1"
            v3.Medic = v4
            v4 = string.sub(ClassAccess, 3, 3) == "1"
            v3.Support = v4
            v4 = string.sub(ClassAccess, 4, 4) == "1"
            v3.Sniper = v4
            v1.ClassAccess = v3
            v1.BaseWeaponId = i.BaseWeaponId
            HasHats = i.HasHats
            if HasHats then
                HasHats = string.lower(i.HasHats) == "true"
            end
            v1.HasHats = HasHats
            Inactive = i.Inactive
            if Inactive then
                Inactive = string.lower(i.Inactive) == "true"
            end
            v1.Inactive = Inactive
            v5[i.ItemId] = v1
        end
    end
    return v5
end)(v1)
local u29 = {}
local u30 = {}
function u29.ClassCanUse(p1, p2, p3) -- Line: 53 -- upvalues: u28 (val)
    if u28[p3] then
        return u28[p3].ClassAccess[p2]
    end
end
function u29.GetByCriteria(p1, p2, p3, p4, p5) -- Line: 59 -- upvalues: u30 (val), u28 (val)
    local v1 = p2 or "All"
    local v2 = p3 or "All"
    local v3 = p4 or "All"
    local v4 = v1 .. v2 .. v3
    if u30[v4] then
        return u30[v4]
    end
    local v5 = {}
    local v6 = p5
    for k, v in pairs(u28) do
        if v1 == "All" then
            if v2 == "All" then
                if not v6 then
                    if not v6 then
                        if v3 == "All" then
                            v5[k] = v
                        elseif v.Slot ~= v3 then
                        end
                    elseif not v.ArcadeSkin then
                        if not v.WorldCupSkin then
                            if v.CyberpunkSkin and v3 == "Cyberpunk" then
                                v5[k] = v
                            end
                        elseif v3 == "WorldCup" then
                            v5[k] = v
                        end
                    elseif v3 == "Arcade" then
                        v5[k] = v
                    end
                elseif not v.InBoxes then
                end
            elseif v.Rarity ~= v2 then
            end
        elseif not (v.ClassAccess[v1]) then
        end
    end
    u30[v4] = v5
    return v5
end
function u29.GetItemIdFromName(p1, p2) -- Line: 111 -- upvalues: u29 (val)
    for k, v in pairs(u29.List) do
        if v.Name == p2 then
            return k
        end
    end
    return nil
end
function u29.GetItemFromName(p1, p2) -- Line: 124 -- upvalues: u29 (val)
    local ItemIdFromName = u29:GetItemIdFromName(p2)
    return u29.List[ItemIdFromName]
end
function u29.AdjustFromCopy(p1, p2, p3) -- Line: 129
    local v1, v2, v3, v4, v5, v6, v7
    local v8 = {}
    local v9 = {Assault = "Aslt", Medic = "Medc", Support = "Supt", Sniper = "Snpr"}
    v4, v1 = p3, p2
    for k, v in pairs(v9) do
        for k2, i in pairs(v1.Loadout.Classes[v]) do
            if not (v8[v]) then
                v8[v] = {}
            end
            v8[v][k2] = v1.Inventory[i][1]
        end
    end
    for k3, j in pairs(v4.Inventory) do
        v2 = j[1]
        for k4, k5 in pairs(v8) do
            for k6, n in pairs(k5) do
                if n == v2 then
                    v4.Loadout.Classes[k4][k6] = k3
                    v8[k4][k6] = nil
                end
            end
        end
    end
    local v10 = require("@game/ServerStorage/common/DefaultData")
    local LevelInfo = require(game.ReplicatedStorage.common:WaitForChild("LevelInfo"))
    for k7, m in pairs(v8) do
        if k7 ~= "Mods" then
            for k8, i5 in pairs(m) do
                v3 = v10.Inventory[v10.Loadout.Classes[k7][k8]][1]
                _, v5 = LevelInfo.OwnsWeapon(v4, (tostring(v3)))
                v6 = v4.Loadout.Classes[k7]
                v7 = tonumber(k8)
                v6[v7] = tonumber(v5)
            end
        end
    end
    return v4
end
u29.List = u28
u29.RarityColors = {
    Stock = {Main = Color3.fromRGB(216, 216, 216), Back = Color3.fromRGB(80, 80, 80), Dark = Color3.fromRGB(27, 27, 27)},
    Typical = {Main = Color3.fromRGB(102, 216, 111), Back = Color3.fromRGB(46, 80, 57), Dark = Color3.fromRGB(19, 27, 22)},
    Unique = {Main = Color3.fromRGB(58, 147, 255), Back = Color3.fromRGB(34, 65, 80), Dark = Color3.fromRGB(17, 24, 27)},
    Rare = {Main = Color3.fromRGB(255, 153, 51), Back = Color3.fromRGB(80, 60, 38), Dark = Color3.fromRGB(27, 25, 21)},
    Mythical = {Main = Color3.fromRGB(144, 47, 255), Back = Color3.fromRGB(64, 44, 80), Dark = Color3.fromRGB(20, 19, 27)},
    Exclusive = {Main = Color3.fromRGB(255, 85, 88), Back = Color3.fromRGB(80, 0, 1), Dark = Color3.fromRGB(20, 19, 27)},
    Gamepass = {Main = Color3.fromRGB(161, 186, 216), Back = Color3.fromRGB(71, 76, 85), Dark = Color3.fromRGB(31, 42, 43)},
    Outfit = {Main = Color3.fromRGB(239, 255, 55), Back = Color3.fromRGB(47, 50, 10), Dark = Color3.fromRGB(22, 24, 4)},
    Special = {Main = Color3.fromRGB(0, 255, 191), Back = Color3.fromRGB(26, 70, 62), Dark = Color3.fromRGB(14, 33, 32)},
    Accursed = {Main = Color3.fromRGB(180, 0, 165), Back = Color3.fromRGB(65, 30, 64), Dark = Color3.fromRGB(22, 24, 4)},
}
local v2 = {Typical = 70, Unique = 25, Rare = 4, Mythical = 1}
local v3 = {Typical = 0, Unique = 54, Rare = 40, Mythical = 6}
u29.LootBoxes = {
    Cyberpunk = {
        DisplayName = "Cyberpunk Lootbox",
        Tier = "Special",
        Slot = "Cyberpunk",
        Currency = "Robux",
        ProductKey = "CyberpunkCrate",
        ProductKeyMulti = "CyberpunkCrate5",
        ImageId = "rbxassetid://85173607578751",
        ProbabilityTable = {Rare = 80, Mythical = 17, Exclusive = 3},
    },
    Primary = {
        Price = 1000,
        DisplayName = "Primary Lootbox",
        Tier = "Typical",
        Slot = "Primary",
        ImageId = "rbxassetid://72839976474351",
        ProbabilityTable = v2,
    },
    Secondary = {
        Price = 1000,
        DisplayName = "Secondary Lootbox",
        Tier = "Typical",
        Slot = "Secondary",
        ImageId = "rbxassetid://80110776180934",
        ProbabilityTable = v2,
    },
    Melee = {
        Price = 1800,
        DisplayName = "Melee Lootbox",
        Tier = "Typical",
        Slot = "Melee",
        ImageId = "rbxassetid://112880363964063",
        ProbabilityTable = v2,
    },
    MythicalPrimary = {
        Price = 5000,
        DisplayName = "Primary Lootbox",
        Tier = "Mythical",
        Slot = "Primary",
        ImageId = "rbxassetid://79087028007940",
        ProbabilityTable = v3,
    },
    MythicalSecondary = {
        Price = 5000,
        DisplayName = "Secondary Lootbox",
        Tier = "Mythical",
        Slot = "Secondary",
        ImageId = "rbxassetid://81696562116264",
        ProbabilityTable = v3,
    },
    MythicalMelee = {
        Price = 9000,
        DisplayName = "Melee Lootbox",
        Tier = "Mythical",
        Slot = "Melee",
        ImageId = "rbxassetid://94501769745526",
        ProbabilityTable = v3,
    },
    Outfit = {
        Price = 3000,
        DisplayName = "Outfit Lootbox",
        Tier = "Outfit",
        Slot = "Outfit",
        ImageId = "rbxassetid://132639764670163",
        ProbabilityTable = {Outfit = 100},
    },
    Arcade = {
        Price = 2500,
        DisplayName = "Arcade Lootbox",
        Tier = "Special",
        Slot = "Arcade",
        ImageId = "rbxassetid://74786715491271",
        ProbabilityTable = v2,
    },
}
u29.DefaultProbabilityTable = v2
u29.MythicalProbabilityTable = v3
u29.probabilityTable = v2
return u29