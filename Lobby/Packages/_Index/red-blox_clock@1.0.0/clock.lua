local RunService = game:GetService("RunService")
return function(p1, p2) -- Line: 3 -- upvalues: RunService (val)
    local u2 = 0
    local u3 = p1 * 10
    local u9 = RunService.Heartbeat:Connect(function(a1) -- Line: 7 -- upvalues: u2 (ref), u3 (val), p2 (val), p1 (val)
        u2 = u2 + a1
        if u3 < u2 then
            u2 = 0
            p2()
            return
        end
        if p1 < u2 then
            u2 = u2 - p1
            p2()
        end
    end)
    return function() -- Line: 21 -- upvalues: u9 (val)
        u9:Disconnect()
    end
end