return {
    EncodePositioningData = function(p1) -- Line: 7
        local v1 = math.clamp(p1.X, -327.68, 326.68)
        local v2 = math.clamp(p1.Y, -327.68, 326.68)
        local v3 = math.clamp(p1.Z, -327.68, 326.68)
        v1 = math.floor(v1 * 100 + 0.5)
        v2 = math.floor(v2 * 100 + 0.5)
        v3 = math.floor(v3 * 100 + 0.5)
        if v1 < -32768 then
            error("OUT OF BOUNDS")
        elseif v2 >= -32768 and v3 >= -32768 then
        end
        if 32767 < v1 then
            error("OUT OF BOUNDS")
        elseif 32767 < v2 then
            error("OUT OF BOUNDS")
        elseif 32767 < v3 then
            error("OUT OF BOUNDS")
        end
        return Vector3int16.new(v1, v2, v3)
    end,
    DecodePositioningData = function(p1) -- Line: 22
        return p1.X / 100, p1.Y / 100, p1.Z / 100
    end,
}