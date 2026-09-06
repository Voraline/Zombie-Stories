game:GetService("TweenService")
return function(p1) -- Line: 13
    if p1.RepeatCount <= -1 then
        return (1 / 0)
    end
    local v1 = p1.DelayTime + p1.Time
    if p1.Reverses then
        v1 = v1 + p1.Time
    end
    return v1 * (p1.RepeatCount + 1)
end