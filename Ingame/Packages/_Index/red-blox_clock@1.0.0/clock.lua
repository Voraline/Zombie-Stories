local RunService = game:GetService("RunService")
return function(p1, p2) -- Line: 3 -- upvalues: RunService (val)
    local u2 = 0
    local u3 = p1 * 10
    local v1 = RunService
    local u9 = v1.Heartbeat:Connect(function(p1_2) -- Line: 7 -- upvalues: u2 (ref), u3 (val), p2 (val), p1 (val)
        u2 = u2 + p1_2
        local v1 = u2
        if u3 < v1 then
            u2 = 0
            p2()
            return
        end
        v1 = u2
        if p1 < v1 then
            u2 = u2 - p1
            p2()
        end
    end)
    return function() -- Line: 21 -- upvalues: u9 (val)
        u9:Disconnect()
    end
end