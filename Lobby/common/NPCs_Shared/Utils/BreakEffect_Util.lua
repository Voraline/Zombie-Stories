local RunService = game:GetService("RunService")
return function(p1, p2) -- Line: 3 -- upvalues: RunService (val)
    local BindableEvent = Instance.new("BindableEvent")
    local CFrame = p1.CFrame
    local u6 = nil
    local u8 = os.clock()
    local u13 = math.random(-5, 5)
    local u17 = math.random(-5, 5)
    local v1 = RunService
    v1 = v1.RenderStepped:Connect(function(p1_2) -- Line: 9
        -- upvalues: u8 (val), CFrame (ref), p1 (val), u13 (val), u17 (val), p2 (val), BindableEvent (ref), u6 (ref)
        local v1 = os.clock() - u8
        local v2 = -v1 ^ 3 * 35 + 8 * v1
        local v3 = CFrame.new(0, v2, v1)
        local v4 = CFrame
        local v5 = v3:ToWorldSpace(v4)
        local v6 = p1
        v6.CFrame = v5 * CFrame.Angles(v1 * u13, -v1 * u17, 0)
        if 2 <= v1 or not p2.Parent then
            if BindableEvent then
                BindableEvent:Fire()
                BindableEvent:Destroy()
                BindableEvent = nil
            end
            if u6 then
                u6:Disconnect()
                u6 = nil
            end
            CFrame = nil
        end
    end)
    return BindableEvent.Event
end