local RunService = game:GetService("RunService")
local v1 = require("./SkillTreeCamera")
local v2, v3, v4, v5 = v1.getBounds()
local u14 = v1.getTreeOrigin()
local u16 = v3 - v2 + 100
local u18 = v5 - v4 + 100
local u20 = (v3 + v2) / 2
local u22 = (v5 + v4) / 2
local u27 = Color3.fromRGB(37, 161, 255)
local u28 = {}
u28.__index = u28

function u28.new() -- Line: 67 -- upvalues: u28 (val), u20 (val), u14 (val), u22 (val), u16 (val), u18 (val), u27 (val)
    local v1
    local v2 = u28
    local v3 = setmetatable({}, v2)
    v3.circleBin = {}
    v3.circleData = {}
    v3.lineList = {}
    v3.connections = {}
    v3.running = false
    v3.grid = {}
    for i = -5, 40 do
        v3.grid[i] = {}
        for j = -5, 40 do
            v1 = v3.grid[i]
            v1[j] = {}
        end
    end
    v3.backgroundPart = Instance.new("Part")
    v3.backgroundPart.Name = "BackgroundPlaceholder"
    v3.backgroundPart.Anchored = true
    v3.backgroundPart.BottomSurface = Enum.SurfaceType.Smooth
    v3.backgroundPart.TopSurface = Enum.SurfaceType.Smooth
    local backgroundPart = v3.backgroundPart
    local new = CFrame.new
    local v4 = u20
    backgroundPart.CFrame = new(v4, u14.Y - 35, u22)
    v3.backgroundPart.CastShadow = false
    v3.backgroundPart.Color = Color3.fromRGB(63, 75, 86)
    v3.backgroundPart.Locked = true
    v3.backgroundPart.Material = Enum.Material.Neon
    local backgroundPart_2 = v3.backgroundPart
    v4 = u16
    local v5 = u18
    backgroundPart_2.Size = Vector3.new(v4, 48, v5)
    v3.surfaceGui = Instance.new("SurfaceGui")
    v3.surfaceGui.Name = "BackgroundEffect"
    v3.surfaceGui.Face = Enum.NormalId.Top
    v3.surfaceGui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
    v3.surfaceGui.PixelsPerStud = 2
    v3.surfaceGui.LightInfluence = 0
    v3.surfaceGui.Brightness = 1
    v3.surfaceGui.Parent = v3.backgroundPart
    v3.container = Instance.new("Frame")
    v3.container.Name = "Container"
    v3.container.BackgroundTransparency = 1
    v3.container.Size = UDim2.fromScale(1, 1)
    v3.container.Parent = v3.surfaceGui
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
    ImageLabel.Parent = v3.container
    v3.effectFrame = Instance.new("Frame")
    v3.effectFrame.Name = "Frame"
    v3.effectFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    v3.effectFrame.BackgroundTransparency = 1
    v3.effectFrame.Position = UDim2.fromScale(0.5, 0.5)
    v3.effectFrame.Size = UDim2.fromScale(1.5, 1.5)
    v3.effectFrame.ZIndex = 1
    v3.effectFrame.Parent = v3.container
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
    ImageLabel_2.Parent = v3.container
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
    ImageLabel_3.Parent = v3.container
    v3.lineTemplate = Instance.new("Frame")
    v3.lineTemplate.Name = "LineTemplate"
    v3.lineTemplate.AnchorPoint = Vector2.new(0.5, 0.5)
    v3.lineTemplate.BackgroundColor3 = u27
    v3.lineTemplate.BackgroundTransparency = 0.6
    v3.lineTemplate.BorderSizePixel = 0
    v3.lineTemplate.Size = UDim2.fromOffset(200, 2)
    v3.lineTemplate.Visible = false
    local Frame = Instance.new("Frame")
    Frame.Name = "fade"
    Frame.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame.BackgroundColor3 = u27
    Frame.BackgroundTransparency = 0.8
    Frame.BorderSizePixel = 0
    Frame.Position = UDim2.fromScale(0.5, 0.5)
    Frame.Size = UDim2.new(1, 0, 0, 6)
    Frame.Parent = v3.lineTemplate
    v3.circleTemplate = Instance.new("ImageLabel")
    v3.circleTemplate.Name = "CircleTemplate"
    v3.circleTemplate.AnchorPoint = Vector2.new(0.5, 0.5)
    v3.circleTemplate.BackgroundTransparency = 1
    v3.circleTemplate.BorderSizePixel = 0
    v3.circleTemplate.Image = "rbxassetid://357953997"
    v3.circleTemplate.ImageColor3 = u27
    v3.circleTemplate.ImageTransparency = 0.85
    v3.circleTemplate.Size = UDim2.fromOffset(6, 6)
    v3.circleTemplate.Visible = false
    return v3
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
    local Magnitude = (p2 - p3).Magnitude
    local v4 = p3.Y - p2.Y
    local v5 = p3.X - p2.X
    local v6 = math.atan2(v4, v5)
    v1.Position = UDim2.fromOffset(v2, v3)
    v1.Size = UDim2.fromOffset(Magnitude, 2)
    v1.Rotation = math.deg(v6)
    v1.Visible = true
    v1.BackgroundTransparency = p5 * 0.15 + 0.6
    local fade = v1:FindFirstChild("fade")
    if fade then
        fade.BackgroundTransparency = p5 * 0.1 + 0.8
    end
end

function u28:getCircle() -- Line: 242
    if not (0 < #self.circleBin) then
        return (self.circleTemplate:Clone())
    end
    local v1 = self.circleBin[#self.circleBin]
    local circleBin = self.circleBin
    local v2 = #self.circleBin
    circleBin[v2] = nil
    return v1
end

local function clampGrid(p1, p2) -- Line: 258
    return (math.clamp(p1, -5, 40)), (math.clamp(p2, -5, 40))
end

function u28:createTerminateFunctions() -- Line: 265
    local AbsoluteSize = self.surfaceGui.AbsoluteSize

    function self.side1Terminate(p1) -- Line: 269 -- upvalues: AbsoluteSize (val), self (val)
        local circleBin, v1
        local Position = p1.Position
        local Size = p1.Size
        local v2 = Position.X.Offset - Size.X.Offset / 2
        if AbsoluteSize.X < v2 then
            p1.Parent = nil
            self.circleData[p1] = nil
            v1 = self
            circleBin = v1.circleBin
            table.insert(circleBin, p1)
        else
            v2 = Position.Y.Offset + Size.Y.Offset / 2
            if v2 < 0 then
                p1.Parent = nil
                self.circleData[p1] = nil
                v1 = self
                circleBin = v1.circleBin
                table.insert(circleBin, p1)
            else
                v2 = Position.Y.Offset - Size.Y.Offset / 2
                if AbsoluteSize.Y < v2 then
                    p1.Parent = nil
                    self.circleData[p1] = nil
                    v1 = self
                    circleBin = v1.circleBin
                    table.insert(circleBin, p1)
                end
            end
        end
    end

    function self.side2Terminate(p1) -- Line: 282 -- upvalues: AbsoluteSize (val), self (val)
        local circleBin, v1
        local Position = p1.Position
        local Size = p1.Size
        local v2 = Position.Y.Offset - Size.Y.Offset / 2
        if AbsoluteSize.Y < v2 then
            p1.Parent = nil
            self.circleData[p1] = nil
            v1 = self
            circleBin = v1.circleBin
            table.insert(circleBin, p1)
        else
            v2 = Position.X.Offset + Size.X.Offset / 2
            if v2 < 0 then
                p1.Parent = nil
                self.circleData[p1] = nil
                v1 = self
                circleBin = v1.circleBin
                table.insert(circleBin, p1)
            else
                v2 = Position.X.Offset - Size.X.Offset / 2
                if AbsoluteSize.X < v2 then
                    p1.Parent = nil
                    self.circleData[p1] = nil
                    v1 = self
                    circleBin = v1.circleBin
                    table.insert(circleBin, p1)
                end
            end
        end
    end

    function self.side3Terminate(p1) -- Line: 295 -- upvalues: AbsoluteSize (val), self (val)
        local circleBin, v1
        local Position = p1.Position
        local Size = p1.Size
        local v2 = Position.X.Offset + Size.X.Offset / 2
        if v2 < 0 then
            p1.Parent = nil
            self.circleData[p1] = nil
            v1 = self
            circleBin = v1.circleBin
            table.insert(circleBin, p1)
        else
            v2 = Position.Y.Offset + Size.Y.Offset / 2
            if v2 < 0 then
                p1.Parent = nil
                self.circleData[p1] = nil
                v1 = self
                circleBin = v1.circleBin
                table.insert(circleBin, p1)
            else
                v2 = Position.Y.Offset - Size.Y.Offset / 2
                if AbsoluteSize.Y < v2 then
                    p1.Parent = nil
                    self.circleData[p1] = nil
                    v1 = self
                    circleBin = v1.circleBin
                    table.insert(circleBin, p1)
                end
            end
        end
    end

    function self.side4Terminate(p1) -- Line: 308 -- upvalues: AbsoluteSize (val), self (val)
        local circleBin, v1
        local Position = p1.Position
        local Size = p1.Size
        local v2 = Position.Y.Offset + Size.Y.Offset / 2
        if v2 < 0 then
            p1.Parent = nil
            self.circleData[p1] = nil
            v1 = self
            circleBin = v1.circleBin
            table.insert(circleBin, p1)
        else
            v2 = Position.X.Offset + Size.X.Offset / 2
            if v2 < 0 then
                p1.Parent = nil
                self.circleData[p1] = nil
                v1 = self
                circleBin = v1.circleBin
                table.insert(circleBin, p1)
            else
                v2 = Position.X.Offset - Size.X.Offset / 2
                if AbsoluteSize.X < v2 then
                    p1.Parent = nil
                    self.circleData[p1] = nil
                    v1 = self
                    circleBin = v1.circleBin
                    table.insert(circleBin, p1)
                end
            end
        end
    end
end

function u28:spawnCircle() -- Line: 324
    local v1, v2, v3, v4
    local AbsoluteSize = self.surfaceGui.AbsoluteSize
    local v5 = math.random(1, 4)
    local v6 = math.random()
    local v7 = math.random() * 50 + 50
    local v8 = math.random() * 50 + 50
    local v9 = self:getCircle()
    if v5 == 1 then
        v4 = {GX = -5}
        local new = Vector2.new
        if math.random(0, 1) ~= 0 then
            v2 = 1
        else
            v2 = -1
        end
        v4.Velocity = new(v7, v8 * v2)
        v4.LastPos = Vector2.new(-3, AbsoluteSize.Y * v6)
        v4.LastTick = tick()
        v4.Terminate = self.side1Terminate
        v4.Connected = {}
        v1 = AbsoluteSize.Y * v6 / 250
        v4.GY = math.floor(v1)
        v3 = v4
    else
        local v10
        if v5 == 2 then
            v4 = {GY = -5}
            local new_2 = Vector2.new
            if math.random(0, 1) ~= 0 then
                v10 = 1
            else
                v10 = -1
            end
            v4.Velocity = new_2(v7 * v10, v8)
            v4.LastPos = Vector2.new(AbsoluteSize.X * v6, -3)
            v4.LastTick = tick()
            v4.Terminate = self.side2Terminate
            v4.Connected = {}
            v1 = AbsoluteSize.X * v6 / 250
            v4.GX = math.floor(v1)
            v3 = v4
        elseif v5 ~= 3 then
            v4 = {GY = 40}
            local new_6 = Vector2.new
            if math.random(0, 1) ~= 0 then
                v10 = 1
            else
                v10 = -1
            end
            v4.Velocity = new_6(v7 * v10, -v8)
            v4.LastPos = Vector2.new(AbsoluteSize.X * v6, AbsoluteSize.Y + 3)
            v4.LastTick = tick()
            v4.Terminate = self.side4Terminate
            v4.Connected = {}
            v1 = AbsoluteSize.X * v6 / 250
            v4.GX = math.floor(v1)
            v3 = v4
        else
            v4 = {GX = 40}
            local new_4 = Vector2.new
            v1 = -v7
            if math.random(0, 1) ~= 0 then
                v2 = 1
            else
                v2 = -1
            end
            v4.Velocity = new_4(v1, v8 * v2)
            v4.LastPos = Vector2.new(AbsoluteSize.X + 3, AbsoluteSize.Y * v6)
            v4.LastTick = tick()
            v4.Terminate = self.side3Terminate
            v4.Connected = {}
            v1 = AbsoluteSize.Y * v6 / 250
            v4.GY = math.floor(v1)
            v3 = v4
        end
    end
    local GX = v3.GX
    local GY = v3.GY
    v4 = math.clamp(GX, -5, 40)
    v2 = math.clamp(GY, -5, 40)
    v3.GX = v4
    v3.GY = v2
    self.circleData[v9] = v3
    v9.Parent = self.effectFrame
    v9.Visible = true
end

function u28:update() -- Line: 391
    local GX, GY, LastPos, LastPos_2, Magnitude, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15
    local v16 = tick()
    local circleData = self.circleData
    local v17 = nil
    local v18 = nil
    local v19 = self
    for i, j in circleData, v17, v18 do
        v13 = v16 - j.LastTick
        v14 = j.LastPos.X + j.Velocity.X * v13
        v15 = j.LastPos.Y + j.Velocity.Y * v13
        i.Position = UDim2.fromOffset(v14, v15)
        j.LastTick = v16
        j.LastPos = Vector2.new(v14, v15)
        j.Terminate(i)
        if not i.Parent then
            v1 = v19.grid[j.GX][j.GY]
            v1[i] = nil
        else
            GX = j.GX
            GY = j.GY
            v3 = v14 / 250
            v2 = math.floor(v3)
            v4 = v15 / 250
            v3 = math.floor(v4)
            v4 = math.clamp(v2, -5, 40)
            v2 = v4
            v3 = math.clamp(v3, -5, 40)
            if GX ~= v2 or GY ~= v3 then
                v4 = v19.grid[GX][GY]
                v4[i] = nil
                j.GX = v2
                j.GY = v3
            end
            v4 = v19.grid[v2][v3]
            v4[i] = true
        end
    end
    local v20 = 1
    local circleData_2 = v19.circleData
    v18 = nil
    local v21 = nil
    for k, n in circleData_2, v18, v21 do
        table.clear(n.Connected)
        for m = -1, 1 do
            for i5 = -1, 1 do
                v6 = n.GX + m
                v7 = n.GY + i5
                v4 = math.clamp(v6, -5, 40)
                v5 = math.clamp(v7, -5, 40)
                v7 = v19.grid[v4][v5]
                v8 = nil
                v9 = nil
                for i6 in v7, v8, v9 do
                    if i6 ~= k then
                        v10 = v19.circleData[i6]
                        if v10 and not v10.Connected[k] then
                            LastPos = v10.LastPos
                            LastPos_2 = n.LastPos
                            Magnitude = (LastPos - LastPos_2).Magnitude
                            if Magnitude <= 250 then
                                n.Connected[i6] = true
                                v11 = Magnitude / 250
                                v19:drawLine(LastPos, LastPos_2, v20, v11)
                                v20 = v20 + 1
                            end
                        end
                    end
                end
            end
        end
    end
    v17 = #v19.lineList
    for i7 = v20, v17 do
        v12 = v19.lineList[i7]
        v12.Visible = false
    end
end

function u28.start(p1, p2) -- Line: 467 -- upvalues: RunService (val)
    if p1.running then
        return
    end
    p1.running = true
    local backgroundPart = p1.backgroundPart
    local v1 = p2 or workspace
    backgroundPart.Parent = v1
    task.defer(function() -- Line: 476 -- upvalues: p1 (val)
        p1:createTerminateFunctions()
    end)
    local v2 = RunService
    v2 = v2.Heartbeat:Connect(function() -- Line: 481 -- upvalues: p1 (val)
        p1:update()
    end)
    local connections = p1.connections
    table.insert(connections, v2)
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
    p1:stop()
    local circleData = p1.circleData
    local v1 = nil
    local v2 = nil
    for i in circleData, v1, v2 do
        i:Destroy()
    end
    p1.circleData = {}
    local circleBin = p1.circleBin
    v1 = nil
    v2 = nil
    for j, k in circleBin, v1, v2 do
        k:Destroy()
    end
    p1.circleBin = {}
    local lineList = p1.lineList
    v1 = nil
    v2 = nil
    for n, m in lineList, v1, v2 do
        m:Destroy()
    end
    p1.lineList = {}
    local v3 = p1
    for i5 = -5, 40 do
        for i6 = -5, 40 do
            table.clear(v3.grid[i5][i6])
        end
    end
    v3.backgroundPart:Destroy()
end

return u28