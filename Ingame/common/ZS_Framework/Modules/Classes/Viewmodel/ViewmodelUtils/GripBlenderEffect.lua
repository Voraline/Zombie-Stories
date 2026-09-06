local v1 = require("../../../Utils/SpringUtil")
local new = CFrame.new
local u6 = v1.new(0)
u6.Target = 0
u6.Speed = 24
u6.Damper = 0.8
local function Lerp(p1, p2, p3) -- Line: 10
    return p1 * (1 - p3) + p2 * p3
end
local u11 = {
    Inspect = true,
    ReloadEmpty = true,
    Reload = true,
    LoadStart = true,
    LoadLoop = true,
    Equip = true,
    LoadStop = true,
    LoadIdle = true,
}
local function checkAnimations(p1) -- Line: 25 -- upvalues: u11 (val)
    local v1 = u11
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        if p1.Viewmodel.Animations[i] and p1.Viewmodel.Animations[i].IsPlaying then
            return false
        end
    end
    return true
end
local u13 = nil
return function(p1, p2) -- Line: 37 -- upvalues: u13 (ref), u6 (val), checkAnimations (val), new (val)
    local Position, v1, v2
    local v3 = p1.LeftWeld.Part0.CFrame:Inverse()
    local v4 = v3 * p2.Config.LeftArmGrip.CFrame
    v3 = false
    if p1.OGLArmWeld ~= u13 then
        u13 = p1.OGLArmWeld
        p1.OGLArmWeld_BaseTransform = nil
        p1.OGLArmWeld_OldTransform = nil
        u6.Position = 0
        u6.Target = 0
    end
    local v5 = not p2.Reloading
    if v5 then
        v5 = checkAnimations(p2)
    end
    if v5 then
        if p1.OGLArmWeld_OldTransform and p1.OGLArmWeld.Transform == p1.OGLArmWeld_OldTransform then
            p1.OGLArmWeld_BaseTransform = p1.OGLArmWeld.Transform
        end
        p1.OGLArmWeld_OldTransform = p1.OGLArmWeld.Transform
    end
    if p1.OGLArmWeld_BaseTransform and v5 then
        local v6 = (p1.OGLArmWeld_BaseTransform.p - p1.OGLArmWeld.Transform.Position).Magnitude <= 0.17
        v2 = math.deg((math.acos((p1.OGLArmWeld_BaseTransform.LookVector:Dot(p1.OGLArmWeld.Transform.LookVector)))))
        if v2 == v2 then
            v2 = v2 <= 0.04
        else
            v2 = false
        end
        if v6 then
            v3 = true
        elseif not v2 then
        end
    end
    if not v3 then
        v1 = 0
    else
        v1 = 1
    end
    u6.Target = v1
    if p1.MoveCF then
        v2 = new(0, 1, 0)
        Position = u6.Position
        p1.LeftWeld.C1 = new():Lerp(v2, 1 * (1 - Position) + 0 * Position)
    end
    p1.LeftWeld.C0 = new():Lerp(v4, u6.Position)
    return p1.LeftWeld.C0
end