local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local TextService = game:GetService("TextService")
local Terrain = Workspace.Terrain
local u25 = Color3.new(1, 0, 0)
local u26 = {}
u26._defaultColor = u25

function u26.setColor(p1) -- Line: 40 -- upvalues: u26 (val)
    u26._defaultColor = p1
end

function u26.resetColor() -- Line: 47 -- upvalues: u26 (val), u25 (val)
    u26._defaultColor = u25
end

function u26.setRandomColor() -- Line: 54 -- upvalues: u26 (val)
    local v1 = u26
    v1.setColor(Color3.fromHSV(math.random(), 0.5 + 0.5 * math.random(), 1))
end

function u26.ray(p1, p2, p3, p4, p5) -- Line: 73 -- upvalues: u26 (val)
    local v1 = typeof(p1) == "Ray"
    assert(v1, "Bad typeof(ray) for Ray")
    local _defaultColor = p2
    if not _defaultColor then
        _defaultColor = u26._defaultColor
    end
    local v2 = _defaultColor
    local v3 = p3
    if not v3 then
        v3 = u26.getDefaultParent()
    end
    local v4 = v3
    local v5 = p4 or 0.2
    local v6 = p5 or 0.2
    v3 = p1.Origin + p1.Direction / 2
    local Part = Instance.new("Part")
    Part.Material = Enum.Material.ForceField
    Part.Anchored = true
    Part.Archivable = false
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.CFrame = (CFrame.new(v3, p1.Origin + p1.Direction)) * CFrame.Angles(1.5707963267948966, 0, 0)
    Part.Color = v2
    Part.Name = "DebugRay"
    Part.Shape = Enum.PartType.Cylinder
    local Magnitude = p1.Direction.Magnitude
    Part.Size = Vector3.new(v6, Magnitude, v6)
    Part.TopSurface = Enum.SurfaceType.Smooth
    Part.Transparency = 0.5
    local Part_2 = Instance.new("Part")
    Part_2.Name = "RotatedPart"
    Part_2.Anchored = true
    Part_2.Archivable = false
    Part_2.CanCollide = false
    Part_2.CanQuery = false
    Part_2.CanTouch = false
    Part_2.CastShadow = false
    Part_2.CFrame = CFrame.new(p1.Origin, p1.Origin + p1.Direction)
    Part_2.Transparency = 1
    Part_2.Size = Vector3.new(1, 1, 1)
    Part_2.Parent = Part
    local LineHandleAdornment = Instance.new("LineHandleAdornment")
    LineHandleAdornment.Name = "DrawRayLineHandleAdornment"
    LineHandleAdornment.Length = p1.Direction.Magnitude
    LineHandleAdornment.Thickness = 5 * v6
    LineHandleAdornment.ZIndex = 3
    LineHandleAdornment.Color3 = v2
    LineHandleAdornment.AlwaysOnTop = true
    LineHandleAdornment.Transparency = 0
    LineHandleAdornment.Adornee = Part_2
    LineHandleAdornment.Parent = Part_2
    local SpecialMesh = Instance.new("SpecialMesh")
    SpecialMesh.Name = "DrawRayMesh"
    SpecialMesh.Scale = Vector3.new(0, 1, 0) + Vector3.new(v5, 0, v5) / v6
    SpecialMesh.Parent = Part
    Part.Parent = v4
    return Part
end

function u26.updateRay(p1, p2, p3) -- Line: 152
    local Color = p3
    if not Color then
        Color = p1.Color
    end
    local v1 = Color
    local x = p1.Size.x
    local v2 = p2.Origin + p2.Direction / 2
    local v3 = CFrame.new(v2, p2.Origin + p2.Direction)
    p1.CFrame = v3 * CFrame.Angles(1.5707963267948966, 0, 0)
    local Magnitude = p2.Direction.Magnitude
    p1.Size = Vector3.new(x, Magnitude, x)
    p1.Color = v1
    local RotatedPart = p1:FindFirstChild("RotatedPart")
    if RotatedPart then
        RotatedPart.CFrame = CFrame.new(p2.Origin, p2.Origin + p2.Direction)
    end
    local DrawRayLineHandleAdornment = RotatedPart
    if DrawRayLineHandleAdornment then
        DrawRayLineHandleAdornment = RotatedPart:FindFirstChild("DrawRayLineHandleAdornment")
    end
    if DrawRayLineHandleAdornment then
        DrawRayLineHandleAdornment.Length = p2.Direction.Magnitude
        DrawRayLineHandleAdornment.Thickness = 5 * x
        DrawRayLineHandleAdornment.Color3 = v1
    end
end

function u26.text(p1, p2, p3) -- Line: 188 -- upvalues: Terrain (val), u26 (val)
    if typeof(p1) ~= "Vector3" then
        if typeof(p1) == "Instance" then
            return u26._textOnAdornee(p1, p2, p3)
        end
        error("Bad adornee")
        return
    end
    local Attachment = Instance.new("Attachment")
    Attachment.WorldPosition = p1
    Attachment.Parent = Terrain
    Attachment.Name = "DebugTextAttachment"
    u26._textOnAdornee(Attachment, p2, p3)
    return Attachment
end

function u26._textOnAdornee(p1, p2, p3) -- Line: 205 -- upvalues: u26 (val), TextService (val)
    local BillboardGui = Instance.new("BillboardGui")
    BillboardGui.Name = "DebugBillboardGui"
    BillboardGui.SizeOffset = Vector2.new(0, 0.5)
    BillboardGui.ExtentsOffset = Vector3.new(0, 1, 0)
    BillboardGui.AlwaysOnTop = true
    BillboardGui.Adornee = p1
    BillboardGui.StudsOffset = Vector3.new(0, 0, 0.009999999776482582)
    local Frame = Instance.new("Frame")
    Frame.Name = "Background"
    Frame.Size = UDim2.new(1, 0, 1, 0)
    Frame.Position = UDim2.new(0.5, 0, 1, 0)
    Frame.AnchorPoint = Vector2.new(0.5, 1)
    Frame.BackgroundTransparency = 0.3
    Frame.BorderSizePixel = 0
    local _defaultColor = p3
    if not _defaultColor then
        _defaultColor = u26._defaultColor
    end
    Frame.BackgroundColor3 = _defaultColor
    Frame.Parent = BillboardGui
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Text = tostring(p2)
    TextLabel.TextScaled = true
    TextLabel.TextSize = 32
    TextLabel.BackgroundTransparency = 1
    TextLabel.BorderSizePixel = 0
    TextLabel.TextColor3 = Color3.new(1, 1, 1)
    TextLabel.Size = UDim2.new(1, 0, 1, 0)
    TextLabel.Parent = Frame
    if not tonumber(p2) then
        TextLabel.Font = Enum.Font.GothamMedium
    else
        TextLabel.Font = Enum.Font.Code
    end
    local v1 = TextService
    local Text = TextLabel.Text
    local TextSize = TextLabel.TextSize
    local Font = TextLabel.Font
    local v2 = Vector2.new(1024, 1000000)
    local TextSize_2 = v1:GetTextSize(Text, TextSize, Font, v2)
    local v3 = TextSize_2.y / TextLabel.TextSize
    local v4 = TextLabel.TextSize * 0.5
    local v5 = TextSize_2.y + 2 * v4
    local v6 = TextSize_2.x + 2 * v4
    v2 = v6 / v5
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
    UIAspectRatioConstraint.AspectRatio = v2
    UIAspectRatioConstraint.Parent = Frame
    local UIPadding = Instance.new("UIPadding")
    UIPadding.PaddingBottom = UDim.new(v4 / v5, 0)
    UIPadding.PaddingTop = UDim.new(v4 / v5, 0)
    UIPadding.PaddingLeft = UDim.new(v4 / v6, 0)
    UIPadding.PaddingRight = UDim.new(v4 / v6, 0)
    UIPadding.Parent = Frame
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(v4 / v5 / 2, 0)
    UICorner.Parent = Frame
    local v7 = v3 * 2 * 2 * 0.5
    BillboardGui.Size = UDim2.new(v7 * v2, 0, v7, 0)
    BillboardGui.Parent = p1
    return BillboardGui
end

function u26.sphere(p1, p2, p3, p4) -- Line: 294 -- upvalues: u26 (val)
    return u26.point(p1, p3, p4, p2 * 2)
end

function u26.point(p1, p2, p3, p4) -- Line: 311 -- upvalues: u26 (val)
    local Position
    if typeof(p1) ~= "CFrame" then
        Position = p1
    else
        Position = p1.Position
    end
    local v1 = typeof(Position) == "Vector3"
    assert(v1, "Bad position")
    local _defaultColor = p2
    if not _defaultColor then
        _defaultColor = u26._defaultColor
    end
    local v2 = _defaultColor
    local v3 = p3
    if not v3 then
        v3 = u26.getDefaultParent()
    end
    local v4 = p4 or 1
    local Part = Instance.new("Part")
    Part.Material = Enum.Material.ForceField
    Part.Anchored = true
    Part.Archivable = false
    Part.BottomSurface = Enum.SurfaceType.Smooth
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.CFrame = CFrame.new(Position)
    Part.Color = v2
    Part.Name = "DebugPoint"
    Part.Shape = Enum.PartType.Ball
    Part.Size = Vector3.new(v4, v4, v4)
    Part.TopSurface = Enum.SurfaceType.Smooth
    Part.Transparency = 0.5
    local SphereHandleAdornment = Instance.new("SphereHandleAdornment")
    SphereHandleAdornment.Archivable = false
    SphereHandleAdornment.Radius = v4 / 4
    SphereHandleAdornment.Color3 = v2
    SphereHandleAdornment.AlwaysOnTop = true
    SphereHandleAdornment.Adornee = Part
    SphereHandleAdornment.ZIndex = 2
    SphereHandleAdornment.Parent = Part
    Part.Parent = v3
    return Part
end

function u26.labelledPoint(p1, p2, p3, p4) -- Line: 366 -- upvalues: u26 (val)
    local Position
    if typeof(p1) ~= "CFrame" then
        Position = p1
    else
        Position = p1.Position
    end
    local v1 = u26.point(Position, p3, p4)
    u26.text(v1, p2, p3)
    return v1
end

function u26.cframe(p1) -- Line: 388 -- upvalues: u26 (val)
    local Model = Instance.new("Model")
    Model.Name = "DebugCFrame"
    local Position = p1.Position
    u26.point(Position, nil, Model, 0.1)
    local v1 = u26
    v1 = v1.ray(Ray.new(Position, p1.XVector), Color3.new(0.75, 0.25, 0.25), Model, 0.1)
    v1.Name = "XVector"
    local v2 = u26
    v2 = v2.ray(Ray.new(Position, p1.YVector), Color3.new(0.25, 0.75, 0.25), Model, 0.1)
    v2.Name = "YVector"
    local v3 = u26
    v3 = v3.ray(Ray.new(Position, p1.ZVector), Color3.new(0.25, 0.25, 0.75), Model, 0.1)
    v3.Name = "ZVector"
    Model.Parent = u26.getDefaultParent()
    return Model
end

function u26.part(p1, p2, p3, p4) -- Line: 431 -- upvalues: u26 (val)
    local v1 = false
    if typeof(p1) == "Instance" then
        v1 = p1:IsA("BasePart")
    end
    assert(v1, "Bad template")
    local v2 = p1:Clone()
    for k, v in pairs(v2:GetChildren()) do
        if not v:IsA("Mesh") then
            v:Destroy()
        else
            u26._sanitize(v)
            v:ClearAllChildren()
        end
    end
    local _defaultColor = p3
    if not _defaultColor then
        _defaultColor = u26._defaultColor
    end
    v2.Color = _defaultColor
    v2.Material = Enum.Material.ForceField
    v2.Transparency = p4 or 0.75
    v2.Name = "Debug" .. p1.Name
    v2.Anchored = true
    v2.CanCollide = false
    v2.CanQuery = false
    v2.CanTouch = false
    v2.CastShadow = false
    v2.Archivable = false
    if p2 then
        v2.CFrame = p2
    end
    u26._sanitize(v2)
    v2.Parent = u26.getDefaultParent()
    return v2
end

function u26._sanitize(p1) -- Line: 466 -- upvalues: CollectionService (val)
    for k, v in pairs(p1:GetAttributes()) do
        p1:SetAttribute(k, nil)
    end
    for k2, i in pairs(CollectionService:GetTags(p1)) do
        CollectionService:RemoveTag(p1, i)
    end
end

function u26.box(p1, p2, p3) -- Line: 488 -- upvalues: u26 (val)
    local v1
    local v2 = typeof(p2) == "Vector3"
    assert(v2, "Bad size")
    local _defaultColor = p3
    if not _defaultColor then
        _defaultColor = u26._defaultColor
    end
    local v3 = _defaultColor
    if typeof(p1) ~= "Vector3" then
        v1 = p1
    else
        v1 = CFrame.new(p1)
        if not v1 then
            v1 = p1
        end
    end
    local Part = Instance.new("Part")
    Part.Color = v3
    Part.Material = Enum.Material.ForceField
    Part.Name = "DebugPart"
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.Archivable = false
    Part.BottomSurface = Enum.SurfaceType.Smooth
    Part.TopSurface = Enum.SurfaceType.Smooth
    Part.Transparency = 0.75
    Part.Size = p2
    Part.CFrame = v1
    local BoxHandleAdornment = Instance.new("BoxHandleAdornment")
    BoxHandleAdornment.Adornee = Part
    BoxHandleAdornment.Size = p2
    BoxHandleAdornment.Color3 = v3
    BoxHandleAdornment.AlwaysOnTop = true
    BoxHandleAdornment.Transparency = 0.75
    BoxHandleAdornment.ZIndex = 1
    BoxHandleAdornment.Parent = Part
    Part.Parent = u26.getDefaultParent()
    return Part
end

function u26.region3(p1, p2) -- Line: 535 -- upvalues: u26 (val)
    return u26.box(p1.CFrame, p1.Size, p2)
end

function u26.terrainCell(p1, p2) -- Line: 551 -- upvalues: Terrain (val), u26 (val)
    local v1 = Terrain:WorldToCell(p1)
    local v2 = Terrain
    local x = v1.x
    local y = v1.y
    local z = v1.z
    v2 = v2:CellCenterToWorld(x, y, z)
    local v3 = u26
    v3 = v3.box(CFrame.new(v2), Vector3.new(4, 4, 4), p2)
    v3.Name = "DebugTerrainCell"
    return v3
end

function u26.screenPointLine(p1, p2, p3, p4) -- Line: 565 -- upvalues: u26 (val)
    local v1
    local v2 = p2 - p1
    local v3 = p1 + v2 / 2
    local Frame = Instance.new("Frame")
    Frame.Name = "DebugScreenLine"
    local fromScale = UDim2.fromScale
    local x = v2.x
    local v4 = math.abs(x)
    local y = v2.y
    Frame.Size = fromScale(v4, (math.abs(y)))
    Frame.BackgroundTransparency = 1
    Frame.Position = UDim2.fromScale(v3.x, v3.y)
    Frame.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame.BorderSizePixel = 0
    Frame.ZIndex = 10000
    Frame.Parent = p3
    if v2.magnitude == 0 then
        return Frame
    end
    if 0 < v2.y / v2.x then
        for j = 0, 25 do
            v1 = u26
            v1.screenPoint(Vector2.new(j / 25, j / 25), Frame, p4, 3)
        end
        return Frame
    end
    for i = 0, 25 do
        v1 = u26
        v1.screenPoint(Vector2.new(i / 25, 1 - i / 25), Frame, p4, 3)
    end
    return Frame
end

function u26.screenPoint(p1, p2, p3, p4) -- Line: 603
    local Frame = Instance.new("Frame")
    Frame.Name = "DebugScreenPoint"
    Frame.Size = UDim2.new(0, p4, 0, p4)
    local v1 = p3
    if not v1 then
        v1 = Color3.new(1, 0.1, 0.1)
    end
    Frame.BackgroundColor3 = v1
    Frame.BackgroundTransparency = 0.5
    Frame.Position = UDim2.fromScale(p1.x, p1.y)
    Frame.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame.BorderSizePixel = 0
    Frame.ZIndex = 20000
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0.5, 0)
    UICorner.Parent = Frame
    Frame.Parent = p2
    return Frame
end

function u26.vector(p1, p2, p3, p4, p5) -- Line: 636 -- upvalues: u26 (val)
    local v1 = u26
    return v1.ray(Ray.new(p1, p2), p3, p4, p5)
end

function u26.ring(p1, p2, p3, p4, p5) -- Line: 654 -- upvalues: u26 (val)
    local v1, v2, v3, v4, v5
    local v6 = CFrame.new(p1, p1 + p2)
    local v7 = {}
    for i = 0, 6.283185307179586, 0.39269908169872414 do
        v1 = math.cos(i) * p3
        v2 = (math.sin(i)) * p3
        v5 = Vector3.new(v1, v2, 0)
        v3 = v6:pointToWorldSpace(v5)
        table.insert(v7, v3)
    end
    local Folder = Instance.new("Folder")
    Folder.Name = "DebugRing"
    local v8 = #v7
    for j = 1, v8 do
        v2 = v7[j]
        v3 = v7[j % #v7 + 1]
        v4 = Ray.new(v2, v3 - v2)
        u26.ray(v4, p4, Folder)
    end
    v8 = p5
    if not v8 then
        v8 = u26.getDefaultParent()
    end
    Folder.Parent = v8
    return Folder
end

function u26.getDefaultParent() -- Line: 684 -- upvalues: RunService (val), Workspace (val)
    if not RunService:IsRunning() then
        return Workspace.CurrentCamera
    end
    if RunService:IsServer() then
        return Workspace
    end
    return Workspace.CurrentCamera
end

return u26