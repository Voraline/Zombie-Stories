local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage.Packages
local Fusion = require(Packages.Fusion)
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
    local v1 = u50
    local v2 = setmetatable({}, v1)
    v2.scope = Fusion.scoped(Fusion)
    v2.squares = {}
    v2.skillStates = {}
    v2.tierStates = {}
    v2.branchStates = {}
    v2.skillBoundingBoxes = {}
    v2.tierBoundingBoxes = {}
    v2.branchBoundingBoxes = {}
    v2.connectionLines = {}
    v2.skillConnectionLines = {}
    v2.branchConnectionLines = {}
    v2.tierConnectionLines = {}
    v2.container = Instance.new("Model")
    v2.container.Name = "SkillTreeSquares"
    v2.guiContainer = nil
    v2.onSkillClicked = nil
    return v2
end

function u50.gridToWorld(p1, p2) -- Line: 145 -- upvalues: u44 (val)
    local v1 = -p1 * 65
    local v2 = p2 * 65
    return u44 + Vector3.new(v1, 0, v2)
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

function u50:createTierBoundingBox(p2, p3, p4) -- Line: 181
    -- upvalues: layout (val), u50 (val), u44 (val), SkillConfig (val), BoundingBoxOverlay (val)
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
            v3 = v2.X - 25
            v5 = math.min(v5, v3)
            v3 = v2.X + 25
            v6 = math.max(v6, v3)
            v3 = v2.Z - 25
            v7 = math.min(v7, v3)
            v3 = v2.Z + 25
            v8 = math.max(v8, v3)
        end
    end
    v5 = v5 - 1
    v6 = v6 + 1
    v7 = v7 - 1
    v8 = v8 + 1
    v9 = v6 - v5
    v10 = v8 - v7
    v11 = (v5 + v6) / 2
    local v12 = (v7 + v8) / 2
    local v13 = p2 == "Core"
    if not v13 then
        v1 = u44.Y - 5
    else
        v1 = u44.Y - 8
        if not v1 then
            v1 = u44.Y - 5
        end
    end
    local Part = Instance.new("Part")
    Part.Name = ("%*_Tier%*_BoundingBox"):format(p2, p3)
    Part.Size = Vector3.new(v9, 1, v10)
    Part.Position = Vector3.new(v11, v1, v12)
    Part.Anchored = true
    Part.CanCollide = false
    Part.Transparency = 1
    Part.CastShadow = false
    Part.CFrame = Part.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
    local v14 = ("%*_Tier%*"):format(p2, p3)
    local v15 = ""
    if 2 <= p3 then
        local v16
        v3 = SkillConfig.getTierRequiredCount(p2, p3 - 1)
        v4 = p3 - 1
        if not (1 < v3) then
            v16 = ""
        else
            v16 = "s"
        end
        v15 = ("Upgrade %* Tier %* skill%*"):format(v3, v4, v16)
    end
    if not v13 then
        v3 = self.scope:Value(true)
    else
        v3 = nil
    end
    local v17 = {locked = self.scope:Value(true), requiresText = self.scope:Value(v15), alwaysOnTop = v3}
    self.tierStates[v14] = v17
    local v18 = BoundingBoxOverlay
    local v19 = {
        CornerRadius = 128,
        StrokeThickness = 50,
        scope = self.scope,
        Locked = v17.locked,
        RequiresText = v17.requiresText,
        ShowLockIcon = not v13,
    }
    if not v13 then
        v4 = v3
    else
        v4 = false
    end
    v19.AlwaysOnTop = v4
    v19.Adornee = Part
    v18 = v18(v19)
    v18.Parent = self.guiContainer
    self.tierBoundingBoxes[v14] = Part
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
    v1 = layout
    local v4 = v1.coreTiers[1]
    local v5 = self:createTierBoundingBox("Core", 0, v4)
    if v5 then
        v5.Parent = self.container
    end
end

function u50:createBranchBoundingBox(p2, p3) -- Line: 301
    -- upvalues: layout (val), u50 (val), u44 (val), SkillConfig (val), BoundingBoxOverlay (val)
    local v1, v2, v3, v4, v5, v6, v7, v8, v9
    local v10 = {}
    local v11 = p3
    local v12 = nil
    local v13 = nil
    for i, j in v11, v12, v13 do
        v9 = j
        v3 = nil
        v4 = nil
        for k, n in v9, v3, v4 do
            table.insert(v10, n)
        end
    end
    if #v10 == 0 then
        return nil
    end
    v11 = (1 / 0)
    v12 = (-1 / 0)
    v13 = (1 / 0)
    local v14 = (-1 / 0)
    local v15 = v10
    v9 = nil
    v3 = nil
    for m, i5 in v15, v9, v3 do
        v5 = layout.getPosition(i5)
        if v5 then
            v6 = u50.gridToWorld(v5.row, v5.column)
            v8 = v6.X - 25
            v11 = math.min(v11, v8)
            v8 = v6.X + 25
            v12 = math.max(v12, v8)
            v8 = v6.Z - 25
            v13 = math.min(v13, v8)
            v8 = v6.Z + 25
            v14 = math.max(v14, v8)
        end
    end
    v11 = v11 - 6
    v12 = v12 + 6
    v13 = v13 - 6
    v14 = v14 + 6
    v15 = v12 - v11
    v9 = v14 - v13
    v3 = (v11 + v12) / 2
    v4 = (v13 + v14) / 2
    local Part = Instance.new("Part")
    Part.Name = ("%*_BoundingBox"):format(v2)
    Part.Size = Vector3.new(v15, 1, v9)
    local v16 = u44.Y - 8
    Part.Position = Vector3.new(v3, v16, v4)
    Part.Anchored = true
    Part.CanCollide = false
    Part.Transparency = 1
    Part.CastShadow = false
    Part.CFrame = Part.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
    v5 = {}
    v5.locked = v1.scope:Value(true)
    v1.branchStates[v2] = v5
    v6 = ""
    v16 = layout.coreTiers[1]
    if v2 == "Combat" then
        local name
        v7 = SkillConfig.getSkill(v16[3])
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
        v7 = SkillConfig.getSkill(v16[2])
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
    v7 = BoundingBoxOverlay
    v7 = v7({
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
    local v1 = layout
    local combatTiers = v1.combatTiers
    local v2 = self:createBranchBoundingBox("Combat", combatTiers)
    if v2 then
        v2.Parent = self.container
    end
    local v3 = layout
    local survivalTiers = v3.survivalTiers
    local v4 = self:createBranchBoundingBox("Survival", survivalTiers)
    if v4 then
        v4.Parent = self.container
    end
end

function u50:createLine(p2, p3, p4, p5, p6) -- Line: 412 -- upvalues: u48 (val)
    local Attachment = Instance.new("Attachment")
    Attachment.Name = "LineStart"
    Attachment.Parent = p2
    local Attachment_2 = Instance.new("Attachment")
    Attachment_2.Name = "LineEnd"
    Attachment_2.Parent = p4
    local X = p3.X
    local Y = p2.Position.Y
    local Z = p3.Z
    Attachment.WorldPosition = Vector3.new(X, Y, Z)
    local X_2 = p5.X
    local Y_2 = p4.Position.Y
    local Z_2 = p5.Z
    Attachment_2.WorldPosition = Vector3.new(X_2, Y_2, Z_2)
    local RopeConstraint = Instance.new("RopeConstraint")
    RopeConstraint.Name = "ConnectionLine"
    RopeConstraint.Attachment0 = Attachment
    RopeConstraint.Attachment1 = Attachment_2
    RopeConstraint.Visible = true
    RopeConstraint.Thickness = u48.X
    local new = BrickColor.new
    local v1 = p6
    if not v1 then
        v1 = Color3.fromRGB(100, 100, 100)
    end
    RopeConstraint.Color = new(v1)
    RopeConstraint.Parent = p2
    local connectionLines = self.connectionLines
    table.insert(connectionLines, RopeConstraint)
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
    local v1, v2
    local v3 = ("%*_Tier%*"):format(p2, p3)
    local v4 = self.tierBoundingBoxes[v3]
    if not v4 then
        return nil
    end
    local Position = v4.Position
    local Size = v4.Size
    if p4 == "left" then
        v2 = -Size.Z / 2
        return Position + Vector3.new(0, 0, v2)
    end
    if p4 == "right" then
        v2 = Size.Z / 2
        return Position + Vector3.new(0, 0, v2)
    end
    if p4 == "top" then
        v1 = Size.X / 2
        return Position + Vector3.new(v1, 0, 0)
    end
    if p4 ~= "bottom" then
        return Position
    end
    v1 = -Size.X / 2
    return Position + Vector3.new(v1, 0, 0)
end

function u50:getBranchEdge(p2, p3) -- Line: 495
    local v1, v2
    local v3 = self.branchBoundingBoxes[p2]
    if not v3 then
        return nil
    end
    local Position = v3.Position
    local Size = v3.Size
    if p3 == "left" then
        v1 = -Size.Z / 2
        return Position + Vector3.new(0, 0, v1)
    end
    if p3 == "right" then
        v1 = Size.Z / 2
        return Position + Vector3.new(0, 0, v1)
    end
    if p3 == "top" then
        v2 = Size.X / 2
        return Position + Vector3.new(v2, 0, 0)
    end
    if p3 ~= "bottom" then
        return Position
    end
    v2 = -Size.X / 2
    return Position + Vector3.new(v2, 0, 0)
end

function u50:createAllConnectionLines() -- Line: 521 -- upvalues: u44 (val), layout (val), u50 (val)
    local X_5, X_6, X_7, X_8, Z_5, Z_6, Z_7, Z_8, tierConnectionLines, tierConnectionLines_2, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12
    local v13 = u44.Y + -4
    local v14 = Color3.fromRGB(0, 0, 0)
    local v15 = Color3.fromRGB(0, 0, 0)
    local v16 = layout.coreTiers[1]
    local v17 = layout.getPosition(v16[2])
    local v18 = layout.getPosition(v16[3])
    local v19 = self:getTierBoundingBox("Core", 0)
    local v20 = self:getBranchBoundingBox("Combat")
    local v21 = self:getBranchBoundingBox("Survival")
    local v22 = self:getTierEdge("Core", 0, "left")
    local v23 = self:getBranchEdge("Survival", "right")
    if v22 and v23 and v17 and v19 and v21 then
        v1 = u50
        local X = (v1.gridToWorld(v17.row, v17.column)).X
        local Z = v22.Z
        v2 = Vector3.new(X, v13, Z)
        local X_2 = v23.X
        local Z_2 = v23.Z
        v3 = Vector3.new(X_2, v13, Z_2)
        v4 = self:createLine(v19, v2, v21, v3, v15)
        self.branchConnectionLines.Survival = v4
    end
    v1 = self:getTierEdge("Core", 0, "right")
    v2 = self:getBranchEdge("Combat", "left")
    if v1 and v2 and v18 and v19 and v20 then
        v3 = u50
        local X_3 = (v3.gridToWorld(v18.row, v18.column)).X
        local Z_3 = v1.Z
        v4 = Vector3.new(X_3, v13, Z_3)
        local X_4 = v2.X
        local Z_4 = v2.Z
        local v24 = Vector3.new(X_4, v13, Z_4)
        v5 = self:createLine(v19, v4, v20, v24, v14)
        self.branchConnectionLines.Combat = v5
    end
    v3 = #layout.survivalTiers - 1
    local v25 = self
    for i = 1, v3 do
        v5 = v25:getTierBoundingBox("Survival", i)
        v9 = i + 1
        v6 = v25:getTierBoundingBox("Survival", v9)
        v7 = v25:getTierEdge("Survival", i, "left")
        v11 = i + 1
        v8 = v25:getTierEdge("Survival", v11, "right")
        if v7 and v8 and v5 and v6 then
            X_5 = v7.X
            Z_5 = v7.Z
            v9 = Vector3.new(X_5, v13, Z_5)
            X_6 = v8.X
            Z_6 = v8.Z
            v10 = Vector3.new(X_6, v13, Z_6)
            v11 = v25:createLine(v5, v9, v6, v10, v15)
            tierConnectionLines = v25.tierConnectionLines
            v12 = i + 1
            tierConnectionLines[("Survival_Tier%*_to_Tier%*"):format(i, v12)] = v11
        end
    end
    v3 = #layout.combatTiers - 1
    for j = 1, v3 do
        v5 = v25:getTierBoundingBox("Combat", j)
        v9 = j + 1
        v6 = v25:getTierBoundingBox("Combat", v9)
        v7 = v25:getTierEdge("Combat", j, "right")
        v11 = j + 1
        v8 = v25:getTierEdge("Combat", v11, "left")
        if v7 and v8 and v5 and v6 then
            X_7 = v7.X
            Z_7 = v7.Z
            v9 = Vector3.new(X_7, v13, Z_7)
            X_8 = v8.X
            Z_8 = v8.Z
            v10 = Vector3.new(X_8, v13, Z_8)
            v11 = v25:createLine(v5, v9, v6, v10, v14)
            tierConnectionLines_2 = v25.tierConnectionLines
            v12 = j + 1
            tierConnectionLines_2[("Combat_Tier%*_to_Tier%*"):format(j, v12)] = v11
        end
    end
end

function u50:createSkillConnectionLines() -- Line: 604 -- upvalues: layout (val)
    local Position, Position_2, Size, Size_2, Top, Top_2, Y, Y_2, Z, Z_2, v1, v2, v3, v4, v5, v6, v7
    local v8 = Color3.fromRGB(0, 0, 0)
    local v9 = layout.coreTiers[1]
    local v10 = #v9 - 1
    local v11 = self
    for i = 1, v10 do
        v4 = v9[i]
        v5 = v9[i + 1]
        v6 = v11.squares[v4]
        v7 = v11.squares[v5]
        Top = v6
        if Top then
            Top = v6:FindFirstChild("Top")
        end
        Top_2 = v7
        if Top_2 then
            Top_2 = v7:FindFirstChild("Top")
        end
        if Top and Top_2 then
            Position_2 = Top.Position
            Size_2 = Top.Size
            Position = Top_2.Position
            Size = Top_2.Size
            v2 = Position_2.X - Size_2.X / 2
            Y = Position_2.Y
            Z = Position_2.Z
            v1 = Vector3.new(v2, Y, Z)
            v3 = Position.X + Size.X / 2
            Y_2 = Position.Y
            Z_2 = Position.Z
            v2 = Vector3.new(v3, Y_2, Z_2)
            v3 = v11:createLine(Top, v1, Top_2, v2, v8)
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
        if not name then
            name = p2
        end
    end
    if not v1 then
        maxRank = 5
    else
        maxRank = v1.maxRank
        if not maxRank then
            maxRank = 5
        end
    end
    if not v1 then
        description = ""
    else
        description = v1.description
        if not description then
            description = ""
        end
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
    elseif v1.branch == "Core" or not v1 then
        tier = 0
    else
        tier = v1.tier
        if not tier then
            tier = 0
        end
    end
    local v2 = false
    if v1 and v1.branch == "Core" and p2 == layout.coreTiers[1][1] then
        v2 = true
    end
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
    local v1 = SkillSquareGui
    v1 = v1({
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
    local v3 = u50
    v3 = v3.gridToWorld(v1.row, v1.column)
    local v4 = CFrame.new(v3)
    v2:PivotTo(v4)
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
    local container = p1.container
    v4 = p2 or workspace
    container.Parent = v4
    v3 = print
    local v6 = #v2
    v3((("Rendered %* skill squares with bounding boxes"):format(v6)))
end

local u68 = {}

local function animateLinePulse(p1) -- Line: 817 -- upvalues: u48 (val)
    local X = u48.X
    local u3 = X * 3
    local u4 = 0
    task.spawn(function() -- Line: 822 -- upvalues: u4 (ref), X (val), u3 (val), p1 (val)
        local v1, v2, v3
        while u4 < 0.3 do
            v1 = task.wait()
            u4 = u4 + v1
            v2 = u4 / 0.3
            v3 = (math.min(v2, 1)) * 3.141592653589793
            v2 = math.sin(v3)
            v3 = X + (u3 - X) * v2
            p1.Thickness = v3
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
            v3 = i - 1
            if v14 ~= "Combat" then
                combatTiers_2 = layout.survivalTiers
            else
                combatTiers_2 = layout.combatTiers
            end
            v4 = combatTiers_2[v3]
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
            v9 = 1 <= (u68[v2] or 0)
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
    local isPurchasable, v1, v2, v3, v4
    local v5 = layout.coreTiers[1]
    local v6 = v5
    local v7 = nil
    local v8 = nil
    local v9 = p1
    for i, j in v6, v7, v8 do
        v2 = v9.skillStates[j]
        if v2 then
            if i ~= 1 then
                v3 = v5[i - 1]
                v4 = u68[v3] or 0
                isPurchasable = v2.isPurchasable
                v1 = 1 <= v4
                isPurchasable:set(v1)
            else
                v2.isPurchasable:set(true)
            end
        end
    end
end

local function updateTierStates(p1, p2) -- Line: 954
    -- upvalues: layout (val), Fusion (val), SkillConfig (val), u68 (val), u48 (val)
    local combatTiers, combatTiers_2, new, requiresText, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14
    if p2 ~= "Combat" then
        combatTiers = layout.survivalTiers
    else
        combatTiers = layout.combatTiers
    end
    local v15 = #combatTiers
    local v16, v17 = p2, p1
    for i = 2, v15 do
        v11 = ("%*_Tier%*"):format(v16, i)
        v12 = v17.tierStates[v11]
        if v12 then
            v13 = Fusion.peek(v12.locked)
            v14 = SkillConfig.getTierRequiredCount(v16, i - 1)
            v2 = i - 1
            if v16 ~= "Combat" then
                combatTiers_2 = layout.survivalTiers
            else
                combatTiers_2 = layout.combatTiers
            end
            v4 = combatTiers_2[v2]
            if v4 then
                v5 = 0
                v6 = v4
                v7 = nil
                v8 = nil
                for j, k in v6, v7, v8 do
                    v5 = v5 + (u68[k] or 0)
                end
                v1 = v5
            else
                v1 = 0
            end
            v4 = v14 - v1
            v2 = math.max(0, v4)
            v3 = v2 == 0
            v4 = v13 and v3
            if not v3 then
                v12.locked:set(true)
                requiresText = v12.requiresText
                v9 = i - 1
                if not (1 < v2) then
                    v10 = ""
                else
                    v10 = "s"
                end
                v7 = ("Upgrade %* Tier %* skill%*"):format(v2, v9, v10)
                requiresText:set(v7)
                if v12.alwaysOnTop then
                    v12.alwaysOnTop:set(true)
                end
            else
                v12.locked:set(false)
                v12.requiresText:set("")
                if v12.alwaysOnTop then
                    v12.alwaysOnTop:set(false)
                end
            end
            v8 = i - 1
            v5 = ("%*_Tier%*_to_Tier%*"):format(v16, v8, i)
            local u147 = v17.tierConnectionLines[v5]
            if u147 then
                new = BrickColor.new
                if not v3 then
                    v8 = Color3.fromRGB(0, 0, 0)
                else
                    v8 = Color3.fromRGB(255, 255, 255)
                    if not v8 then
                        v8 = Color3.fromRGB(0, 0, 0)
                    end
                end
                u147.Color = new(v8)
                if v4 then
                    local X = u48.X
                    local u173 = X * 3
                    local u174 = 0
                    task.spawn(function() -- Line: 822 -- upvalues: u174 (ref), X (val), u173 (val), u147 (val)
                        local v1, v2, v3
                        while u174 < 0.3 do
                            v1 = task.wait()
                            u174 = u174 + v1
                            v2 = u174 / 0.3
                            v3 = (math.min(v2, 1)) * 3.141592653589793
                            v2 = math.sin(v3)
                            v3 = X + (u173 - X) * v2
                            u147.Thickness = v3
                        end
                        u147.Thickness = X
                    end)
                end
            end
        end
    end
end

function u50.setSkillRank(p1, p2, p3) -- Line: 1012
    -- upvalues: u68 (val), u48 (val), layout (val), SkillConfig (val), updateTierStates (val)
    -- upvalues: updateSkillPurchasability (val), updateCorePurchasability (val)
    local v1, v2
    local v3 = u68[p2] or 0
    local v4 = false
    if v3 < 1 then
        v4 = 1 <= p3
    end
    u68[p2] = p3
    local v5 = p1.skillStates[p2]
    if v5 then
        v5.currentRank:set(p3)
    end
    local u25 = p1.skillConnectionLines[p2]
    if u25 then
        if not (1 <= p3) then
            u25.Color = BrickColor.new(Color3.fromRGB(0, 0, 0))
        else
            u25.Color = BrickColor.new(Color3.fromRGB(255, 255, 255))
            if v4 then
                local X = u48.X
                local u39 = X * 3
                local u40 = 0
                task.spawn(function() -- Line: 822 -- upvalues: u40 (ref), X (val), u39 (val), u25 (val)
                    local v1, v2, v3
                    while u40 < 0.3 do
                        v1 = task.wait()
                        u40 = u40 + v1
                        v2 = u40 / 0.3
                        v3 = (math.min(v2, 1)) * 3.141592653589793
                        v2 = math.sin(v3)
                        v3 = X + (u39 - X) * v2
                        u25.Thickness = v3
                    end
                    u25.Thickness = X
                end)
            end
        end
    end
    local v6 = layout.coreTiers[1]
    if p2 == v6[2] then
        v2 = 1 <= p3
        local Survival_2 = p1.branchStates.Survival
        if Survival_2 then
            Survival_2.locked:set(not v2)
        end
        local Survival_Tier1 = p1.tierStates.Survival_Tier1
        if Survival_Tier1 then
            Survival_Tier1.locked:set(not v2)
            if Survival_Tier1.alwaysOnTop then
                Survival_Tier1.alwaysOnTop:set(not v2)
            end
        end
        local Survival = p1.branchConnectionLines.Survival
        if Survival then
            local new = BrickColor.new
            if not v2 then
                v1 = Color3.fromRGB(0, 0, 0)
            else
                v1 = Color3.fromRGB(255, 255, 255)
                if not v1 then
                    v1 = Color3.fromRGB(0, 0, 0)
                end
            end
            Survival.Color = new(v1)
            if v4 and v2 then
                local X_2 = u48.X
                local u116 = X_2 * 3
                local u117 = 0
                task.spawn(function() -- Line: 822 -- upvalues: u117 (ref), X_2 (val), u116 (val), Survival (val)
                    local v1, v2, v3
                    while u117 < 0.3 do
                        v1 = task.wait()
                        u117 = u117 + v1
                        v2 = u117 / 0.3
                        v3 = (math.min(v2, 1)) * 3.141592653589793
                        v2 = math.sin(v3)
                        v3 = X_2 + (u116 - X_2) * v2
                        Survival.Thickness = v3
                    end
                    Survival.Thickness = X_2
                end)
            end
        end
    elseif p2 == v6[3] then
        v2 = 1 <= p3
        local Combat_2 = p1.branchStates.Combat
        if Combat_2 then
            Combat_2.locked:set(not v2)
        end
        local Combat_Tier1 = p1.tierStates.Combat_Tier1
        if Combat_Tier1 then
            Combat_Tier1.locked:set(not v2)
            if Combat_Tier1.alwaysOnTop then
                Combat_Tier1.alwaysOnTop:set(not v2)
            end
        end
        local Combat = p1.branchConnectionLines.Combat
        if Combat then
            local new_2 = BrickColor.new
            if not v2 then
                v1 = Color3.fromRGB(0, 0, 0)
            else
                v1 = Color3.fromRGB(255, 255, 255)
                if not v1 then
                    v1 = Color3.fromRGB(0, 0, 0)
                end
            end
            Combat.Color = new_2(v1)
            if v4 and v2 then
                local X_3 = u48.X
                local u179 = X_3 * 3
                local u180 = 0
                task.spawn(function() -- Line: 822 -- upvalues: u180 (ref), X_3 (val), u179 (val), Combat (val)
                    local v1, v2, v3
                    while u180 < 0.3 do
                        v1 = task.wait()
                        u180 = u180 + v1
                        v2 = u180 / 0.3
                        v3 = (math.min(v2, 1)) * 3.141592653589793
                        v2 = math.sin(v3)
                        v3 = X_3 + (u179 - X_3) * v2
                        Combat.Thickness = v3
                    end
                    Combat.Thickness = X_3
                end)
            end
        end
    end
    v2 = SkillConfig.getSkill(p2)
    if v2 then
        if v2.branch == "Combat" then
            updateTierStates(p1, "Combat")
            updateSkillPurchasability(p1, "Combat")
            return
        end
        if v2.branch == "Survival" then
            updateTierStates(p1, "Survival")
            updateSkillPurchasability(p1, "Survival")
            return
        end
        if v2.branch == "Core" then
            updateCorePurchasability(p1)
            updateSkillPurchasability(p1, "Combat")
            updateSkillPurchasability(p1, "Survival")
        end
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
    local branch = v1.branch
    local tier = v1.tier
    local v2 = ("%*_Tier%*"):format(branch, tier)
    local v3 = p1.tierStates[v2]
    if v3 and v3.alwaysOnTop then
        if p3 and not Fusion.peek(v3.locked) then
            return
        end
        v3.alwaysOnTop:set(p3)
    end
end

function u50.clearHoverStates(p1) -- Line: 1218 -- upvalues: Fusion (val)
    local alwaysOnTop, v1
    local skillStates = p1.skillStates
    local v2 = nil
    local v3 = nil
    for i, j in skillStates, v2, v3 do
        j.isHovered:set(false)
    end
    local tierStates = p1.tierStates
    v2 = nil
    v3 = nil
    for k, n in tierStates, v2, v3 do
        if n.alwaysOnTop then
            alwaysOnTop = n.alwaysOnTop
            v1 = Fusion
            v1 = v1.peek(n.locked)
            alwaysOnTop:set(v1)
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