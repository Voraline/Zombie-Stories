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
    local ImpulsePitch = v1.ImpulsePitch
    local RecoilPitchSpeed = Config.RecoilPitchSpeed
    if not RecoilPitchSpeed then
        RecoilPitchSpeed = Config.angularFrequency
        if not RecoilPitchSpeed then
            RecoilPitchSpeed = 8
        end
    end
    ImpulsePitch.Speed = RecoilPitchSpeed
    local ImpulsePitch_2 = v1.ImpulsePitch
    local RecoilPitchDamp = Config.RecoilPitchDamp
    if not RecoilPitchDamp then
        RecoilPitchDamp = Config.dampingRatio
        if not RecoilPitchDamp then
            RecoilPitchDamp = 0.6
        end
    end
    ImpulsePitch_2.Damper = RecoilPitchDamp
    v1.ImpulseYaw = SpringUtil.new(0)
    v1.ImpulseYaw.Target = 0
    local ImpulseYaw = v1.ImpulseYaw
    local RecoilYawSpeed = Config.RecoilYawSpeed
    if not RecoilYawSpeed then
        RecoilYawSpeed = Config.angularFrequency
        if not RecoilYawSpeed then
            RecoilYawSpeed = 7
        end
    end
    ImpulseYaw.Speed = RecoilYawSpeed
    local ImpulseYaw_2 = v1.ImpulseYaw
    local RecoilYawDamp = Config.RecoilYawDamp
    if not RecoilYawDamp then
        RecoilYawDamp = Config.dampingRatio
        if not RecoilYawDamp then
            RecoilYawDamp = 0.6
        end
    end
    ImpulseYaw_2.Damper = RecoilYawDamp
    v1.ImpulseRoll = SpringUtil.new(0)
    v1.ImpulseRoll.Target = 0
    local ImpulseRoll = v1.ImpulseRoll
    local RecoilRollSpeed = Config.RecoilRollSpeed
    if not RecoilRollSpeed then
        RecoilRollSpeed = Config.angularFrequency
        if not RecoilRollSpeed then
            RecoilRollSpeed = 15
        end
    end
    ImpulseRoll.Speed = RecoilRollSpeed
    local ImpulseRoll_2 = v1.ImpulseRoll
    local RecoilRollDamp = Config.RecoilRollDamp
    if not RecoilRollDamp then
        RecoilRollDamp = Config.dampingRatio
        if not RecoilRollDamp then
            RecoilRollDamp = 0.6
        end
    end
    ImpulseRoll_2.Damper = RecoilRollDamp
    v1.CameraPush = {0, 0}
    local v2 = u21
    return (setmetatable(v1, v2))
end

function u21.RecoilImpulse(p1, p2, p3, p4, p5) -- Line: 38
    local v1 = math.random() - 0.5
    return p1 + 0.03 * p4, p2 + 0.02 * p5 * v1, p3 + math.random(500, 1000) * 8e-05 * v1
end

function u21.Impulse(p1) -- Line: 46 -- upvalues: LocalPlayerController (val), u21 (val)
    local v1, v2, v3, v4, v5, v6, v7, v8
    local Config = p1.Weapon.Config
    if not Config.RecoilImpulse then
        v4 = Config.VerticalRecoil or 3
        v5 = Config.HorizontalRecoil or 3
        v6, v7, v8 = u21.RecoilImpulse(p1.ImpulsePitch.p, p1.ImpulseYaw.p, p1.ImpulseRoll.p, v4, v5)
        v1 = v6
        v2 = v7
        v3 = v8
    else
        v4 = Config.VerticalRecoil or 3
        v5 = Config.HorizontalRecoil or 3
        v6, v7, v8 = Config.RecoilImpulse(
            p1.Weapon,
            LocalPlayerController,
            p1.ImpulsePitch.p,
            p1.ImpulseYaw.p,
            p1.ImpulseRoll.p,
            v4,
            v5
        )
        v1 = v6
        v2 = v7
        v3 = v8
    end
    if Config.RecoilMultiplier then
        local RecoilMultiplier = Config.RecoilMultiplier
        if type(RecoilMultiplier) ~= "number" then
            local RecoilMultiplier_2 = Config.RecoilMultiplier
            if type(RecoilMultiplier_2) == "table" then
                v1 = v1 * Config.RecoilMultiplier[1]
                v2 = v2 * Config.RecoilMultiplier[2]
                v3 = v3 * Config.RecoilMultiplier[3]
            end
        else
            v1 = v1 * Config.RecoilMultiplier
            v2 = v2 * Config.RecoilMultiplier
            v3 = v3 * Config.RecoilMultiplier
        end
    end
    if LocalPlayerController.States.Crouching or LocalPlayerController.States.Sliding then
        v4 = p1.Weapon.Config.CrouchRecoilMultiplier or 0.92
    elseif not LocalPlayerController.States.Proning then
        v4 = p1.Weapon.Config.StandardRecoilMultiplier or 1
    else
        v4 = p1.Weapon.Config.ProneRecoilMultiplier or 0.85
    end
    v1 = v1 * v4
    v2 = v2 * v4
    v3 = v3 * v4
    local ImpulsePitch = p1.ImpulsePitch
    local p = v1
    if not p then
        p = p1.ImpulsePitch.p
    end
    ImpulsePitch.p = p
    local ImpulseYaw = p1.ImpulseYaw
    local p_2 = v2
    if not p_2 then
        p_2 = p1.ImpulseYaw.p
    end
    ImpulseYaw.p = p_2
    local ImpulseRoll = p1.ImpulseRoll
    v6 = v3
    if not v6 then
        v6 = p1.ImpulseRoll.p + math.random(-1000, 1000) * 7e-05
    end
    ImpulseRoll.p = v6
end

return u21