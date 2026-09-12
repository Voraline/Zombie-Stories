return function(p1, p2, p3) -- Line: 22
    if p1 ~= 0 and p3 ~= 0 then
        local v1, v2, v3, v4, v5, v6, v7
        if 1 < p2 then
            v6 = p2 ^ 2 - 1
            v5 = math.sqrt(v6)
            v6 = -0.5 / (v5 * p3)
            v7 = p3 * (v5 + p2) * -1
            v1 = p3 * (v5 - p2)
            v3 = p1 * v7
            v2 = math.exp(v3)
            v4 = p1 * v1
            v3 = math.exp(v4)
            return (v3 * v7 - v2 * v1) * v6, (v2 - v3) * v6 / p3, (v3 - v2) * v6 * p3, (v2 * v7 - v3 * v1) * v6
        end
        if p2 == 1 then
            v5 = p1 * p3
            v6 = v5 * -1
            v7 = math.exp(v6)
            return v7 * (v5 + 1), v7 * p1, v7 * (v6 * p3), v7 * (v6 + 1)
        end
        v7 = 1 - p2 ^ 2
        v5 = p3 * math.sqrt(v7)
        v6 = 1 / v5
        v1 = p1 * -1 * p3 * p2
        v7 = math.exp(v1)
        v2 = v5 * p1
        v1 = math.sin(v2)
        v3 = v5 * p1
        v2 = math.cos(v3)
        v3 = v7 * v1
        v4 = v7 * v2
        local v8 = v3 * p3 * p2 * v6
        return v8 + v4, v3 * v6, (v3 * v5 + p3 * p2 * v8) * -1, v4 - v8
    end
    return 1, 0, 0, 1
end