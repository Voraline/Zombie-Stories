local u0 = {}
u0.__index = u0
local profilebegin = debug.profilebegin
local profileend = debug.profileend
local new = Vector3.new
local new_2 = CFrame.new
local Angles = CFrame.Angles
local rad = math.rad
local u8 = new()
local u11 = require("@self/CameraShakeInstance")
local CameraShakeState = u11.CameraShakeState
u0.CameraShakeInstance = u11
u0.Presets = require("@self/CameraShakePresets")

function u0.new(p1, p2) -- Line: 74 -- upvalues: u8 (val), u0 (val)
    local v1 = type(p1) == "number"
    assert(v1, "RenderPriority must be a number (e.g.: Enum.RenderPriority.Camera.Value)")
    v1 = type(p2) == "function"
    assert(v1, "Callback must be a function")
    v1 = {
        _running = false,
        _renderName = "CameraShakerCS",
        _renderPriority = p1,
        _posAddShake = u8,
        _rotAddShake = u8,
        _camShakeInstances = {},
        _removeInstances = {},
        _callback = p2,
    }
    local v2 = u0
    return (setmetatable(v1, v2))
end

function u0.Start(p1) -- Line: 95 -- upvalues: profilebegin (val), profileend (val)
    if p1._running then
        return
    end
    p1._running = true
    local _callback = p1._callback
    local RunService = game:GetService("RunService")
    local _renderName = p1._renderName
    local _renderPriority = p1._renderPriority
    RunService:BindToRenderStep(_renderName, _renderPriority, function(p1_2) -- Line: 99 -- upvalues: profilebegin (upval), p1 (val), profileend (upval), _callback (val)
        profilebegin("CameraShakerUpdate")
        local v1 = p1:Update(p1_2)
        profileend()
        _callback(v1)
    end)
end

function u0.Stop(p1) -- Line: 108
    if not p1._running then
        return
    end
    local RunService = game:GetService("RunService")
    local _renderName = p1._renderName
    RunService:UnbindFromRenderStep(_renderName)
    p1._running = false
end

function u0:Update(p2) -- Line: 115 -- upvalues: u8 (val), CameraShakeState (val), new_2 (val), Angles (val), rad (val)
    local State, v1
    local v2 = u8
    local v3 = u8
    local _camShakeInstances = self._camShakeInstances
    local v4 = #_camShakeInstances
    local v5, v6 = self, p2
    for i = 1, v4 do
        v1 = _camShakeInstances[i]
        State = v1:GetState()
        if State ~= CameraShakeState.Inactive then
            if State ~= CameraShakeState.Inactive then
                v2 = v2 + (v1:UpdateShake(v6)) * v1.PositionInfluence
                v3 = v3 + (v1:UpdateShake(v6)) * v1.RotationInfluence
            end
        elseif v1.DeleteOnInactive then
            v5._removeInstances[#v5._removeInstances + 1] = i
        elseif State ~= CameraShakeState.Inactive then
            v2 = v2 + (v1:UpdateShake(v6)) * v1.PositionInfluence
            v3 = v3 + (v1:UpdateShake(v6)) * v1.RotationInfluence
        end
    end
    for j = #v5._removeInstances, 1, -1 do
        v1 = v5._removeInstances[j]
        table.remove(_camShakeInstances, v1)
        v5._removeInstances[j] = nil
    end
    local v7 = new_2(v2)
    v1 = Angles
    local Y = v3.Y
    local v8 = v7 * v1(0, rad(Y), 0)
    v7 = Angles
    local X = v3.X
    v1 = rad(X)
    local Z = v3.Z
    return v8 * v7(v1, 0, (rad(Z)))
end

function u0.Shake(p1, p2) -- Line: 151
    local _camShakeInstance = false
    if type(p2) == "table" then
        _camShakeInstance = p2._camShakeInstance
    end
    assert(_camShakeInstance, "ShakeInstance must be of type CameraShakeInstance")
    p1._camShakeInstances[#p1._camShakeInstances + 1] = p2
    return p2
end

function u0.ShakeSustain(p1, p2) -- Line: 158
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

function u0.ShakeOnce(p1, p2, p3, p4, p5, p6, p7) -- Line: 166 -- upvalues: u11 (val)
    local v1 = u11.new(p2, p3, p4, p5)
    local v2 = typeof(p6) == "Vector3" and p6 or Vector3.new(0.15000000596046448, 0.15000000596046448, 0.15000000596046448)
    v1.PositionInfluence = v2
    v2 = typeof(p7) == "Vector3" and p7 or Vector3.new(1, 1, 1)
    v1.RotationInfluence = v2
    p1._camShakeInstances[#p1._camShakeInstances + 1] = v1
    return v1
end

function u0.StartShake(p1, p2, p3, p4, p5, p6) -- Line: 175 -- upvalues: u11 (val)
    local v1 = u11.new(p2, p3, p4)
    local v2 = typeof(p5) == "Vector3" and p5 or Vector3.new(0.15000000596046448, 0.15000000596046448, 0.15000000596046448)
    v1.PositionInfluence = v2
    v2 = typeof(p6) == "Vector3" and p6 or Vector3.new(1, 1, 1)
    v1.RotationInfluence = v2
    v1:StartFadeIn(p4)
    p1._camShakeInstances[#p1._camShakeInstances + 1] = v1
    return v1
end

return u0