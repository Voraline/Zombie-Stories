local u2 = require("./utils/finder")
require("./types/fusion")
require("./types/ripple")
local u14 = require(script.Parent.utils["lock-value"])
local u19 = require(script.Parent["use-event-listener"])
local RunService = game:GetService("RunService")
return function(p1, p2) -- Line: 16 -- upvalues: u2 (val), u19 (val), RunService (val), u14 (val)
    local v1 = u2.find(u2.libraries.ripple, "useMotion")
    local peek = p1.peek
    local u12 = v1.createMotion(p2)
    local u16 = p1:Value(p2)
    u19(p1, RunService.Heartbeat, function(p1) -- Line: 26 -- upvalues: u12 (val), peek (val), u16 (val)
        local v1 = u12:step(p1)
        if v1 ~= peek(u16) then
            u16:set(v1)
        end
    end)
    local v2 = u14(u16)
    return v2, u12
end