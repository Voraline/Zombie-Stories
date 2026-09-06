local u0 = {
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
}
local u9 = {
    0,
    1,
    3,
    4,
    5,
    7,
}
local u16 = {
    0,
    1,
    4,
    5,
    6,
}
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
    local v1, v2
    local v3 = {}
    for k, v in pairs(p3) do
        v1 = math.floor(v / 4) % 2 * 2 - 1
        v2 = math.floor(v / 2) % 2 * 2 - 1
        v3[v + 1] = p1 * (p2 * Vector3.new(v1, v2, 2 * (v % 2) - 1))
    end
    return v3
end
local function getModelPointCloud(p1) -- Line: 34 -- upvalues: u9 (val), u16 (val), u0 (val), getCorners (val)
    local v1, v2
    local v3 = {}
    for i, j in p1:QueryDescendants("BasePart") do
        if j:IsA("WedgePart") then
            v1 = u9
        elseif not (j:IsA("CornerWedgePart")) then
            v1 = u0
        else
            v1 = u16
        end
        v2 = getCorners(j.CFrame, j.Size / 2, v1)
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
    local v1 = setmetatable({}, u22)
    v1.Model = nil
    v1.ViewportFrame = p1
    v1.Camera = p2
    v1._points = {}
    v1._modelCFrame = CFrame.new()
    v1._modelSize = Vector3.new()
    v1._modelRadius = 0
    v1._viewport = {}
    v1:Calibrate()
    return v1
end
function u22.SetModel(p1, p2) -- Line: 89 -- upvalues: getModelPointCloud (val)
    local BoundingBox, BoundingBox_2
    p1.Model = p2
    BoundingBox, BoundingBox_2 = p2:GetBoundingBox()
    p1._points = getModelPointCloud(p2)
    p1._modelCFrame = BoundingBox
    p1._modelSize = BoundingBox_2
    p1._modelRadius = BoundingBox_2.Magnitude / 2
end
function u22:Calibrate() -- Line: 102
    local v1 = {}
    local AbsoluteSize = self.ViewportFrame.AbsoluteSize
    v1.aspect = AbsoluteSize.X / AbsoluteSize.Y
    v1.yFov2 = math.rad(self.Camera.FieldOfView / 2)
    v1.tanyFov2 = math.tan(v1.yFov2)
    v1.xFov2 = math.atan(v1.tanyFov2 * v1.aspect)
    v1.tanxFov2 = math.tan(v1.xFov2)
    v1.cFov2 = math.atan(v1.tanyFov2 * math.min(1, v1.aspect))
    v1.sincFov2 = math.sin(v1.cFov2)
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
    local v1, v2
    if not p1.Model then
        return CFrame.new()
    end
    local v3 = (p2 - p2.Position):Inverse()
    local _points = p1._points
    local v4 = {v3 * _points[1]}
    local Z = v4[1].Z
    local v5 = #_points
    local v6 = 1
    for i = 2, v5, v6 do
        v1 = v3 * _points[i]
        Z = math.min(Z, v1.Z)
        v4[i] = v1
    end
    v5, v6 = viewProjectionEdgeHits(v4, "X", Z, p1._viewport.tanxFov2)
    v2, v1 = viewProjectionEdgeHits(v4, "Y", Z, p1._viewport.tanyFov2)
    local v7 = math.max((v5 - v6) / 2 / p1._viewport.tanxFov2, (v2 - v1) / 2 / p1._viewport.tanyFov2)
    return p2 * CFrame.new((v5 + v6) / 2, (v2 + v1) / 2, Z + v7)
end
return u22