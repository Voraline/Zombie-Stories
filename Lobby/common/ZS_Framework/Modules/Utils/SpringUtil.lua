local u0 = {}
function u0.new(p1, p2) -- Line: 42 -- upvalues: u0 (val)
    local v1 = p1 or 0
    local v2 = p2
    if not v2 then
        v2 = tick
    end
    local v3 = v2
    local v4 = {
        _damper = 1,
        _speed = 1,
        _clock = v3,
        _time0 = v3(),
        _position0 = v1,
        _velocity0 = 0 * v1,
        _target = v1,
    }
    return (setmetatable(v4, u0))
end
function u0.Impulse(p1, p2) -- Line: 58
    p1.Velocity = p1.Velocity + p2
end
function u0.TimeSkip(p1, p2) -- Line: 64
    local v1, v2
    local v3 = p1._clock()
    v1, v2 = p1:_positionVelocity(v3 + p2)
    p1._position0 = v1
    p1._velocity0 = v2
    p1._time0 = v3
end
function u0.__index(p1, p2) -- Line: 72 -- upvalues: u0 (val)
    local v1
    if u0[p2] then
        return u0[p2]
    end
    if p2 == "Value" or p2 == "Position" or p2 == "p" then
        local v2 = p1:_positionVelocity(p1._clock())
        return v2
    end
    if p2 == "Velocity" or p2 == "v" then
        _, v1 = p1:_positionVelocity(p1._clock())
        return v1
    end
    if p2 == "Target" or p2 == "t" then
        return p1._target
    end
    if p2 == "Damper" or p2 == "d" then
        return p1._damper
    end
    if p2 == "Speed" or p2 == "s" then
        return p1._speed
    end
    if p2 == "Clock" then
        return p1._clock
    end
    v1 = ("%q is not a valid member of Spring"):format((tostring(p2)))
    error(v1, 2)
end
function u0.__newindex(p1, p2, p3) -- Line: 94
    local v1, v2
    local v3 = p1._clock()
    if p2 == "Value" or p2 == "Position" or p2 == "p" then
        _, v2 = p1:_positionVelocity(v3)
        p1._position0 = p3
        p1._velocity0 = v2
        p1._time0 = v3
        return
    end
    if p2 == "Velocity" or p2 == "v" then
        v1 = p1:_positionVelocity(v3)
        p1._position0 = v1
        p1._velocity0 = p3
        p1._time0 = v3
        return
    end
    if p2 == "Target" or p2 == "t" then
        v1, v2 = p1:_positionVelocity(v3)
        p1._position0 = v1
        p1._velocity0 = v2
        p1._target = p3
        p1._time0 = v3
        return
    end
    if p2 == "Damper" or p2 == "d" then
        v1, v2 = p1:_positionVelocity(v3)
        p1._position0 = v1
        p1._velocity0 = v2
        p1._damper = math.clamp(p3, 0, 1)
        p1._time0 = v3
        return
    end
    if p2 == "Speed" or p2 == "s" then
        local v4
        v1, v2 = p1:_positionVelocity(v3)
        p1._position0 = v1
        p1._velocity0 = v2
        if p3 >= 0 then
            v4 = p3
        else
            v4 = 0
        end
        p1._speed = v4
        p1._time0 = v3
        return
    end
    if p2 ~= "Clock" then
        v2 = ("%q is not a valid member of Spring"):format((tostring(p2)))
        error(v2, 2)
        return
    end
    v1, v2 = p1:_positionVelocity(v3)
    p1._position0 = v1
    p1._velocity0 = v2
    p1._clock = p3
    p1._time0 = p3()
end
function u0:_positionVelocity(p2) -- Line: 136
    local v1, v2, v3, v4
    local _position0 = self._position0
    local _velocity0 = self._velocity0
    local _target = self._target
    local _damper = self._damper
    local _speed = self._speed
    local v5 = _speed * (p2 - self._time0)
    local v6 = _damper * _damper
    if v6 < 1 then
        v4 = math.sqrt(1 - v6)
        v3 = math.exp(-_damper * v5) / v4
        v2 = v3 * math.cos(v4 * v5)
        v1 = v3 * math.sin(v4 * v5)
    elseif v6 ~= 1 then
        v4 = math.sqrt(v6 - 1)
        local v7 = math.exp((-_damper + v4) * v5)
        v3 = v7 / (2 * v4)
        local v8 = math.exp((-_damper - v4) * v5)
        v7 = v8 / (2 * v4)
        v2 = v3 + v7
        v1 = v3 - v7
    else
        v3 = math.exp(-_damper * v5) / 1
        v2 = v3
        v1 = v3 * v5
    end
    return (v4 * v2 + _damper * v1) * _position0 + (1 - (v4 * v2 + _damper * v1)) * _target + v1 / _speed * _velocity0, -_speed * v1 * _position0 + _speed * v1 * _target + (v4 * v2 - _damper * v1) * _velocity0
end
return u0