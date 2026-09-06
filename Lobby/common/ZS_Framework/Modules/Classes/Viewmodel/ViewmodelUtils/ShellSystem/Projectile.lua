local RunService = game:GetService("RunService")
local u5 = {}
u5.__index = u5
function u5.new(p1, p2, p3) -- Line: 21 -- upvalues: u5 (val), RunService (val)
    local u6 = setmetatable({}, u5)
    u6.Instance = p1
    local Velocity = p3
    if Velocity then
        Velocity = p3.Velocity
    end
    u6.Velocity = Velocity
    u6.AngularDisplacement = 0
    local v1 = p2
    if not v1 then
        v1 = {}
    end
    u6.CollisionIgnoreList = v1
    v1 = p3
    if not v1 then
        v1 = {}
    end
    u6.Parameters = v1
    table.insert(u6.CollisionIgnoreList, p1)
    RunService.Heartbeat:Connect(function(p1) -- Line: 36 -- upvalues: u6 (val)
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
    local v2 = workspace:Raycast(self.Instance.Position + self.Parameters.Direction * self.Instance.Size.Y / 2, self.Parameters.Direction * self.Velocity * p2, v1)
    if not v2 then
        local v3 = Vector3.new(0, -self.Instance.Size.Y / 2, 0)
        v2 = workspace:Raycast(self.Instance.Position, v3, v1)
    end
    if not v2 then
        return
    end
    if v2.Instance then
        return v2.Instance, v2.Position, v2.Normal
    end
end
function u5:applyGravity(p2) -- Line: 79
    self.AngularDisplacement = self.AngularDisplacement - self.Parameters.Mass * workspace.Gravity * self.Parameters.GravityRate * p2
end
function u5:step(p2) -- Line: 90
    local Instance, v1, v2
    if self.Velocity <= 5 then
        return
    end
    v1, _, v2 = self:detectCollision(p2)
    if not v1 then
        self:applyGravity(p2)
    else
        Instance = self.Instance
        Instance.CFrame = CFrame.new(self.Instance.Position, self.Instance.Position + self:reflect(v2))
    end
    self.Instance.CFrame = self.Instance.CFrame * CFrame.new(0, 0, -self.Velocity * p2)
    if -0.95 < self.Instance.CFrame.LookVector.Y then
        local v3 = math.rad(self.AngularDisplacement)
        self.Instance.CFrame = self.Instance.CFrame * CFrame.Angles(v3, 0, 0)
    end
end
function u5.__init(p1) end
return u5