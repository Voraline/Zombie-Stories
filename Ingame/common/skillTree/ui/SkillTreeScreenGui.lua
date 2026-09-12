local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Packages = ReplicatedStorage.Packages
local Children = (require(Packages.Fusion)).Children
local u17 = require("./SkillsUI/SkillsUI")
return function(p1) -- Line: 25 -- upvalues: Players (val), Children (val), u17 (val)
    local scope = p1.scope
    local v1 = scope:Computed(function(p1_2) -- Line: 28 -- upvalues: p1 (val)
        local v1 = p1_2(p1.SelectedSkillId) ~= nil
        return v1
    end)
    local v2 = scope:New("ScreenGui")
    local v3 = {
        Name = "SkillTreeGui",
        Parent = Players.LocalPlayer:WaitForChild("PlayerGui"),
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        IgnoreGuiInset = false,
        DisplayOrder = 24,
    }
    local v4 = Children
    local v5 = {}
    local v6 = u17
    v5[1] = v6({
        scope = scope,
        Visible = v1,
        SelectedSkillId = p1.SelectedSkillId,
        CurrentRank = p1.CurrentRank,
        OnBuy = p1.OnBuy,
        OnExit = p1.OnExit,
    })
    v3[v4] = v5
    return v2(v3)
end