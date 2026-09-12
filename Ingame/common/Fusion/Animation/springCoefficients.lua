return function(p1, p2, p3) -- Line: 14
    if p1 ~= 0 and p3 ~= 0 then
        local v1, v2, v3, v4, v5, v6, v7, v8
        if 1 < p2 then
            v6 = p1 * p3
            v8 = p2 ^ 2 - 1
            v7 = math.sqrt(v8)
            v8 = -0.5 / v7
            v1 = -v7 - p2
            v2 = 1 / v1
            v4 = v6 * v1
            v3 = math.exp(v4)
            v5 = v6 * v2
            v4 = math.exp(v5)
            return (v4 * v1 - v3 * v2) * v8, (v3 - v4) * v8 / p3, (v4 - v3) * v8 * p3, (v3 * v1 - v4 * v2) * v8
        end
        if p2 == 1 then
            v6 = p1 * p3
            v8 = -v6
            v7 = math.exp(v8)
            return v7 * (v6 + 1), v7 * p1, v7 * (-v6 * p3), v7 * (1 - v6)
        end
        v6 = p1 * p3
        v8 = 1 - p2 ^ 2
        v7 = math.sqrt(v8)
        v8 = 1 / v7
        v1 = v7 * v6
        v3 = -v6 * p2
        v2 = math.exp(v3)
        v3 = v2 * math.sin(v1)
        v4 = v2 * math.cos(v1)
        v5 = v3 * v8
        local v9 = v5 * p2
        return v9 + v4, v5, -(v9 * p2 + v3 * v7), v4 - v9
    end
    return 1, 0, 0, 1
end