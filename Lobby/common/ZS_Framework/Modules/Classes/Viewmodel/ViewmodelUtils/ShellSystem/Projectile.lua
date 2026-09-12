local RunService = game:GetService("RunService")
local u5 = {}
u5.__index = u5

function u5.new(p1, p2, p3) -- Line: 21 -- upvalues: u5 (val), RunService (val)
    local v1 = u5
    local u6 = setmetatable({}, v1)
    u6.Instance = p1
    local Velocity = p3
    if Velocity then
        Velocity = p3.Velocity
    end
    u6.Velocity = Velocity
    u6.AngularDisplacement = 0
    local v2 = p2 or {}
    u6.CollisionIgnoreList = v2
    v2 = p3 or {}
    u6.Parameters = v2
    local CollisionIgnoreList = u6.CollisionIgnoreList
    table.insert(CollisionIgnoreList, p1)
    v2 = RunService
    v2.Heartbeat:Connect(function(p1) -- Line: 36 -- upvalues: u6 (val)
        u6:step(p1)
    end)
    return u6
end

function u5:reflect(p2) -- Line: 42
    local Direction = self.Parameters.Direction
    self.Velocity = self.Velocity / 2
    return Direction - 2 * Direction:Dot(p2) * p2
end

function u5:detectCollision(p2) -- Line: 55
    local v1 = RaycastParams.new()
    v1.FilterDescendantsInstances = self.CollisionIgnoreList
    v1.FilterType = Enum.RaycastFilterType.Blacklist
    local v2 = workspace
    local v3 = self.Instance.Position + self.Parameters.Direction * self.Instance.Size.Y / 2
    local v4 = self.Parameters.Direction * self.Velocity * p2
    v2 = v2:Raycast(v3, v4, v1)
    if not v2 then
        local v5 = workspace
        local Position = self.Instance.Position
        local v6 = -self.Instance.Size.Y / 2
        local v7 = Vector3.new(0, v6, 0)
        v2 = v5:Raycast(Position, v7, v1)
    end
    if v2 and v2.Instance then
        return v2.Instance, v2.Position, v2.Normal
    end
end

function u5:applyGravity(p2) -- Line: 79
    local v1 = self.Parameters.Mass * workspace.Gravity * self.Parameters.GravityRate * p2
    self.AngularDisplacement = self.AngularDisplacement - v1
end

function u5:step(p2) -- Line: 90
    local v1, v2
    local Position = self.Instance.Position
    if self.Velocity <= 5 then
        return
    end
    v1, _, v2 = self:detectCollision(p2)
    if not v1 then
        self:applyGravity(p2)
    else
        local Instance = self.Instance
        Instance.CFrame = CFrame.new(self.Instance.Position, self.Instance.Position + self:reflect(v2))
    end
    self.Instance.CFrame = self.Instance.CFrame * CFrame.new(0, 0, -self.Velocity * p2)
    if -0.95 < self.Instance.CFrame.LookVector.Y then
        local Instance_2 = self.Instance
        local CFrame_2 = self.Instance.CFrame
        local Angles = CFrame.Angles
        local AngularDisplacement = self.AngularDisplacement
        Instance_2.CFrame = CFrame_2 * Angles(math.rad(AngularDisplacement), 0, 0)
    end
end

function u5.__init(p1) end

return u5