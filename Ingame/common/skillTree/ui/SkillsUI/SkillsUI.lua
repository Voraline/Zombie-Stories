local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Children = require(ReplicatedStorage.Packages.Fusion).Children
local SkillConfig = require(ReplicatedStorage.common.skillTree.config.SkillConfig)
local SkillTreeData = require(ReplicatedStorage.common.skillTree.SkillTreeData)
local u23 = require("../Controls/Controls")
local u26 = require("../Costs/Costs")
return function(p1) -- Line: 28 -- upvalues: SkillConfig (val), SkillTreeData (val), Children (val), u26 (val), u23 (val)
    local v1, v2, v3, v4, v5, v6
    local scope = p1.scope
    local u5 = scope:Computed(function(a1) -- Line: 32 -- upvalues: p1 (val), SkillConfig (upval)
        local amount, costs, firstRankOnlyCosts, v1, v2
        local v3 = a1(p1.SelectedSkillId)
        if not v3 then
            return {}
        end
        local v4 = SkillConfig.getSkill(v3)
        if not v4 or not v4.costs then
            return {}
        end
        if not p1.CurrentRank then
            v1 = 0
        else
            v1 = a1(p1.CurrentRank)
        end
        local v5 = v1 + 1
        if v4.maxRank <= v1 then
            return {}
        end
        local v6 = {}
        if v4.firstRankOnlyCosts then
            firstRankOnlyCosts = v4.firstRankOnlyCosts
            local v7 = nil
            v2 = nil
            for i, j in firstRankOnlyCosts, v7, v2 do
                v6[j] = true
            end
        end
        local v8 = {}
        costs = v4.costs
        v2 = nil
        local v9 = nil
        for k, n in costs, v2, v9 do
            if not (v6[n.type]) then
                amount = if n.type ~= "SP" then math.floor(n.amount * v5) else n.amount
                table.insert(v8, {type = n.type, amount = amount})
            elseif 1 < v5 then
            end
        end
        return v8
    end)
    v1 = scope:Computed(function(p1) -- Line: 84 -- upvalues: u5 (val), SkillTreeData (upval)
        local v1
        local v2 = p1(u5)
        if #v2 == 0 then
            return false
        end
        local v3 = v2
        local v4 = nil
        local v5 = nil
        for i, j in v3, v4, v5 do
            if j.type == "SP" then
                v1 = p1(SkillTreeData.SP)
                if v1 < j.amount then
                    return false
                end
            end
        end
        return true
    end)
    v2 = scope:Computed(function(a1) -- Line: 98 -- upvalues: p1 (val)
        local Visible = p1.Visible
        if Visible == nil then
            return true
        end
        return (a1(Visible))
    end)
    v3 = scope:New("Frame")
    v4 = {
        Name = "SkillsUI",
        AnchorPoint = Vector2.new(0.5, 1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.fromScale(0.5, 1),
        Size = UDim2.fromScale(1, 0.2),
        Visible = v2,
    }
    v5 = {}
    v6 = scope:New("UIListLayout")
    v6 = v6({Name = "UIListLayout", HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder})
    local v7 = u26({scope = scope, Costs = u5})
    local v8 = {scope = scope, OnBuy = p1.OnBuy, OnExit = p1.OnExit, BuyEnabled = v1}
    v5[1] = v6
    v5[2] = v7
    v5[3] = u23(v8)
    v4[Children] = v5
    return v3(v4)
end