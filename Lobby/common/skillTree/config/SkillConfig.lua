require("./SkillTypes")
local v1 = require("./CoreSkills")
local v2 = require("./CombatSkills")
local v3 = require("./SurvivalSkills")
local v4 = require("./SkillLayout")
local u15 = {}

local function registerSkills(p1) -- Line: 28 -- upvalues: u15 (val)
    local id, v1
    local v2 = p1
    local v3 = nil
    local v4 = nil
    for i, j in v2, v3, v4 do
        if u15[j.id] then
            v1 = warn
            id = j.id
            v1((("Duplicate skill ID: %*"):format(id)))
        end
        u15[j.id] = j
    end
end

registerSkills(v1)
registerSkills(v2)
registerSkills(v3)
return {
    skills = u15,
    layout = v4,
    getSkill = function(p1) -- Line: 49 -- upvalues: u15 (val)
        return u15[p1]
    end,
    getSkillsByBranch = function(p1) -- Line: 54 -- upvalues: u15 (val)
        local v1 = {}
        local v2 = u15
        local v3 = nil
        local v4 = nil
        for i, j in v2, v3, v4 do
            if j.branch == p1 then
                table.insert(v1, j)
            end
        end
        return v1
    end,
    getSkillsByTier = function(p1, p2) -- Line: 65 -- upvalues: u15 (val)
        local v1 = {}
        local v2 = u15
        local v3 = nil
        local v4 = nil
        for i, j in v2, v3, v4 do
            if j.branch == p1 and j.tier == p2 then
                table.insert(v1, j)
            end
        end
        return v1
    end,
    getAllSkillIds = function() -- Line: 76 -- upvalues: u15 (val)
        local v1 = {}
        local v2 = u15
        local v3 = nil
        local v4 = nil
        for i in v2, v3, v4 do
            table.insert(v1, i)
        end
        return v1
    end,
    getTierRequiredCount = function(p1, p2) -- Line: 86 -- upvalues: u15 (val)
        local requirements, v1, v2
        local v3 = u15
        local v4 = nil
        local v5 = nil
        local v6, v7 = p1, p2
        for i, j in v3, v4, v5 do
            if j.branch == v6 and j.tier == v7 + 1 and j.requirements then
                requirements = j.requirements.requirements
                v1 = nil
                v2 = nil
                for k, n in requirements, v1, v2 do
                    if n.type == "tier" and n.tier == v7 then
                        return n.count or 4
                    end
                end
            end
        end
        return 4
    end,
    countSkillsAtTier = function(p1, p2, p3) -- Line: 101 -- upvalues: u15 (val)
        local v1 = 0
        local v2 = u15
        local v3 = nil
        local v4 = nil
        for i, j in v2, v3, v4 do
            if j.branch == p1 and j.tier == p2 then
                v1 = v1 + (p3[j.id] or 0)
            end
        end
        return v1
    end,
}