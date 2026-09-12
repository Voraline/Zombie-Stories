game:GetService("ReplicatedStorage")
local v1 = require("@game/ReplicatedStorage/common/ItemData")
return {
    ZBucks = {
        Image = "rbxassetid://123456789",
        LayoutOrder = 1,
        Tier1 = {Image = "rbxassetid://4936288857", Amount = 500},
        Tier2 = {Image = "rbxassetid://4936350857", Amount = 1000},
        Tier3 = {Image = "rbxassetid://4936401476", Amount = 3000},
    },
    ClassXP = {
        LayoutOrder = 2,
        Assault = {Image = "rbxassetid://4458718282", Text = "XP", TextOffset = -0.1},
        Support = {Image = "rbxassetid://2706886028", Text = "XP", TextOffset = -0.1},
        Sniper = {Image = "rbxassetid://4458692655", Text = "XP", TextOffset = -0.1},
        Medic = {Image = "rbxassetid://2706886795", Text = "XP", TextOffset = -0.1},
    },
    SP = {
        LayoutOrder = 4,
        Image = (require("@game/ReplicatedStorage/common/Assets/assets")).Images.SkillTree.skillPointIcon,
    },
    Crate = {
        LayoutOrder = 3,
        Primary = {Text = "Primary", TextRotation = -5, TextOffset = -0.2, Image = v1.LootBoxes.Primary.ImageId},
        Secondary = {
            Text = "Secondary",
            TextRotation = -5,
            TextOffset = -0.2,
            Image = v1.LootBoxes.Secondary.ImageId,
        },
        Melee = {Text = "Melee", TextRotation = -5, TextOffset = -0.2, Image = v1.LootBoxes.Melee.ImageId},
        Arcade = {Text = "Arcade", TextRotation = -5, TextOffset = -0.2, Image = v1.LootBoxes.Arcade.ImageId},
        MythicalPrimary = {
            Text = "Primary",
            TextRotation = -5,
            TextOffset = -0.2,
            Image = v1.LootBoxes.MythicalPrimary.ImageId,
        },
        MythicalSecondary = {
            Text = "Secondary",
            TextRotation = -5,
            TextOffset = -0.2,
            Image = v1.LootBoxes.MythicalSecondary.ImageId,
        },
        MythicalMelee = {
            Text = "Melee",
            TextRotation = -5,
            TextOffset = -0.2,
            Image = v1.LootBoxes.MythicalMelee.ImageId,
        },
    },
}