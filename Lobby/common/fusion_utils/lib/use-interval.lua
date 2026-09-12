local RunService = game:GetService("RunService")
require("./types/fusion")
local u12 = require(script.Parent["use-event-listener"])
local u17 = require(script.Parent["use-thread"])
return function(p1, p2, p3, p4) -- Line: 14 -- upvalues: u12 (val), RunService (val), u17 (val)
    local v1
    local u6 = p1:innerScope()
    local peek = u6.peek
    local u8 = nil
    if p4 == nil then
        v1 = false
    else
        v1 = p4
    end
    local u11 = 0
    local u12_2 = nil
    local v2 = u12
    local v3 = RunService
    local Heartbeat = v3.Heartbeat
    v2 = v2(u6, Heartbeat, function(p1) -- Line: 28 -- upvalues: u11 (ref), peek (val), p2 (val), u12_2 (ref), u8 (ref), u6 (val), p3 (val)
        u11 = u11 + p1
        local v1 = peek
        local v2 = p2
        v1 = v1(v2)
        if typeof(v1) ~= "number" then
            return u12_2()
        end
        if u11 < peek(p2) then
            return
        end
        u11 = 0
        if u8 then
            u8:doCleanup()
        end
        u8 = u6:innerScope()
        p3(u8)
    end)
    if v1 then
        u8 = u6:innerScope()
        u17(u6, p3, u8)
    end
end