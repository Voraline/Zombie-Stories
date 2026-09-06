local RunService = game:GetService("RunService")
require("./types/fusion")
local u12 = require(script.Parent["use-event-listener"])
return function(p1, p2) -- Line: 18 -- upvalues: u12 (val), RunService (val)
    local u5 = p1:Value(p2 or 0)
    local u6 = true
    u12(p1, RunService.Heartbeat, function(a1) -- Line: 22 -- upvalues: u6 (ref), u5 (val), p1 (val)
        if u6 then
            u5:set(p1.peek(u5) + a1)
        end
    end)
    local v1 = {}
    setmetatable(v1, {__index = u5})
    function v1.start(p1) -- Line: 34 -- upvalues: u6 (ref)
        u6 = true
    end
    function v1.stop(p1) -- Line: 38 -- upvalues: u6 (ref)
        u6 = false
    end
    function v1.reset(p1, a2) -- Line: 42 -- upvalues: u5 (val), p2 (val)
        local v1
        if not a2 then
            v1 = 0
        else
            v1 = p2
            if not v1 then
                v1 = 0
            end
        end
        u5:set(v1)
    end
    return v1
end