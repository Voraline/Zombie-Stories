local TweenService = game:GetService("TweenService")
return function(p1, p2) -- Line: 13 -- upvalues: TweenService (val)
    local v1, v2
    local DelayTime = p1.DelayTime
    local Time = p1.Time
    local v3 = DelayTime + Time
    if p1.Reverses then
        v3 = v3 + Time
    end
    if p2 == (1 / 0) then
        return 1
    end
    if v3 * (1 + p1.RepeatCount) > p2 then
        v2 = p2 % v3
        if v2 <= DelayTime then
            return 0
        end
        v1 = (v2 - DelayTime) / Time
        if 1 < v1 then
            v1 = 2 - v1
        end
        return (TweenService:GetValue(v1, p1.EasingStyle, p1.EasingDirection))
    end
    if -1 < p1.RepeatCount then
        return 1
    end
    v2 = p2 % v3
    if v2 <= DelayTime then
        return 0
    end
    v1 = (v2 - DelayTime) / Time
    if 1 < v1 then
        v1 = 2 - v1
    end
    return (TweenService:GetValue(v1, p1.EasingStyle, p1.EasingDirection))
end