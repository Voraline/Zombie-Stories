local function createKillZombieQuest(p1) -- Line: 12
    return {
        Type = "KillZombie",
        Title = p1.Title or "Kill %0d Zombies",
        Description = p1.Description or "Shoot and kill zombies",
        TitleFormatKeys = {"Goal"},
        DescriptionFormatKeys = p1.DescriptionFormatKeys,
        Props = p1.Props,
        Goal = p1.Range,
        Rewards = {
            ZBucks = {Amount = 0.5 * (p1.RewardMultiplier or 1)},
        },
    }
end

local function createCompleteStoryQuest(p1) -- Line: 35
    local v1 = nil
    if p1.Props and p1.Props.Class == "RandomClass" then
        v1 = {Type = "SelectedClass", Amount = 500 * (p1.RewardMultiplier or 1)}
    end
    local v2 = {Type = "CompleteStory", Title = p1.Title or "Complete %0d Stories"}
    local TitleFormatKeys = p1.TitleFormatKeys
    if not TitleFormatKeys then
        TitleFormatKeys = {"Goal"}
    end
    v2.TitleFormatKeys = TitleFormatKeys
    v2.DescriptionFormatKeys = p1.DescriptionFormatKeys
    v2.Description = p1.Description or "Finish any story chapters on any difficulty"
    v2.Props = p1.Props
    v2.Goal = p1.Range
    v2.Rewards = {
        ZBucks = {Amount = 50 * (p1.RewardMultiplier or 1)},
        ClassXP = v1,
    }
    return v2
end

local v1 = {}
local v2 = {}
local v3 = createKillZombieQuest({
    RewardMultiplier = 1,
    Range = {Min = 250, Max = 750},
})
local v4 = createKillZombieQuest({
    Title = "Headshot %0d Zombies",
    Description = "Kill zombies with headshots",
    RewardMultiplier = 1.25,
    TitleFormatKeys = {"Goal"},
    Range = {Min = 100, Max = 200},
    Props = {Headshot = true},
})
local v5 = createCompleteStoryQuest({
    Range = 1,
    RewardMultiplier = 1.5,
    Description = "Complete any of the story chapters",
    Title = "Complete Any of the %s Chapters",
    Props = {StoryName = "Random"},
    TitleFormatKeys = {"StoryName"},
})
local v6 = createCompleteStoryQuest({
    Range = 1,
    RewardMultiplier = 2.5,
    Title = "Complete a Story with the Selected Modifiers",
    Description = "%s",
    Props = {
        Modifiers = {Min = 1, Max = 4},
    },
    DescriptionFormatKeys = {"Modifiers"},
})
local v7 = createCompleteStoryQuest({
    RewardMultiplier = 1,
    Range = {Min = 1, Max = 3},
})
v2[1] = v3
v2[2] = v4
v2[3] = v5
v2[4] = v6
v2[5] = v7
v2[6] = (createCompleteStoryQuest({
    RewardMultiplier = 2,
    Title = "Complete %0d Stories as %s Class",
    Description = "Complete story chapters using a specific class",
    Range = {Min = 1, Max = 2},
    Props = {Class = "RandomClass"},
    TitleFormatKeys = {"Goal", "Class"},
}))
v1.Daily = v2
v2 = {}
v3 = createCompleteStoryQuest({
    RewardMultiplier = 2,
    Title = "Complete %0d Stories as %s Class",
    Description = "Complete story chapters using a specific class",
    Range = {Min = 4, Max = 6},
    Props = {Class = "RandomClass"},
    TitleFormatKeys = {"Goal", "Class"},
})
v4 = createCompleteStoryQuest({
    RewardMultiplier = 1,
    Range = {Min = 5, Max = 10},
})
v5 = createKillZombieQuest({
    RewardMultiplier = 0.8,
    Range = {Min = 2000, Max = 5000},
})
v6 = createKillZombieQuest({
    Title = "Headshot %0d Zombies",
    Description = "Kill zombies with headshots",
    RewardMultiplier = 1.05,
    TitleFormatKeys = {"Goal"},
    Range = {Min = 500, Max = 1000},
    Props = {Headshot = true},
})
v2[1] = v3
v2[2] = v4
v2[3] = v5
v2[4] = v6
v2[5] = (createCompleteStoryQuest({
    Range = 1,
    RewardMultiplier = 2.5,
    Title = "Complete a Story with the Selected Modifiers",
    Description = "%s",
    Props = {
        Modifiers = {Min = 3, Max = 5},
    },
    DescriptionFormatKeys = {"Modifiers"},
}))
v1.Weekly = v2
v2 = {}
v3 = createCompleteStoryQuest({
    Range = {Min = 20, Max = 40},
})
v4 = createCompleteStoryQuest({
    RewardMultiplier = 2,
    Title = "Complete %0d Stories as %s Class",
    Description = "Complete story chapters using a specific class",
    Range = {Min = 2, Max = 4},
    Props = {Class = "Assault"},
    TitleFormatKeys = {"Goal", "Class"},
})
v5 = createCompleteStoryQuest({
    RewardMultiplier = 2,
    Title = "Complete %0d Stories as %s Class",
    Description = "Complete story chapters using a specific class",
    Range = {Min = 2, Max = 4},
    Props = {Class = "Sniper"},
    TitleFormatKeys = {"Goal", "Class"},
})
v6 = createCompleteStoryQuest({
    RewardMultiplier = 2,
    Title = "Complete %0d Stories as %s Class",
    Description = "Complete story chapters using a specific class",
    Range = {Min = 2, Max = 4},
    Props = {Class = "Medic"},
    TitleFormatKeys = {"Goal", "Class"},
})
v7 = createCompleteStoryQuest({
    RewardMultiplier = 2,
    Title = "Complete %0d Stories as %s Class",
    Description = "Complete story chapters using a specific class",
    Range = {Min = 2, Max = 4},
    Props = {Class = "Support"},
    TitleFormatKeys = {"Goal", "Class"},
})
local v8 = createKillZombieQuest({
    RewardMultiplier = 0.6,
    Range = {Min = 10000, Max = 20000},
})
local v9 = createKillZombieQuest({
    Title = "Headshot %0d Zombies",
    Description = "Kill zombies with headshots",
    RewardMultiplier = 0.85,
    TitleFormatKeys = {"Goal"},
    Range = {Min = 2500, Max = 5000},
    Props = {Headshot = true},
})
v2[1] = v3
v2[2] = v4
v2[3] = v5
v2[4] = v6
v2[5] = v7
v2[6] = v8
v2[7] = v9
v2[8] = (createCompleteStoryQuest({
    Title = "Complete %0d Stories with %0d Modifiers",
    Description = "Complete story chapters with the required number of modifiers",
    RewardMultiplier = 1.25,
    TitleFormatKeys = {"Goal", "ModifierCount"},
    Props = {
        ModifierCount = {Min = 1, Max = 4},
    },
    Range = {Min = 2, Max = 4},
}))
v1.Monthly = v2
return v1