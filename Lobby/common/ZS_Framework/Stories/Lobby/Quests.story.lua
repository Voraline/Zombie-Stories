local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local fusion_utils = require(ReplicatedStorage.common.fusion_utils)
local u13 = {Visible = true}
local u16 = require("../../UI/Components/Quests/QuestsMenu")
return {
    summary = "A wide window with a title and close button.",
    fusion = Fusion,
    controls = u13,
    story = function(p1) -- Line: 16 -- upvalues: fusion_utils (val), u16 (val), u13 (val)
        local scope = p1.scope
        local v1 = fusion_utils
        local v2 = scope:innerScope(v1)
        local v3 = u16
        return v3({
            scope = v2,
            Parent = p1.target,
            OnClickClose = function() -- Line: 23 -- upvalues: u13 (upval)
                u13.Visible = false
            end,
            QuestCategories = {
                Daily = {
                    LayoutOrder = 1,
                    NextReset = os.time() + 1000,
                    List = {
                        Quest1 = {
                            Title = "Main Quest 1",
                            Description = "Description for Main Quest 1",
                            IsCompleted = false,
                            IsClaimed = false,
                            LayoutOrder = 1,
                            Progress = {Current = 2, Goal = 5},
                            Rewards = {
                                ZBucks = {Amount = 100},
                                ClassXP = {Amount = 50, Type = "Assault"},
                            },
                        },
                        Quest2 = {
                            Title = "Main Quest 2",
                            Description = "Description for Main Quest 2",
                            IsCompleted = false,
                            IsClaimed = false,
                            LayoutOrder = 2,
                            Progress = {Current = 0, Goal = 1},
                            Rewards = {
                                ZBucks = {Amount = 100},
                                ClassXP = {Amount = 50, Type = "Support"},
                            },
                        },
                        Quest3 = {
                            Title = "Main Quest 3",
                            Description = "Description for Main Quest 3",
                            IsCompleted = false,
                            IsBonus = true,
                            IsClaimed = false,
                            LayoutOrder = 2,
                            Progress = {Current = 4, Goal = 5},
                            Rewards = {
                                ZBucks = {Amount = 100},
                                ClassXP = {Amount = 50, Type = "Sniper"},
                            },
                        },
                        Quest4 = {
                            Title = "Main Quest 4",
                            Description = "Description for Main Quest 4",
                            IsCompleted = true,
                            IsClaimed = false,
                            LayoutOrder = 2,
                            Progress = {Current = 5, Goal = 5},
                            Rewards = {
                                ZBucks = {Amount = 100},
                                ClassXP = {Amount = 50, Type = "Medic"},
                            },
                        },
                        Quest6 = {
                            Title = "Complete a Story with the Selected Modifiers",
                            Description = "Super Quick Attack Zombies, Extra Zombies, Take More Damage, Fast Zombies",
                            IsCompleted = false,
                            IsClaimed = false,
                            LayoutOrder = 2,
                            Progress = {Current = 0, Goal = 1},
                            Props = {
                                Modifiers = {
                                    SuperQuickAttackZombies = true,
                                    ExtraZombies = true,
                                    TakeMoreDamage = true,
                                    FastZombies = true,
                                },
                            },
                            Rewards = {
                                ZBucks = {Amount = 250},
                                ClassXP = {Amount = 125, Type = "Assault"},
                            },
                        },
                        Quest5 = {
                            Title = "Main Quest 5",
                            Description = "Description for Main Quest 5",
                            IsCompleted = true,
                            IsClaimed = true,
                            LayoutOrder = 2,
                            Progress = {Current = 5, Goal = 5},
                            Rewards = {
                                ZBucks = {Amount = 100},
                                ClassXP = {Amount = 50, Type = "Medic"},
                            },
                        },
                    },
                    Bonus = {
                        QuestsToComplete = 5,
                        QuestsCompleted = 0,
                        IsClaimed = false,
                        Rewards = {
                            ZBucks = {Amount = 500},
                            ClassXP = {Amount = 250, Type = "Medic"},
                        },
                    },
                },
                Weekly = {
                    LayoutOrder = 2,
                    NextReset = os.time() + 10000000,
                    List = {
                        Quest1 = {
                            Title = "Main Quest 1",
                            Description = "Description for Main Quest 1",
                            IsCompleted = false,
                            IsClaimed = false,
                            LayoutOrder = 1,
                            Progress = {Current = 2, Goal = 5},
                            Rewards = {
                                ZBucks = {Amount = 100},
                                ClassXP = {Amount = 50, Type = "Medic"},
                            },
                        },
                    },
                    Bonus = {
                        QuestsToComplete = 5,
                        QuestsCompleted = 0,
                        IsClaimed = false,
                        Rewards = {
                            ZBucks = {Amount = 500},
                            ClassXP = {Amount = 250, Type = "Medic"},
                        },
                    },
                },
                Monthly = {
                    LayoutOrder = 3,
                    NextReset = os.time() + 20000000,
                    List = {
                        Quest1 = {
                            Title = "Monthly Quest",
                            Description = "Complete objectives throughout the month.",
                            IsCompleted = false,
                            LayoutOrder = 1,
                            Progress = {Current = 1, Goal = 10},
                            Rewards = {
                                ZBucks = {Amount = 250},
                                ClassXP = {Amount = 100, Type = "Medic"},
                            },
                        },
                    },
                },
            },
        })
    end,
}