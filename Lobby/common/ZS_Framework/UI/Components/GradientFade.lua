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
    v1 = v2:New("UIGradient")
    local v3 = {Rotation = p1.Rotation or 0}
    v3.Transparency = v2:Computed(function(a1) -- Line: 37 -- upvalues: p1 (val), u16 (ref), u15 (ref), u6 (val), u8 (val)
        local v1
        local v2 = a1(p1.CurrentValue)
        local v3 = a1(p1.MaxValue)
        local v4 = a1(u16)
        local v5 = a1(u15)
        if v3 == 0 then
            local v6 = {}
            v1 = NumberSequenceKeypoint.new(0, v5)
            v6[1] = v1
            v6[2] = NumberSequenceKeypoint.new(1, v5)
            return NumberSequence.new(v6)
        end
        local v7 = math.clamp(v2 / v3, 0, 1)
        v1 = {}
        local v8 = NumberSequenceKeypoint.new(0, v4)
        local v9 = math.max(v7 - u6, 0)
        local v10 = NumberSequenceKeypoint.new(v9, v4)
        local v11 = math.min(v7 + u8, 1)
        v9 = NumberSequenceKeypoint.new(v11, v5)
        v1[1] = v8
        v1[2] = v10
        v1[3] = v9
        v1[4] = NumberSequenceKeypoint.new(1, v5)
        return NumberSequence.new(v1)
    end)
    return v1(v3)
end