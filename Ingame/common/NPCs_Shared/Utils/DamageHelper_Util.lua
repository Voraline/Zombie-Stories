local deepCopy
local u0 = {}
local u1 = {}
function deepCopy(p1) -- Line: 6 -- upvalues: deepCopy (val)
    local v1 = {}
    for k, v in pairs(p1) do
        if type(v) == "table" then
            v = deepCopy(v)
        end
        v1[k] = v
    end
    return v1
end
return {
    GetHPList = function(p1, p2) -- Line: 20 -- upvalues: u1 (val)
        if not (u1[p2]) then
            local Attribute, Attribute_2
            local v1 = {}
            for i, j in p2:GetChildren() do
                if j:IsA("BasePart") and j.CanQuery then
                    Attribute = j:GetAttribute("uid")
                    assert(Attribute, "uid doesn't exist!")
                    Attribute_2 = j:GetAttribute("uid")
                    v1[Attribute_2] = true
                end
            end
            u1[p2] = v1
        end
        return u1[p2]
    end,
    GetArmorHPList = function(p1, p2) -- Line: 35 -- upvalues: u0 (val), deepCopy (val)
        local v1
        if u0[p2] then
            v1 = p2
        else
            local v2 = {HPDir = {}}
            if not (p2:FindFirstChild("Hitboxes")) then
                v1 = p2
            elseif not (p2.Hitboxes:FindFirstChild("Armor")) then
                v1 = p2
            else
                local Attribute, Attribute_2
                v1 = p2
                for i, j in p2.Hitboxes.Armor:GetChildren() do
                    if not (j:GetAttribute("ArmorHealth")) then
                        warn(j, "does not have a set armor health. Setting to 25")
                        j:SetAttribute("ArmorHealth", 25)
                    end
                    if not (j:GetAttribute("ArmorLevel")) then
                        warn(j, "does not have a set armor level. Setting to 1")
                        j:SetAttribute("ArmorLevel", 1)
                    end
                    table.insert(v2.HPDir, {HP = j:GetAttribute("ArmorHealth"), Lvl = j:GetAttribute("ArmorLevel")})
                    for k, n in j:GetChildren() do
                        Attribute = n:GetAttribute("uid")
                        assert(Attribute, "uid doesn't exist!")
                        Attribute_2 = n:GetAttribute("uid")
                        v2[Attribute_2] = {#v2.HPDir, j.Name}
                    end
                end
            end
            u0[v1] = v2
        end
        return (deepCopy(u0[v1]))
    end,
    GenUIDTable = function(p1, p2) -- Line: 62
        local v1 = {}
        for i, j in p2:GetDescendants() do
            if j:GetAttribute("uid") then
                v1[j:GetAttribute("uid")] = j
            end
        end
        return v1
    end,
}