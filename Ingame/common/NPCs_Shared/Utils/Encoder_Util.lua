return {
    EncodePositioningData = function(p1) -- Line: 7
        local X = p1.X
        local v1 = math.clamp(X, -327.68, 326.68)
        local Y = p1.Y
        local v2 = math.clamp(Y, -327.68, 326.68)
        local Z = p1.Z
        local v3 = math.clamp(Z, -327.68, 326.68)
        local v4 = v1 * 100 + 0.5
        v1 = math.floor(v4)
        v4 = v2 * 100 + 0.5
        v2 = math.floor(v4)
        v4 = v3 * 100 + 0.5
        v3 = math.floor(v4)
        if v1 < -32768 or v2 < -32768 or v3 < -32768 then
            error("OUT OF BOUNDS")
        end
        if 32767 < v1 or 32767 < v2 or 32767 < v3 then
            error("OUT OF BOUNDS")
        end
        return Vector3int16.new(v1, v2, v3)
    end,
    DecodePositioningData = function(p1) -- Line: 22
        return p1.X / 100, p1.Y / 100, p1.Z / 100
    end,
}