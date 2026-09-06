local u0 = {}
u0.__index = u0
local profilebegin = debug.profilebegin
local profileend = debug.profileend
local new = CFrame.new
local Angles = CFrame.Angles
local rad = math.rad
local u8 = Vector3.new()
local CameraShakeInstance = require(script:WaitForChild("CameraShakeInstance"))
local CameraShakeState = CameraShakeInstance.CameraShakeState
u0.CameraShakeInstance = CameraShakeInstance
u0.Presets = require("@self/CameraShakePresets")
function u0.new(p1, p2) -- Line: 87 -- upvalues: u8 (val), u0 (val)
    local v1 = type(p1) == "number"
    assert(v1, "RenderPriority must be a number (e.g.: Enum.RenderPriority.Camera.Value)")
    v1 = {
        _running = false,
        _renderName = p2 or "EZCameraShake",
        _renderPriority = p1,
        _posAddShake = u8,
        _rotAddShake = u8,
        _camShakeInstances = {},
        _removeInstances = {},
    }
    return (setmetatable(v1, u0))
end
function u0.Start(p1) -- Line: 106 -- upvalues: profilebegin (val), profileend (val)
    if p1._running then
        return
    end
    p1._running = true
    local RunService = game:GetService("RunService")
    RunService:BindToRenderStep(p1._renderName, p1._renderPriority, function(a1) -- Line: 109 -- upvalues: profilebegin (upval), p1 (val), profileend (upval)
        profilebegin("CameraShakerUpdate")
        p1:Update(a1)
        profileend()
    end)
end
function u0.Stop(p1) -- Line: 117
    if not p1._running then
        return
    end
    local RunService = game:GetService("RunService")
    RunService:UnbindFromRenderStep(p1._renderName)
    p1._running = false
end
function u0.StopSustained(p1, p2) -- Line: 124
    local fadeInDuration
    local v1 = p2
    for k, v in pairs(p1._camShakeInstances) do
        if v.fadeOutDuration == 0 then
            fadeInDuration = v1
            if not fadeInDuration then
                fadeInDuration = v.fadeInDuration
            end
            v:StartFadeOut(fadeInDuration)
        end
    end
end
function u0:Update(p2) -- Line: 133 -- upvalues: u8 (val), CameraShakeState (val), new (val), Angles (val), rad (val)
    local State, v1, v2, v3, v4
    local v5 = u8
    local v6 = u8
    local _camShakeInstances = self._camShakeInstances
    local v7 = #_camShakeInstances
    local v8 = 1
    v1, v2 = self, p2
    for i = 1, v7, v8 do
        v4 = _camShakeInstances[i]
        State = v4:GetState()
        if State ~= CameraShakeState.Inactive then
            if State ~= CameraShakeState.Inactive then
                v3 = v4:UpdateShake(v2)
                v5 = v5 + v3 * v4.PositionInfluence
                v6 = v6 + v3 * v4.RotationInfluence
            end
        elseif v4.DeleteOnInactive then
            v1._removeInstances[#v1._removeInstances + 1] = i
        end
    end
    v7 = 1
    v8 = -1
    for j = #v1._removeInstances, v7, v8 do
        table.remove(_camShakeInstances, v1._removeInstances[j])
        v1._removeInstances[j] = nil
    end
    local v9 = new(v5)
    v3 = rad(v6.Y)
    v8 = v9 * Angles(0, v3, 0)
    v4 = rad(v6.X)
    return v8 * Angles(v4, 0, (rad(v6.Z)))
end
function u0.Shake(p1, p2) -- Line: 169
    local _camShakeInstance
    _camShakeInstance = if type(p2) == "table" then p2._camShakeInstance else false
    assert(_camShakeInstance, "ShakeInstance must be of type CameraShakeInstance")
    p1._camShakeInstances[#p1._camShakeInstances + 1] = p2
    return p2
end
function u0.ShakeSustain(p1, p2) -- Line: 176
    local _camShakeInstance
    _camShakeInstance = if type(p2) == "table" then p2._camShakeInstance else false
    assert(_camShakeInstance, "ShakeInstance must be of type CameraShakeInstance")
    p1._camShakeInstances[#p1._camShakeInstances + 1] = p2
    p2:StartFadeIn(p2.fadeInDuration)
    return p2
end
function u0.ShakeOnce(p1, p2, p3, p4, p5, p6, p7) -- Line: 184 -- upvalues: CameraShakeInstance (val)
    local v1
    local v2 = CameraShakeInstance.new(p2, p3, p4, p5)
    if typeof(p6) ~= "Vector3" then
        v1 = Vector3.new(0.15000000596046448, 0.15000000596046448, 0.15000000596046448)
    else
        v1 = p6
    end
    v2.PositionInfluence = v1
    if typeof(p7) ~= "Vector3" then
        v1 = Vector3.new(1, 1, 1)
    else
        v1 = p7
        if not v1 then
            v1 = Vector3.new(1, 1, 1)
        end
    end
    v2.RotationInfluence = v1
    p1._camShakeInstances[#p1._camShakeInstances + 1] = v2
    return v2
end
function u0.StartShake(p1, p2, p3, p4, p5, p6) -- Line: 193 -- upvalues: CameraShakeInstance (val)
    local v1
    local v2 = CameraShakeInstance.new(p2, p3, p4)
    if typeof(p5) ~= "Vector3" then
        v1 = Vector3.new(0.15000000596046448, 0.15000000596046448, 0.15000000596046448)
    else
        v1 = p5
    end
    v2.PositionInfluence = v1
    if typeof(p6) ~= "Vector3" then
        v1 = Vector3.new(1, 1, 1)
    else
        v1 = p6
        if not v1 then
            v1 = Vector3.new(1, 1, 1)
        end
    end
    v2.RotationInfluence = v1
    v2:StartFadeIn(p4)
    p1._camShakeInstances[#p1._camShakeInstances + 1] = v2
    return v2
end
return u0