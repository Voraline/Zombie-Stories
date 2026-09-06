return function(p1, p2, p3) -- Line: 14
    local v1, v2, v3, v4, v5, v6
    if p1 == 0 or p3 == 0 then
        return 1, 0, 0, 1
    end
    if 1 < p2 then
        v5 = p1 * p3
        v6 = math.sqrt(p2 ^ 2 - 1)
        local v7 = -0.5 / v6
        v1 = -v6 - p2
        v2 = 1 / v1
        v3 = math.exp(v5 * v1)
        v4 = math.exp(v5 * v2)
        return (v4 * v1 - v3 * v2) * v7, (v3 - v4) * v7 / p3, (v4 - v3) * v7 * p3, (v3 * v1 - v4 * v2) * v7
    end
    if p2 == 1 then
        v5 = p1 * p3
        v6 = math.exp(-v5)
        return v6 * (v5 + 1), v6 * p1, v6 * (-v5 * p3), v6 * (1 - v5)
    end
    v5 = p1 * p3
    v6 = math.sqrt(1 - p2 ^ 2)
    v1 = v6 * v5
    v2 = math.exp(-v5 * p2)
    v3 = v2 * math.sin(v1)
    v4 = v2 * math.cos(v1)
    local v8 = v3 * (1 / v6)
    local v9 = v8 * p2
    return v9 + v4, v8, -(v9 * p2 + v3 * v6), v4 - v9
end