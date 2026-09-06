local v1, v2, v3, v4
local RunService = game:GetService("RunService")
local v5 = require("./SkillTreeCamera")
v1, v2, v3, v4 = v5.getBounds()
local u14 = v5.getTreeOrigin()
local u16 = v2 - v1 + 100
local u18 = v4 - v3 + 100
local u20 = (v2 + v1) / 2
local u22 = (v4 + v3) / 2
local u27 = Color3.fromRGB(37, 161, 255)
local u28 = {}
u28.__index = u28
function u28.new() -- Line: 67 -- upvalues: u28 (val), u20 (val), u14 (val), u22 (val), u16 (val), u18 (val), u27 (val)
    local v1, v2, v3
    local v4 = setmetatable({}, u28)
    v4.circleBin = {}
    v4.circleData = {}
    v4.lineList = {}
    v4.connections = {}
    v4.running = false
    v4.grid = {}
    local v5 = 40
    local v6 = 1
    for i = -5, v5, v6 do
        v4.grid[i] = {}
        v1 = 40
        v2 = 1
        for j = -5, v1, v2 do
            v3 = v4.grid[i]
            v3[j] = {}
        end
    end
    v4.backgroundPart = Instance.new("Part")
    v4.backgroundPart.Name = "BackgroundPlaceholder"
    v4.backgroundPart.Anchored = true
    v4.backgroundPart.BottomSurface = Enum.SurfaceType.Smooth
    v4.backgroundPart.TopSurface = Enum.SurfaceType.Smooth
    v4.backgroundPart.CFrame = CFrame.new(u20, u14.Y - 35, u22)
    v4.backgroundPart.CastShadow = false
    v4.backgroundPart.Color = Color3.fromRGB(63, 75, 86)
    v4.backgroundPart.Locked = true
    v4.backgroundPart.Material = Enum.Material.Neon
    v4.backgroundPart.Size = Vector3.new(u16, 48, u18)
    v4.surfaceGui = Instance.new("SurfaceGui")
    v4.surfaceGui.Name = "BackgroundEffect"
    v4.surfaceGui.Face = Enum.NormalId.Top
    v4.surfaceGui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
    v4.surfaceGui.PixelsPerStud = 2
    v4.surfaceGui.LightInfluence = 0
    v4.surfaceGui.Brightness = 1
    v4.surfaceGui.Parent = v4.backgroundPart
    v4.container = Instance.new("Frame")
    v4.container.Name = "Container"
    v4.container.BackgroundTransparency = 1
    v4.container.Size = UDim2.fromScale(1, 1)
    v4.container.Parent = v4.surfaceGui
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Name = "background"
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    ImageLabel.BackgroundColor3 = Color3.fromRGB(4, 14, 34)
    ImageLabel.BorderSizePixel = 0
    ImageLabel.Image = "rbxassetid://924320031"
    ImageLabel.ImageTransparency = 1
    ImageLabel.Position = UDim2.fromScale(0.5, 0.5)
    ImageLabel.Size = UDim2.fromScale(2.5, 2.5)
    ImageLabel.ZIndex = 0
    ImageLabel.Parent = v4.container
    v4.effectFrame = Instance.new("Frame")
    v4.effectFrame.Name = "Frame"
    v4.effectFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    v4.effectFrame.BackgroundTransparency = 1
    v4.effectFrame.Position = UDim2.fromScale(0.5, 0.5)
    v4.effectFrame.Size = UDim2.fromScale(1.5, 1.5)
    v4.effectFrame.ZIndex = 1
    v4.effectFrame.Parent = v4.container
    local ImageLabel_2 = Instance.new("ImageLabel")
    ImageLabel_2.Name = "crosstexture"
    ImageLabel_2.AnchorPoint = Vector2.new(0.5, 0.5)
    ImageLabel_2.BackgroundTransparency = 1
    ImageLabel_2.BorderSizePixel = 0
    ImageLabel_2.Image = "rbxassetid://1826269153"
    ImageLabel_2.ImageColor3 = Color3.fromRGB(17, 57, 118)
    ImageLabel_2.ImageTransparency = 0.8
    ImageLabel_2.Position = UDim2.fromScale(0.5, 0.5)
    ImageLabel_2.ScaleType = Enum.ScaleType.Tile
    ImageLabel_2.Size = UDim2.fromScale(2.5, 2.5)
    ImageLabel_2.TileSize = UDim2.fromOffset(20, 20)
    ImageLabel_2.ZIndex = 2
    ImageLabel_2.Parent = v4.container
    local ImageLabel_3 = Instance.new("ImageLabel")
    ImageLabel_3.Name = "fade"
    ImageLabel_3.AnchorPoint = Vector2.new(0.5, 0.5)
    ImageLabel_3.BackgroundTransparency = 1
    ImageLabel_3.BorderSizePixel = 0
    ImageLabel_3.Image = "rbxassetid://1826269005"
    ImageLabel_3.ImageColor3 = Color3.fromRGB(115, 183, 255)
    ImageLabel_3.ImageTransparency = 0.75
    ImageLabel_3.Position = UDim2.fromScale(0.5, 0.5)
    ImageLabel_3.ScaleType = Enum.ScaleType.Fit
    ImageLabel_3.Size = UDim2.fromScale(1.5, 1.5)
    ImageLabel_3.ZIndex = 2
    ImageLabel_3.Parent = v4.container
    v4.lineTemplate = Instance.new("Frame")
    v4.lineTemplate.Name = "LineTemplate"
    v4.lineTemplate.AnchorPoint = Vector2.new(0.5, 0.5)
    v4.lineTemplate.BackgroundColor3 = u27
    v4.lineTemplate.BackgroundTransparency = 0.6
    v4.lineTemplate.BorderSizePixel = 0
    v4.lineTemplate.Size = UDim2.fromOffset(200, 2)
    v4.lineTemplate.Visible = false
    local Frame = Instance.new("Frame")
    Frame.Name = "fade"
    Frame.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame.BackgroundColor3 = u27
    Frame.BackgroundTransparency = 0.8
    Frame.BorderSizePixel = 0
    Frame.Position = UDim2.fromScale(0.5, 0.5)
    Frame.Size = UDim2.new(1, 0, 0, 6)
    Frame.Parent = v4.lineTemplate
    v4.circleTemplate = Instance.new("ImageLabel")
    v4.circleTemplate.Name = "CircleTemplate"
    v4.circleTemplate.AnchorPoint = Vector2.new(0.5, 0.5)
    v4.circleTemplate.BackgroundTransparency = 1
    v4.circleTemplate.BorderSizePixel = 0
    v4.circleTemplate.Image = "rbxassetid://357953997"
    v4.circleTemplate.ImageColor3 = u27
    v4.circleTemplate.ImageTransparency = 0.85
    v4.circleTemplate.Size = UDim2.fromOffset(6, 6)
    v4.circleTemplate.Visible = false
    return v4
end
function u28:getLine(p2) -- Line: 207
    local v1 = self.lineList[p2]
    if not v1 then
        v1 = self.lineTemplate:Clone()
        v1.Parent = self.effectFrame
        self.lineList[p2] = v1
    end
    return v1
end
function u28:drawLine(p2, p3, p4, p5) -- Line: 220
    local v1 = self:getLine(p4)
    local v2 = (p2.X + p3.X) * 0.5
    local v3 = (p2.Y + p3.Y) * 0.5
    local v4 = math.atan2(p3.Y - p2.Y, p3.X - p2.X)
    v1.Position = UDim2.fromOffset(v2, v3)
    v1.Size = UDim2.fromOffset((p2 - p3).Magnitude, 2)
    v1.Rotation = math.deg(v4)
    v1.Visible = true
    v1.BackgroundTransparency = p5 * 0.15 + 0.6
    local fade = v1:FindFirstChild("fade")
    if fade then
        fade.BackgroundTransparency = p5 * 0.1 + 0.8
    end
end
function u28:getCircle() -- Line: 242
    local v1 = #self.circleBin
    if 0 >= v1 then
        return (self.circleTemplate:Clone())
    end
    local v2 = self.circleBin[#self.circleBin]
    self.circleBin[#self.circleBin] = nil
    return v2
end
local function clampGrid(p1, p2) -- Line: 258
    local v1 = math.clamp(p1, -5, 40)
    return v1, (math.clamp(p2, -5, 40))
end
function u28:createTerminateFunctions() -- Line: 265
    local AbsoluteSize = self.surfaceGui.AbsoluteSize
    function self.side1Terminate(p1) -- Line: 269 -- upvalues: AbsoluteSize (val), self (val)
        local Position = p1.Position
        local Size = p1.Size
        local v1 = Position.X.Offset - Size.X.Offset / 2
        if AbsoluteSize.X < v1 then
            p1.Parent = nil
            self.circleData[p1] = nil
            table.insert(self.circleBin, p1)
        else
            v1 = Position.Y.Offset + Size.Y.Offset / 2
            if v1 < 0 then
                p1.Parent = nil
                self.circleData[p1] = nil
                table.insert(self.circleBin, p1)
            else
                v1 = Position.Y.Offset - Size.Y.Offset / 2
                if AbsoluteSize.Y < v1 then
                    p1.Parent = nil
                    self.circleData[p1] = nil
                    table.insert(self.circleBin, p1)
                end
            end
        end
    end
    function self.side2Terminate(p1) -- Line: 282 -- upvalues: AbsoluteSize (val), self (val)
        local Position = p1.Position
        local Size = p1.Size
        local v1 = Position.Y.Offset - Size.Y.Offset / 2
        if AbsoluteSize.Y < v1 then
            p1.Parent = nil
            self.circleData[p1] = nil
            table.insert(self.circleBin, p1)
        else
            v1 = Position.X.Offset + Size.X.Offset / 2
            if v1 < 0 then
                p1.Parent = nil
                self.circleData[p1] = nil
                table.insert(self.circleBin, p1)
            else
                v1 = Position.X.Offset - Size.X.Offset / 2
                if AbsoluteSize.X < v1 then
                    p1.Parent = nil
                    self.circleData[p1] = nil
                    table.insert(self.circleBin, p1)
                end
            end
        end
    end
    function self.side3Terminate(p1) -- Line: 295 -- upvalues: AbsoluteSize (val), self (val)
        local Position = p1.Position
        local Size = p1.Size
        local v1 = Position.X.Offset + Size.X.Offset / 2
        if v1 < 0 then
            p1.Parent = nil
            self.circleData[p1] = nil
            table.insert(self.circleBin, p1)
        else
            v1 = Position.Y.Offset + Size.Y.Offset / 2
            if v1 < 0 then
                p1.Parent = nil
                self.circleData[p1] = nil
                table.insert(self.circleBin, p1)
            else
                v1 = Position.Y.Offset - Size.Y.Offset / 2
                if AbsoluteSize.Y < v1 then
                    p1.Parent = nil
                    self.circleData[p1] = nil
                    table.insert(self.circleBin, p1)
                end
            end
        end
    end
    function self.side4Terminate(p1) -- Line: 308 -- upvalues: AbsoluteSize (val), self (val)
        local Position = p1.Position
        local Size = p1.Size
        local v1 = Position.Y.Offset + Size.Y.Offset / 2
        if v1 < 0 then
            p1.Parent = nil
            self.circleData[p1] = nil
            table.insert(self.circleBin, p1)
        else
            v1 = Position.X.Offset + Size.X.Offset / 2
            if v1 < 0 then
                p1.Parent = nil
                self.circleData[p1] = nil
                table.insert(self.circleBin, p1)
            else
                v1 = Position.X.Offset - Size.X.Offset / 2
                if AbsoluteSize.X < v1 then
                    p1.Parent = nil
                    self.circleData[p1] = nil
                    table.insert(self.circleBin, p1)
                end
            end
        end
    end
end
function u28:spawnCircle() -- Line: 324
    local v1, v2, v3
    local AbsoluteSize = self.surfaceGui.AbsoluteSize
    local v4 = math.random(1, 4)
    local v5 = math.random()
    local v6 = math.random() * 50 + 50
    local v7 = math.random() * 50 + 50
    local v8 = self:getCircle()
    if v4 == 1 then
        v3 = {GX = -5}
        if math.random(0, 1) ~= 0 then
            v1 = 1
        else
            v1 = -1
        end
        v3.Velocity = Vector2.new(v6, v7 * v1)
        v3.LastPos = Vector2.new(-3, AbsoluteSize.Y * v5)
        v3.LastTick = tick()
        v3.Terminate = self.side1Terminate
        v3.Connected = {}
        v3.GY = math.floor(AbsoluteSize.Y * v5 / 250)
        v2 = v3
    else
        local v9
        if v4 == 2 then
            v3 = {GY = -5}
            if math.random(0, 1) ~= 0 then
                v9 = 1
            else
                v9 = -1
            end
            v3.Velocity = Vector2.new(v6 * v9, v7)
            v3.LastPos = Vector2.new(AbsoluteSize.X * v5, -3)
            v3.LastTick = tick()
            v3.Terminate = self.side2Terminate
            v3.Connected = {}
            v3.GX = math.floor(AbsoluteSize.X * v5 / 250)
            v2 = v3
        elseif v4 ~= 3 then
            v3 = {GY = 40}
            if math.random(0, 1) ~= 0 then
                v9 = 1
            else
                v9 = -1
            end
            v3.Velocity = Vector2.new(v6 * v9, -v7)
            v3.LastPos = Vector2.new(AbsoluteSize.X * v5, AbsoluteSize.Y + 3)
            v3.LastTick = tick()
            v3.Terminate = self.side4Terminate
            v3.Connected = {}
            v3.GX = math.floor(AbsoluteSize.X * v5 / 250)
            v2 = v3
        else
            v3 = {GX = 40}
            if math.random(0, 1) ~= 0 then
                v1 = 1
            else
                v1 = -1
            end
            v3.Velocity = Vector2.new(-v6, v7 * v1)
            v3.LastPos = Vector2.new(AbsoluteSize.X + 3, AbsoluteSize.Y * v5)
            v3.LastTick = tick()
            v3.Terminate = self.side3Terminate
            v3.Connected = {}
            v3.GY = math.floor(AbsoluteSize.Y * v5 / 250)
            v2 = v3
        end
    end
    v3 = math.clamp(v2.GX, -5, 40)
    v2.GX = v3
    v2.GY = math.clamp(v2.GY, -5, 40)
    self.circleData[v8] = v2
    v8.Parent = self.effectFrame
    v8.Visible = true
end
function u28:update() -- Line: 391
    local GX, GY, LastPos, LastPos_2, Magnitude, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14
    local v15 = tick()
    local circleData = self.circleData
    local v16 = nil
    local v17 = nil
    local v18 = self
    for i, j in circleData, v16, v17 do
        v12 = v15 - j.LastTick
        v13 = j.LastPos.X + j.Velocity.X * v12
        v14 = j.LastPos.Y + j.Velocity.Y * v12
        i.Position = UDim2.fromOffset(v13, v14)
        j.LastTick = v15
        j.LastPos = Vector2.new(v13, v14)
        j.Terminate(i)
        if not i.Parent then
            v1 = v18.grid[j.GX][j.GY]
            v1[i] = nil
        else
            GX = j.GX
            GY = j.GY
            v3 = math.floor(v13 / 250)
            v5 = math.clamp(v3, -5, 40)
            v3 = v5
            v4 = math.clamp(math.floor(v14 / 250), -5, 40)
            if GX ~= v3 then
                v5 = v18.grid[GX][GY]
                v5[i] = nil
                j.GX = v3
                j.GY = v4
            elseif GY == v4 then
            end
            v5 = v18.grid[v3][v4]
            v5[i] = true
        end
    end
    local v19 = 1
    local circleData_2 = v18.circleData
    v17 = nil
    local v20 = nil
    for k, n in circleData_2, v17, v20 do
        table.clear(n.Connected)
        v13 = 1
        v14 = 1
        for m = -1, v13, v14 do
            v2 = 1
            v3 = 1
            for i5 = -1, v2, v3 do
                v7 = n.GY + i5
                v5 = math.clamp(n.GX + m, -5, 40)
                v6 = math.clamp(v7, -5, 40)
                v7 = v18.grid[v5][v6]
                v8 = nil
                v9 = nil
                for i6 in v7, v8, v9 do
                    if i6 ~= k then
                        v10 = v18.circleData[i6]
                        if v10 and not (v10.Connected[k]) then
                            LastPos = v10.LastPos
                            LastPos_2 = n.LastPos
                            Magnitude = (LastPos - LastPos_2).Magnitude
                            if Magnitude <= 250 then
                                n.Connected[i6] = true
                                v18:drawLine(LastPos, LastPos_2, v19, Magnitude / 250)
                                v19 = v19 + 1
                            end
                        end
                    end
                end
            end
        end
    end
    v16 = #v18.lineList
    v17 = 1
    for i7 = v19, v16, v17 do
        v11 = v18.lineList[i7]
        v11.Visible = false
    end
end
function u28.start(p1, p2) -- Line: 467 -- upvalues: RunService (val)
    if p1.running then
        return
    end
    p1.running = true
    local v1 = p2
    if not v1 then
        v1 = workspace
    end
    p1.backgroundPart.Parent = v1
    task.defer(function() -- Line: 476 -- upvalues: p1 (val)
        p1:createTerminateFunctions()
    end)
    local v2 = RunService.Heartbeat:Connect(function() -- Line: 481 -- upvalues: p1 (val)
        p1:update()
    end)
    table.insert(p1.connections, v2)
    task.spawn(function() -- Line: 487 -- upvalues: p1 (val)
        local v1
        while p1.running do
            v1 = math.random() * 0.15000000000000002 + 0.25
            task.wait(v1)
            if p1.running and p1.side1Terminate then
                p1:spawnCircle()
            end
        end
    end)
end
function u28:stop() -- Line: 501
    self.running = false
    local connections = self.connections
    local v1 = nil
    local v2 = nil
    for i, j in connections, v1, v2 do
        j:Disconnect()
    end
    self.connections = {}
end
function u28.destroy(p1) -- Line: 513
    local v1, v2
    p1:stop()
    local circleData = p1.circleData
    local v3 = nil
    local v4 = nil
    for i in circleData, v3, v4 do
        i:Destroy()
    end
    p1.circleData = {}
    local circleBin = p1.circleBin
    v3 = nil
    v4 = nil
    for j, k in circleBin, v3, v4 do
        k:Destroy()
    end
    p1.circleBin = {}
    local lineList = p1.lineList
    v3 = nil
    v4 = nil
    for n, m in lineList, v3, v4 do
        m:Destroy()
    end
    p1.lineList = {}
    local v5 = 40
    v3 = 1
    local v6 = p1
    for i5 = -5, v5, v3 do
        v1 = 40
        v2 = 1
        for i6 = -5, v1, v2 do
            table.clear(v6.grid[i5][i6])
        end
    end
    v6.backgroundPart:Destroy()
end
return u28