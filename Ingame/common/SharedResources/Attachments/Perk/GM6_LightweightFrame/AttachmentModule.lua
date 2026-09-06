local u0 = {}
u0.__index = u0
function u0.new(p1, p2) -- Line: 4 -- upvalues: u0 (val)
    local v1 = {}
    setmetatable(v1, u0)
    v1.SettingChanges = {
        EquippedWalkspeedMultiplier = 0.92,
        HolsteredWalkspeedMultiplier = 0.95,
        ADSSpeed = p2.ADSSpeed * 1.5,
        DrawSpeed = p2.DrawSpeed * 2,
        HolsterSpeed = p2.HolsterSpeed * 2,
        VerticalRecoil = p2.VerticalRecoil * 1.5,
        HorizontalRecoil = p2.HorizontalRecoil * 1.5,
    }
    return v1
end
return u0