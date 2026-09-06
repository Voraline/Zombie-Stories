local Name = script.Name
local u2 = {}
u2.__index = u2
function u2.new(p1) -- Line: 6 -- upvalues: u2 (val)
    local v1 = {SpeedMult = 0, Inactive = true, _StatusEffects = p1}
    return (setmetatable(v1, u2))
end
function u2.Apply(p1, p2, p3, p4) -- Line: 17
    p1.SpeedMult = p4 or 0
    local v1 = p1.SpeedMult == 0
    p1.Inactive = v1
    if p1.Inactive or not p3 or p3 <= 0 then
        p1._TimeRemaining = nil
        return
    end
    p1._TimeRemaining = p3
end
function u2.Update(p1, p2) -- Line: 28 -- upvalues: Name (val)
    if p1.Inactive or not p1._TimeRemaining then
        return
    end
    p1._TimeRemaining = p1._TimeRemaining - p2
    if p1._TimeRemaining > 0 then
        return
    end
    local _StatusEffects = p1._StatusEffects
    if _StatusEffects then
        _StatusEffects:RemoveStatus(Name)
        return
    end
    p1:Destroy()
end
function u2:Destroy() -- Line: 44
    self.SpeedMult = 0
    self.Inactive = true
    self._TimeRemaining = nil
end
return u2