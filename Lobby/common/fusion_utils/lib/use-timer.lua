local RunService = game:GetService("RunService")
require("./types/fusion")
local u12 = require(script.Parent["use-event-listener"])
return function(p1, p2) -- Line: 18 -- upvalues: u12 (val), RunService (val)
    local u5 = p1:Value(p2 or 0)
    local u6 = true
    local v1 = u12
    local v2 = RunService
    local Heartbeat = v2.Heartbeat
    v1(p1, Heartbeat, function(p1_2) -- Line: 22 -- upvalues: u6 (ref), u5 (val), p1 (val)
        if u6 then
            local v1 = u5
            local v2 = p1
            local peek = v2.peek
            local v3 = u5
            local v4 = (peek(v3)) + p1_2
            v1:set(v4)
        end
    end)
    v1 = {}
    local v3 = {__index = u5}
    setmetatable(v1, v3)

    function v1.start(p1) -- Line: 34 -- upvalues: u6 (ref)
        u6 = true
    end

    function v1.stop(p1) -- Line: 38 -- upvalues: u6 (ref)
        u6 = false
    end

    function v1.reset(p1, p2_2) -- Line: 42 -- upvalues: u5 (val), p2 (val)
        local v1
        local v2 = u5
        if not p2_2 then
            v1 = 0
        else
            v1 = p2
            if not v1 then
                v1 = 0
            end
        end
        v2:set(v1)
    end

    return v1
end