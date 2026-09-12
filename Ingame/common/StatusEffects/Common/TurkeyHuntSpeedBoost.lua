local Name = script.Name
local u2 = {}
u2.__index = u2

function u2.new(p1) -- Line: 6 -- upvalues: u2 (val)
    local v1 = {SpeedMult = 0, Inactive = true, _StatusEffects = p1}
    local v2 = u2
    return (setmetatable(v1, v2))
end

function u2.Apply(p1, p2, p3, p4) -- Line: 17
    p1.SpeedMult = p4 or 0
    local v1 = p1.SpeedMult == 0
    p1.Inactive = v1
    if not p1.Inactive and p3 and not (p3 <= 0) then
        p1._TimeRemaining = p3
        return
    end
    p1._TimeRemaining = nil
end

function u2.Update(p1, p2) -- Line: 28 -- upvalues: Name (val)
    if not p1.Inactive and p1._TimeRemaining then
        p1._TimeRemaining = p1._TimeRemaining - p2
        if p1._TimeRemaining <= 0 then
            local _StatusEffects = p1._StatusEffects
            if _StatusEffects then
                local v1 = Name
                _StatusEffects:RemoveStatus(v1)
                return
            end
            p1:Destroy()
        end
        return
    end
end

function u2:Destroy() -- Line: 44
    self.SpeedMult = 0
    self.Inactive = true
    self._TimeRemaining = nil
end

return u2