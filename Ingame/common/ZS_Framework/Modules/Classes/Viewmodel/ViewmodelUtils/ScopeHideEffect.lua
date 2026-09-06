local u0 = {}
local u1 = {}
local u2 = {}
local v1 = {}
function easeInQuart(p1) -- Line: 9
    return p1 * p1 * p1 * p1
end
local function initialize(p1) -- Line: 13 -- upvalues: u0 (val), u1 (val)
    local Weld, v1
    local v2 = {}
    u0[p1] = v2
    local v3 = {}
    u1[p1] = v3
    local Folder = Instance.new("Folder")
    Folder.Name = "GlassParts"
    Folder.Parent = p1
    for i, j in p1:QueryDescendants("BasePart[$HideScope]") do
        table.insert(v2, j)
        j:SetAttribute("OriginalTransparency", j.Transparency)
        if j.Material ~= Enum.Material.Glass and not (j:GetAttribute("NoGlass")) then
            v1 = j:Clone()
            v1.Material = "Glass"
            v1.Transparency = v1.Transparency * 0.5
            v1:SetAttribute("OriginalTransparency", v1.Transparency)
            table.insert(v3, v1)
            Weld = Instance.new("Weld")
            Weld.Part0 = j
            Weld.Part1 = v1
            Weld.Parent = v1
            v1.Parent = Folder
        end
    end
    for k, n in p1:QueryDescendants("Texture") do
        if n.Parent:GetAttribute("HideScope") then
            n:SetAttribute("OriginalTransparency", n.Transparency)
            table.insert(v2, n)
        end
    end
end
local function setPartVisible(p1, p2) -- Line: 52 -- upvalues: u2 (val)
    if p2 then
        if p2 and p1.Parent == nil then
            p1.Parent = u2[p1]
        end
        return
    end
    if p1.Parent ~= nil then
        u2[p1] = p1.Parent
        p1.Parent = nil
        return
    end
    if p2 and p1.Parent == nil then
        p1.Parent = u2[p1]
    end
end
local function correctGlassVisibility(p1) -- Line: 61 -- upvalues: u2 (val)
    local v1 = p1.Transparency ~= 1
    if v1 then
        if v1 and p1.Parent == nil then
            p1.Parent = u2[p1]
        end
        return
    end
    if p1.Parent ~= nil then
        u2[p1] = p1.Parent
        p1.Parent = nil
        return
    end
    if v1 and p1.Parent == nil then
        p1.Parent = u2[p1]
    end
end
function v1.Update(p1, p2, p3) -- Line: 65 -- upvalues: u0 (val), initialize (val), u1 (val), u2 (val)
    local Attribute, v1, v2, v3
    if not (u0[p2]) then
        initialize(p2)
    end
    local v4 = u0[p2]
    local v5 = u1[p2]
    local v6 = easeInQuart(p3.Position)
    local v7 = math.min(v6, 0.5) * 2
    local v8 = v4
    local v9 = nil
    local v10 = nil
    for i, j in v8, v9, v10 do
        v1 = j:GetAttribute("OriginalTransparency") or 0
        j.Transparency = v1 + (1 - v1) * v7
        if j:IsA("BasePart") and j.Material == Enum.Material.Glass then
            v2 = j.Transparency ~= 1
            if v2 then
                if v2 and j.Parent == nil then
                    j.Parent = u2[j]
                end
            elseif j.Parent ~= nil then
                u2[j] = j.Parent
                j.Parent = nil
            end
        end
    end
    v9 = math.max(v6 - 0.45, 0) * 2
    v8 = math.min(v9, 1)
    v9 = v5
    v10 = nil
    local v11 = nil
    for k, n in v9, v10, v11 do
        Attribute = n:GetAttribute("OriginalTransparency")
        n.Transparency = Attribute + (1 - Attribute) * v8
        if v8 ~= 0 then
            v3 = n.Transparency ~= 1
            if v3 then
                if v3 and n.Parent == nil then
                    n.Parent = u2[n]
                end
            elseif n.Parent ~= nil then
                u2[n] = n.Parent
                n.Parent = nil
            end
        elseif n.Parent ~= nil then
            u2[n] = n.Parent
            n.Parent = nil
        end
    end
end
return v1