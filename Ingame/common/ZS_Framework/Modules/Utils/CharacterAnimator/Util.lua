return {
    lerp = function(p1, p2, p3, p4) -- Line: 3
        return p2 * (1 - p4) + p3 * p4
    end,
    rotateAround = function(p1, p2, p3, p4, p5, p6) -- Line: 7
        local v1 = math.atan2(p2.Z, p2.X)
        local v2 = (v1 + ((math.atan2(p3.Z, p3.X) - v1 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793) * p5 * p6 + 6.283185307179586) % 6.283185307179586
        local v3 = p4 * math.cos(v2)
        return (Vector3.new(v3, 0, p4 * math.sin(v2)))
    end,
}