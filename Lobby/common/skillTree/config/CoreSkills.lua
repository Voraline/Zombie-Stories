require("./SkillTypes")
return {
    {
        id = "core1",
        name = "Basic Training",
        branch = "Core",
        tier = 1,
        maxRank = 1,
        description = "+5% skill point XP",
        effectPerRank = 5,
        costs = {
            {type = "SP", amount = 1},
            {type = "ZBucks", amount = 100},
        },
    },
    {
        id = "core2",
        name = "Weight Lifting",
        branch = "Core",
        tier = 2,
        maxRank = 1,
        description = "+10% max HP",
        effectPerRank = 10,
        costs = {
            {type = "SP", amount = 1},
            {type = "ZBucks", amount = 200},
        },
        requirements = {
            logic = "all",
            requirements = {
                {type = "skill", skillId = "core1", minRank = 1},
            },
        },
    },
    {
        id = "core3",
        name = "Combat Drills",
        branch = "Core",
        tier = 3,
        maxRank = 1,
        description = "+5% headshot damage",
        effectPerRank = 5,
        costs = {
            {type = "SP", amount = 1},
            {type = "ZBucks", amount = 300},
        },
        requirements = {
            logic = "all",
            requirements = {
                {type = "skill", skillId = "core2", minRank = 1},
            },
        },
    },
    {
        id = "core4",
        name = "Survival Drills",
        branch = "Core",
        tier = 4,
        maxRank = 1,
        description = "+1 down before spectator",
        effectPerRank = 1,
        costs = {
            {type = "SP", amount = 1},
            {type = "ZBucks", amount = 400},
        },
        requirements = {
            logic = "all",
            requirements = {
                {type = "skill", skillId = "core3", minRank = 1},
            },
        },
    },
    {
        id = "core5",
        name = "Coming Soon",
        branch = "Core",
        tier = 5,
        maxRank = 1,
        description = "Coming soon",
        enabled = false,
        comingSoonText = "Unlocks with future update",
        costs = {
            {type = "SP", amount = 1},
            {type = "ZBucks", amount = 500},
        },
        requirements = {
            logic = "all",
            requirements = {
                {type = "skill", skillId = "core4", minRank = 1},
            },
        },
    },
}