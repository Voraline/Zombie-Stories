require("./SkillTypes")
return {
    {
        id = "thickSkin",
        name = "Thick Skin",
        branch = "Survival",
        tier = 1,
        maxRank = 5,
        description = "+10% max HP per rank",
        effectPerRank = 10,
        costs = {
            {type = "SP", amount = 1},
            {type = "ZBucks", amount = 250},
        },
        requirements = {
            logic = "all",
            requirements = {
                {type = "skill", skillId = "core2", minRank = 1},
            },
        },
    },
    {
        id = "grit",
        name = "Grit",
        branch = "Survival",
        tier = 1,
        maxRank = 5,
        description = "+3% damage reduction per rank",
        effectPerRank = 3,
        costs = {
            {type = "SP", amount = 1},
            {type = "ZBucks", amount = 250},
        },
        requirements = {
            logic = "all",
            requirements = {
                {type = "skill", skillId = "core2", minRank = 1},
            },
        },
    },
    {
        id = "adrenaline",
        name = "Adrenaline",
        branch = "Survival",
        tier = 2,
        maxRank = 3,
        description = "Regain +5 stamina when hit per rank",
        effectPerRank = 5,
        costs = {
            {type = "SP", amount = 2},
            {type = "ZBucks", amount = 500},
        },
        requirements = {
            logic = "any",
            requirements = {
                {type = "skill", skillId = "thickSkin", minRank = 1},
                {type = "skill", skillId = "grit", minRank = 1},
            },
        },
    },
    {
        id = "ironWill",
        name = "Iron Will",
        branch = "Survival",
        tier = 2,
        maxRank = 5,
        description = "+15% downed time per rank",
        effectPerRank = 15,
        costs = {
            {type = "SP", amount = 2},
            {type = "ZBucks", amount = 500},
        },
        requirements = {
            logic = "any",
            requirements = {
                {type = "skill", skillId = "thickSkin", minRank = 1},
                {type = "skill", skillId = "grit", minRank = 1},
            },
        },
    },
    {
        id = "desperateSprint",
        name = "Desperate Sprint",
        branch = "Survival",
        tier = 2,
        maxRank = 5,
        description = "Below X% HP, sprint costs no stamina (5% per rank)",
        effectPerRank = 5,
        costs = {
            {type = "SP", amount = 2},
            {type = "ZBucks", amount = 500},
        },
        requirements = {
            logic = "any",
            requirements = {
                {type = "skill", skillId = "thickSkin", minRank = 1},
                {type = "skill", skillId = "grit", minRank = 1},
            },
        },
    },
    {
        id = "secondChance",
        name = "Second Chance",
        branch = "Survival",
        tier = 3,
        maxRank = 1,
        description = "+1 down before spectator",
        costs = {
            {type = "SP", amount = 3},
            {type = "ZBucks", amount = 1000},
            {type = "Gems", amount = 35},
        },
        requirements = {
            logic = "all",
            requirements = {
                {type = "tier", branch = "Survival", tier = 2, count = 4},
            },
        },
    },
    {
        id = "swanSong",
        name = "Swan Song",
        branch = "Survival",
        tier = 3,
        maxRank = 1,
        description = "4s free movement + infinite ammo when downed",
        costs = {
            {type = "SP", amount = 3},
            {type = "ZBucks", amount = 1000},
            {type = "Gems", amount = 35},
        },
        requirements = {
            logic = "all",
            requirements = {
                {type = "tier", branch = "Survival", tier = 2, count = 4},
            },
        },
    },
    {
        id = "secondWind",
        name = "Second Wind",
        branch = "Survival",
        tier = 3,
        maxRank = 1,
        description = "Deal damage while downed to fill self-revive meter",
        costs = {
            {type = "SP", amount = 3},
            {type = "ZBucks", amount = 1000},
            {type = "Gems", amount = 35},
        },
        requirements = {
            logic = "all",
            requirements = {
                {type = "tier", branch = "Survival", tier = 2, count = 4},
            },
        },
    },
    {
        id = "lastStand",
        name = "Last Stand",
        branch = "Survival",
        tier = 3,
        maxRank = 1,
        description = "Use primary weapon while downed",
        costs = {
            {type = "SP", amount = 3},
            {type = "ZBucks", amount = 1000},
            {type = "Gems", amount = 35},
        },
        requirements = {
            logic = "all",
            requirements = {
                {type = "tier", branch = "Survival", tier = 2, count = 4},
            },
        },
    },
    {
        id = "theSpartan",
        name = "The Spartan",
        branch = "Survival",
        tier = 4,
        maxRank = 3,
        description = "Energy shield, regens after cooldown (-10% per rank)",
        effectPerRank = 10,
        costs = {
            {type = "SP", amount = 3},
            {type = "ZBucks", amount = 2000},
            {type = "Gems", amount = 100},
        },
        firstRankOnlyCosts = {"Gems"},
        requirements = {
            logic = "all",
            requirements = {
                {type = "tier", branch = "Survival", tier = 3, count = 3},
            },
        },
    },
}