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
    local v1, v2, v3, v4
    local v5 = (p1.LeftWeld.Part0.CFrame:Inverse()) * p2.Config.LeftArmGrip.CFrame
    local v6 = false
    if p1.OGLArmWeld ~= u13 then
        u13 = p1.OGLArmWeld
        p1.OGLArmWeld_BaseTransform = nil
        p1.OGLArmWeld_OldTransform = nil
        u6.Position = 0
        u6.Target = 0
    end
    local v7 = not p2.Reloading
    if v7 then
        v7 = checkAnimations(p2)
    end
    if v7 then
        if p1.OGLArmWeld_OldTransform and p1.OGLArmWeld.Transform == p1.OGLArmWeld_OldTransform then
            p1.OGLArmWeld_BaseTransform = p1.OGLArmWeld.Transform
        end
        p1.OGLArmWeld_OldTransform = p1.OGLArmWeld.Transform
    end
    if p1.OGLArmWeld_BaseTransform and v7 then
        v1 = (p1.OGLArmWeld_BaseTransform.p - p1.OGLArmWeld.Transform.Position).Magnitude <= 0.17
        local LookVector = p1.OGLArmWeld_BaseTransform.LookVector
        local LookVector_2 = p1.OGLArmWeld.Transform.LookVector
        local v8 = LookVector:Dot(LookVector_2)
        v4 = math.acos(v8)
        v3 = math.deg(v4)
        if v3 == v3 then
            v3 = v3 <= 0.04
        else
            v3 = false
        end
        if v1 or v3 then
            v6 = true
        end
    end
    v1 = u6
    if not v6 then
        v2 = 0
    else
        v2 = 1
    end
    v1.Target = v2
    if p1.MoveCF then
        local LeftWeld = p1.LeftWeld
        v2 = new
        v2 = v2()
        v3 = new(0, 1, 0)
        local Position = u6.Position
        v4 = 1 * (1 - Position) + 0 * Position
        LeftWeld.C1 = v2:Lerp(v3, v4)
    end
    local LeftWeld_2 = p1.LeftWeld
    v2 = new
    v2 = v2()
    v4 = u6
    local Position_2 = v4.Position
    LeftWeld_2.C0 = v2:Lerp(v5, Position_2)
    return p1.LeftWeld.C0
end