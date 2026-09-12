local u0 = {}

function u0.new(p1, p2) -- Line: 42 -- upvalues: u0 (val)
    local v1 = p1 or 0
    local v2 = p2 or tick
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
    local v5 = u0
    return (setmetatable(v4, v5))
end

function u0.Impulse(p1, p2) -- Line: 58
    p1.Velocity = p1.Velocity + p2
end

function u0.TimeSkip(p1, p2) -- Line: 64
    local v1 = p1._clock()
    local v2 = v1 + p2
    local v3, v4 = p1:_positionVelocity(v2)
    p1._position0 = v3
    p1._velocity0 = v4
    p1._time0 = v1
end

function u0.__index(p1, p2) -- Line: 72 -- upvalues: u0 (val)
    local v1, v2
    if u0[p2] then
        return u0[p2]
    end
    if p2 ~= "Value" and p2 ~= "Position" and p2 ~= "p" then
        local v3
        if p2 ~= "Velocity" and p2 ~= "v" then
            if p2 ~= "Target" and p2 ~= "t" then
                if p2 ~= "Damper" and p2 ~= "d" then
                    if p2 ~= "Speed" and p2 ~= "s" then
                        if p2 == "Clock" then
                            return p1._clock
                        end
                        v1 = error
                        local v4 = tostring(p2)
                        v1(("%q is not a valid member of Spring"):format(v4), 2)
                        return
                    end
                    return p1._speed
                end
                return p1._damper
            end
            return p1._target
        end
        v2 = p1._clock()
        _, v3 = p1:_positionVelocity(v2)
        return v3
    end
    v2 = p1._clock()
    v1 = p1:_positionVelocity(v2)
    return v1
end

function u0.__newindex(p1, p2, p3) -- Line: 94
    local v1
    local v2 = p1._clock()
    if p2 ~= "Value" and p2 ~= "Position" and p2 ~= "p" then
        local v3
        if p2 ~= "Velocity" and p2 ~= "v" then
            if p2 ~= "Target" and p2 ~= "t" then
                if p2 ~= "Damper" and p2 ~= "d" then
                    local v4
                    if p2 ~= "Speed" and p2 ~= "s" then
                        if p2 ~= "Clock" then
                            v3 = error
                            local v5 = tostring(p2)
                            v3(("%q is not a valid member of Spring"):format(v5), 2)
                            return
                        end
                        v3, v1 = p1:_positionVelocity(v2)
                        p1._position0 = v3
                        p1._velocity0 = v1
                        p1._clock = p3
                        p1._time0 = p3()
                        return
                    end
                    v3, v1 = p1:_positionVelocity(v2)
                    p1._position0 = v3
                    p1._velocity0 = v1
                    if not (p3 < 0) then
                        v4 = p3
                    else
                        v4 = 0
                    end
                    p1._speed = v4
                    p1._time0 = v2
                    return
                end
                v3, v1 = p1:_positionVelocity(v2)
                p1._position0 = v3
                p1._velocity0 = v1
                p1._damper = math.clamp(p3, 0, 1)
                p1._time0 = v2
                return
            end
            v3, v1 = p1:_positionVelocity(v2)
            p1._position0 = v3
            p1._velocity0 = v1
            p1._target = p3
            p1._time0 = v2
            return
        end
        v3 = p1:_positionVelocity(v2)
        p1._position0 = v3
        p1._velocity0 = p3
        p1._time0 = v2
        return
    end
    _, v1 = p1:_positionVelocity(v2)
    p1._position0 = p3
    p1._velocity0 = v1
    p1._time0 = v2
end

function u0:_positionVelocity(p2) -- Line: 136
    local v1, v2, v3, v4, v5, v6, v7
    local _position0 = self._position0
    local _velocity0 = self._velocity0
    local _target = self._target
    local _damper = self._damper
    local _speed = self._speed
    local v8 = _speed * (p2 - self._time0)
    local v9 = _damper * _damper
    if v9 < 1 then
        v4 = 1 - v9
        v7 = math.sqrt(v4)
        v5 = -_damper * v8
        v3 = math.exp(v5) / v7
        v5 = v7 * v8
        v2 = v3 * math.cos(v5)
        v5 = v7 * v8
        v1 = v3 * math.sin(v5)
    elseif v9 ~= 1 then
        v4 = v9 - 1
        v7 = math.sqrt(v4)
        v5 = (-_damper + v7) * v8
        v3 = (math.exp(v5)) / (2 * v7)
        v6 = (-_damper - v7) * v8
        v4 = (math.exp(v6)) / (2 * v7)
        v2 = v3 + v4
        v1 = v3 - v4
    else
        v7 = 1
        v5 = -_damper * v8
        v3 = math.exp(v5) / v7
        v2 = v3
        v1 = v3 * v8
    end
    v3 = v7 * v2 + _damper * v1
    v4 = 1 - (v7 * v2 + _damper * v1)
    v5 = v1 / _speed
    v6 = -_speed * v1
    local v10 = _speed * v1
    local v11 = v7 * v2 - _damper * v1
    return v3 * _position0 + v4 * _target + v5 * _velocity0, v6 * _position0 + v10 * _target + v11 * _velocity0
end

return u0