local TweenService = game:GetService("TweenService")
return function(p1, p2) -- Line: 13 -- upvalues: TweenService (val)
    local DelayTime = p1.DelayTime
    local Time = p1.Time
    local Reverses = p1.Reverses
    local v1 = 1 + p1.RepeatCount
    local EasingStyle = p1.EasingStyle
    local EasingDirection = p1.EasingDirection
    local v2 = DelayTime + Time
    if Reverses then
        v2 = v2 + Time
    end
    if p2 == (1 / 0) then
        return 1
    end
    if v2 * v1 <= p2 and -1 < p1.RepeatCount then
        return 1
    end
    local v3 = p2 % v2
    if v3 <= DelayTime then
        return 0
    end
    local v4 = (v3 - DelayTime) / Time
    if 1 < v4 then
        v4 = 2 - v4
    end
    return (TweenService:GetValue(v4, EasingStyle, EasingDirection))
end