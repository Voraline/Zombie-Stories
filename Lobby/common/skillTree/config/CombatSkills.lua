require("./SkillTypes")
return {
    {
        id = "steadyAim",
        name = "Steady Aim",
        branch = "Combat",
        tier = 1,
        maxRank = 5,
        description = "-4% recoil per rank",
        effectPerRank = 4,
        costs = {
            {type = "SP", amount = 1},
            {type = "ZBucks", amount = 250},
        },
        requirements = {
            logic = "all",
            requirements = {
                {type = "skill", skillId = "core3", minRank = 1},
            },
        },
    },
    {
        id = "fastHands",
        name = "Fast Hands",
        branch = "Combat",
        tier = 1,
        maxRank = 5,
        description = "+4% reload speed per rank",
        effectPerRank = 4,
        costs = {
            {type = "SP", amount = 1},
            {type = "ZBucks", amount = 250},
        },
        requirements = {
            logic = "all",
            requirements = {
                {type = "skill", skillId = "core3", minRank = 1},
            },
        },
    },
    {
        id = "deepPockets",
        name = "Deep Pockets",
        branch = "Combat",
        tier = 2,
        maxRank = 5,
        description = "+8% ammo capacity per rank",
        effectPerRank = 8,
        costs = {
            {type = "SP", amount = 2},
            {type = "ZBucks", amount = 500},
        },
        requirements = {
            logic = "any",
            requirements = {
                {type = "skill", skillId = "steadyAim", minRank = 1},
                {type = "skill", skillId = "fastHands", minRank = 1},
            },
        },
    },
    {
        id = "quickInteract",
        name = "Quick Interact",
        branch = "Combat",
        tier = 2,
        maxRank = 3,
        description = "+5% interact speed per rank",
        effectPerRank = 5,
        costs = {
            {type = "SP", amount = 2},
            {type = "ZBucks", amount = 500},
        },
        requirements = {
            logic = "any",
            requirements = {
                {type = "skill", skillId = "steadyAim", minRank = 1},
                {type = "skill", skillId = "fastHands", minRank = 1},
            },
        },
    },
    {
        id = "sleightSwitch",
        name = "Sleight Switch",
        branch = "Combat",
        tier = 2,
        maxRank = 3,
        description = "+10% swap speed per rank",
        effectPerRank = 10,
        costs = {
            {type = "SP", amount = 2},
            {type = "ZBucks", amount = 500},
        },
        requirements = {
            logic = "any",
            requirements = {
                {type = "skill", skillId = "steadyAim", minRank = 1},
                {type = "skill", skillId = "fastHands", minRank = 1},
            },
        },
    },
    {
        id = "meleeTempo",
        name = "Melee Tempo",
        branch = "Combat",
        tier = 2,
        maxRank = 3,
        description = "+10% melee swing speed per rank",
        effectPerRank = 10,
        costs = {
            {type = "SP", amount = 2},
            {type = "ZBucks", amount = 500},
        },
        requirements = {
            logic = "any",
            requirements = {
                {type = "skill", skillId = "steadyAim", minRank = 1},
                {type = "skill", skillId = "fastHands", minRank = 1},
            },
        },
    },
    {
        id = "fury",
        name = "Fury",
        branch = "Combat",
        tier = 3,
        maxRank = 1,
        description = "Below 25% HP, +25% damage",
        costs = {
            {type = "SP", amount = 3},
            {type = "ZBucks", amount = 1000},
            {type = "Gems", amount = 35},
        },
        requirements = {
            logic = "all",
            requirements = {
                {type = "tier", branch = "Combat", tier = 2, count = 4},
            },
        },
    },
    {
        id = "deadEye",
        name = "Dead Eye",
        branch = "Combat",
        tier = 3,
        maxRank = 1,
        description = "+10% damage when stationary for 1 second",
        costs = {
            {type = "SP", amount = 3},
            {type = "ZBucks", amount = 1000},
            {type = "Gems", amount = 35},
        },
        requirements = {
            logic = "all",
            requirements = {
                {type = "tier", branch = "Combat", tier = 2, count = 4},
            },
        },
    },
    {
        id = "parryMaster",
        name = "Parry Master",
        branch = "Combat",
        tier = 3,
        maxRank = 3,
        description = "+0.1s parry window per rank",
        effectPerRank = 0.1,
        costs = {
            {type = "SP", amount = 3},
            {type = "ZBucks", amount = 1000},
            {type = "Gems", amount = 35},
        },
        firstRankOnlyCosts = {"Gems"},
        requirements = {
            logic = "all",
            requirements = {
                {type = "tier", branch = "Combat", tier = 2, count = 4},
            },
        },
    },
    {
        id = "quickDraw",
        name = "Quick Draw",
        branch = "Combat",
        tier = 4,
        maxRank = 1,
        description = "Primary lowers to side, pull pistol one-handed, shoot immediately",
        costs = {
            {type = "SP", amount = 3},
            {type = "ZBucks", amount = 2000},
            {type = "Gems", amount = 100},
        },
        requirements = {
            logic = "all",
            requirements = {
                {type = "tier", branch = "Combat", tier = 3, count = 3},
            },
        },
    },
}