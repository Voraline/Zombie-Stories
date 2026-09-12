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
    id = "Boss",
    category = "PeopleOfInterest",
    title = "BOSS",
    model = "documentJohnathan",
    unlock = {
        kind = "worldPickup",
        storyId = "EXT",
        chapter = 4,
        hint = "Find in Verboten Grounds",
        cframe = CFrame.new(
            189.365829,
            -546.582642,
            -138.226028,
            0.912785411,
            0,
            0.408439487,
            0,
            1,
            0,
            -0.408439398,
            0,
            0.912785411
        ),
    },
}
local v3 = {
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
local v4 = {
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
    unlock = {
        kind = "condition",
        check = "EnemyKilled",
        enemy = "TaintedSlasher",
        hint = "Kill a Tainted Slasher",
    },
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
    unlock = {
        kind = "condition",
        check = "EnemyKilled",
        enemy = "SpectralHunter",
        hint = "Kill a Spectral Hunter",
    },
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
    unlock = {
        kind = "condition",
        check = "EnemyKilled",
        enemy = "CyberneticSmasher",
        hint = "Kill a Cybernetic Smasher",
    },
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
v1[11] = {
    id = "VolatileIncarnation",
    category = "HeavyPlusZombies",
    title = "VOLATILE INCARNATION",
    model = "documentVolatileIncarnation",
    unlock = {
        kind = "condition",
        check = "EnemyKilled",
        enemy = "VolatileIncarnation",
        hint = "Kill a Volatile Incarnation",
    },
}
v1[12] = v2
v1[13] = v3
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
v1[16] = v4
local v5 = {
    id = "Odysseus",
    category = "Locations",
    title = "THE ODYSSEUS",
    model = "documentOdysseus",
    unlock = {
        kind = "worldPickup",
        storyId = "Lobby",
        hint = "Find on the Odysseus",
        cframe = CFrame.new(
            -134.399994,
            77.3422775,
            -6.69999695,
            0.906307757,
            0,
            -0.42261827,
            0,
            1,
            0,
            0.42261827,
            0,
            0.906307757
        ),
    },
}
v1[17] = {
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
v1[18] = {
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
v1[19] = {
    id = "UMBRA",
    category = "UMBRA",
    title = "UMBRA",
    model = "documentUMBRA",
    unlock = {kind = "condition", check = "AnyChapterCompleted", hint = "Beat any chapter on any difficulty"},
}
v1[20] = v5
v1[21] = {
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
v1[22] = {
    id = "Assistant",
    category = "Personnel",
    title = "ASSISTANT",
    model = "documentAssistant",
    unlock = {kind = "locked", hint = "Unlock condition not yet assigned"},
}
v1[23] = {
    id = "Izumi",
    category = "Personnel",
    title = "OPERATOR IA-039",
    model = "documentIzumi",
    unlock = {
        kind = "condition",
        check = "DistinctWeaponSkinCount",
        count = 50,
        hint = "Own 50 different weapon skins",
    },
}
v1[24] = {
    id = "Quartermaster",
    category = "Personnel",
    title = "QUARTERMASTER",
    model = "documentQuartermaster",
    unlock = {
        kind = "condition",
        check = "CumulativeZBucksSpent",
        amount = 3000,
        hint = "Spend at least 3,000 Z$",
    },
}
v1[25] = {
    id = "Rangemaster",
    category = "Personnel",
    title = "RANGEMASTER",
    model = "documentRangemaster",
    unlock = {
        kind = "condition",
        check = "HardPlusPerfectAccuracy",
        hint = "Finish a Hard or Nightmare chapter with 70% accuracy and at least 25 shots",
    },
}
v1[26] = {
    id = "Jenny",
    category = "Personnel",
    title = "OPERATOR JH-827",
    model = "documentJenny",
    unlock = {kind = "locked", hint = "Unlock condition not yet assigned"},
}
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
        local v2 = p1[7]
        v1 = 0 < (tonumber(v2) or 0)
    end
    return v1
end

local function statsChapterWasCompleted(p1, p2, p3) -- Line: 414
    local v1, v2, v3, v4
    local Stats = false
    if type(p1) == "table" then
        Stats = p1.Stats
    end
    local Stories = false
    if type(Stats) == "table" then
        Stories = Stats.Stories
    end
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
            v2 = v[7]
            v1 = 0 < (tonumber(v2) or 0)
        end
        if v1 then
            return true
        end
    end
    return false
end

local function chapterWasCompleted(p1, p2, p3) -- Line: 431 -- upvalues: statsChapterWasCompleted (val)
    local v1
    local Progression = false
    if type(p1) == "table" then
        Progression = p1.Progression
    end
    local Stories = false
    if type(Progression) == "table" then
        Stories = Progression.Stories
    end
    if type(Stories) == "table" then
        v1 = Stories[p2]
        if not v1 then
            v1 = Stories[tostring(p2)]
        end
    else
        v1 = nil
    end
    local v2 = tonumber(v1)
    if v2 and p3 <= v2 then
        return true
    end
    return (statsChapterWasCompleted(p1, p2, p3))
end

local function hasCompletedChapter(p1) -- Line: 442
    local v1, v2
    local Progression = false
    if type(p1) == "table" then
        Progression = p1.Progression
    end
    local Stories = false
    if type(Progression) == "table" then
        Stories = Progression.Stories
    end
    if type(Stories) == "table" then
        for k, v in pairs(Stories) do
            if 1 <= (tonumber(v) or 0) then
                return true
            end
        end
    end
    local Stats = false
    if type(p1) == "table" then
        Stats = p1.Stats
    end
    local Stories_2 = false
    if type(Stats) == "table" then
        Stories_2 = Stats.Stories
    end
    if type(Stories_2) ~= "table" then
        return false
    end
    for k2, i in pairs(Stories_2) do
        if type(i) == "table" then
            for k3, j in pairs(i) do
                if type(j) == "table" then
                    for k4, k5 in pairs(j) do
                        v1 = false
                        if type(k5) == "table" then
                            v2 = k5[7]
                            v1 = 0 < (tonumber(v2) or 0)
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
end

local function getUnlocked(p1) -- Line: 476
    local Unlocked_2
    local Documents = false
    if type(p1) == "table" then
        Documents = p1.Documents
    end
    if type(Documents) ~= "table" then
        Unlocked_2 = {}
    else
        local Unlocked = Documents.Unlocked
        if type(Unlocked) ~= "table" then
            Unlocked_2 = {}
        else
            Unlocked_2 = Documents.Unlocked
            if not Unlocked_2 then
                Unlocked_2 = {}
            end
        end
    end
    return Unlocked_2
end

local function categoryUnlockCount(p1, p2) -- Line: 481 -- upvalues: u12 (val)
    local Unlocked_2
    local Documents = false
    if type(p1) == "table" then
        Documents = p1.Documents
    end
    if type(Documents) ~= "table" then
        Unlocked_2 = {}
    else
        local Unlocked = Documents.Unlocked
        if type(Unlocked) ~= "table" then
            Unlocked_2 = {}
        else
            Unlocked_2 = Documents.Unlocked
            if not Unlocked_2 then
                Unlocked_2 = {}
            end
        end
    end
    local v1 = 0
    for i, v in ipairs(u12.Documents) do
        if v.category == p2 and Unlocked_2[v.id] then
            v1 = v1 + 1
        end
    end
    return v1
end

local function distinctWeaponSkinCount(p1) -- Line: 492 -- upvalues: u16 (val), ItemData (val)
    local BaseWeaponId, ItemId, v1, v2
    local Inventory = false
    if type(p1) == "table" then
        Inventory = p1.Inventory
    end
    if type(Inventory) ~= "table" then
        return 0
    end
    local v3 = os.clock()
    local v4 = u16[p1]
    if v4 and v4.inventory == Inventory and v3 < v4.expiresAt then
        return v4.count
    end
    local v5 = {}
    local v6 = p1
    for k, v in pairs(Inventory) do
        if type(v) ~= "table" then
            ItemId = nil
        else
            ItemId = v[1]
            if not ItemId then
                ItemId = v.ItemId
                if not ItemId then
                    ItemId = nil
                end
            end
        end
        if ItemId ~= nil then
            v1 = tostring(ItemId)
            v2 = ItemData.List[v1]
            BaseWeaponId = v2
            if BaseWeaponId then
                BaseWeaponId = v2.BaseWeaponId
            end
            if BaseWeaponId ~= nil and tostring(BaseWeaponId) ~= "" then
                v5[v1] = true
            end
        end
    end
    local v7 = 0
    for k2 in pairs(v5) do
        v7 = v7 + 1
    end
    local v8 = u16
    v8[v6] = {inventory = Inventory, count = v7, expiresAt = v3 + 10}
    return v7
end

local function enemyWasKilled(p1, p2) -- Line: 529
    local Stats = false
    if type(p1) == "table" then
        Stats = p1.Stats
    end
    local UniqueAwards = false
    if type(Stats) == "table" then
        UniqueAwards = Stats.UniqueAwards
    end
    local DocumentEnemyKills = false
    if type(UniqueAwards) == "table" then
        DocumentEnemyKills = UniqueAwards.DocumentEnemyKills
    end
    local v1 = false
    if type(DocumentEnemyKills) == "table" then
        v1 = DocumentEnemyKills[p2]
    end
    local v2 = true
    if v1 ~= true then
        v2 = 0 < (tonumber(v1) or 0)
    end
    return v2
end

local v6 = {
    AnyChapterCompleted = function(p1) -- Line: 538 -- upvalues: hasCompletedChapter (val)
        return (hasCompletedChapter(p1))
    end,
    SpecificChapterCompleted = function(p1, p2) -- Line: 541 -- upvalues: statsChapterWasCompleted (val)
        local v1
        local storyId = p2.storyId
        local chapter = p2.chapter
        local Progression = false
        if type(p1) == "table" then
            Progression = p1.Progression
        end
        local Stories = false
        if type(Progression) == "table" then
            Stories = Progression.Stories
        end
        if type(Stories) == "table" then
            v1 = Stories[storyId]
            if not v1 then
                v1 = Stories[tostring(storyId)]
            end
        else
            v1 = nil
        end
        local v2 = tonumber(v1)
        if v2 and chapter <= v2 then
            return true
        end
        return (statsChapterWasCompleted(p1, storyId, chapter))
    end,
    CumulativeZBucksSpent = function(p1, p2) -- Line: 544
        local Stats = false
        if type(p1) == "table" then
            Stats = p1.Stats
        end
        local Overall = false
        if type(Stats) == "table" then
            Overall = Stats.Overall
        end
        local ZBucksSpent = false
        if type(Overall) == "table" then
            ZBucksSpent = Overall.ZBucksSpent
        end
        local v1 = tonumber(ZBucksSpent) or 0
        local v2 = p2.amount <= v1
        return v2
    end,
    HardPlusPerfectAccuracy = function(p1) -- Line: 549
        local Stats = false
        if type(p1) == "table" then
            Stats = p1.Stats
        end
        local UniqueAwards = false
        if type(Stats) == "table" then
            UniqueAwards = Stats.UniqueAwards
        end
        local HardPlusPerfectAccuracyAt = false
        if type(UniqueAwards) == "table" then
            HardPlusPerfectAccuracyAt = UniqueAwards.HardPlusPerfectAccuracyAt
        end
        local v1 = 0 < (tonumber(HardPlusPerfectAccuracyAt) or 0)
        return v1
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
        local enemy = p2.enemy
        local Stats = false
        if type(p1) == "table" then
            Stats = p1.Stats
        end
        local UniqueAwards = false
        if type(Stats) == "table" then
            UniqueAwards = Stats.UniqueAwards
        end
        local DocumentEnemyKills = false
        if type(UniqueAwards) == "table" then
            DocumentEnemyKills = UniqueAwards.DocumentEnemyKills
        end
        local v1 = false
        if type(DocumentEnemyKills) == "table" then
            v1 = DocumentEnemyKills[enemy]
        end
        local v2 = true
        if v1 ~= true then
            v2 = 0 < (tonumber(v1) or 0)
        end
        return v2
    end,
}
u12.Checks = v6

local function matchesPlace(p1, p2, p3) -- Line: 565
    local unlock = p1.unlock
    if type(unlock) == "table" and unlock.kind == "worldPickup" and unlock.storyId == p2 then
        if unlock.chapter == nil then
            return true
        end
        local chapter = unlock.chapter
        local v1 = (tonumber(chapter)) == tonumber(p3)
        return v1
    end
    return false
end

function u12.ResolveId(p1) -- Line: 576 -- upvalues: u12 (val)
    return u12.LegacyIds[p1] or p1
end

local function normalizeEnemyName(p1) -- Line: 580
    if type(p1) ~= "string" then
        return nil
    end
    local v1 = string.lower(p1):gsub("[^%w]", "")
    local v2 = v1 ~= "" and v1 or nil
    return v2
end

function u12.ResolveEnemyKillName(...) -- Line: 589 -- upvalues: u12 (val)
    local enemy, enemyModels, unlock, v1, v2, v3, v4, v5, v6, v7
    local v8 = select("#", ...)
    for i = 1, v8 do
        v6 = select(i, ...)
        if type(v6) == "string" then
            v7 = string.lower(v6):gsub("[^%w]", "")
            v5 = v7 ~= "" and v7 or nil
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
                        v1 = v2 ~= "" and v2 or nil
                    else
                        v1 = nil
                    end
                    if v1 == v5 then
                        return unlock.enemy
                    end
                    enemyModels = unlock.enemyModels
                    if type(enemyModels) == "table" then
                        for i3, j in ipairs(unlock.enemyModels) do
                            if type(j) == "string" then
                                v4 = string.lower(j):gsub("[^%w]", "")
                                v3 = v4 ~= "" and v4 or nil
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
    local v1 = {}
    if type(p1) == "string" and p1 ~= "" then
        local chapter, unlock, v2
        local v3, v4 = p1, p2
        for i, v in ipairs(u12.Documents) do
            unlock = v.unlock
            if type(unlock) ~= "table" or unlock.kind ~= "worldPickup" or unlock.storyId ~= v3 then
                v2 = false
            elseif unlock.chapter ~= nil then
                chapter = unlock.chapter
                v2 = (tonumber(chapter)) == tonumber(v4)
            else
                v2 = true
            end
            if v2 then
                table.insert(v1, v)
            end
        end
        return v1
    end
    return v1
end

local function mergeUnlockTimestamp(p1, p2) -- Line: 659
    if p1 == nil then
        return p2
    end
    local v1 = tonumber(p1)
    local v2 = tonumber(p2)
    if v1 and 0 < v1 and v2 and 0 < v2 then
        return (math.min(v1, v2))
    end
    return p1
end

function u12.MigrateDocumentData(p1) -- Line: 671 -- upvalues: u12 (val)
    local Unlocked_2, v1, v2, v3, v4, v5
    if type(p1) ~= "table" then
        return false
    end
    local Documents = p1.Documents
    if type(Documents) ~= "table" then
        p1.Documents = {}
    end
    local Documents_2 = p1.Documents
    local Unlocked = Documents_2.Unlocked
    if type(Unlocked) ~= "table" then
        Documents_2.Unlocked = {}
    end
    local Viewed = Documents_2.Viewed
    if type(Viewed) ~= "table" then
        Documents_2.Viewed = {}
    end
    local v6 = false
    for k, v in pairs(u12.LegacyIds) do
        v5 = Documents_2.Unlocked[k]
        if v5 ~= nil then
            Unlocked_2 = Documents_2.Unlocked
            v2 = Documents_2.Unlocked[v]
            if v2 ~= nil then
                v3 = tonumber(v2)
                v4 = tonumber(v5)
                if not v3 or not (0 < v3) or not v4 or not (0 < v4) then
                    v1 = v2
                else
                    v1 = math.min(v3, v4)
                end
            else
                v1 = v5
            end
            Unlocked_2[v] = v1
            Documents_2.Unlocked[k] = nil
            v6 = true
        end
        if Documents_2.Viewed[k] ~= nil then
            if Documents_2.Viewed[v] == nil then
                Documents_2.Viewed[v] = Documents_2.Viewed[k]
            elseif Documents_2.Viewed[k] == true then
                Documents_2.Viewed[v] = true
            end
            Documents_2.Viewed[k] = nil
            v6 = true
        end
    end
    return v6
end

function u12.EvaluateConditions(p1) -- Line: 707 -- upvalues: u12 (val)
    local Unlocked_2, id, result, success, unlock, v1
    local v2 = {}
    local Documents = false
    if type(p1) == "table" then
        Documents = p1.Documents
    end
    if type(Documents) ~= "table" then
        Unlocked_2 = {}
    else
        local Unlocked = Documents.Unlocked
        if type(Unlocked) ~= "table" then
            Unlocked_2 = {}
        else
            Unlocked_2 = Documents.Unlocked
            if not Unlocked_2 then
                Unlocked_2 = {}
            end
        end
    end
    local v3 = p1
    for i, v in ipairs(u12.Documents) do
        unlock = v.unlock
        if type(unlock) == "table" and unlock.kind == "condition" and not Unlocked_2[v.id] then
            v1 = u12.Checks[unlock.check]
            if type(v1) == "function" then
                success, result = pcall(v1, v3, unlock, v)
                if not success then
                    if not success then
                        warn(string.format("[Documents] Condition %s failed for %s: %s", unlock.check, v.id, result))
                    end
                elseif result == true then
                    id = v.id
                    table.insert(v2, id)
                elseif not success then
                    warn(string.format("[Documents] Condition %s failed for %s: %s", unlock.check, v.id, result))
                end
            end
        end
    end
    return v2
end

function u12.GetConditionProgress(p1, p2) -- Line: 729
    -- upvalues: u12 (val), categoryUnlockCount (val), distinctWeaponSkinCount (val), statsChapterWasCompleted (val)
    -- upvalues: hasCompletedChapter (val)
    local v1, v2, v3
    if type(p2) ~= "table" then
        v1 = u12.GetById(p2)
    else
        v1 = p2
    end
    if not v1 then
        return nil
    end
    local unlock = v1.unlock
    if type(unlock) ~= "table" then
        return {kind = "invalid", current = 0, required = 1, satisfied = false}
    end
    if unlock.kind == "locked" then
        return {kind = "locked", current = 0, required = 1, satisfied = false}
    end
    if unlock.kind == "worldPickup" then
        local Unlocked_2, Unlocked_4, v4
        v2 = {kind = "worldPickup", required = 1}
        local Documents = false
        if type(p1) == "table" then
            Documents = p1.Documents
        end
        if type(Documents) ~= "table" then
            Unlocked_2 = {}
        else
            local Unlocked = Documents.Unlocked
            if type(Unlocked) ~= "table" then
                Unlocked_2 = {}
            else
                Unlocked_2 = Documents.Unlocked
                if not Unlocked_2 then
                    Unlocked_2 = {}
                end
            end
        end
        if not Unlocked_2[v1.id] then
            v4 = 0
        else
            v4 = 1
        end
        v2.current = v4
        local Documents_2 = false
        if type(p1) == "table" then
            Documents_2 = p1.Documents
        end
        if type(Documents_2) ~= "table" then
            Unlocked_4 = {}
        else
            local Unlocked_3 = Documents_2.Unlocked
            if type(Unlocked_3) ~= "table" then
                Unlocked_4 = {}
            else
                Unlocked_4 = Documents_2.Unlocked
                if not Unlocked_4 then
                    Unlocked_4 = {}
                end
            end
        end
        v4 = Unlocked_4[v1.id] ~= nil
        v2.satisfied = v4
        local cframe = unlock.cframe
        v4 = typeof(cframe) == "CFrame"
        v2.placed = v4
        return v2
    end
    if unlock.kind ~= "condition" then
        v2 = {current = 0, required = 1, satisfied = false}
        local kind = unlock.kind
        v2.kind = tostring(kind)
        return v2
    end
    v2 = 0
    local amount = 1
    if unlock.check == "CumulativeZBucksSpent" then
        local Stats = false
        if type(p1) == "table" then
            Stats = p1.Stats
        end
        local Overall = false
        if type(Stats) == "table" then
            Overall = Stats.Overall
        end
        local ZBucksSpent = false
        if type(Overall) == "table" then
            ZBucksSpent = Overall.ZBucksSpent
        end
        v2 = tonumber(ZBucksSpent) or 0
        amount = unlock.amount
    elseif unlock.check == "HardPlusPerfectAccuracy" then
        local Stats_2 = false
        if type(p1) == "table" then
            Stats_2 = p1.Stats
        end
        local UniqueAwards = false
        if type(Stats_2) == "table" then
            UniqueAwards = Stats_2.UniqueAwards
        end
        local HardPlusPerfectAccuracyAt = false
        if type(UniqueAwards) == "table" then
            HardPlusPerfectAccuracyAt = UniqueAwards.HardPlusPerfectAccuracyAt
        end
        if not (0 < (tonumber(HardPlusPerfectAccuracyAt) or 0)) then
            v2 = 0
        else
            v2 = 1
        end
    elseif unlock.check == "CategoryUnlockCount" then
        v2 = categoryUnlockCount(p1, unlock.category)
        amount = unlock.count
    elseif unlock.check == "DistinctWeaponSkinCount" then
        v2 = distinctWeaponSkinCount(p1)
        amount = unlock.count
    else
        local v5
        if unlock.check == "SpecificChapterCompleted" then
            local v6
            local storyId = unlock.storyId
            local chapter = unlock.chapter
            local Progression = false
            if type(p1) == "table" then
                Progression = p1.Progression
            end
            local Stories = false
            if type(Progression) == "table" then
                Stories = Progression.Stories
            end
            if type(Stories) == "table" then
                v6 = Stories[storyId]
                if not v6 then
                    v6 = Stories[tostring(storyId)]
                end
            else
                v6 = nil
            end
            v5 = tonumber(v6)
            if not v5 or not (chapter <= v5) then
                v3 = statsChapterWasCompleted(p1, storyId, chapter)
            else
                v3 = true
            end
            if not v3 then
                v2 = 0
            else
                v2 = 1
            end
        elseif unlock.check ~= "AnyChapterCompleted" then
            if unlock.check == "EnemyKilled" then
                local enemy = unlock.enemy
                local Stats_3 = false
                if type(p1) == "table" then
                    Stats_3 = p1.Stats
                end
                local UniqueAwards_2 = false
                if type(Stats_3) == "table" then
                    UniqueAwards_2 = Stats_3.UniqueAwards
                end
                local DocumentEnemyKills = false
                if type(UniqueAwards_2) == "table" then
                    DocumentEnemyKills = UniqueAwards_2.DocumentEnemyKills
                end
                v5 = false
                if type(DocumentEnemyKills) == "table" then
                    v5 = DocumentEnemyKills[enemy]
                end
                v3 = true
                if v5 ~= true then
                    v3 = 0 < (tonumber(v5) or 0)
                end
                if not v3 then
                    v2 = 0
                else
                    v2 = 1
                end
            end
        elseif not hasCompletedChapter(p1) then
            v2 = 0
        else
            v2 = 1
        end
    end
    v3 = u12.Checks[unlock.check]
    local v7 = false
    local v8 = false
    if type(v3) == "function" then
        local success, result = pcall(v3, p1, unlock, v1)
        v7 = success
        v8 = result
    end
    local v9 = {kind = "condition", check = unlock.check, current = v2, required = amount}
    local v10 = v7
    if v10 then
        v10 = v8 == true
    end
    v9.satisfied = v10
    return v9
end

local function validPositiveInteger(p1) -- Line: 792
    local v1 = false
    if type(p1) == "number" then
        v1 = false
        if 0 < p1 then
            v1 = p1 % 1 == 0
        end
    end
    return v1
end

local function validateCondition(p1, p2) -- Line: 796 -- upvalues: u12 (val)
    local check = p2.check
    if type(check) == "string" then
        local v1 = u12
        local v2 = v1.Checks[p2.check]
        if type(v2) == "function" then
            local v3
            if p2.check == "CumulativeZBucksSpent" then
                local amount = p2.amount
                if type(amount) == "number" and not (p2.amount <= 0) then
                    return nil
                end
                return "amount must be a positive number"
            end
            if p2.check == "CategoryUnlockCount" then
                if not u12.GetCategory(p2.category) then
                    return "category must name a registered category"
                end
                local count = p2.count
                v3 = false
                if type(count) == "number" then
                    v3 = false
                    if 0 < count then
                        v3 = count % 1 == 0
                    end
                end
                if not v3 then
                    return "count must be a positive integer"
                end
                return nil
            end
            if p2.check == "DistinctWeaponSkinCount" then
                local count_2 = p2.count
                v3 = false
                if type(count_2) == "number" then
                    v3 = false
                    if 0 < count_2 then
                        v3 = count_2 % 1 == 0
                    end
                end
                if not v3 then
                    return "count must be a positive integer"
                end
                return nil
            end
            if p2.check == "SpecificChapterCompleted" then
                local storyId = p2.storyId
                if type(storyId) == "string" and p2.storyId ~= "" then
                    local chapter = p2.chapter
                    v3 = false
                    if type(chapter) == "number" then
                        v3 = false
                        if 0 < chapter then
                            v3 = chapter % 1 == 0
                        end
                    end
                    if not v3 then
                        return "chapter must be a positive integer"
                    end
                    return nil
                end
                return "storyId must be a non-empty string"
            end
            if p2.check ~= "EnemyKilled" then
                return nil
            end
            local enemy = p2.enemy
            if type(enemy) == "string" and p2.enemy ~= "" then
                if p2.enemyModels == nil then
                    return nil
                end
                local enemyModels = p2.enemyModels
                if type(enemyModels) == "table" and #p2.enemyModels ~= 0 then
                    v3 = 0
                    for k, v in pairs(p2.enemyModels) do
                        v3 = v3 + 1
                        if type(k) == "number" and k % 1 == 0 and not (k < 1) and not (#p2.enemyModels < k) then
                            if type(v) == "string" and v ~= "" then
                                continue
                            end
                            return "enemyModels must contain only non-empty strings"
                        end
                        return "enemyModels must be an array"
                    end
                    if v3 ~= #p2.enemyModels then
                        return "enemyModels must be an array"
                    end
                    return nil
                end
                return "enemyModels must be a non-empty array"
            end
            return "enemy must be a non-empty string"
        end
    end
    local check_3 = p2.check
    return "unknown condition check " .. tostring(check_3)
end

function u12.FindModel(p1, p2) -- Line: 844 -- upvalues: u12 (val)
    local model_2, v1
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
        local folder = v2.folder
        v4 = v3:FindFirstChild(folder)
    end
    if not v4 then
        model_2 = p1.model
        v1 = v3:FindFirstChild(model_2, true)
    else
        local model = p1.model
        v1 = v4:FindFirstChild(model, true)
        if not v1 then
            model_2 = p1.model
            v1 = v3:FindFirstChild(model_2, true)
        end
    end
    if v1 and v1:IsA("Model") then
        return v1
    end
    return nil
end

function u12.Audit(p1, p2, p3) -- Line: 856 -- upvalues: u12 (val), validateCondition (val)
    local category_2, category_3, cframe, chapter, chapter_2, count, duplicateCategoryIds, duplicateIds, format_2, format_4, id_10, id_11, id_12, id_13, id_14, id_2, id_3, id_4, id_5, id_6, impossibleConditions, invalidCategories, invalidConditions, invalidDocuments, invalidDocuments_2, invalidDocuments_3, invalidDocuments_4, invalidDocuments_5, invalidDocuments_6, kind, missingModels, missingPlacements, missingSurfaceGuis, model, model_2, storyId, unlock, unlock_2, unlock_3, v1, v2, v3, v4
    local v5 = {
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
    local v6 = {}
    local v7 = {}
    local v8 = {}
    local v9, v10, v11 = p1, p2, p3
    for i, v in ipairs(u12.Categories) do
        if v7[v.id] then
            duplicateCategoryIds = v5.duplicateCategoryIds
            id_14 = v.id
            table.insert(duplicateCategoryIds, id_14)
        end
        v7[v.id] = true
        v8[v.id] = 0
    end
    for i2, i3 in ipairs(u12.Documents) do
        id_2 = i3.id
        if type(id_2) ~= "string" or i3.id == "" then
            invalidDocuments = v5.invalidDocuments
            table.insert(invalidDocuments, "document with missing id")
        elseif not v6[i3.id] then
            v6[i3.id] = true
        else
            duplicateIds = v5.duplicateIds
            id_3 = i3.id
            table.insert(duplicateIds, id_3)
        end
        if u12.GetCategory(i3.category) then
            category_3 = i3.category
            v8[category_3] = v8[category_3] + 1
        else
            invalidCategories = v5.invalidCategories
            format_2 = string.format
            id_4 = i3.id
            v4 = tostring(id_4)
            category_2 = i3.category
            v2 = format_2("%s: %s", v4, (tostring(category_2)))
            table.insert(invalidCategories, v2)
        end
        model = i3.model
        if type(model) ~= "string" or i3.model == "" then
            invalidDocuments_2 = v5.invalidDocuments
            id_5 = i3.id
            v2 = (tostring(id_5)) .. ": missing model name"
            table.insert(invalidDocuments_2, v2)
        end
        unlock_2 = i3.unlock
        if type(unlock_2) ~= "table" then
            invalidDocuments_3 = v5.invalidDocuments
            id_6 = i3.id
            v3 = (tostring(id_6)) .. ": missing unlock definition"
            table.insert(invalidDocuments_3, v3)
        elseif unlock_2.kind == "condition" then
            v1 = validateCondition(i3, unlock_2)
            if v1 then
                invalidConditions = v5.invalidConditions
                v4 = string.format("%s: %s", i3.id, v1)
                table.insert(invalidConditions, v4)
            end
        elseif unlock_2.kind == "worldPickup" then
            storyId = unlock_2.storyId
            if type(storyId) ~= "string" or unlock_2.storyId == "" then
                invalidDocuments_5 = v5.invalidDocuments
                v3 = i3.id .. ": pickup storyId is missing"
                table.insert(invalidDocuments_5, v3)
            elseif unlock_2.chapter ~= nil then
                chapter = unlock_2.chapter
                v1 = false
                if type(chapter) == "number" then
                    v1 = false
                    if 0 < chapter then
                        v1 = chapter % 1 == 0
                    end
                end
                if not v1 then
                    invalidDocuments_4 = v5.invalidDocuments
                    v3 = i3.id .. ": pickup chapter is invalid"
                    table.insert(invalidDocuments_4, v3)
                end
            end
            if v9 == nil then
                cframe = unlock_2.cframe
                if typeof(cframe) ~= "CFrame" then
                    missingPlacements = v5.missingPlacements
                    id_10 = i3.id
                    table.insert(missingPlacements, id_10)
                end
            else
                unlock_3 = i3.unlock
                if type(unlock_3) ~= "table" or unlock_3.kind ~= "worldPickup" or unlock_3.storyId ~= v9 then
                    v1 = false
                elseif unlock_3.chapter ~= nil then
                    chapter_2 = unlock_3.chapter
                    v1 = (tonumber(chapter_2)) == tonumber(v10)
                else
                    v1 = true
                end
                if v1 then
                    cframe = unlock_2.cframe
                    if typeof(cframe) ~= "CFrame" then
                        missingPlacements = v5.missingPlacements
                        id_10 = i3.id
                        table.insert(missingPlacements, id_10)
                    end
                end
            end
        elseif unlock_2.kind ~= "locked" then
            invalidDocuments_6 = v5.invalidDocuments
            id_11 = i3.id
            kind = unlock_2.kind
            v3 = id_11 .. ": unknown unlock kind " .. (tostring(kind))
            table.insert(invalidDocuments_6, v3)
        end
        if v11 then
            v1 = u12.FindModel(i3, v11)
            if not v1 then
                missingModels = v5.missingModels
                format_4 = string.format
                id_12 = i3.id
                model_2 = i3.model
                v4 = format_4("%s(%s)", id_12, (tostring(model_2)))
                table.insert(missingModels, v4)
            elseif not v1:FindFirstChildWhichIsA("SurfaceGui", true) then
                missingSurfaceGuis = v5.missingSurfaceGuis
                id_13 = i3.id
                table.insert(missingSurfaceGuis, id_13)
            end
        end
    end
    for i4, j in ipairs(u12.Documents) do
        unlock = j.unlock
        if type(unlock) == "table" and unlock.kind == "condition" and unlock.check == "CategoryUnlockCount" then
            v1 = v8[unlock.category] or 0
            count = unlock.count
            v2 = false
            if type(count) == "number" then
                v2 = false
                if 0 < count then
                    v2 = count % 1 == 0
                end
            end
            if v2 and v1 < unlock.count then
                impossibleConditions = v5.impossibleConditions
                v4 = string.format("%s needs %d %s documents; %d registered", j.id, unlock.count, unlock.category, v1)
                table.insert(impossibleConditions, v4)
            end
        end
    end
    for k, k2 in pairs(v5) do
        table.sort(k2)
    end
    return v5
end

return u12