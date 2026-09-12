local DataString = require(script:WaitForChild("DataString"))
local v1 = (game:GetService("HttpService")):JSONDecode(DataString)
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

local function parseItemData(p1) -- Line: 16 -- upvalues: u23 (val)
    local ClassAccess, HasHats, Inactive, ItemId, Price, v1, v2, v3, v4
    local v5 = {}
    for k, v in pairs(p1) do
        for k2, i in pairs(v) do
            if u23 and v5[i.ItemId] then
                error("Duplicate ItemID: You forgot to set an unique ItemId [" .. i.Name .. "] ..... again.")
            end
            ItemId = i.ItemId
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
            v2 = string.lower(i.ArcadeSkin or "") == "true"
            v1.ArcadeSkin = v2
            v2 = string.lower(i.WorldCupSkin or "") == "true"
            v1.WorldCupSkin = v2
            v2 = string.lower(i.CyberpunkSkin or "") == "true"
            v1.CyberpunkSkin = v2
            Price = i.Price
            v1.Price = tonumber(Price)
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
            v5[ItemId] = v1
        end
    end
    return v5
end

local u28 = parseItemData(v1)
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
    local v4 = p5 == true
    local v5 = table.concat({v1, v2, v3, (tostring(v4))}, "|")
    if u30[v5] then
        return u30[v5]
    end
    local v6 = {}
    for k, v in pairs(u28) do
        if v1 == "All" or v.ClassAccess[v1] then
            if v2 == "All" or v.Rarity == v2 then
                if not v4 or v.InBoxes then
                    if not v4 then
                        if v3 == "All" or v.Slot == v3 then
                            v6[k] = v
                        end
                    elseif not v.ArcadeSkin then
                        if not v.WorldCupSkin then
                            if not v.CyberpunkSkin then
                                if v3 == "All" or v.Slot == v3 then
                                    v6[k] = v
                                end
                            elseif v3 == "Cyberpunk" then
                                v6[k] = v
                            end
                        elseif v3 == "WorldCup" then
                            v6[k] = v
                        end
                    elseif v3 == "Arcade" then
                        v6[k] = v
                    end
                end
            end
        end
    end
    u30[v5] = v6
    return v6
end

function u29.GetItemIdFromName(p1, p2) -- Line: 112 -- upvalues: u29 (val)
    for k, v in pairs(u29.List) do
        if v.Name == p2 then
            return k
        end
    end
    return nil
end

function u29.GetItemFromName(p1, p2) -- Line: 125 -- upvalues: u29 (val)
    local ItemIdFromName = u29:GetItemIdFromName(p2)
    return u29.List[ItemIdFromName]
end

function u29.AdjustFromCopy(p1, p2, p3) -- Line: 130
    local v1, v2, v3, v4, v5, v6, v7
    local v8 = {}
    local v9 = {Assault = "Aslt", Medic = "Medc", Support = "Supt", Sniper = "Snpr"}
    local v10, v11 = p3, p2
    for k, v in pairs(v9) do
        for k2, i in pairs(v11.Loadout.Classes[v]) do
            v2 = v11.Inventory[i][1]
            if not v8[v] then
                v8[v] = {}
            end
            v8[v][k2] = v2
        end
    end
    for k3, j in pairs(v10.Inventory) do
        v1 = j[1]
        for k4, k5 in pairs(v8) do
            for k6, n in pairs(k5) do
                if n == v1 then
                    v10.Loadout.Classes[k4][k6] = k3
                    v8[k4][k6] = nil
                end
            end
        end
    end
    local v12 = require("@game/ServerStorage/common/DefaultData")
    local LevelInfo = require(game.ReplicatedStorage.common:WaitForChild("LevelInfo"))
    for k7, m in pairs(v8) do
        if k7 ~= "Mods" then
            for k8, i5 in pairs(m) do
                v3 = v12.Loadout.Classes[k7][k8]
                v4 = v12.Inventory[v3][1]
                _, v5 = LevelInfo.OwnsWeapon(v10, (tostring(v4)))
                v6 = v10.Loadout.Classes[k7]
                v7 = tonumber(k8)
                v6[v7] = (tonumber(v5))
            end
        end
    end
    return v10
end

u29.List = u28
local v2 = {
    Stock = {
        Main = Color3.fromRGB(216, 216, 216),
        Back = Color3.fromRGB(80, 80, 80),
        Dark = Color3.fromRGB(27, 27, 27),
    },
    Typical = {
        Main = Color3.fromRGB(102, 216, 111),
        Back = Color3.fromRGB(46, 80, 57),
        Dark = Color3.fromRGB(19, 27, 22),
    },
    Unique = {
        Main = Color3.fromRGB(58, 147, 255),
        Back = Color3.fromRGB(34, 65, 80),
        Dark = Color3.fromRGB(17, 24, 27),
    },
    Rare = {
        Main = Color3.fromRGB(255, 153, 51),
        Back = Color3.fromRGB(80, 60, 38),
        Dark = Color3.fromRGB(27, 25, 21),
    },
    Mythical = {
        Main = Color3.fromRGB(144, 47, 255),
        Back = Color3.fromRGB(64, 44, 80),
        Dark = Color3.fromRGB(20, 19, 27),
    },
    Exclusive = {
        Main = Color3.fromRGB(255, 85, 88),
        Back = Color3.fromRGB(80, 0, 1),
        Dark = Color3.fromRGB(20, 19, 27),
    },
    Gamepass = {
        Main = Color3.fromRGB(161, 186, 216),
        Back = Color3.fromRGB(71, 76, 85),
        Dark = Color3.fromRGB(31, 42, 43),
    },
    Outfit = {
        Main = Color3.fromRGB(239, 255, 55),
        Back = Color3.fromRGB(47, 50, 10),
        Dark = Color3.fromRGB(22, 24, 4),
    },
    Special = {
        Main = Color3.fromRGB(0, 255, 191),
        Back = Color3.fromRGB(26, 70, 62),
        Dark = Color3.fromRGB(14, 33, 32),
    },
    Accursed = {
        Main = Color3.fromRGB(180, 0, 165),
        Back = Color3.fromRGB(65, 30, 64),
        Dark = Color3.fromRGB(22, 24, 4),
    },
}
u29.RarityColors = v2
local CrateHandler = require(script.Parent:WaitForChild("CrateHandler"))
u29.LootBoxes = CrateHandler.GetEnabled()
u29.DefaultProbabilityTable = CrateHandler.Probabilities.Default
u29.MythicalProbabilityTable = CrateHandler.Probabilities.Mythical
u29.probabilityTable = CrateHandler.Probabilities.Default
return u29