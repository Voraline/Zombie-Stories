local u0 = {}
u0.__index = u0
local profilebegin = debug.profilebegin
local profileend = debug.profileend
local new = Vector3.new
local new_2 = CFrame.new
local Angles = CFrame.Angles
local rad = math.rad
local u8 = new()
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
    local v2 = u0
    return (setmetatable(v1, v2))
end

function u0.Start(p1) -- Line: 106 -- upvalues: profilebegin (val), profileend (val)
    if p1._running then
        return
    end
    p1._running = true
    local RunService = game:GetService("RunService")
    local _renderName = p1._renderName
    local _renderPriority = p1._renderPriority
    RunService:BindToRenderStep(_renderName, _renderPriority, function(p1_2) -- Line: 109 -- upvalues: profilebegin (upval), p1 (val), profileend (upval)
        profilebegin("CameraShakerUpdate")
        p1:Update(p1_2)
        profileend()
    end)
end

function u0.Stop(p1) -- Line: 117
    if not p1._running then
        return
    end
    local RunService = game:GetService("RunService")
    local _renderName = p1._renderName
    RunService:UnbindFromRenderStep(_renderName)
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

function u0:Update(p2) -- Line: 133 -- upvalues: u8 (val), CameraShakeState (val), new_2 (val), Angles (val), rad (val)
    local State, v1, v2
    local v3 = u8
    local v4 = u8
    local _camShakeInstances = self._camShakeInstances
    local v5 = #_camShakeInstances
    local v6, v7 = self, p2
    for i = 1, v5 do
        v2 = _camShakeInstances[i]
        State = v2:GetState()
        if State ~= CameraShakeState.Inactive then
            if State ~= CameraShakeState.Inactive then
                v1 = v2:UpdateShake(v7)
                v3 = v3 + v1 * v2.PositionInfluence
                v4 = v4 + v1 * v2.RotationInfluence
            end
        elseif v2.DeleteOnInactive then
            v6._removeInstances[#v6._removeInstances + 1] = i
        elseif State ~= CameraShakeState.Inactive then
            v1 = v2:UpdateShake(v7)
            v3 = v3 + v1 * v2.PositionInfluence
            v4 = v4 + v1 * v2.RotationInfluence
        end
    end
    for j = #v6._removeInstances, 1, -1 do
        v2 = v6._removeInstances[j]
        table.remove(_camShakeInstances, v2)
        v6._removeInstances[j] = nil
    end
    local v8 = new_2(v3)
    v2 = Angles
    local Y = v4.Y
    local v9 = v8 * v2(0, rad(Y), 0)
    v8 = Angles
    local X = v4.X
    v2 = rad(X)
    local Z = v4.Z
    return v9 * v8(v2, 0, (rad(Z)))
end

function u0.Shake(p1, p2) -- Line: 169
    local _camShakeInstance = false
    if type(p2) == "table" then
        _camShakeInstance = p2._camShakeInstance
    end
    assert(_camShakeInstance, "ShakeInstance must be of type CameraShakeInstance")
    p1._camShakeInstances[#p1._camShakeInstances + 1] = p2
    return p2
end

function u0.ShakeSustain(p1, p2) -- Line: 176
    local _camShakeInstance = false
    if type(p2) == "table" then
        _camShakeInstance = p2._camShakeInstance
    end
    assert(_camShakeInstance, "ShakeInstance must be of type CameraShakeInstance")
    p1._camShakeInstances[#p1._camShakeInstances + 1] = p2
    local fadeInDuration = p2.fadeInDuration
    p2:StartFadeIn(fadeInDuration)
    return p2
end

function u0.ShakeOnce(p1, p2, p3, p4, p5, p6, p7) -- Line: 184 -- upvalues: CameraShakeInstance (val)
    local v1 = CameraShakeInstance.new(p2, p3, p4, p5)
    local v2 = typeof(p6) == "Vector3" and p6 or Vector3.new(0.15000000596046448, 0.15000000596046448, 0.15000000596046448)
    v1.PositionInfluence = v2
    v2 = typeof(p7) == "Vector3" and p7 or Vector3.new(1, 1, 1)
    v1.RotationInfluence = v2
    p1._camShakeInstances[#p1._camShakeInstances + 1] = v1
    return v1
end

function u0.StartShake(p1, p2, p3, p4, p5, p6) -- Line: 193 -- upvalues: CameraShakeInstance (val)
    local v1 = CameraShakeInstance.new(p2, p3, p4)
    local v2 = typeof(p5) == "Vector3" and p5 or Vector3.new(0.15000000596046448, 0.15000000596046448, 0.15000000596046448)
    v1.PositionInfluence = v2
    v2 = typeof(p6) == "Vector3" and p6 or Vector3.new(1, 1, 1)
    v1.RotationInfluence = v2
    v1:StartFadeIn(p4)
    p1._camShakeInstances[#p1._camShakeInstances + 1] = v1
    return v1
end

return u0