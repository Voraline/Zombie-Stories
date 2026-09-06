local TweenService = game:GetService("TweenService")
return function(p1, p2) -- Line: 10 -- upvalues: TweenService (val)
    local DelayTime = p1.DelayTime
    local Time = p1.Time
    local v1 = DelayTime + Time
    if p1.Reverses then
        v1 = v1 + Time
    end
    if v1 * (1 + p1.RepeatCount) <= p2 then
        return 1
    end
    local v2 = p2 % v1
    if v2 <= DelayTime then
        return 0
    end
    local v3 = (v2 - DelayTime) / Time
    if 1 < v3 then
        v3 = 2 - v3
    end
    return (TweenService:GetValue(v3, p1.EasingStyle, p1.EasingDirection))
end