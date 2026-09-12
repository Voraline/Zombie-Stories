local TweenService = game:GetService("TweenService")
local DashLineTemplate = script.Parent:WaitForChild("DashLineTemplate")
local Parent = script.Parent
local DashLineFrame = Parent:WaitForChild("DashLineFrame")
local u18 = Random.new()

local function chooseEdgePoint(p1, p2) -- Line: 7 -- upvalues: u18 (val)
    local v1
    local v2 = p1 * 2 + p2 * 2
    local v3 = u18:NextInteger(1, v2)
    local v4, v5 = p2, p1
    for i = 1, 4 do
        if i % 2 ~= 0 then
            v1 = v5
        else
            v1 = v4
        end
        if v3 <= v1 then
            if i == 1 then
                return Vector2.new(v3, 0)
            end
            if i == 2 then
                return Vector2.new(v5, v3)
            end
            if i == 3 then
                return Vector2.new(v5 - v3, v4)
            end
            return Vector2.new(0, v4 - v3)
        end
        v3 = v3 - v1
    end
end

local u24 = TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
;(game:GetService("RunService")).RenderStepped:Connect(function() -- Line: 40
    -- upvalues: Parent (val), DashLineTemplate (val), chooseEdgePoint (val), u18 (val), DashLineFrame (val)
    -- upvalues: TweenService (val), u24 (val)
    if script.Parent.On.Value then
        local X = Parent.AbsoluteSize.X
        local Y = Parent.AbsoluteSize.Y
        local u13 = DashLineTemplate:Clone()
        local v1 = chooseEdgePoint(X, Y)
        local v2 = v1 - Vector2.new(X * 0.5, Y * 0.5)
        local Unit = v2.Unit
        local Y_2 = v2.Y
        local X_2 = v2.X
        local v3 = math.atan2(Y_2, X_2)
        u13.Rotation = math.deg(v3) - 90
        local v4 = v2.Magnitude * 0.5 * u18:NextNumber(0.7, 1.3)
        u13.Size = UDim2.new(0, v4 * 0.05, 0, v4)
        local v5 = v1 - Unit * v4 * 0.4
        v3 = v1 + Unit * v4 * 0.4
        u13.Position = UDim2.new(0, v5.X, 0, v5.Y)
        u13.Parent = DashLineFrame
        local v6 = {ImageTransparency = 0.3, Position = UDim2.new(0, v1.X, 0, v1.Y)}
        local u66 = {ImageTransparency = 1}
        u66.Position = UDim2.new(0, v3.X, 0, v3.Y)
        local v7 = TweenService
        local v8 = u24
        v7 = v7:Create(u13, v8, v6)
        v7:Play()
        v7.Completed:Connect(function() -- Line: 65 -- upvalues: TweenService (upval), u13 (val), u24 (upval), u66 (val)
            local v1 = TweenService
            local v2 = u13
            local v3 = u24
            local v4 = u66
            v1 = v1:Create(v2, v3, v4)
            v1:Play()
            v1.Completed:Connect(function() -- Line: 68 -- upvalues: u13 (upval)
                u13:Destroy()
            end)
        end)
    end
end)