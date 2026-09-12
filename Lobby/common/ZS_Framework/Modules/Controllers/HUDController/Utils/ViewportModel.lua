local u0 = {0, 1, 2, 3, 4, 5, 6, 7}
local u9 = {0, 1, 3, 4, 5, 7}
local u16 = {0, 1, 4, 5, 6}
local u22 = {}
u22.__index = u22
u22.ClassName = "ViewportModel"

local function getIndices(p1) -- Line: 13 -- upvalues: u9 (val), u16 (val), u0 (val)
    if p1:IsA("WedgePart") then
        return u9
    end
    if p1:IsA("CornerWedgePart") then
        return u16
    end
    return u0
end

local function getCorners(p1, p2, p3) -- Line: 22
    local v1, v2, v3, v4, v5, v6
    local v7 = {}
    for k, v in pairs(p3) do
        v6 = v + 1
        v4 = v / 4
        v1 = math.floor(v4) % 2 * 2 - 1
        v5 = v / 2
        v2 = math.floor(v5) % 2 * 2 - 1
        v3 = 2 * (v % 2) - 1
        v7[v6] = p1 * (p2 * Vector3.new(v1, v2, v3))
    end
    return v7
end

local function getModelPointCloud(p1) -- Line: 34 -- upvalues: u9 (val), u16 (val), u0 (val), getCorners (val)
    local v1, v2
    local v3 = {}
    for i, j in p1:QueryDescendants("BasePart") do
        if j:IsA("WedgePart") then
            v1 = u9
        elseif not j:IsA("CornerWedgePart") then
            v1 = u0
        else
            v1 = u16
        end
        v2 = getCorners
        v2 = v2(j.CFrame, j.Size / 2, v1)
        for k, v in pairs(v2) do
            table.insert(v3, v)
        end
    end
    return v3
end

local function viewProjectionEdgeHits(p1, p2, p3, p4) -- Line: 46
    local v1, v2, v3
    local v4 = (-1 / 0)
    local v5 = (1 / 0)
    for k, v in pairs(p1) do
        v1 = p4 * (p3 - v.Z)
        v2 = v[p2] + v1
        v3 = v[p2] - v1
        v4 = math.max(v4, v2, v3)
        v5 = math.min(v5, v2, v3)
    end
    return v4, v5
end

function u22.new(p1, p2) -- Line: 65 -- upvalues: u22 (val)
    local v1 = u22
    local v2 = setmetatable({}, v1)
    v2.Model = nil
    v2.ViewportFrame = p1
    v2.Camera = p2
    v2._points = {}
    v2._modelCFrame = CFrame.new()
    v2._modelSize = Vector3.new()
    v2._modelRadius = 0
    v2._viewport = {}
    v2:Calibrate()
    return v2
end

function u22.SetModel(p1, p2) -- Line: 89 -- upvalues: getModelPointCloud (val)
    p1.Model = p2
    local BoundingBox, BoundingBox_2 = p2:GetBoundingBox()
    p1._points = getModelPointCloud(p2)
    p1._modelCFrame = BoundingBox
    p1._modelSize = BoundingBox_2
    p1._modelRadius = BoundingBox_2.Magnitude / 2
end

function u22:Calibrate() -- Line: 102
    local v1 = {}
    local AbsoluteSize = self.ViewportFrame.AbsoluteSize
    v1.aspect = AbsoluteSize.X / AbsoluteSize.Y
    local v2 = self.Camera.FieldOfView / 2
    v1.yFov2 = math.rad(v2)
    local yFov2 = v1.yFov2
    v1.tanyFov2 = math.tan(yFov2)
    v2 = v1.tanyFov2 * v1.aspect
    v1.xFov2 = math.atan(v2)
    local xFov2 = v1.xFov2
    v1.tanxFov2 = math.tan(xFov2)
    local tanyFov2_2 = v1.tanyFov2
    local aspect = v1.aspect
    v2 = tanyFov2_2 * (math.min(1, aspect))
    v1.cFov2 = math.atan(v2)
    local cFov2 = v1.cFov2
    v1.sincFov2 = math.sin(cFov2)
    self._viewport = v1
end

function u22.GetFitDistance(p1, p2) -- Line: 124
    local Magnitude
    if not p2 then
        Magnitude = 0
    else
        Magnitude = (p2 - p1._modelCFrame.Position).Magnitude
        if not Magnitude then
            Magnitude = 0
        end
    end
    return (p1._modelRadius + Magnitude) / p1._viewport.sincFov2
end

function u22.GetMinimumFitCFrame(p1, p2) -- Line: 136 -- upvalues: viewProjectionEdgeHits (val)
    local Z_2, v1, v2, v3
    if not p1.Model then
        return CFrame.new()
    end
    local v4 = (p2 - p2.Position):Inverse()
    local _points = p1._points
    local v5 = {}
    v5[1] = v4 * _points[1]
    local Z = v5[1].Z
    local v6 = #_points
    for i = 2, v6 do
        v1 = v4 * _points[i]
        Z_2 = v1.Z
        Z = math.min(Z, Z_2)
        v5[i] = v1
    end
    v6, v2 = viewProjectionEdgeHits(v5, "X", Z, p1._viewport.tanxFov2)
    v3, v1 = viewProjectionEdgeHits(v5, "Y", Z, p1._viewport.tanyFov2)
    local v7 = (v6 - v2) / 2 / p1._viewport.tanxFov2
    local v8 = (v3 - v1) / 2 / p1._viewport.tanyFov2
    local v9 = math.max(v7, v8)
    local new = CFrame.new
    local v10 = (v6 + v2) / 2
    local v11 = (v3 + v1) / 2
    return p2 * new(v10, v11, Z + v9)
end

return u22