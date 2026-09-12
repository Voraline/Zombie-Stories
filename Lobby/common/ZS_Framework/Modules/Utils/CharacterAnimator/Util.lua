return {
    lerp = function(p1, p2, p3, p4) -- Line: 3
        return p2 * (1 - p4) + p3 * p4
    end,
    rotateAround = function(p1, p2, p3, p4, p5, p6) -- Line: 7
        local Z = p2.Z
        local X = p2.X
        local v1 = math.atan2(Z, X)
        local Z_2 = p3.Z
        local X_2 = p3.X
        local v2 = (v1 + ((math.atan2(Z_2, X_2) - v1 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793) * p5 * p6 + 6.283185307179586) % 6.283185307179586
        local v3 = p4 * math.cos(v2)
        local v4 = math.sin(v2)
        local v5 = p4 * v4
        return (Vector3.new(v3, 0, v5))
    end,
}