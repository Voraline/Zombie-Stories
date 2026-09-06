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
    local u12 = nil
    if v1 then
        u8 = u6:innerScope()
        u17(u6, p3, u8)
    end
end