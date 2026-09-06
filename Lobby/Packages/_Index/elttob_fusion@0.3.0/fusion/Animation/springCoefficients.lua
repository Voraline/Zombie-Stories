return function(p1, p2, p3) -- Line: 22
    local v1, v2, v3, v4, v5, v6
    if p1 == 0 or p3 == 0 then
        return 1, 0, 0, 1
    end
    if 1 < p2 then
        v4 = math.sqrt(p2 ^ 2 - 1)
        v5 = -0.5 / (v4 * p3)
        v6 = p3 * (v4 + p2) * -1
        v1 = p3 * (v4 - p2)
        v2 = math.exp(p1 * v6)
        v3 = math.exp(p1 * v1)
        return (v3 * v6 - v2 * v1) * v5, (v2 - v3) * v5 / p3, (v3 - v2) * v5 * p3, (v2 * v6 - v3 * v1) * v5
    end
    if p2 == 1 then
        v4 = p1 * p3
        v5 = v4 * -1
        v6 = math.exp(v5)
        return v6 * (v4 + 1), v6 * p1, v6 * (v5 * p3), v6 * (v5 + 1)
    end
    v4 = p3 * math.sqrt(1 - p2 ^ 2)
    v5 = 1 / v4
    v6 = math.exp(p1 * -1 * p3 * p2)
    v1 = math.sin(v4 * p1)
    v2 = math.cos(v4 * p1)
    v3 = v6 * v1
    local v7 = v6 * v2
    local v8 = v3 * p3 * p2 * v5
    return v8 + v7, v3 * v5, (v3 * v4 + p3 * p2 * v8) * -1, v7 - v8
end