local u2 = require("./CameraShakeInstance")
local u3 = {}

function u3.Bump() -- Line: 26 -- upvalues: u2 (val)
    local v1 = u2.new(2.5, 4, 0.1, 0.75)
    v1.PositionInfluence = Vector3.new(0.15000000596046448, 0.15000000596046448, 0.15000000596046448)
    v1.RotationInfluence = Vector3.new(1, 1, 1)
    return v1
end

function u3.Explosion() -- Line: 36 -- upvalues: u2 (val)
    local v1 = u2.new(5, 10, 0, 1.5)
    v1.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
    v1.RotationInfluence = Vector3.new(4, 1, 1)
    return v1
end

function u3.Earthquake() -- Line: 46 -- upvalues: u2 (val)
    local v1 = u2.new(0.6, 3.5, 2, 10)
    v1.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
    v1.RotationInfluence = Vector3.new(1, 1, 4)
    return v1
end

function u3.BadTrip() -- Line: 56 -- upvalues: u2 (val)
    local v1 = u2.new(10, 0.15, 5, 10)
    v1.PositionInfluence = Vector3.new(0, 0, 0.15000000596046448)
    v1.RotationInfluence = Vector3.new(2, 1, 4)
    return v1
end

function u3.HandheldCamera() -- Line: 66 -- upvalues: u2 (val)
    local v1 = u2.new(1, 0.25, 5, 10)
    v1.PositionInfluence = Vector3.new(0, 0, 0)
    v1.RotationInfluence = Vector3.new(1, 0.5, 0.5)
    return v1
end

function u3.Helicopter() -- Line: 75 -- upvalues: u2 (val)
    local v1 = u2.new(0.5, 0.1, 5, 10)
    v1.PositionInfluence = Vector3.new(0, 0, 0)
    v1.RotationInfluence = Vector3.new(1, 0.25, 0.25)
    return v1
end

function u3.Vibration() -- Line: 84 -- upvalues: u2 (val)
    local v1 = u2.new(0.4, 20, 2, 2)
    v1.PositionInfluence = Vector3.new(0, 0.15000000596046448, 0)
    v1.RotationInfluence = Vector3.new(1.25, 0, 4)
    return v1
end

function u3.RoughDriving() -- Line: 94 -- upvalues: u2 (val)
    local v1 = u2.new(1, 2, 1, 1)
    v1.PositionInfluence = Vector3.new(0, 0, 0)
    v1.RotationInfluence = Vector3.new(1, 1, 1)
    return v1
end

local v1 = {
    __index = function(p1, p2) -- Line: 106 -- upvalues: u3 (val)
        local v1 = u3[p2]
        if type(v1) == "function" then
            return v1()
        end
        error("No preset found with index \"" .. p2 .. "\"")
    end,
}
return (setmetatable({}, v1))