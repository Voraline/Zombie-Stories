local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage.Packages
local Children = (require(Packages.Fusion)).Children
local SkillConfig = require(ReplicatedStorage.common.skillTree.config.SkillConfig)
local SkillTreeData = require(ReplicatedStorage.common.skillTree.SkillTreeData)
local u23 = require("../Controls/Controls")
local u26 = require("../Costs/Costs")
return function(p1) -- Line: 28 -- upvalues: SkillConfig (val), SkillTreeData (val), Children (val), u26 (val), u23 (val)
    local scope = p1.scope
    local u5 = scope:Computed(function(p1_2) -- Line: 32 -- upvalues: p1 (val), SkillConfig (upval)
        local v1 = p1_2(p1.SelectedSkillId)
        if not v1 then
            return {}
        end
        local v2 = SkillConfig.getSkill(v1)
        if v2 and v2.costs then
            local amount, v3, v4, v5, v6
            if not p1.CurrentRank then
                v5 = 0
            else
                v5 = p1_2(p1.CurrentRank)
                if not v5 then
                    v5 = 0
                end
            end
            local v7 = v5 + 1
            if v2.maxRank <= v5 then
                return {}
            end
            local v8 = {}
            if v2.firstRankOnlyCosts then
                local firstRankOnlyCosts = v2.firstRankOnlyCosts
                local v9 = nil
                v6 = nil
                for i, j in firstRankOnlyCosts, v9, v6 do
                    v8[j] = true
                end
            end
            local v10 = {}
            local costs = v2.costs
            v6 = nil
            local v11 = nil
            for k, n in costs, v6, v11 do
                if not v8[n.type] or not (1 < v7) then
                    amount = n.amount
                    if n.type ~= "SP" then
                        v3 = n.amount * v7
                        amount = math.floor(v3)
                    end
                    v4 = {type = n.type, amount = amount}
                    table.insert(v10, v4)
                end
            end
            return v10
        end
        return {}
    end)
    local v1 = scope:Computed(function(p1) -- Line: 84 -- upvalues: u5 (val), SkillTreeData (upval)
        local v1 = p1(u5)
        if #v1 == 0 then
            return false
        end
        local v2 = v1
        local v3 = nil
        local v4 = nil
        for i, j in v2, v3, v4 do
            if j.type == "SP" and (p1(SkillTreeData.SP)) < j.amount then
                return false
            end
        end
        return true
    end)
    local v2 = scope:Computed(function(p1_2) -- Line: 98 -- upvalues: p1 (val)
        local Visible = p1.Visible
        if Visible == nil then
            return true
        end
        return (p1_2(Visible))
    end)
    local v3 = scope:New("Frame")
    local v4 = {
        Name = "SkillsUI",
        AnchorPoint = Vector2.new(0.5, 1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.fromScale(0.5, 1),
        Size = UDim2.fromScale(1, 0.2),
        Visible = v2,
    }
    local v5 = Children
    local v6 = {}
    local v7 = scope:New("UIListLayout")({
        Name = "UIListLayout",
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
    })
    local v8 = u26
    v8 = v8({scope = scope, Costs = u5})
    local v9 = u23
    local v10 = {scope = scope, OnBuy = p1.OnBuy, OnExit = p1.OnExit, BuyEnabled = v1}
    v6[1] = v7
    v6[2] = v8
    v6[3] = v9(v10)
    v4[v5] = v6
    return v3(v4)
end