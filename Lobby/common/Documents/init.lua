local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ItemData = require(ReplicatedStorage.common:WaitForChild("ItemData"))
local u12 = {}
local u16 = setmetatable({}, {__mode = "k"})
u12.ClientState = nil
u12.Config = {Enabled = true, PickupPromptRange = 8, CollectMaxDistance = 24, PickupScale = 1}
function u12.GetAssetRoot() -- Line: 22 -- upvalues: ReplicatedStorage (val)
    local Assets
    local Documents = ReplicatedStorage.common:FindFirstChild("Documents")
    if not Documents then
        Assets = nil
    else
        Assets = Documents:FindFirstChild("Assets")
        if not Assets then
            Assets = nil
        end
    end
    return Assets
end
u12.Categories = {
    {id = "LightZombies", name = "Light Zombies", folder = "Light Zombies"},
    {id = "HeavyZombies", name = "Heavy Zombies", folder = "Heavy Zombies"},
    {id = "HeavyPlusZombies", name = "Heavy+ Zombies", folder = "Heavy+ Zombies"},
    {id = "Personnel", name = "Personnel", folder = "Personnel"},
    {id = "PeopleOfInterest", name = "People of Interest", folder = "PeopleOfInterest"},
    {id = "GroupsOfInterest", name = "Groups of Interest", folder = "GroupsOfInterest"},
    {id = "Locations", name = "Locations", folder = "Locations"},
    {id = "UMBRA", name = "UMBRA", folder = "UMBRA"},
}
u12.LegacyIds = {Johnathan = "Boss", StorageWorker = "Guest7123"}
local v1 = {}
local v2 = {
    id = "VolatileIncarnation",
    category = "HeavyPlusZombies",
    title = "VOLATILE INCARNATION",
    model = "documentVolatileIncarnation",
    unlock = {kind = "condition", check = "EnemyKilled", enemy = "VolatileIncarnation", hint = "Kill a Volatile Incarnation"},
}
local v3 = {
    id = "Boss",
    category = "PeopleOfInterest",
    title = "BOSS",
    model = "documentJohnathan",
    unlock = {
        kind = "worldPickup",
        storyId = "EXT",
        chapter = 4,
        hint = "Find in Verboten Grounds",
        cframe = CFrame.new(189.365829, -546.582642, -138.226028, 0.912785411, 0, 0.408439487, 0, 1, 0, -0.408439398, 0, 0.912785411),
    },
}
local v4 = {
    id = "Guest7123",
    category = "PeopleOfInterest",
    title = "STORAGE WORKER 40923824",
    model = "documentStorageWorker",
    unlock = {
        kind = "worldPickup",
        storyId = "LGCY",
        chapter = 1,
        hint = "Find in Contamination",
        cframe = CFrame.new(206.599991, 186.866882, 83.3999939),
    },
}
local v5 = {
    id = "H2Foundation",
    category = "GroupsOfInterest",
    title = "H2 FOUNDATION",
    model = "documentH2Foundation",
    unlock = {
        kind = "worldPickup",
        storyId = "ZB:O",
        chapter = 1,
        hint = "Find in 2 Days Later",
        cframe = CFrame.new(97, 2265.47925, 248.099991, 0.258819073, 0, -0.965925813, 0, 1, 0, 0.965925813, 0, 0.258819073),
    },
}
v1[1] = {
    id = "Slasher",
    category = "LightZombies",
    title = "SLASHER",
    model = "documentSlasher",
    unlock = {
        kind = "condition",
        check = "EnemyKilled",
        enemy = "Slasher",
        hint = "Kill a Slasher",
        enemyModels = {"WH_Slasher"},
    },
}
v1[2] = {
    id = "Charger",
    category = "LightZombies",
    title = "CHARGER",
    model = "documentCharger",
    unlock = {
        kind = "condition",
        check = "EnemyKilled",
        enemy = "Charger",
        hint = "Kill a Charger",
        enemyModels = {"WH_Charger"},
    },
}
v1[3] = {
    id = "Beamer",
    category = "LightZombies",
    title = "BEAMER",
    model = "documentBeamer",
    unlock = {
        kind = "condition",
        check = "EnemyKilled",
        enemy = "Beamer",
        hint = "Kill a Beamer",
        enemyModels = {"RobotBeamer", "WH_Beamer"},
    },
}
v1[4] = {
    id = "TaintedSlasher",
    category = "LightZombies",
    title = "TAINTED SLASHER",
    model = "documentTaintedSlasher",
    unlock = {kind = "condition", check = "EnemyKilled", enemy = "TaintedSlasher", hint = "Kill a Tainted Slasher"},
}
v1[5] = {
    id = "PlasmaBeamer",
    category = "LightZombies",
    title = "PLASMA BEAMER",
    model = "documentPlasmaBeamer",
    unlock = {kind = "condition", check = "EnemyKilled", enemy = "PlasmaBeamer", hint = "Kill a Plasma Beamer"},
}
v1[6] = {
    id = "SpectralHunter",
    category = "LightZombies",
    title = "SPECTRAL HUNTER",
    model = "documentSpectralHunter",
    unlock = {kind = "condition", check = "EnemyKilled", enemy = "SpectralHunter", hint = "Kill a Spectral Hunter"},
}
v1[7] = {
    id = "Mortar",
    category = "LightZombies",
    title = "MORTAR",
    model = "documentMortar",
    unlock = {kind = "condition", check = "EnemyKilled", enemy = "Mortar", hint = "Kill a Mortar"},
}
v1[8] = {
    id = "Smasher",
    category = "HeavyZombies",
    title = "SMASHER",
    model = "documentSmasher",
    unlock = {
        kind = "condition",
        check = "EnemyKilled",
        enemy = "Smasher",
        hint = "Kill a Smasher",
        enemyModels = {"WH_Smasher"},
    },
}
v1[9] = {
    id = "CyberneticSmasher",
    category = "HeavyZombies",
    title = "CYBERNETIC SMASHER",
    model = "documentCyberneticSmasher",
    unlock = {kind = "condition", check = "EnemyKilled", enemy = "CyberneticSmasher", hint = "Kill a Cybernetic Smasher"},
}
v1[10] = {
    id = "SupremeSupersoldier",
    category = "HeavyPlusZombies",
    title = "SUPREME SUPER SOLDIER",
    model = "documentSupremeSupersoldier",
    unlock = {
        kind = "condition",
        check = "EnemyKilled",
        enemy = "SupremeSoldier",
        hint = "Kill a Supreme Super Soldier",
        enemyModels = {"Supreme Super Soldier"},
    },
}
v1[11] = v2
v1[12] = v3
v1[13] = v4
v1[14] = {
    id = "BlitzResearchInc",
    category = "GroupsOfInterest",
    title = "BLITZ RESEARCH INC.",
    model = "documentBlitzResearch",
    unlock = {
        kind = "condition",
        check = "SpecificChapterCompleted",
        storyId = "ZB:O",
        chapter = 1,
        hint = "Beat 2 Days Later on any difficulty",
    },
}
v1[15] = {
    id = "GeneticalResearchInstitute",
    category = "GroupsOfInterest",
    title = "GENETICAL RESEARCH INSTITUTE",
    model = "documentGRI",
    unlock = {
        kind = "condition",
        check = "SpecificChapterCompleted",
        storyId = "LGCY",
        chapter = 1,
        hint = "Beat Contamination on any difficulty",
    },
}
v1[16] = v5
local v6 = {
    id = "BlackSnake",
    category = "GroupsOfInterest",
    title = "BLACK SNAKE",
    model = "documentBlackSnake",
    unlock = {
        kind = "condition",
        check = "SpecificChapterCompleted",
        storyId = "EXT",
        chapter = 4,
        hint = "Beat Verboten Grounds on any difficulty",
    },
}
local v7 = {
    id = "PimilaLaboratories",
    category = "GroupsOfInterest",
    title = "PIMILA LABORATORIES",
    model = "documentPimilaLaboratories",
    unlock = {
        kind = "condition",
        check = "SpecificChapterCompleted",
        storyId = "DEAH",
        chapter = 1,
        hint = "Beat Pimila Laboratories on any difficulty",
    },
}
local v8 = {
    id = "UMBRA",
    category = "UMBRA",
    title = "UMBRA",
    model = "documentUMBRA",
    unlock = {kind = "condition", check = "AnyChapterCompleted", hint = "Beat any chapter on any difficulty"},
}
local v9 = {
    id = "Odysseus",
    category = "Locations",
    title = "THE ODYSSEUS",
    model = "documentOdysseus",
    unlock = {kind = "worldPickup", storyId = "Lobby", hint = "Find on the Odysseus", cframe = CFrame.new(-134.399994, 77.3422775, -6.69999695, 0.906307757, 0, -0.42261827, 0, 1, 0, 0.42261827, 0, 0.906307757)},
}
local v10 = {
    id = "Archivist",
    category = "Personnel",
    title = "ARCHIVIST",
    model = "documentArchivist",
    unlock = {
        kind = "condition",
        check = "CategoryUnlockCount",
        category = "GroupsOfInterest",
        count = 5,
        hint = "Obtain 5 different Groups of Interest documents",
    },
}
local v11 = {
    id = "Assistant",
    category = "Personnel",
    title = "ASSISTANT",
    model = "documentAssistant",
    unlock = {kind = "locked", hint = "Unlock condition not yet assigned"},
}
local v12 = {
    id = "Izumi",
    category = "Personnel",
    title = "OPERATOR IA-039",
    model = "documentIzumi",
    unlock = {kind = "condition", check = "DistinctWeaponSkinCount", count = 50, hint = "Own 50 different weapon skins"},
}
local v13 = {
    id = "Quartermaster",
    category = "Personnel",
    title = "QUARTERMASTER",
    model = "documentQuartermaster",
    unlock = {kind = "condition", check = "CumulativeZBucksSpent", amount = 3000, hint = "Spend at least 3,000 Z$"},
}
local v14 = {
    id = "Rangemaster",
    category = "Personnel",
    title = "RANGEMASTER",
    model = "documentRangemaster",
    unlock = {kind = "condition", check = "HardPlusPerfectAccuracy", hint = "Finish a Hard or Nightmare chapter with 70% accuracy and at least 25 shots"},
}
local v15 = {id = "Jenny", category = "Personnel", title = "OPERATOR JH-827", model = "documentJenny"}
local v16 = {kind = "locked", hint = "Unlock condition not yet assigned"}
v15.unlock = v16
v1[17] = v6
v1[18] = v7
v1[19] = v8
v1[20] = v9
v1[21] = v10
v1[22] = v11
v1[23] = v12
v1[24] = v13
v1[25] = v14
v1[26] = v15
u12.Documents = v1
local function getTableValue(p1, p2) -- Line: 403
    if type(p1) ~= "table" then
        return nil
    end
    local v1 = p1[p2]
    if not v1 then
        v1 = p1[tostring(p2)]
    end
    return v1
end
local function resultWasCompleted(p1) -- Line: 410
    local v1 = false
    if type(p1) == "table" then
        local v2 = tonumber(p1[7]) or 0
        v1 = 0 < v2
    end
    return v1
end
local function statsChapterWasCompleted(p1, p2, p3) -- Line: 414
    local Stats, Stories, v1, v2, v3, v4
    Stats = if type(p1) == "table" then p1.Stats else false
    Stories = if type(Stats) == "table" then Stats.Stories else false
    if type(Stories) == "table" then
        v3 = Stories[p2]
        if not v3 then
            v3 = Stories[tostring(p2)]
        end
    else
        v3 = nil
    end
    if type(v3) == "table" then
        v4 = v3[p3]
        if not v4 then
            v4 = v3[tostring(p3)]
        end
    else
        v4 = nil
    end
    if type(v4) ~= "table" then
        return false
    end
    for k, v in pairs(v4) do
        v1 = false
        if type(v) == "table" then
            v2 = tonumber(v[7]) or 0
            v1 = 0 < v2
        end
        if v1 then
            return true
        end
    end
    return false
end
local function chapterWasCompleted(p1, p2, p3) -- Line: 431 -- upvalues: statsChapterWasCompleted (val)
    local Progression, Stories, v1
    Progression = if type(p1) == "table" then p1.Progression else false
    Stories = if type(Progression) == "table" then Progression.Stories else false
    if type(Stories) == "table" then
        v1 = Stories[p2]
        if not v1 then
            v1 = Stories[tostring(p2)]
        end
    else
        v1 = nil
    end
    local v2 = tonumber(v1)
    if not v2 then
        return (statsChapterWasCompleted(p1, p2, p3))
    end
    if p3 <= v2 then
        return true
    end
    return (statsChapterWasCompleted(p1, p2, p3))
end
local function hasCompletedChapter(p1) -- Line: 442
    local Progression, Stories
    Progression = if type(p1) == "table" then p1.Progression else false
    Stories = if type(Progression) == "table" then Progression.Stories else false
    if type(Stories) ~= "table" then
        local Stats, v1, v2
        Stats = if type(p1) == "table" then p1.Stats else false
        local Stories_2 = if type(Stats) == "table" then Stats.Stories else false
        if type(Stories_2) ~= "table" then
            return false
        end
        for k, v in pairs(Stories_2) do
            if type(v) == "table" then
                for k2, i in pairs(v) do
                    if type(i) == "table" then
                        for k3, j in pairs(i) do
                            v1 = false
                            if type(j) == "table" then
                                v2 = tonumber(j[7]) or 0
                                v1 = 0 < v2
                            end
                            if v1 then
                                return true
                            end
                        end
                    end
                end
            end
        end
        return false
    else
        local v3
        for k4, k5 in pairs(Stories) do
            v3 = tonumber(k5) or 0
            if 1 <= v3 then
                return true
            end
        end
    end
end
local function getUnlocked(p1) -- Line: 476
    local Documents, Unlocked
    Documents = if type(p1) == "table" then p1.Documents else false
    if type(Documents) ~= "table" then
        Unlocked = {}
    elseif type(Documents.Unlocked) ~= "table" then
        Unlocked = {}
    else
        Unlocked = Documents.Unlocked
        if not Unlocked then
            Unlocked = {}
        end
    end
    return Unlocked
end
local function categoryUnlockCount(p1, p2) -- Line: 481 -- upvalues: u12 (val)
    local Documents, Unlocked
    Documents = if type(p1) == "table" then p1.Documents else false
    if type(Documents) ~= "table" then
        Unlocked = {}
    elseif type(Documents.Unlocked) == "table" then
        Unlocked = Documents.Unlocked
    end
    local v1 = 0
    for i, v in ipairs(u12.Documents) do
        if v.category == p2 and Unlocked[v.id] then
            v1 = v1 + 1
        end
    end
    return v1
end
local function distinctWeaponSkinCount(p1) -- Line: 492 -- upvalues: u16 (val), ItemData (val)
    local Inventory
    Inventory = if type(p1) == "table" then p1.Inventory else false
    if type(Inventory) ~= "table" then
        return 0
    end
    local v1 = os.clock()
    local v2 = u16[p1]
    if not v2 then
        local BaseWeaponId, ItemId, v3, v4
        local v5 = {}
        for k, v in pairs(Inventory) do
            if type(v) ~= "table" then
                ItemId = nil
            else
                ItemId = v[1]
                if not ItemId then
                    ItemId = v.ItemId
                end
            end
            if ItemId ~= nil then
                v3 = tostring(ItemId)
                v4 = ItemData.List[v3]
                BaseWeaponId = v4
                if BaseWeaponId then
                    BaseWeaponId = v4.BaseWeaponId
                end
                if BaseWeaponId ~= nil and tostring(BaseWeaponId) ~= "" then
                    v5[v3] = true
                end
            end
        end
        local v6 = 0
        for k2 in pairs(v5) do
            v6 = v6 + 1
        end
        u16[p1] = {inventory = Inventory, count = v6, expiresAt = v1 + 10}
        return v6
    elseif v2.inventory == Inventory and v1 < v2.expiresAt then
        return v2.count
    end
end
local function enemyWasKilled(p1, p2) -- Line: 529
    local DocumentEnemyKills, Stats, UniqueAwards
    Stats = if type(p1) == "table" then p1.Stats else false
    UniqueAwards = if type(Stats) == "table" then Stats.UniqueAwards else false
    DocumentEnemyKills = if type(UniqueAwards) == "table" then UniqueAwards.DocumentEnemyKills else false
    local v1 = if type(DocumentEnemyKills) == "table" then DocumentEnemyKills[p2] else false
    local v2 = true
    if v1 ~= true then
        local v3 = tonumber(v1) or 0
        v2 = 0 < v3
    end
    return v2
end
u12.Checks = {
    AnyChapterCompleted = function(p1) -- Line: 538 -- upvalues: hasCompletedChapter (val)
        return (hasCompletedChapter(p1))
    end,
    SpecificChapterCompleted = function(p1, p2) -- Line: 541 -- upvalues: statsChapterWasCompleted (val)
        local Progression, Stories, v1
        local storyId = p2.storyId
        local chapter = p2.chapter
        Progression = if type(p1) == "table" then p1.Progression else false
        Stories = if type(Progression) == "table" then Progression.Stories else false
        if type(Stories) == "table" then
            v1 = Stories[storyId]
            if not v1 then
                v1 = Stories[tostring(storyId)]
            end
        else
            v1 = nil
        end
        local v2 = tonumber(v1)
        if not v2 then
            return (statsChapterWasCompleted(p1, storyId, chapter))
        end
        if chapter <= v2 then
            return true
        end
        return (statsChapterWasCompleted(p1, storyId, chapter))
    end,
    CumulativeZBucksSpent = function(p1, p2) -- Line: 544
        local Overall, Stats, ZBucksSpent
        Stats = if type(p1) == "table" then p1.Stats else false
        Overall = if type(Stats) == "table" then Stats.Overall else false
        ZBucksSpent = if type(Overall) == "table" then Overall.ZBucksSpent else false
        local v1 = tonumber(ZBucksSpent) or 0
        local v2 = p2.amount <= v1
        return v2
    end,
    HardPlusPerfectAccuracy = function(p1) -- Line: 549
        local HardPlusPerfectAccuracyAt, Stats, UniqueAwards
        Stats = if type(p1) == "table" then p1.Stats else false
        UniqueAwards = if type(Stats) == "table" then Stats.UniqueAwards else false
        HardPlusPerfectAccuracyAt = if type(UniqueAwards) == "table" then UniqueAwards.HardPlusPerfectAccuracyAt else false
        local v1 = tonumber(HardPlusPerfectAccuracyAt) or 0
        local v2 = 0 < v1
        return v2
    end,
    CategoryUnlockCount = function(p1, p2) -- Line: 554 -- upvalues: categoryUnlockCount (val)
        local v1 = categoryUnlockCount(p1, p2.category)
        local v2 = p2.count <= v1
        return v2
    end,
    DistinctWeaponSkinCount = function(p1, p2) -- Line: 557 -- upvalues: distinctWeaponSkinCount (val)
        local v1 = distinctWeaponSkinCount(p1)
        local v2 = p2.count <= v1
        return v2
    end,
    EnemyKilled = function(p1, p2) -- Line: 560
        local DocumentEnemyKills, Stats, UniqueAwards
        Stats = if type(p1) == "table" then p1.Stats else false
        UniqueAwards = if type(Stats) == "table" then Stats.UniqueAwards else false
        DocumentEnemyKills = if type(UniqueAwards) == "table" then UniqueAwards.DocumentEnemyKills else false
        local v1 = if type(DocumentEnemyKills) == "table" then DocumentEnemyKills[p2.enemy] else false
        local v2 = true
        if v1 ~= true then
            local v3 = tonumber(v1) or 0
            v2 = 0 < v3
        end
        return v2
    end,
}
local function matchesPlace(p1, p2, p3) -- Line: 565
    local unlock = p1.unlock
    if type(unlock) ~= "table" or unlock.kind ~= "worldPickup" or unlock.storyId ~= p2 then
        return false
    end
    if unlock.chapter == nil then
        return true
    end
    local v1 = tonumber(unlock.chapter)
    local v2 = v1 == tonumber(p3)
    return v2
end
function u12.ResolveId(p1) -- Line: 576 -- upvalues: u12 (val)
    return u12.LegacyIds[p1] or p1
end
local function normalizeEnemyName(p1) -- Line: 580
    local v1
    if type(p1) ~= "string" then
        return nil
    end
    local v2 = string.lower(p1):gsub("[^%w]", "")
    if v2 == "" then
        v1 = nil
    else
        v1 = v2
        if not v1 then
            v1 = nil
        end
    end
    return v1
end
function u12.ResolveEnemyKillName(...) -- Line: 589 -- upvalues: u12 (val)
    local enemy, unlock, v1, v2, v3, v4, v5, v6, v7
    local v8 = select("#", ...)
    local v9 = 1
    for i = 1, v8, v9 do
        v6 = select(i, ...)
        if type(v6) == "string" then
            v7 = string.lower(v6):gsub("[^%w]", "")
            if v7 == "" then
                v5 = nil
            else
                v5 = v7
            end
        else
            v5 = nil
        end
        if v5 then
            for i2, v in ipairs(u12.Documents) do
                unlock = v.unlock
                if type(unlock) == "table" and unlock.kind == "condition" and unlock.check == "EnemyKilled" then
                    enemy = unlock.enemy
                    if type(enemy) == "string" then
                        v2 = string.lower(enemy):gsub("[^%w]", "")
                        if v2 == "" then
                            v1 = nil
                        else
                            v1 = v2
                        end
                    else
                        v1 = nil
                    end
                    if v1 == v5 then
                        return unlock.enemy
                    end
                    if type(unlock.enemyModels) == "table" then
                        for i3, j in ipairs(unlock.enemyModels) do
                            if type(j) == "string" then
                                v4 = string.lower(j):gsub("[^%w]", "")
                                if v4 == "" then
                                    v3 = nil
                                else
                                    v3 = v4
                                end
                            else
                                v3 = nil
                            end
                            if v3 == v5 then
                                return unlock.enemy
                            end
                        end
                    end
                end
            end
        end
    end
    return nil
end
function u12.GetById(p1) -- Line: 613 -- upvalues: u12 (val)
    local v1 = u12.ResolveId(p1)
    for i, v in ipairs(u12.Documents) do
        if v.id == v1 then
            return v
        end
    end
    return nil
end
function u12.GetCategory(p1) -- Line: 623 -- upvalues: u12 (val)
    for i, v in ipairs(u12.Categories) do
        if v.id == p1 then
            return v
        end
    end
    return nil
end
function u12.ByCategory(p1) -- Line: 632 -- upvalues: u12 (val)
    local v1 = {}
    for i, v in ipairs(u12.Documents) do
        if v.category == p1 then
            table.insert(v1, v)
        end
    end
    return v1
end
function u12.Total() -- Line: 642 -- upvalues: u12 (val)
    return #u12.Documents
end
function u12.PickupsForPlace(p1, p2) -- Line: 646 -- upvalues: u12 (val)
    local unlock, v1, v2, v3, v4
    local v5 = {}
    if type(p1) ~= "string" or p1 == "" then
        return v5
    end
    v1, v2 = p1, p2
    for i, v in ipairs(u12.Documents) do
        unlock = v.unlock
        if type(unlock) ~= "table" then
            v4 = false
        elseif unlock.kind == "worldPickup" and unlock.storyId == v1 then
            if unlock.chapter ~= nil then
                v3 = tonumber(unlock.chapter)
                v4 = v3 == tonumber(v2)
            else
                v4 = true
            end
        end
        if v4 then
            table.insert(v5, v)
        end
    end
    return v5
end
local function mergeUnlockTimestamp(p1, p2) -- Line: 659
    if p1 == nil then
        return p2
    end
    local v1 = tonumber(p1)
    local v2 = tonumber(p2)
    if not v1 or 0 >= v1 or not v2 then
        return p1
    end
    if 0 < v2 then
        return (math.min(v1, v2))
    end
    return p1
end
function u12.MigrateDocumentData(p1) -- Line: 671 -- upvalues: u12 (val)
    local Documents, Unlocked, v1, v2, v3, v4, v5
    if type(p1) ~= "table" then
        return false
    end
    if type(p1.Documents) ~= "table" then
        p1.Documents = {}
    end
    Documents = p1.Documents
    if type(Documents.Unlocked) ~= "table" then
        Documents.Unlocked = {}
    end
    if type(Documents.Viewed) ~= "table" then
        Documents.Viewed = {}
    end
    local v6 = false
    for k, v in pairs(u12.LegacyIds) do
        v5 = Documents.Unlocked[k]
        if v5 ~= nil then
            Unlocked = Documents.Unlocked
            v2 = Documents.Unlocked[v]
            if v2 ~= nil then
                v3 = tonumber(v2)
                v4 = tonumber(v5)
                if not v3 then
                    v1 = v2
                elseif 0 < v3 and v4 and 0 < v4 then
                    v1 = math.min(v3, v4)
                end
            else
                v1 = v5
            end
            Unlocked[v] = v1
            Documents.Unlocked[k] = nil
            v6 = true
        end
        if Documents.Viewed[k] ~= nil then
            if Documents.Viewed[v] == nil then
                Documents.Viewed[v] = Documents.Viewed[k]
            elseif Documents.Viewed[k] == true then
                Documents.Viewed[v] = true
            end
            Documents.Viewed[k] = nil
            v6 = true
        end
    end
    return v6
end
function u12.EvaluateConditions(p1) -- Line: 707 -- upvalues: u12 (val)
    local Documents, Unlocked, unlock, v1, v2, v3
    local v4 = {}
    Documents = if type(p1) == "table" then p1.Documents else false
    if type(Documents) ~= "table" then
        Unlocked = {}
    elseif type(Documents.Unlocked) == "table" then
        Unlocked = Documents.Unlocked
    end
    local v5 = p1
    for i, v in ipairs(u12.Documents) do
        unlock = v.unlock
        if type(unlock) == "table" and unlock.kind == "condition" and not (Unlocked[v.id]) then
            v3 = u12.Checks[unlock.check]
            if type(v3) == "function" then
                v1, v2 = pcall(v3, v5, unlock, v)
                if not v1 then
                    if not v1 then
                        warn(string.format("[Documents] Condition %s failed for %s: %s", unlock.check, v.id, v2))
                    end
                elseif v2 == true then
                    table.insert(v4, v.id)
                end
            end
        end
    end
    return v4
end
function u12.GetConditionProgress(p1, p2) -- Line: 729 -- upvalues: u12 (val), categoryUnlockCount (val), distinctWeaponSkinCount (val), statsChapterWasCompleted (val), hasCompletedChapter (val)
    local Stats, v1, v2, v3, v4, v5, v6
    if type(p2) ~= "table" then
        v2 = u12.GetById(p2)
    else
        v2 = p2
    end
    if not v2 then
        return nil
    end
    local unlock = v2.unlock
    if type(unlock) ~= "table" then
        return {kind = "invalid", current = 0, required = 1, satisfied = false}
    end
    if unlock.kind == "locked" then
        return {kind = "locked", current = 0, required = 1, satisfied = false}
    end
    if unlock.kind == "worldPickup" then
        local Documents, Unlocked, Unlocked_2, v7
        v3 = {kind = "worldPickup", required = 1}
        Documents = if type(p1) == "table" then p1.Documents else false
        if type(Documents) ~= "table" then
            Unlocked = {}
        elseif type(Documents.Unlocked) == "table" then
            Unlocked = Documents.Unlocked
        end
        if not (Unlocked[v2.id]) then
            v7 = 0
        else
            v7 = 1
        end
        v3.current = v7
        local Documents_2 = if type(p1) == "table" then p1.Documents else false
        if type(Documents_2) ~= "table" then
            Unlocked_2 = {}
        elseif type(Documents_2.Unlocked) == "table" then
            Unlocked_2 = Documents_2.Unlocked
        end
        v7 = Unlocked_2[v2.id] ~= nil
        v3.satisfied = v7
        v7 = typeof(unlock.cframe) == "CFrame"
        v3.placed = v7
        return v3
    end
    if unlock.kind ~= "condition" then
        return {current = 0, required = 1, satisfied = false, kind = tostring(unlock.kind)}
    end
    v3 = 0
    local amount = 1
    if unlock.check == "CumulativeZBucksSpent" then
        local Overall, ZBucksSpent
        Stats = if type(p1) == "table" then p1.Stats else false
        Overall = if type(Stats) == "table" then Stats.Overall else false
        ZBucksSpent = if type(Overall) == "table" then Overall.ZBucksSpent else false
        v3 = tonumber(ZBucksSpent) or 0
        amount = unlock.amount
    else
        local UniqueAwards
        if unlock.check == "HardPlusPerfectAccuracy" then
            local HardPlusPerfectAccuracyAt
            local Stats_2 = if type(p1) == "table" then p1.Stats else false
            UniqueAwards = if type(Stats_2) == "table" then Stats_2.UniqueAwards else false
            HardPlusPerfectAccuracyAt = if type(UniqueAwards) == "table" then UniqueAwards.HardPlusPerfectAccuracyAt else false
            v5 = tonumber(HardPlusPerfectAccuracyAt) or 0
            if 0 >= v5 then
                v3 = 0
            else
                v3 = 1
            end
        elseif unlock.check == "CategoryUnlockCount" then
            v3 = categoryUnlockCount(p1, unlock.category)
            amount = unlock.count
        elseif unlock.check == "DistinctWeaponSkinCount" then
            v3 = distinctWeaponSkinCount(p1)
            amount = unlock.count
        else
            local v8, v9
            if unlock.check == "SpecificChapterCompleted" then
                local Progression, Stories
                local storyId = unlock.storyId
                local chapter = unlock.chapter
                Progression = if type(p1) == "table" then p1.Progression else false
                Stories = if type(Progression) == "table" then Progression.Stories else false
                if type(Stories) == "table" then
                    v9 = Stories[storyId]
                    if not v9 then
                        v9 = Stories[tostring(storyId)]
                    end
                else
                    v9 = nil
                end
                v8 = tonumber(v9)
                if not v8 then
                    v4 = statsChapterWasCompleted(p1, storyId, chapter)
                elseif chapter <= v8 then
                    v4 = true
                end
                if not v4 then
                    v3 = 0
                else
                    v3 = 1
                end
            elseif unlock.check ~= "AnyChapterCompleted" then
                if unlock.check == "EnemyKilled" then
                    local DocumentEnemyKills
                    local Stats_3 = if type(p1) == "table" then p1.Stats else false
                    local UniqueAwards_2 = if type(Stats_3) == "table" then Stats_3.UniqueAwards else false
                    DocumentEnemyKills = if type(UniqueAwards_2) == "table" then UniqueAwards_2.DocumentEnemyKills else false
                    v8 = if type(DocumentEnemyKills) == "table" then DocumentEnemyKills[unlock.enemy] else false
                    v4 = true
                    if v8 ~= true then
                        v9 = tonumber(v8) or 0
                        v4 = 0 < v9
                    end
                    if not v4 then
                        v3 = 0
                    else
                        v3 = 1
                    end
                end
            elseif not (hasCompletedChapter(p1)) then
                v3 = 0
            else
                v3 = 1
            end
        end
    end
    v4 = u12.Checks[unlock.check]
    local v10 = false
    v5 = false
    if type(v4) == "function" then
        v6, v1 = pcall(v4, p1, unlock, v2)
        v10 = v6
        v5 = v1
    end
    v6 = {kind = "condition", check = unlock.check, current = v3, required = amount}
    v1 = v10
    if v1 then
        v1 = v5 == true
    end
    v6.satisfied = v1
    return v6
end
local function validPositiveInteger(p1) -- Line: 792
    local v1 = if type(p1) == "number" then if 0 < p1 then p1 % 1 == 0 else false else false
    return v1
end
local function validateCondition(p1, p2) -- Line: 796 -- upvalues: u12 (val)
    local v1
    if type(p2.check) ~= "string" or type(u12.Checks[p2.check]) ~= "function" then
        return "unknown condition check " .. tostring(p2.check)
    end
    if p2.check == "CumulativeZBucksSpent" then
        if type(p2.amount) ~= "number" or p2.amount <= 0 then
            return "amount must be a positive number"
        end
        return nil
    end
    if p2.check == "CategoryUnlockCount" then
        if not (u12.GetCategory(p2.category)) then
            return "category must name a registered category"
        end
        local count = p2.count
        v1 = if type(count) == "number" then if 0 < count then count % 1 == 0 else false else false
        if not v1 then
            return "count must be a positive integer"
        end
        return nil
    end
    if p2.check == "DistinctWeaponSkinCount" then
        local count_2 = p2.count
        v1 = if type(count_2) == "number" then if 0 < count_2 then count_2 % 1 == 0 else false else false
        if not v1 then
            return "count must be a positive integer"
        end
        return nil
    end
    if p2.check == "SpecificChapterCompleted" then
        if type(p2.storyId) ~= "string" or p2.storyId == "" then
            return "storyId must be a non-empty string"
        end
        local chapter = p2.chapter
        v1 = if type(chapter) == "number" then if 0 < chapter then chapter % 1 == 0 else false else false
        if not v1 then
            return "chapter must be a positive integer"
        end
        return nil
    end
    if p2.check ~= "EnemyKilled" then
        return nil
    end
    if type(p2.enemy) ~= "string" or p2.enemy == "" then
        return "enemy must be a non-empty string"
    end
    if p2.enemyModels == nil then
        return nil
    end
    if type(p2.enemyModels) ~= "table" or #p2.enemyModels == 0 then
        return "enemyModels must be a non-empty array"
    end
    v1 = 0
    for k, v in pairs(p2.enemyModels) do
        v1 = v1 + 1
        if type(k) == "number" and k % 1 == 0 and k >= 1 and #p2.enemyModels >= k then
            if type(v) == "string" and v ~= "" then
                continue
            end
            return "enemyModels must contain only non-empty strings"
        end
        return "enemyModels must be an array"
    end
    if v1 ~= #p2.enemyModels then
        return "enemyModels must be an array"
    end
    return nil
end
function u12.FindModel(p1, p2) -- Line: 844 -- upvalues: u12 (val)
    local v1
    local v2 = p2
    if not v2 then
        v2 = u12.GetAssetRoot()
    end
    local v3 = v2
    if not v3 then
        return nil
    end
    v2 = u12.GetCategory(p1.category)
    local v4 = v2
    if v4 then
        v4 = v3:FindFirstChild(v2.folder)
    end
    if not v4 then
        v1 = v3:FindFirstChild(p1.model, true)
    else
        v1 = v4:FindFirstChild(p1.model, true)
        if not v1 then
            v1 = v3:FindFirstChild(p1.model, true)
        end
    end
    if not v1 then
        return nil
    end
    if v1:IsA("Model") then
        return v1
    end
    return nil
end
function u12.Audit(p1, p2, p3) -- Line: 856 -- upvalues: u12 (val), validateCondition (val)
    local category, chapter, count, unlock, unlock_2, unlock_3, v1, v2, v3, v4, v5, v6, v7
    local v8 = {
        duplicateIds = {},
        duplicateCategoryIds = {},
        invalidCategories = {},
        invalidConditions = {},
        invalidDocuments = {},
        impossibleConditions = {},
        missingPlacements = {},
        missingModels = {},
        missingSurfaceGuis = {},
    }
    local v9 = {}
    local v10 = {}
    local v11 = {}
    v1, v2, v7 = p1, p2, p3
    for i, v in ipairs(u12.Categories) do
        if v10[v.id] then
            table.insert(v8.duplicateCategoryIds, v.id)
        end
        v10[v.id] = true
        v11[v.id] = 0
    end
    for i2, i3 in ipairs(u12.Documents) do
        if type(i3.id) ~= "string" then
            table.insert(v8.invalidDocuments, "document with missing id")
        elseif i3.id ~= "" then
            if not (v9[i3.id]) then
                v9[i3.id] = true
            else
                table.insert(v8.duplicateIds, i3.id)
            end
        end
        if u12.GetCategory(i3.category) then
            category = i3.category
            v11[category] = v11[category] + 1
        else
            v6 = tostring(i3.id)
            table.insert(v8.invalidCategories, string.format("%s: %s", v6, (tostring(i3.category))))
        end
        if type(i3.model) ~= "string" then
            v5 = tostring(i3.id)
            table.insert(v8.invalidDocuments, v5 .. ": missing model name")
        elseif i3.model ~= "" then
        end
        unlock_2 = i3.unlock
        if type(unlock_2) ~= "table" then
            v6 = tostring(i3.id)
            table.insert(v8.invalidDocuments, v6 .. ": missing unlock definition")
        elseif unlock_2.kind == "condition" then
            v3 = validateCondition(i3, unlock_2)
            if v3 then
                table.insert(v8.invalidConditions, string.format("%s: %s", i3.id, v3))
            end
        elseif unlock_2.kind == "worldPickup" then
            if type(unlock_2.storyId) ~= "string" then
                table.insert(v8.invalidDocuments, i3.id .. ": pickup storyId is missing")
            elseif unlock_2.storyId ~= "" and unlock_2.chapter ~= nil then
                chapter = unlock_2.chapter
                v3 = if type(chapter) == "number" then if 0 < chapter then chapter % 1 == 0 else false else false
                if not v3 then
                    table.insert(v8.invalidDocuments, i3.id .. ": pickup chapter is invalid")
                end
            end
            if v1 ~= nil then
                unlock_3 = i3.unlock
                if type(unlock_3) ~= "table" then
                    v3 = false
                elseif unlock_3.kind == "worldPickup" and unlock_3.storyId == v1 then
                    if unlock_3.chapter ~= nil then
                        v5 = tonumber(unlock_3.chapter)
                        v3 = v5 == tonumber(v2)
                    else
                        v3 = true
                    end
                end
                if not v3 then end
            elseif typeof(unlock_2.cframe) ~= "CFrame" then
                table.insert(v8.missingPlacements, i3.id)
            end
        elseif unlock_2.kind ~= "locked" then
            table.insert(v8.invalidDocuments, i3.id .. ": unknown unlock kind " .. tostring(unlock_2.kind))
        end
        if v7 then
            v3 = u12.FindModel(i3, v7)
            if not v3 then
                table.insert(v8.missingModels, string.format("%s(%s)", i3.id, (tostring(i3.model))))
            elseif not (v3:FindFirstChildWhichIsA("SurfaceGui", true)) then
                table.insert(v8.missingSurfaceGuis, i3.id)
            end
        end
    end
    for i4, j in ipairs(u12.Documents) do
        unlock = j.unlock
        if type(unlock) == "table" and unlock.kind == "condition" and unlock.check == "CategoryUnlockCount" then
            v3 = v11[unlock.category] or 0
            count = unlock.count
            v4 = if type(count) == "number" then if 0 < count then count % 1 == 0 else false else false
            if v4 and v3 < unlock.count then
                table.insert(v8.impossibleConditions, string.format("%s needs %d %s documents; %d registered", j.id, unlock.count, unlock.category, v3))
            end
        end
    end
    for k, k2 in pairs(v8) do
        table.sort(k2)
    end
    return v8
end
return u12