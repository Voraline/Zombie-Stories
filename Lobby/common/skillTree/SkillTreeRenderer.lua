local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local assets = require(ReplicatedStorage.common.Assets.assets)
local SkillConfig = require(ReplicatedStorage.common.skillTree.config.SkillConfig)
local layout = SkillConfig.layout
local SkillSquareGui = require(ReplicatedStorage.common.skillTree.ui.SkillSquareGui.SkillSquareGui)
local BoundingBoxOverlay = require(ReplicatedStorage.common.skillTree.ui.BoundingBoxOverlay.BoundingBoxOverlay)
local u44 = require("./SkillTreeCamera").getTreeOrigin()
local u48 = Vector2.new(4, 1)
local function getSkillIcon(p1) -- Line: 46 -- upvalues: assets (val)
    local v1, v2, v3
    local Images = assets.Images
    if Images then
        Images = assets.Images.SkillTree
    end
    if not Images then
        return nil
    end
    local v4 = p1:lower()
    local v5 = Images
    local v6 = nil
    local v7 = nil
    for i, j in v5, v6, v7 do
        if type(j) == "string" and i:lower() == v4 then
            return j
        end
        if type(j) == "table" then
            v2 = j
            v3 = nil
            v1 = nil
            for k, n in v2, v3, v1 do
                if k:lower() == v4 then
                    return n
                end
            end
        end
    end
    return nil
end
local u50 = {}
u50.__index = u50
function u50.new() -- Line: 118 -- upvalues: u50 (val), Fusion (val)
    local v1 = setmetatable({}, u50)
    v1.scope = Fusion.scoped(Fusion)
    v1.squares = {}
    v1.skillStates = {}
    v1.tierStates = {}
    v1.branchStates = {}
    v1.skillBoundingBoxes = {}
    v1.tierBoundingBoxes = {}
    v1.branchBoundingBoxes = {}
    v1.connectionLines = {}
    v1.skillConnectionLines = {}
    v1.branchConnectionLines = {}
    v1.tierConnectionLines = {}
    v1.container = Instance.new("Model")
    v1.container.Name = "SkillTreeSquares"
    v1.guiContainer = nil
    v1.onSkillClicked = nil
    return v1
end
function u50.gridToWorld(p1, p2) -- Line: 145 -- upvalues: u44 (val)
    return u44 + Vector3.new(-p1 * 65, 0, p2 * 65)
end
function u50.createSkillBoundingBox(p1, p2, p3) -- Line: 156
    local Part = Instance.new("Part")
    Part.Name = p2 .. "_BoundingBox"
    Part.Size = Vector3.new(50, 1, 50)
    Part.Position = p3 + Vector3.new(0, 6, 0)
    Part.Anchored = true
    Part.CanCollide = false
    Part.Transparency = 1
    Part.CastShadow = false
    local SurfaceGui = Instance.new("SurfaceGui")
    SurfaceGui.Name = "LockOverlay"
    SurfaceGui.Face = Enum.NormalId.Top
    SurfaceGui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
    SurfaceGui.Parent = Part
    p1.skillBoundingBoxes[p2] = Part
    return Part
end
function u50:createTierBoundingBox(p2, p3, p4) -- Line: 181 -- upvalues: layout (val), u50 (val), u44 (val), SkillConfig (val), BoundingBoxOverlay (val)
    local v1, v2, v3, v4
    if #p4 == 0 then
        return nil
    end
    local v5 = (1 / 0)
    local v6 = (-1 / 0)
    local v7 = (1 / 0)
    local v8 = (-1 / 0)
    local v9 = p4
    local v10 = nil
    local v11 = nil
    for i, j in v9, v10, v11 do
        v1 = layout.getPosition(j)
        if v1 then
            v2 = u50.gridToWorld(v1.row, v1.column)
            v5 = math.min(v5, v2.X - 25)
            v6 = math.max(v6, v2.X + 25)
            v7 = math.min(v7, v2.Z - 25)
            v8 = math.max(v8, v2.Z + 25)
        end
    end
    v5 = v5 - 1
    v6 = v6 + 1
    v7 = v7 - 1
    v8 = v8 + 1
    local v12 = p2 == "Core"
    if not v12 then
        v1 = u44.Y - 5
    else
        v1 = u44.Y - 8
    end
    local Part = Instance.new("Part")
    Part.Name = ("%*_Tier%*_BoundingBox"):format(p2, p3)
    Part.Size = Vector3.new(v6 - v5, 1, v8 - v7)
    Part.Position = Vector3.new((v5 + v6) / 2, v1, (v7 + v8) / 2)
    Part.Anchored = true
    Part.CanCollide = false
    Part.Transparency = 1
    Part.CastShadow = false
    Part.CFrame = Part.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
    local v13 = ("%*_Tier%*"):format(p2, p3)
    local v14 = ""
    if 2 <= p3 then
        local v15
        v3 = SkillConfig.getTierRequiredCount(p2, p3 - 1)
        if 1 >= v3 then
            v15 = ""
        else
            v15 = "s"
        end
        v14 = ("Upgrade %* Tier %* skill%*"):format(v3, p3 - 1, v15)
    end
    if not v12 then
        v3 = self.scope:Value(true)
    else
        v3 = nil
    end
    local v16 = {locked = self.scope:Value(true), requiresText = self.scope:Value(v14), alwaysOnTop = v3}
    self.tierStates[v13] = v16
    local v17 = {
        CornerRadius = 128,
        StrokeThickness = 50,
        scope = self.scope,
        Locked = v16.locked,
        RequiresText = v16.requiresText,
        ShowLockIcon = not v12,
    }
    if not v12 then
        v4 = v3
    else
        v4 = false
    end
    v17.AlwaysOnTop = v4
    v17.Adornee = Part
    local v18 = BoundingBoxOverlay(v17)
    v18.Parent = self.guiContainer
    self.tierBoundingBoxes[v13] = Part
    return Part
end
function u50:createAllTierBoundingBoxes() -- Line: 274 -- upvalues: layout (val)
    local v1
    local combatTiers = layout.combatTiers
    local v2 = nil
    local v3 = nil
    for i, j in combatTiers, v2, v3 do
        v1 = self:createTierBoundingBox("Combat", i, j)
        if v1 then
            v1.Parent = self.container
        end
    end
    local survivalTiers = layout.survivalTiers
    v2 = nil
    v3 = nil
    for k, n in survivalTiers, v2, v3 do
        v1 = self:createTierBoundingBox("Survival", k, n)
        if v1 then
            v1.Parent = self.container
        end
    end
    local v4 = self:createTierBoundingBox("Core", 0, layout.coreTiers[1])
    if v4 then
        v4.Parent = self.container
    end
end
function u50:createBranchBoundingBox(p2, p3) -- Line: 301 -- upvalues: layout (val), u50 (val), u44 (val), SkillConfig (val), BoundingBoxOverlay (val)
    local v1, v2, v3, v4, v5, v6, v7, v8
    local v9 = {}
    local v10 = p3
    local v11 = nil
    local v12 = nil
    for i, j in v10, v11, v12 do
        v8 = j
        v3 = nil
        v4 = nil
        for k, n in v8, v3, v4 do
            table.insert(v9, n)
        end
    end
    if #v9 == 0 then
        return nil
    end
    v10 = (1 / 0)
    v11 = (-1 / 0)
    v12 = (1 / 0)
    local v13 = (-1 / 0)
    local v14 = v9
    v8 = nil
    v3 = nil
    for m, i5 in v14, v8, v3 do
        v5 = layout.getPosition(i5)
        if v5 then
            v6 = u50.gridToWorld(v5.row, v5.column)
            v10 = math.min(v10, v6.X - 25)
            v11 = math.max(v11, v6.X + 25)
            v12 = math.min(v12, v6.Z - 25)
            v13 = math.max(v13, v6.Z + 25)
        end
    end
    v10 = v10 - 6
    v11 = v11 + 6
    v12 = v12 - 6
    v13 = v13 + 6
    local Part = Instance.new("Part")
    Part.Name = ("%*_BoundingBox"):format(v2)
    Part.Size = Vector3.new(v11 - v10, 1, v13 - v12)
    Part.Position = Vector3.new((v10 + v11) / 2, u44.Y - 8, (v12 + v13) / 2)
    Part.Anchored = true
    Part.CanCollide = false
    Part.Transparency = 1
    Part.CastShadow = false
    Part.CFrame = Part.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
    v5 = {locked = v1.scope:Value(true)}
    v1.branchStates[v2] = v5
    v6 = ""
    local v15 = layout.coreTiers[1]
    if v2 == "Combat" then
        local name
        v7 = SkillConfig.getSkill(v15[3])
        if not v7 then
            name = "Core 3"
        else
            name = v7.name
            if not name then
                name = "Core 3"
            end
        end
        v6 = ("Unlock %* to access the Combat tree"):format(name)
    elseif v2 == "Survival" then
        local name_2
        v7 = SkillConfig.getSkill(v15[2])
        if not v7 then
            name_2 = "Core 2"
        else
            name_2 = v7.name
            if not name_2 then
                name_2 = "Core 2"
            end
        end
        v6 = ("Unlock %* to access the Survival tree"):format(name_2)
    end
    v7 = BoundingBoxOverlay({
        CornerRadius = 255,
        StrokeThickness = 100,
        ZOffset = 25,
        scope = v1.scope,
        Locked = v5.locked,
        RequiresText = v6,
        TextMaxSize = Vector2.new(5000, 1000),
        Adornee = Part,
    })
    v7.Parent = v1.guiContainer
    v1.branchBoundingBoxes[v2] = Part
    return Part
end
function u50:createAllBranchBoundingBoxes() -- Line: 394 -- upvalues: layout (val)
    local v1 = self:createBranchBoundingBox("Combat", layout.combatTiers)
    if v1 then
        v1.Parent = self.container
    end
    local v2 = self:createBranchBoundingBox("Survival", layout.survivalTiers)
    if v2 then
        v2.Parent = self.container
    end
end
function u50:createLine(p2, p3, p4, p5, p6) -- Line: 412 -- upvalues: u48 (val)
    local Attachment = Instance.new("Attachment")
    Attachment.Name = "LineStart"
    Attachment.Parent = p2
    local Attachment_2 = Instance.new("Attachment")
    Attachment_2.Name = "LineEnd"
    Attachment_2.Parent = p4
    Attachment.WorldPosition = Vector3.new(p3.X, p2.Position.Y, p3.Z)
    Attachment_2.WorldPosition = Vector3.new(p5.X, p4.Position.Y, p5.Z)
    local RopeConstraint = Instance.new("RopeConstraint")
    RopeConstraint.Name = "ConnectionLine"
    RopeConstraint.Attachment0 = Attachment
    RopeConstraint.Attachment1 = Attachment_2
    RopeConstraint.Visible = true
    RopeConstraint.Thickness = u48.X
    local v1 = p6
    if not v1 then
        v1 = Color3.fromRGB(100, 100, 100)
    end
    RopeConstraint.Color = BrickColor.new(v1)
    RopeConstraint.Parent = p2
    table.insert(self.connectionLines, RopeConstraint)
    return RopeConstraint
end
function u50.getTierCenter(p1, p2, p3) -- Line: 450
    local v1 = ("%*_Tier%*"):format(p2, p3)
    local v2 = p1.tierBoundingBoxes[v1]
    if v2 then
        return v2.Position
    end
    return nil
end
function u50:getTierEdge(p2, p3, p4) -- Line: 463
    local v1 = ("%*_Tier%*"):format(p2, p3)
    local v2 = self.tierBoundingBoxes[v1]
    if not v2 then
        return nil
    end
    local Position = v2.Position
    local Size = v2.Size
    if p4 == "left" then
        return Position + Vector3.new(0, 0, -Size.Z / 2)
    end
    if p4 == "right" then
        return Position + Vector3.new(0, 0, Size.Z / 2)
    end
    if p4 == "top" then
        return Position + Vector3.new(Size.X / 2, 0, 0)
    end
    if p4 == "bottom" then
        return Position + Vector3.new(-Size.X / 2, 0, 0)
    end
    return Position
end
function u50:getBranchEdge(p2, p3) -- Line: 495
    local v1 = self.branchBoundingBoxes[p2]
    if not v1 then
        return nil
    end
    local Position = v1.Position
    local Size = v1.Size
    if p3 == "left" then
        return Position + Vector3.new(0, 0, -Size.Z / 2)
    end
    if p3 == "right" then
        return Position + Vector3.new(0, 0, Size.Z / 2)
    end
    if p3 == "top" then
        return Position + Vector3.new(Size.X / 2, 0, 0)
    end
    if p3 == "bottom" then
        return Position + Vector3.new(-Size.X / 2, 0, 0)
    end
    return Position
end
function u50:createAllConnectionLines() -- Line: 521 -- upvalues: u44 (val), layout (val), u50 (val)
    local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10
    local v11 = u44.Y + -4
    local v12 = Color3.fromRGB(0, 0, 0)
    local v13 = Color3.fromRGB(0, 0, 0)
    local v14 = layout.coreTiers[1]
    local v15 = layout.getPosition(v14[2])
    local v16 = layout.getPosition(v14[3])
    local v17 = self:getTierBoundingBox("Core", 0)
    local v18 = self:getBranchBoundingBox("Combat")
    local v19 = self:getBranchBoundingBox("Survival")
    local v20 = self:getTierEdge("Core", 0, "left")
    local v21 = self:getBranchEdge("Survival", "right")
    if v20 and v21 and v15 and v17 and v19 then
        v1 = Vector3.new(u50.gridToWorld(v15.row, v15.column).X, v11, v20.Z)
        v2 = Vector3.new(v21.X, v11, v21.Z)
        v3 = self:createLine(v17, v1, v19, v2, v13)
        self.branchConnectionLines.Survival = v3
    end
    local v22 = self:getTierEdge("Core", 0, "right")
    v1 = self:getBranchEdge("Combat", "left")
    if v22 and v1 and v16 and v17 and v18 then
        v3 = Vector3.new(u50.gridToWorld(v16.row, v16.column).X, v11, v22.Z)
        local v23 = Vector3.new(v1.X, v11, v1.Z)
        v4 = self:createLine(v17, v3, v18, v23, v12)
        self.branchConnectionLines.Combat = v4
    end
    v2 = #layout.survivalTiers - 1
    v3 = 1
    local v24 = self
    for i = 1, v2, v3 do
        v4 = v24:getTierBoundingBox("Survival", i)
        v5 = v24:getTierBoundingBox("Survival", i + 1)
        v6 = v24:getTierEdge("Survival", i, "left")
        v7 = v24:getTierEdge("Survival", i + 1, "right")
        if v6 and v7 and v4 and v5 then
            v8 = Vector3.new(v6.X, v11, v6.Z)
            v9 = Vector3.new(v7.X, v11, v7.Z)
            v10 = v24:createLine(v4, v8, v5, v9, v13)
            v24.tierConnectionLines[("Survival_Tier%*_to_Tier%*"):format(i, i + 1)] = v10
        end
    end
    v2 = #layout.combatTiers - 1
    v3 = 1
    for j = 1, v2, v3 do
        v4 = v24:getTierBoundingBox("Combat", j)
        v5 = v24:getTierBoundingBox("Combat", j + 1)
        v6 = v24:getTierEdge("Combat", j, "right")
        v7 = v24:getTierEdge("Combat", j + 1, "left")
        if v6 and v7 and v4 and v5 then
            v8 = Vector3.new(v6.X, v11, v6.Z)
            v9 = Vector3.new(v7.X, v11, v7.Z)
            v10 = v24:createLine(v4, v8, v5, v9, v12)
            v24.tierConnectionLines[("Combat_Tier%*_to_Tier%*"):format(j, j + 1)] = v10
        end
    end
end
function u50:createSkillConnectionLines() -- Line: 604 -- upvalues: layout (val)
    local Position, Position_2, Top, Top_2, v1, v2, v3, v4, v5, v6
    local v7 = Color3.fromRGB(0, 0, 0)
    local v8 = layout.coreTiers[1]
    local v9 = #v8 - 1
    local v10 = 1
    local v11 = self
    for i = 1, v9, v10 do
        v4 = v8[i]
        v5 = v11.squares[v4]
        v6 = v11.squares[v8[i + 1]]
        Top = v5
        if Top then
            Top = v5:FindFirstChild("Top")
        end
        Top_2 = v6
        if Top_2 then
            Top_2 = v6:FindFirstChild("Top")
        end
        if Top and Top_2 then
            Position_2 = Top.Position
            Position = Top_2.Position
            v1 = Vector3.new(Position_2.X - Top.Size.X / 2, Position_2.Y, Position_2.Z)
            v2 = Vector3.new(Position.X + Top_2.Size.X / 2, Position.Y, Position.Z)
            v3 = v11:createLine(Top, v1, Top_2, v2, v7)
            v11.skillConnectionLines[v4] = v3
        end
    end
end
function u50:createSkillState(p2) -- Line: 637 -- upvalues: SkillConfig (val), layout (val)
    local description, maxRank, name, tier
    local v1 = SkillConfig.getSkill(p2)
    if not v1 then
        name = p2
    else
        name = v1.name
    end
    if not v1 then
        maxRank = 5
    else
        maxRank = v1.maxRank
    end
    if not v1 then
        description = ""
    else
        description = v1.description
    end
    if not v1 then
        if not v1 then
            tier = 0
        else
            tier = v1.tier
            if not tier then
                tier = 0
            end
        end
    elseif v1.branch == "Core" then
        tier = 0
    end
    local v2 = v1 and v1.branch == "Core" and p2 == layout.coreTiers[1][1]
    local v3 = {
        currentRank = self.scope:Value(0),
        maxRank = maxRank,
        name = name,
        description = description,
        tier = tier,
        showDescription = self.scope:Value(false),
        isPurchasable = self.scope:Value(v2),
        isSelected = self.scope:Value(false),
        isHovered = self.scope:Value(false),
    }
    self.skillStates[p2] = v3
    return v3
end
function u50:createSurfaceGui(p2, p3) -- Line: 676 -- upvalues: SkillSquareGui (val), getSkillIcon (val)
    local u8 = self.skillStates[p3]
    if not u8 then
        u8 = self:createSkillState(p3)
    end
    local v1 = SkillSquareGui({
        scope = self.scope,
        SkillName = u8.name,
        CurrentRank = u8.currentRank,
        MaxRank = u8.maxRank,
        Description = u8.description,
        Icon = getSkillIcon(p3),
        ShowDescription = u8.showDescription,
        IsPurchasable = u8.isPurchasable,
        IsSelected = u8.isSelected,
        IsHovered = u8.isHovered,
        Tier = u8.tier,
        Adornee = p2,
        OnClick = function() -- Line: 692 -- upvalues: self (val), p3 (val)
            if self.onSkillClicked then
                self.onSkillClicked(p3)
            end
        end,
        OnHoverEnter = function() -- Line: 697 -- upvalues: u8 (val)
            u8.isHovered:set(true)
        end,
        OnHoverLeave = function() -- Line: 701 -- upvalues: u8 (val)
            u8.isHovered:set(false)
        end,
    })
    v1.Parent = self.guiContainer
end
function u50:createSquare(p2) -- Line: 712 -- upvalues: ReplicatedStorage (val), layout (val), u50 (val)
    local skillTree = ReplicatedStorage.common:FindFirstChild("skillTree")
    if not skillTree then
        warn("skillTree folder not found in ReplicatedStorage")
        return nil
    end
    local skillSquare = skillTree:FindFirstChild("skillSquare")
    if not skillSquare then
        warn("skillSquare template not found")
        return nil
    end
    local v1 = layout.getPosition(p2)
    if not v1 then
        warn((("No position found for skill: %*"):format(p2)))
        return nil
    end
    self:createSkillState(p2)
    local v2 = skillSquare:Clone()
    v2.Name = p2
    v2:PivotTo(CFrame.new((u50.gridToWorld(v1.row, v1.column))))
    local Top = v2:FindFirstChild("Top")
    local Bottom = v2:FindFirstChild("Bottom")
    if Top then
        Top.CastShadow = false
        Top.Material = Enum.Material.Metal
        Top.Color = Color3.fromRGB(91, 93, 105)
        self:createSurfaceGui(Top, p2)
    end
    if Bottom then
        Bottom.CastShadow = false
        Bottom.Material = Enum.Material.Metal
        Bottom.Color = Color3.fromRGB(17, 17, 17)
    end
    return v2
end
function u50.render(p1, p2) -- Line: 771 -- upvalues: Players (val), SkillConfig (val)
    local v1
    p1:clear()
    local LocalPlayer = Players.LocalPlayer
    if LocalPlayer then
        p1.guiContainer = LocalPlayer:WaitForChild("PlayerGui")
    end
    p1:createAllBranchBoundingBoxes()
    p1:createAllTierBoundingBoxes()
    p1:createAllConnectionLines()
    local v2 = SkillConfig.getAllSkillIds()
    local v3 = v2
    local v4 = nil
    local v5 = nil
    for i, j in v3, v4, v5 do
        v1 = p1:createSquare(j)
        if v1 then
            v1.Parent = p1.container
            p1.squares[j] = v1
        end
    end
    p1:createSkillConnectionLines()
    v4 = p2
    if not v4 then
        v4 = workspace
    end
    p1.container.Parent = v4
    print((("Rendered %* skill squares with bounding boxes"):format(#v2)))
end
local u68 = {}
local function animateLinePulse(p1) -- Line: 817 -- upvalues: u48 (val)
    local X = u48.X
    local u3 = X * 3
    local u4 = 0
    task.spawn(function() -- Line: 822 -- upvalues: u4 (ref), X (val), u3 (val), p1 (val)
        local v1
        while u4 < 0.3 do
            u4 = u4 + task.wait()
            v1 = X + (u3 - X) * math.sin(math.min(u4 / 0.3, 1) * 3.141592653589793)
            p1.Thickness = v1
        end
        p1.Thickness = X
    end)
end
function u50:clear() -- Line: 843 -- upvalues: u68 (val)
    local squares = self.squares
    local v1 = nil
    local v2 = nil
    for i, j in squares, v1, v2 do
        j:Destroy()
    end
    local tierBoundingBoxes = self.tierBoundingBoxes
    v1 = nil
    v2 = nil
    for k, n in tierBoundingBoxes, v1, v2 do
        n:Destroy()
    end
    local branchBoundingBoxes = self.branchBoundingBoxes
    v1 = nil
    v2 = nil
    for m, i5 in branchBoundingBoxes, v1, v2 do
        i5:Destroy()
    end
    local connectionLines = self.connectionLines
    v1 = nil
    v2 = nil
    for i6, i7 in connectionLines, v1, v2 do
        i7:Destroy()
    end
    self.guiContainer = nil
    self.squares = {}
    self.skillStates = {}
    self.tierStates = {}
    self.branchStates = {}
    self.skillBoundingBoxes = {}
    self.tierBoundingBoxes = {}
    self.branchBoundingBoxes = {}
    self.connectionLines = {}
    self.skillConnectionLines = {}
    self.branchConnectionLines = {}
    self.tierConnectionLines = {}
    table.clear(u68)
end
function u50.getSquare(p1, p2) -- Line: 875
    return p1.squares[p2]
end
local function countTierUpgrades(p1, p2) -- Line: 883 -- upvalues: layout (val), u68 (val)
    local combatTiers
    if p1 ~= "Combat" then
        combatTiers = layout.survivalTiers
    else
        combatTiers = layout.combatTiers
    end
    local v1 = combatTiers[p2]
    if not v1 then
        return 0
    end
    local v2 = 0
    local v3 = v1
    local v4 = nil
    local v5 = nil
    for i, j in v3, v4, v5 do
        v2 = v2 + (u68[j] or 0)
    end
    return v2
end
local function updateSkillPurchasability(p1, p2) -- Line: 901 -- upvalues: layout (val), u68 (val), SkillConfig (val)
    local combatTiers, combatTiers_2, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10
    if p2 ~= "Combat" then
        combatTiers = layout.survivalTiers
    else
        combatTiers = layout.combatTiers
    end
    local v11 = combatTiers
    local v12 = nil
    local v13 = nil
    local v14 = p2
    for i, j in v11, v12, v13 do
        if i ~= 1 then
            v10 = SkillConfig.getTierRequiredCount(v14, i - 1)
            if v14 ~= "Combat" then
                combatTiers_2 = layout.survivalTiers
            else
                combatTiers_2 = layout.combatTiers
            end
            v4 = combatTiers_2[i - 1]
            if v4 then
                v5 = 0
                v6 = v4
                v7 = nil
                v8 = nil
                for k, n in v6, v7, v8 do
                    v5 = v5 + (u68[n] or 0)
                end
                v2 = v5
            else
                v2 = 0
            end
            v9 = v10 <= v2
        else
            v10 = layout.coreTiers[1]
            if v14 ~= "Survival" then
                v2 = v10[3]
            else
                v2 = v10[2]
            end
            v3 = u68[v2] or 0
            v9 = 1 <= v3
        end
        v10 = j
        v2 = nil
        v3 = nil
        for m, i5 in v10, v2, v3 do
            v5 = v1.skillStates[i5]
            if v5 then
                v5.isPurchasable:set(v9)
            end
        end
    end
end
local function updateCorePurchasability(p1) -- Line: 932 -- upvalues: layout (val), u68 (val)
    local v1, v2, v3
    local v4 = layout.coreTiers[1]
    local v5 = v4
    local v6 = nil
    local v7 = nil
    local v8 = p1
    for i, j in v5, v6, v7 do
        v2 = v8.skillStates[j]
        if v2 then
            if i ~= 1 then
                v3 = u68[v4[i - 1]] or 0
                v1 = 1 <= v3
                v2.isPurchasable:set(v1)
            else
                v2.isPurchasable:set(true)
            end
        end
    end
end
local function updateTierStates(p1, p2) -- Line: 954 -- upvalues: layout (val), Fusion (val), SkillConfig (val), u68 (val), u48 (val)
    local combatTiers, combatTiers_2, new, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15
    if p2 ~= "Combat" then
        combatTiers = layout.survivalTiers
    else
        combatTiers = layout.combatTiers
    end
    local v16 = #combatTiers
    local v17 = 1
    v2, v1 = p2, p1
    for i = 2, v16, v17 do
        v12 = ("%*_Tier%*"):format(v2, i)
        v13 = v1.tierStates[v12]
        if v13 then
            v14 = Fusion.peek(v13.locked)
            v15 = SkillConfig.getTierRequiredCount(v2, i - 1)
            if v2 ~= "Combat" then
                combatTiers_2 = layout.survivalTiers
            else
                combatTiers_2 = layout.combatTiers
            end
            v6 = combatTiers_2[i - 1]
            if v6 then
                v7 = 0
                v8 = v6
                v9 = nil
                v10 = nil
                for j, k in v8, v9, v10 do
                    v7 = v7 + (u68[k] or 0)
                end
                v3 = v7
            else
                v3 = 0
            end
            v4 = math.max(0, v15 - v3)
            v5 = v4 == 0
            v6 = v14 and v5
            if not v5 then
                v13.locked:set(true)
                if 1 >= v4 then
                    v11 = ""
                else
                    v11 = "s"
                end
                v13.requiresText:set((("Upgrade %* Tier %* skill%*"):format(v4, i - 1, v11)))
                if v13.alwaysOnTop then
                    v13.alwaysOnTop:set(true)
                end
            else
                v13.locked:set(false)
                v13.requiresText:set("")
                if v13.alwaysOnTop then
                    v13.alwaysOnTop:set(false)
                end
            end
            v7 = ("%*_Tier%*_to_Tier%*"):format(v2, i - 1, i)
            local u147 = v1.tierConnectionLines[v7]
            if u147 then
                new = BrickColor.new
                if not v5 then
                    v10 = Color3.fromRGB(0, 0, 0)
                else
                    v10 = Color3.fromRGB(255, 255, 255)
                end
                u147.Color = new(v10)
                if v6 then
                    local X = u48.X
                    local u173 = X * 3
                    local u174 = 0
                    task.spawn(function() -- Line: 822 -- upvalues: u174 (ref), X (val), u173 (val), u147 (val)
                        local v1
                        while u174 < 0.3 do
                            u174 = u174 + task.wait()
                            v1 = X + (u173 - X) * math.sin(math.min(u174 / 0.3, 1) * 3.141592653589793)
                            u147.Thickness = v1
                        end
                        u147.Thickness = X
                    end)
                end
            end
        end
    end
end
function u50.setSkillRank(p1, p2, p3) -- Line: 1012 -- upvalues: u68 (val), u48 (val), layout (val), SkillConfig (val), updateTierStates (val), updateSkillPurchasability (val), updateCorePurchasability (val)
    local Combat, Survival, u117, v1, v2
    local v3 = u68[p2] or 0
    local v4 = if v3 < 1 then 1 <= p3 else false
    u68[p2] = p3
    local v5 = p1.skillStates[p2]
    if v5 then
        v5.currentRank:set(p3)
    end
    local u25 = p1.skillConnectionLines[p2]
    if u25 then
        if 1 > p3 then
            u25.Color = BrickColor.new(Color3.fromRGB(0, 0, 0))
        else
            u25.Color = BrickColor.new(Color3.fromRGB(255, 255, 255))
            if v4 then
                local X = u48.X
                local u39 = X * 3
                Survival = 0
                task.spawn(function() -- Line: 822 -- upvalues: Survival (ref), X (val), u39 (val), u25 (val)
                    local v1
                    while Survival < 0.3 do
                        Survival = Survival + task.wait()
                        v1 = X + (u39 - X) * math.sin(math.min(Survival / 0.3, 1) * 3.141592653589793)
                        u25.Thickness = v1
                    end
                    u25.Thickness = X
                end)
            end
        end
    end
    local v6 = layout.coreTiers[1]
    if p2 == v6[2] then
        Survival = 1
        v2 = Survival <= p3
        Survival = p1.branchStates.Survival
        if Survival then
            Survival.locked:set(not v2)
        end
        local Survival_Tier1 = p1.tierStates.Survival_Tier1
        if Survival_Tier1 then
            Survival_Tier1.locked:set(not v2)
            if Survival_Tier1.alwaysOnTop then
                Survival_Tier1.alwaysOnTop:set(not v2)
            end
        end
        local Survival_2 = p1.branchConnectionLines.Survival
        if Survival_2 then
            local new = BrickColor.new
            if not v2 then
                v1 = Color3.fromRGB(0, 0, 0)
            else
                v1 = Color3.fromRGB(255, 255, 255)
            end
            Survival_2.Color = new(v1)
            if v4 and v2 then
                local X_2 = u48.X
                local u116 = X_2 * 3
                u117 = 0
                task.spawn(function() -- Line: 822 -- upvalues: u117 (ref), X_2 (val), u116 (val), Survival_2 (val)
                    local v1
                    while u117 < 0.3 do
                        u117 = u117 + task.wait()
                        v1 = X_2 + (u116 - X_2) * math.sin(math.min(u117 / 0.3, 1) * 3.141592653589793)
                        Survival_2.Thickness = v1
                    end
                    Survival_2.Thickness = X_2
                end)
            end
        end
    elseif p2 == v6[3] then
        Survival = 1
        v2 = Survival <= p3
        Survival = p1.branchStates.Combat
        if Survival then
            Survival.locked:set(not v2)
        end
        local Combat_Tier1 = p1.tierStates.Combat_Tier1
        if Combat_Tier1 then
            Combat_Tier1.locked:set(not v2)
            if Combat_Tier1.alwaysOnTop then
                Combat_Tier1.alwaysOnTop:set(not v2)
            end
        end
        Combat = p1.branchConnectionLines.Combat
        if Combat then
            local new_2 = BrickColor.new
            if not v2 then
                v1 = Color3.fromRGB(0, 0, 0)
            else
                v1 = Color3.fromRGB(255, 255, 255)
            end
            Combat.Color = new_2(v1)
            if v4 and v2 then
                local X_3 = u48.X
                local u179 = X_3 * 3
                u117 = 0
                task.spawn(function() -- Line: 822 -- upvalues: u117 (ref), X_3 (val), u179 (val), Combat (val)
                    local v1
                    while u117 < 0.3 do
                        u117 = u117 + task.wait()
                        v1 = X_3 + (u179 - X_3) * math.sin(math.min(u117 / 0.3, 1) * 3.141592653589793)
                        Combat.Thickness = v1
                    end
                    Combat.Thickness = X_3
                end)
            end
        end
    end
    Survival = p2
    v2 = SkillConfig.getSkill(Survival)
    if not v2 then
        return
    end
    Survival = v2.branch
    if Survival == "Combat" then
        updateTierStates(p1, "Combat")
        updateSkillPurchasability(p1, "Combat")
        return
    end
    Survival = v2.branch
    if Survival == "Survival" then
        updateTierStates(p1, "Survival")
        updateSkillPurchasability(p1, "Survival")
        return
    end
    Survival = v2.branch
    if Survival == "Core" then
        updateCorePurchasability(p1)
        updateSkillPurchasability(p1, "Combat")
        updateSkillPurchasability(p1, "Survival")
    end
end
function u50.setSkillShowDescription(p1, p2, p3) -- Line: 1112
    local v1 = p1.skillStates[p2]
    if v1 then
        v1.showDescription:set(p3)
    end
end
function u50.setSkillSelected(p1, p2, p3) -- Line: 1122
    local v1 = p1.skillStates[p2]
    if v1 then
        v1.isSelected:set(p3)
    end
end
function u50.getSkillState(p1, p2) -- Line: 1132
    return p1.skillStates[p2]
end
function u50.getSkillBoundingBox(p1, p2) -- Line: 1139
    return p1.skillBoundingBoxes[p2]
end
function u50:getTierBoundingBox(p2, p3) -- Line: 1146
    local v1 = ("%*_Tier%*"):format(p2, p3)
    return self.tierBoundingBoxes[v1]
end
function u50:getBranchBoundingBox(p2) -- Line: 1154
    return self.branchBoundingBoxes[p2]
end
function u50.setTierLocked(p1, p2, p3, p4) -- Line: 1161
    local v1 = ("%*_Tier%*"):format(p2, p3)
    local v2 = p1.tierStates[v1]
    if v2 then
        v2.locked:set(p4)
    end
end
function u50.setBranchLocked(p1, p2, p3) -- Line: 1172
    local v1 = p1.branchStates[p2]
    if v1 then
        v1.locked:set(p3)
    end
end
function u50.getTierState(p1, p2, p3) -- Line: 1182
    local v1 = ("%*_Tier%*"):format(p2, p3)
    return p1.tierStates[v1]
end
function u50.setSkillTierAlwaysOnTop(p1, p2, p3) -- Line: 1192 -- upvalues: SkillConfig (val), Fusion (val)
    local v1 = SkillConfig.getSkill(p2)
    if not v1 or v1.branch == "Core" then
        return
    end
    local v2 = ("%*_Tier%*"):format(v1.branch, v1.tier)
    local v3 = p1.tierStates[v2]
    if not v3 or not v3.alwaysOnTop then
        return
    end
    if not p3 then
        v3.alwaysOnTop:set(p3)
        return
    end
    if not (Fusion.peek(v3.locked)) then
        return
    end
    v3.alwaysOnTop:set(p3)
end
function u50.clearHoverStates(p1) -- Line: 1218 -- upvalues: Fusion (val)
    local skillStates = p1.skillStates
    local v1 = nil
    local v2 = nil
    for i, j in skillStates, v1, v2 do
        j.isHovered:set(false)
    end
    local tierStates = p1.tierStates
    v1 = nil
    v2 = nil
    for k, n in tierStates, v1, v2 do
        if n.alwaysOnTop then
            n.alwaysOnTop:set(Fusion.peek(n.locked))
        end
    end
end
function u50.getBranchState(p1, p2) -- Line: 1232
    return p1.branchStates[p2]
end
function u50.destroy(p1) -- Line: 1239
    p1:clear()
    p1.scope:doCleanup()
    p1.container:Destroy()
end
return u50