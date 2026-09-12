return {
    collect = function(p1) -- Line: 12
        local v1 = nil
        for i, j in p1:GetDescendants() do
            if j:IsA("Texture") and j.Name == "Animate" then
                if not v1 then
                    v1 = {}
                end
                table.insert(v1, j)
            end
        end
        return v1
    end,
    update = function(p1) -- Line: 26
        local v1 = (os.clock()) * 1
        local v2 = math.rad(v1) % 6.283185307179586 / 6.283185307179586 * 20
        local v3 = p1
        local v4 = nil
        local v5 = nil
        for i, j in v3, v4, v5 do
            j.OffsetStudsU = v2
            j.OffsetStudsV = v2
        end
    end,
}