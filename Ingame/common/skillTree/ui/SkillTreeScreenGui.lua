local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Children = require(ReplicatedStorage.Packages.Fusion).Children
local u17 = require("./SkillsUI/SkillsUI")
return function(p1) -- Line: 25 -- upvalues: Players (val), Children (val), u17 (val)
    local scope = p1.scope
    local v1 = scope:Computed(function(a1) -- Line: 28 -- upvalues: p1 (val)
        local v1 = a1(p1.SelectedSkillId) ~= nil
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
    v3[Children] = {u17({
        scope = scope,
        Visible = v1,
        SelectedSkillId = p1.SelectedSkillId,
        CurrentRank = p1.CurrentRank,
        OnBuy = p1.OnBuy,
        OnExit = p1.OnExit,
    })}
    return v2(v3)
end