local u0 = {_ClassName = script.Parent.Parent}
function u0.new(p1, p2) -- Line: 4 -- upvalues: u0 (val)
    local v1 = {}
    setmetatable(v1, u0)
    local v2 = {AimFOVMultiplier = 0.9, HasReticle = true}
    local AimOffset = p2.AimOffset
    if not AimOffset then
        AimOffset = CFrame.new()
    end
    v2.AimOffset = AimOffset * CFrame.new(0, 0, -0.3)
    v1.SettingChanges = v2
    v1.AttModel = p1
    v1.SettingChanges.Aimpart = p1:WaitForChild("Aimpart", 2)
    v1.SettingChanges.Lense = p1:WaitForChild("Lense", 2)
    v1.SettingChanges.AimOffset = CFrame.new()
    return v1
end
return u0