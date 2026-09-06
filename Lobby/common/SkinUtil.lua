local u0 = {
    ApplySkinPalette = function(p1, p2, p3, p4) -- Line: 4
        local Attribute, v1, v2, v3
        local v4 = p3
        for i, j in p2.Weapon:QueryDescendants("BasePart") do
            Attribute = j:GetAttribute("PaletteIndex")
            if Attribute and v4[Attribute] then
                v1 = v4[Attribute]
                v2 = nil
                v3 = nil
                for k, n in v1, v2, v3 do
                    j[k] = n
                end
            end
        end
    end,
    ApplyTexture = function(p1, p2, p3, p4, p5) -- Line: 15
        local Decal, v1, v2, v3, v4
        if not p5 then
            Decal = Instance.new("Texture")
        else
            Decal = Instance.new("Decal")
        end
        Decal.Texture = p2
        if p4 then
            v2 = p4
            v3 = nil
            v4 = nil
            for i, j in v2, v3, v4 do
                Decal[i] = j
            end
        end
        v2 = p3
        v3 = nil
        v4 = nil
        for k, n in v2, v3, v4 do
            if n:IsA("BasePart") then
                for m, i5 in Enum.NormalId:GetEnumItems() do
                    v1 = Decal:Clone()
                    v1.Face = i5
                    v1.Parent = n
                    v1.Transparency = v1.Transparency + n.Transparency
                end
            end
        end
    end,
}
function u0.ApplyGalaxy(p1, p2) -- Line: 36 -- upvalues: u0 (val)
    p2:SetAttribute("attuid1", nil)
    for i, j in p2.Weapon:QueryDescendants("BasePart") do
        u0:ApplyTexture("rbxassetid://1818175145", {j}, {Name = "Animate", StudsPerTileU = 2, StudsPerTileV = 2})
    end
end
return u0