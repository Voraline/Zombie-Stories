game:GetService("TweenService")
return function(p1) -- name: getTweenDuration
	if p1.RepeatCount <= -1 then
		return (1 / 0)
	end
	local v2 = p1.DelayTime + p1.Time
	if p1.Reverses then
		v2 = v2 + p1.Time
	end
	return v2 * (p1.RepeatCount + 1)
end