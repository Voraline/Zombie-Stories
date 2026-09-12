return function(p1, p2) -- Line: 1
    local Transparency, Transparency_2, v1, v2, v3, v4, v5, v6
    local v7 = {}
    local Attribute = p1:GetAttribute("attuid3")
    local Attribute_2 = p1:GetAttribute("attuid2")
    v7[1] = Attribute
    v7[2] = Attribute_2
    v7[3] = p1:GetAttribute("attuid1")
    local v8 = nil
    local v9 = nil
    local v10, v11 = p1, p2
    for i, j in v7, v8, v9 do
        if j and j ~= "None" then
            v5 = nil
            for k, n in v10:GetDescendants() do
                if n:IsA("BasePart") and n:GetAttribute("uid") == j then
                    v5 = n
                    break
                end
            end
            if v5 then
                v6 = {}
                for m, i5 in v5:GetChildren() do
                    if i5:IsA("Texture") and not v6[i5.Texture] then
                        v6[i5.Texture] = i5
                    end
                end
                for i6, i7 in v11:GetDescendants() do
                    if i7:IsA("BasePart") and i7.Transparency == 0 then
                        v1 = v6
                        v2 = nil
                        v3 = nil
                        for i8, i9 in v1, v2, v3 do
                            for i10, i11 in Enum.NormalId:GetEnumItems() do
                                v4 = i9:Clone()
                                v4.Face = i11
                                Transparency_2 = v4.Transparency
                                Transparency = i7.Transparency
                                v4.Transparency = Transparency_2 + (1 - Transparency_2) * Transparency
                                v4.Parent = i7
                            end
                        end
                        i7.Color = v5.Color
                        i7.Material = v5.Material
                        if i7.Transparency == 0 then
                            i7.Transparency = v5.Transparency
                        end
                        i7.Reflectance = v5.Reflectance
                        if i7:IsA("UnionOperation") then
                            i7.UsePartColor = true
                        end
                    end
                end
            end
        end
    end
end