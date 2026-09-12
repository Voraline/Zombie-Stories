local u0 = {DebugLogging = false, VisualizeCasts = false}
u0.__index = u0
u0.__type = "FastCast"
u0.HighFidelityBehavior = {Default = 1, Always = 3}
local u7 = require("@self/ActiveCast")
local u10 = require("@self/Signal")
require("@self/Table")
require("@self/TypeDefinitions")
u7.SetStaticFastCastReference(u0)

function u0.new() -- Line: 107 -- upvalues: u10 (val), u0 (val)
    local v1 = {
        LengthChanged = u10.new("LengthChanged"),
        RayHit = u10.new("RayHit"),
        RayPierced = u10.new("RayPierced"),
        CastTerminating = u10.new("CastTerminating"),
        WorldRoot = workspace,
    }
    local v2 = u0
    return (setmetatable(v1, v2))
end

function u0.newBehavior() -- Line: 119 -- upvalues: u0 (val)
    return {
        MaxDistance = 1000,
        HighFidelitySegmentSize = 0.5,
        AutoIgnoreContainer = true,
        Acceleration = Vector3.new(),
        HighFidelityBehavior = u0.HighFidelityBehavior.Default,
    }
end

local u23 = u0.newBehavior()

function u0.Fire(p1, p2, p3, p4, p5) -- Line: 136 -- upvalues: u23 (val), u7 (val)
    local v1
    if p5 ~= nil then
        v1 = p5
    else
        v1 = u23
    end
    local v2 = u7.new(p1, p2, p3, p4, v1)
    v2.RayInfo.WorldRoot = p1.WorldRoot
    return v2
end

return u0