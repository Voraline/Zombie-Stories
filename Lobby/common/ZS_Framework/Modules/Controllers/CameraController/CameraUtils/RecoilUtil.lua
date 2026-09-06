local Parent = script.Parent.Parent.Parent
local Utils = Parent.Parent:WaitForChild("Utils")
local SpringUtil = require(Utils:WaitForChild("SpringUtil"))
local LocalPlayerController = require(Parent:WaitForChild("LocalPlayerController"))
local u21 = {}
u21.__index = u21
function u21.new(p1) -- Line: 14 -- upvalues: SpringUtil (val), u21 (val)
    local Config = p1.Config
    local v1 = {Weapon = p1, ImpulsePitch = SpringUtil.new(0)}
    v1.ImpulsePitch.Target = 0
    local RecoilPitchSpeed = Config.RecoilPitchSpeed
    if not RecoilPitchSpeed then
        RecoilPitchSpeed = Config.angularFrequency
        if not RecoilPitchSpeed then
            RecoilPitchSpeed = 8
        end
    end
    v1.ImpulsePitch.Speed = RecoilPitchSpeed
    local RecoilPitchDamp = Config.RecoilPitchDamp
    if not RecoilPitchDamp then
        RecoilPitchDamp = Config.dampingRatio
        if not RecoilPitchDamp then
            RecoilPitchDamp = 0.6
        end
    end
    v1.ImpulsePitch.Damper = RecoilPitchDamp
    v1.ImpulseYaw = SpringUtil.new(0)
    v1.ImpulseYaw.Target = 0
    local RecoilYawSpeed = Config.RecoilYawSpeed
    if not RecoilYawSpeed then
        RecoilYawSpeed = Config.angularFrequency
        if not RecoilYawSpeed then
            RecoilYawSpeed = 7
        end
    end
    v1.ImpulseYaw.Speed = RecoilYawSpeed
    local RecoilYawDamp = Config.RecoilYawDamp
    if not RecoilYawDamp then
        RecoilYawDamp = Config.dampingRatio
        if not RecoilYawDamp then
            RecoilYawDamp = 0.6
        end
    end
    v1.ImpulseYaw.Damper = RecoilYawDamp
    v1.ImpulseRoll = SpringUtil.new(0)
    v1.ImpulseRoll.Target = 0
    local RecoilRollSpeed = Config.RecoilRollSpeed
    if not RecoilRollSpeed then
        RecoilRollSpeed = Config.angularFrequency
        if not RecoilRollSpeed then
            RecoilRollSpeed = 15
        end
    end
    v1.ImpulseRoll.Speed = RecoilRollSpeed
    local RecoilRollDamp = Config.RecoilRollDamp
    if not RecoilRollDamp then
        RecoilRollDamp = Config.dampingRatio
        if not RecoilRollDamp then
            RecoilRollDamp = 0.6
        end
    end
    v1.ImpulseRoll.Damper = RecoilRollDamp
    v1.CameraPush = {0, 0}
    return (setmetatable(v1, u21))
end
function u21.RecoilImpulse(p1, p2, p3, p4, p5) -- Line: 38
    local v1 = math.random() - 0.5
    return p1 + 0.03 * p4, p2 + 0.02 * p5 * v1, p3 + math.random(500, 1000) * 8e-05 * v1
end
function u21.Impulse(p1) -- Line: 46 -- upvalues: LocalPlayerController (val), u21 (val)
    local v1, v2, v3, v4, v5, v6, v7
    local Config = p1.Weapon.Config
    if not Config.RecoilImpulse then
        v5, v6, v7 = u21.RecoilImpulse(p1.ImpulsePitch.p, p1.ImpulseYaw.p, p1.ImpulseRoll.p, Config.VerticalRecoil or 3, Config.HorizontalRecoil or 3)
        v1 = v5
        v2 = v6
        v3 = v7
    else
        v5, v6, v7 = Config.RecoilImpulse(p1.Weapon, LocalPlayerController, p1.ImpulsePitch.p, p1.ImpulseYaw.p, p1.ImpulseRoll.p, Config.VerticalRecoil or 3, Config.HorizontalRecoil or 3)
        v1 = v5
        v2 = v6
        v3 = v7
    end
    if Config.RecoilMultiplier then
        if type(Config.RecoilMultiplier) == "number" then
            v1 = v1 * Config.RecoilMultiplier
            v2 = v2 * Config.RecoilMultiplier
            v3 = v3 * Config.RecoilMultiplier
        elseif type(Config.RecoilMultiplier) == "table" then
            v1 = v1 * Config.RecoilMultiplier[1]
            v2 = v2 * Config.RecoilMultiplier[2]
            v3 = v3 * Config.RecoilMultiplier[3]
        end
    end
    if LocalPlayerController.States.Crouching then
        v4 = p1.Weapon.Config.CrouchRecoilMultiplier or 0.92
    elseif not LocalPlayerController.States.Sliding then
        if not LocalPlayerController.States.Proning then
            v4 = p1.Weapon.Config.StandardRecoilMultiplier or 1
        else
            v4 = p1.Weapon.Config.ProneRecoilMultiplier or 0.85
        end
    end
    local p = v1 * v4
    if not p then
        p = p1.ImpulsePitch.p
    end
    p1.ImpulsePitch.p = p
    local p_2 = v2 * v4
    if not p_2 then
        p_2 = p1.ImpulseYaw.p
    end
    p1.ImpulseYaw.p = p_2
    v5 = v3 * v4
    if not v5 then
        v5 = p1.ImpulseRoll.p + math.random(-1000, 1000) * 7e-05
    end
    p1.ImpulseRoll.p = v5
end
return u21