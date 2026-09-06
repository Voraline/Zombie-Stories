local TweenService = game:GetService("TweenService")
local DashLineTemplate = script.Parent:WaitForChild("DashLineTemplate")
local Parent = script.Parent
local DashLineFrame = Parent:WaitForChild("DashLineFrame")
local u18 = Random.new()
local function chooseEdgePoint(p1, p2) -- Line: 7 -- upvalues: u18 (val)
    local v1, v2, v3
    local v4 = u18:NextInteger(1, p1 * 2 + p2 * 2)
    local v5 = 4
    local v6 = 1
    v2, v1 = p2, p1
    for i = 1, v5, v6 do
        if i % 2 ~= 0 then
            v3 = v1
        else
            v3 = v2
        end
        if v4 <= v3 then
            if i == 1 then
                return Vector2.new(v4, 0)
            end
            if i == 2 then
                return Vector2.new(v1, v4)
            end
            if i == 3 then
                return Vector2.new(v1 - v4, v2)
            end
            return Vector2.new(0, v2 - v4)
        end
        v4 = v4 - v3
    end
end
local u24 = TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
game:GetService("RunService").RenderStepped:Connect(function() -- Line: 40 -- upvalues: Parent (val), DashLineTemplate (val), chooseEdgePoint (val), u18 (val), DashLineFrame (val), TweenService (val), u24 (val)
    if script.Parent.On.Value then
        local X = Parent.AbsoluteSize.X
        local Y = Parent.AbsoluteSize.Y
        local u13 = DashLineTemplate:Clone()
        local v1 = chooseEdgePoint(X, Y)
        local v2 = v1 - Vector2.new(X * 0.5, Y * 0.5)
        local Unit = v2.Unit
        u13.Rotation = math.deg((math.atan2(v2.Y, v2.X))) - 90
        local v3 = v2.Magnitude * 0.5 * u18:NextNumber(0.7, 1.3)
        u13.Size = UDim2.new(0, v3 * 0.05, 0, v3)
        local v4 = v1 - Unit * v3 * 0.4
        local v5 = v1 + Unit * v3 * 0.4
        u13.Position = UDim2.new(0, v4.X, 0, v4.Y)
        u13.Parent = DashLineFrame
        local v6 = {ImageTransparency = 0.3, Position = UDim2.new(0, v1.X, 0, v1.Y)}
        local u66 = {ImageTransparency = 1, Position = UDim2.new(0, v5.X, 0, v5.Y)}
        local v7 = TweenService:Create(u13, u24, v6)
        v7:Play()
        v7.Completed:Connect(function() -- Line: 65 -- upvalues: TweenService (upval), u13 (val), u24 (upval), u66 (val)
            local v1 = TweenService:Create(u13, u24, u66)
            v1:Play()
            v1.Completed:Connect(function() -- Line: 68 -- upvalues: u13 (upval)
                u13:Destroy()
            end)
        end)
    end
end)