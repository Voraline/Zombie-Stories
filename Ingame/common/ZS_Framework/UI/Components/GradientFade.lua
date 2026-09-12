local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Packages.Fusion)
return function(p1) -- Line: 22
    local v1
    local v2 = p1.scope:innerScope()
    local u6 = p1.fadeLowerOffset or 0.001
    local u8 = p1.fadeUpperOffset or 0.001
    local u16 = p1.MinTransparency or 0
    local u15 = p1.MaxTransparency or 1
    if p1.Reversed then
        v1 = u15
        u15 = u16
        u16 = v1
    end
    v1 = v2:New("UIGradient")({
        Rotation = p1.Rotation or 0,
        Transparency = v2:Computed(function(p1_2) -- Line: 37 -- upvalues: p1 (val), u16 (ref), u15 (ref), u6 (val), u8 (val)
            local v1 = p1_2(p1.CurrentValue)
            local v2 = p1_2(p1.MaxValue)
            local v3 = p1_2(u16)
            local v4 = p1_2(u15)
            if v2 == 0 then
                return NumberSequence.new({NumberSequenceKeypoint.new(0, v4), NumberSequenceKeypoint.new(1, v4)})
            end
            local v5 = v1 / v2
            local v6 = math.clamp(v5, 0, 1)
            local new_2 = NumberSequence.new
            local v7 = {}
            local v8 = NumberSequenceKeypoint.new(0, v3)
            local new_3 = NumberSequenceKeypoint.new
            local v9 = v6 - u6
            local v10 = new_3(math.max(v9, 0), v3)
            local new_4 = NumberSequenceKeypoint.new
            local v11 = v6 + u8
            local v12 = new_4(math.min(v11, 1), v4)
            v7[1] = v8
            v7[2] = v10
            v7[3] = v12
            v7[4] = NumberSequenceKeypoint.new(1, v4)
            return new_2(v7)
        end),
    })
    return v1
end