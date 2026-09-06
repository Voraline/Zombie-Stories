return function(p1, p2) -- Line: 1
    local Transparency, v1, v2, v3, v4, v5, v6, v7, v8
    local v9 = {}
    local Attribute = p1:GetAttribute("attuid3")
    local Attribute_2 = p1:GetAttribute("attuid2")
    v9[1] = Attribute
    v9[2] = Attribute_2
    v9[3] = p1:GetAttribute("attuid1")
    local v10 = nil
    local v11 = nil
    v1, v2 = p1, p2
    for i, j in v9, v10, v11 do
        if j and j ~= "None" then
            v7 = nil
            for k, n in v1:GetDescendants() do
                if n:IsA("BasePart") and n:GetAttribute("uid") == j then
                    v7 = n
                    break
                end
            end
            if v7 then
                v8 = {}
                for m, i5 in v7:GetChildren() do
                    if i5:IsA("Texture") and not (v8[i5.Texture]) then
                        v8[i5.Texture] = i5
                    end
                end
                for i6, i7 in v2:GetDescendants() do
                    if i7:IsA("BasePart") and i7.Transparency == 0 then
                        v3 = v8
                        v4 = nil
                        v5 = nil
                        for i8, i9 in v3, v4, v5 do
                            for i10, i11 in Enum.NormalId:GetEnumItems() do
                                v6 = i9:Clone()
                                v6.Face = i11
                                Transparency = v6.Transparency
                                v6.Transparency = Transparency + (1 - Transparency) * i7.Transparency
                                v6.Parent = i7
                            end
                        end
                        i7.Color = v7.Color
                        i7.Material = v7.Material
                        if i7.Transparency == 0 then
                            i7.Transparency = v7.Transparency
                        end
                        i7.Reflectance = v7.Reflectance
                        if i7:IsA("UnionOperation") then
                            i7.UsePartColor = true
                        end
                    end
                end
            end
        end
    end
end