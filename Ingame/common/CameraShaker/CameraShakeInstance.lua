local u0 = {}
u0.__index = u0
local new = Vector3.new
local noise = math.noise
local v1 = {FadingIn = 0, FadingOut = 1, Sustained = 2, Inactive = 3}
u0.CameraShakeState = v1
function u0.new(p1, p2, p3, p4) -- Line: 28 -- upvalues: new (val), u0 (val)
    local v1, v2
    if p3 ~= nil then
        v1 = p3
    else
        v1 = 0
    end
    if p4 ~= nil then
        v2 = p4
    else
        v2 = 0
    end
    local v3 = type(p1) == "number"
    assert(v3, "Magnitude must be a number")
    v3 = type(p2) == "number"
    assert(v3, "Roughness must be a number")
    v3 = type(v1) == "number"
    assert(v3, "FadeInTime must be a number")
    v3 = type(v2) == "number"
    assert(v3, "FadeOutTime must be a number")
    v3 = {
        DeleteOnInactive = true,
        roughMod = 1,
        magnMod = 1,
        _camShakeInstance = true,
        Magnitude = p1,
        Roughness = p2,
        PositionInfluence = new(),
        RotationInfluence = new(),
        fadeOutDuration = v2,
        fadeInDuration = v1,
    }
    local v4 = 0 < v1
    v3.sustain = v4
    if 0 >= v1 then
        v4 = 1
    else
        v4 = 0
    end
    v3.currentFadeTime = v4
    v3.tick = Random.new():NextNumber(-100, 100)
    return (setmetatable(v3, u0))
end
function u0.UpdateShake(p1, p2) -- Line: 59 -- upvalues: noise (val), new (val)
    local tick = p1.tick
    local currentFadeTime = p1.currentFadeTime
    local v1 = noise(tick, 0) * 0.5
    local v2 = noise(0, tick) * 0.5
    local v3 = new(v1, v2, noise(tick, tick) * 0.5)
    if 0 < p1.fadeInDuration and p1.sustain then
        if currentFadeTime < 1 then
            currentFadeTime = currentFadeTime + p2 / p1.fadeInDuration
        elseif 0 < p1.fadeOutDuration then
            p1.sustain = false
        end
    end
    if not p1.sustain then
        currentFadeTime = currentFadeTime - p2 / p1.fadeOutDuration
    end
    if not p1.sustain then
        p1.tick = tick + p2 * p1.Roughness * p1.roughMod * currentFadeTime
    else
        p1.tick = tick + p2 * p1.Roughness * p1.roughMod
    end
    p1.currentFadeTime = currentFadeTime
    return v3 * p1.Magnitude * p1.magnMod * currentFadeTime
end
function u0.StartFadeOut(p1, p2) -- Line: 95
    if p2 == 0 then
        p1.currentFadeTime = 0
    end
    p1.fadeOutDuration = p2
    p1.fadeInDuration = 0
    p1.sustain = false
end
function u0.StartFadeIn(p1, p2) -- Line: 105
    if p2 == 0 then
        p1.currentFadeTime = 1
    end
    local fadeInDuration = p2
    if not fadeInDuration then
        fadeInDuration = p1.fadeInDuration
    end
    p1.fadeInDuration = fadeInDuration
    p1.fadeOutDuration = 0
    p1.sustain = true
end
function u0.GetScaleRoughness(p1) -- Line: 115
    return p1.roughMod
end
function u0.SetScaleRoughness(p1, p2) -- Line: 120
    p1.roughMod = p2
end
function u0.GetScaleMagnitude(p1) -- Line: 125
    return p1.magnMod
end
function u0.SetScaleMagnitude(p1, p2) -- Line: 130
    p1.magnMod = p2
end
function u0.GetNormalizedFadeTime(p1) -- Line: 135
    return p1.currentFadeTime
end
function u0:IsShaking() -- Line: 140
    local sustain
    sustain = if 0 >= self.currentFadeTime then self.sustain else true
    return sustain
end
function u0:IsFadingOut() -- Line: 145
    local v1 = not self.sustain
    if v1 then
        v1 = 0 < self.currentFadeTime
    end
    return v1
end
function u0:IsFadingIn() -- Line: 150
    local sustain = false
    if self.currentFadeTime < 1 then
        sustain = self.sustain
        if sustain then
            sustain = 0 < self.fadeInDuration
        end
    end
    return sustain
end
function u0.GetState(p1) -- Line: 155 -- upvalues: u0 (val)
    if p1:IsFadingIn() then
        return u0.CameraShakeState.FadingIn
    end
    if p1:IsFadingOut() then
        return u0.CameraShakeState.FadingOut
    end
    if p1:IsShaking() then
        return u0.CameraShakeState.Sustained
    end
    return u0.CameraShakeState.Inactive
end
return u0