local v1 = {}
local function normalizeName(p1) -- Line: 22
    return string.lower(p1):gsub("[^%w]", "")
end
local function isUnderBriefingRoom(p1) -- Line: 27
    local Parent = p1.Parent
    while Parent do
        if Parent:IsA("Model") and string.find(string.lower(Parent.Name):gsub("[^%w]", ""), "briefingroom", 1, true) then
            return true
        end
        Parent = Parent.Parent
    end
    return false
end
function v1.shouldAutoDiscover(p1) -- Line: 41 -- upvalues: isUnderBriefingRoom (val)
    local v1 = string.lower(p1.Name):gsub("[^%w]", "")
    if string.find(v1, "fake", 1, true) then
        return false
    end
    if string.find(v1, "largegate", 1, true) ~= nil or string.find(v1, "doubledoors", 1, true) ~= nil then
        return true
    end
    if string.find(v1, "singlewindowdoor", 1, true) then
        return not isUnderBriefingRoom(p1)
    end
    return false
end
local function getModelPivot(p1) -- Line: 61
    local v1, v2
    v1, v2 = pcall(p1.GetPivot, p1)
    if not v1 then
        local PrimaryPart = p1.PrimaryPart
        if not PrimaryPart then
            for i, v in ipairs(p1:GetDescendants()) do
                if v:IsA("BasePart") then
                    PrimaryPart = v
                    break
                end
            end
        end
        if PrimaryPart then
            return PrimaryPart.CFrame
        end
        return CFrame.new()
    elseif typeof(v2) == "CFrame" then
        return v2
    end
end
local function getModelBoundingBox(p1) -- Line: 84 -- upvalues: getModelPivot (val)
    local v1, v2, v3
    v1, v2, v3 = pcall(p1.GetBoundingBox, p1)
    if not v1 or typeof(v2) ~= "CFrame" then
        return getModelPivot(p1), (Vector3.new(6, 6, 6))
    end
    if typeof(v3) == "Vector3" then
        return v2, v3
    end
    return getModelPivot(p1), (Vector3.new(6, 6, 6))
end
local function getHalfExtentAlongAxis(p1, p2, p3) -- Line: 94
    local Unit
    if 0 >= p3.Magnitude then
        Unit = Vector3.new(1, 0, 0)
    else
        Unit = p3.Unit
        if not Unit then
            Unit = Vector3.new(1, 0, 0)
        end
    end
    local v1 = p2.Y * 0.5
    local v2 = math.abs((Unit:Dot(p1.RightVector))) * (p2.X * 0.5)
    local v3 = v2 + math.abs((Unit:Dot(p1.UpVector))) * v1
    return v3 + math.abs((Unit:Dot(p1.LookVector))) * (p2.Z * 0.5)
end
local function findFirstDescendantModel(p1, p2) -- Line: 105
    for i, v in ipairs(p1:GetDescendants()) do
        if v:IsA("Model") and v ~= p1 and p2(v) then
            return v
        end
    end
    return nil
end
local function findModelByNamePattern(p1, p2) -- Line: 114 -- upvalues: findFirstDescendantModel (val)
    return (findFirstDescendantModel(p1, function(p1) -- Line: 115 -- upvalues: p2 (val)
    local v1, v2, v3
    for i, v in ipairs(p2) do
        if string.find(string.lower(p1.Name):gsub("[^%w]", ""), v, 1, true) then
            return true
        end
    end
    return false
end))
end
local function findTopBottomChildModels(p1) -- Line: 126 -- upvalues: getModelPivot (val)
    local v1 = {}
    for i, v in ipairs(p1:GetChildren()) do
        if v:IsA("Model") then
            table.insert(v1, v)
        end
    end
    if #v1 < 2 then
        table.clear(v1)
        for i2, i3 in ipairs(p1:GetDescendants()) do
            if i3:IsA("Model") and i3 ~= p1 then
                table.insert(v1, i3)
            end
        end
    end
    if #v1 < 2 then
        return nil, nil
    end
    table.sort(v1, function(p1, p2) -- Line: 147 -- upvalues: getModelPivot (upval)
        local v1 = getModelPivot(p1).Position.Y < getModelPivot(p2).Position.Y
        return v1
    end)
    return v1[#v1], v1[1]
end
local function findDoorLeaf(p1) -- Line: 154 -- upvalues: findFirstDescendantModel (val)
    local u1 = {"door"}
    local v1 = findFirstDescendantModel(p1, function(p1) -- Line: 115 -- upvalues: u1 (val)
        for i, v in ipairs(u1) do
            if string.find(string.lower(p1.Name):gsub("[^%w]", ""), v, 1, true) then
                return true
            end
        end
        return false
    end)
    if v1 then
        return v1
    end
    return (findFirstDescendantModel(p1, function() -- Line: 160
    return true
end))
end
local function getAttrNumber(p1, p2, p3) -- Line: 165
    local Attribute = p1:GetAttribute(p2)
    if typeof(Attribute) == "number" then
        return Attribute
    end
    return p3
end
local function warnMissing(p1, p2, ...) -- Line: 173
    if p1 then
        local FullName = p2:GetFullName()
        p1(FullName, ...)
    end
end
local function buildLargeGateDoor(p1, p2) -- Line: 179 -- upvalues: findFirstDescendantModel (val), findTopBottomChildModels (val), warnMissing (val), getModelPivot (val)
    local v1, v2, v3, v4, v5, v6, v7, v8
    local u2 = {"upperdoor", "upper"}
    local v9 = findFirstDescendantModel(p1, function(p1) -- Line: 115 -- upvalues: u2 (val)
        for i, v in ipairs(u2) do
            if string.find(string.lower(p1.Name):gsub("[^%w]", ""), v, 1, true) then
                return true
            end
        end
        return false
    end)
    local u10 = {"lowerdoor", "lower"}
    local v10 = findFirstDescendantModel(p1, function(p1) -- Line: 115 -- upvalues: u10 (val)
        for i, v in ipairs(u10) do
            if string.find(string.lower(p1.Name):gsub("[^%w]", ""), v, 1, true) then
                return true
            end
        end
        return false
    end)
    if not v9 then
        v4, v5 = findTopBottomChildModels(p1)
        v9 = v9 or v4
        v10 = v10 or v5
    end
    if not v9 or not v10 then
        warnMissing(p2, p1, "Skipping largeGate without upper/lower parts", p1:GetFullName())
        return nil
    end
    local v11 = v9
    v6, v7, v8 = pcall(v11.GetBoundingBox, v11)
    if not v6 then
        v4 = getModelPivot(v11)
        v5 = Vector3.new(6, 6, 6)
    elseif typeof(v7) == "CFrame" and typeof(v8) == "Vector3" then
        v4 = v7
        v5 = v8
    end
    v7 = v10
    v8, v1, v2 = pcall(v7.GetBoundingBox, v7)
    if not v8 then
        v11 = getModelPivot(v7)
        v6 = Vector3.new(6, 6, 6)
    elseif typeof(v1) == "CFrame" and typeof(v2) == "Vector3" then
        v11 = v1
        v6 = v2
    end
    v7 = math.max(v5.Y, v6.Y, 6)
    local Attribute = p1:GetAttribute("AutoDoorSlideDistance")
    if typeof(Attribute) ~= "number" then
        v8 = v7
    else
        v8 = Attribute
    end
    local Attribute_2 = p1:GetAttribute("AutoDoorTweenTime")
    if typeof(Attribute_2) ~= "number" then
        v1 = 1.5
    else
        v1 = Attribute_2
    end
    v2 = {
        Type = "largegate",
        Open = false,
        OpenSoundId = "rbxassetid://110428049010781",
        CloseSoundId = "rbxassetid://76567106762000",
        Id = p1:GetFullName(),
        Model = p1,
    }
    local Attribute_3 = p1:GetAttribute("AutoDoorRadius")
    if typeof(Attribute_3) ~= "number" then
        v3 = 12
    else
        v3 = Attribute_3
    end
    v2.Radius = v3
    local Attribute_4 = p1:GetAttribute("AutoDoorCloseDelay")
    if typeof(Attribute_4) ~= "number" then
        v3 = 0.75
    else
        v3 = Attribute_4
    end
    v2.CloseDelay = v3
    v2.TweenTime = v1
    v3 = {}
    local v12 = {Model = v10, Closed = v11, Open = v11 - v11.UpVector * v8}
    v3[1] = {Model = v9, Closed = v4, Open = v4 + v4.UpVector * v8}
    v3[2] = v12
    v2.Movers = v3
    return v2
end
local function buildDoubleDoors(p1, p2) -- Line: 225 -- upvalues: findFirstDescendantModel (val), warnMissing (val), getModelPivot (val), getHalfExtentAlongAxis (val)
    local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11
    local u2 = {"leftdoor", "doorleft", "left"}
    local v12 = findFirstDescendantModel(p1, function(p1) -- Line: 115 -- upvalues: u2 (val)
        for i, v in ipairs(u2) do
            if string.find(string.lower(p1.Name):gsub("[^%w]", ""), v, 1, true) then
                return true
            end
        end
        return false
    end)
    local u11 = {"rightdoor", "doorright", "right"}
    local v13 = findFirstDescendantModel(p1, function(p1) -- Line: 115 -- upvalues: u11 (val)
        for i, v in ipairs(u11) do
            if string.find(string.lower(p1.Name):gsub("[^%w]", ""), v, 1, true) then
                return true
            end
        end
        return false
    end)
    if not v12 or not v13 then
        warnMissing(p2, p1, "Skipping doubleDoors without left/right parts", p1:GetFullName())
        return nil
    end
    v8, v9, v10 = pcall(v12.GetBoundingBox, v12)
    if not v8 then
        v6 = getModelPivot(v12)
        v7 = Vector3.new(6, 6, 6)
    elseif typeof(v9) == "CFrame" and typeof(v10) == "Vector3" then
        v6 = v9
        v7 = v10
    end
    v10, v11, v1 = pcall(v13.GetBoundingBox, v13)
    if not v10 then
        v8 = getModelPivot(v13)
        v9 = Vector3.new(6, 6, 6)
    elseif typeof(v11) == "CFrame" and typeof(v1) == "Vector3" then
        v8 = v11
        v9 = v1
    end
    local RightVector = v8.Position - v6.Position
    if RightVector.Magnitude < 0.001 then
        RightVector = getModelPivot(p1).RightVector
    end
    local Unit = RightVector.Unit
    v11 = getHalfExtentAlongAxis(v6, v7, Unit)
    v1 = getHalfExtentAlongAxis(v8, v9, Unit)
    local v14 = math.max(v11 * 2, v1 * 2)
    if 0.05 >= v14 then
        v2 = 6
    else
        v2 = v14
    end
    local Attribute = p1:GetAttribute("AutoDoorSlideDistance")
    if typeof(Attribute) ~= "number" then
        v3 = v2
    else
        v3 = Attribute
    end
    local Attribute_2 = p1:GetAttribute("AutoDoorTweenTime")
    if typeof(Attribute_2) ~= "number" then
        v4 = 1.25
    else
        v4 = Attribute_2
    end
    local v15 = {
        Type = "doubledoors",
        Open = false,
        OpenSoundId = "rbxassetid://120593972038273",
        CloseSoundId = "rbxassetid://97990188684793",
        Id = p1:GetFullName(),
        Model = p1,
    }
    local Attribute_3 = p1:GetAttribute("AutoDoorRadius")
    if typeof(Attribute_3) ~= "number" then
        v5 = 12
    else
        v5 = Attribute_3
    end
    v15.Radius = v5
    local Attribute_4 = p1:GetAttribute("AutoDoorCloseDelay")
    if typeof(Attribute_4) ~= "number" then
        v5 = 0.75
    else
        v5 = Attribute_4
    end
    v15.CloseDelay = v5
    v15.TweenTime = v4
    local Attribute_5 = p1:GetAttribute("AutoDoorOpenTweenTime")
    if typeof(Attribute_5) ~= "number" then
        v5 = 1.25
    else
        v5 = Attribute_5
    end
    v15.OpenTweenTime = v5
    v15.CloseTweenTime = v4
    v15.Movers = {
        {Model = v12, Closed = v6, Open = v6 - Unit * v3},
        {Model = v13, Closed = v8, Open = v8 + Unit * v3},
    }
    return v15
end
local function buildSingleWindowDoor(p1, p2) -- Line: 278 -- upvalues: findDoorLeaf (val), warnMissing (val), getModelPivot (val), getHalfExtentAlongAxis (val)
    local LookVector, v1, v2, v3, v4, v5, v6, v7, v8
    local v9 = findDoorLeaf(p1)
    if not v9 then
        warnMissing(p2, p1, "Skipping singleWindowDoor without child door model", p1:GetFullName())
        return nil
    end
    local v10 = getModelPivot(v9)
    v5, v6, v7 = pcall(v9.GetBoundingBox, v9)
    if not v5 then
        v3 = getModelPivot(v9)
        v4 = Vector3.new(6, 6, 6)
    elseif typeof(v6) == "CFrame" and typeof(v7) == "Vector3" then
        v3 = v6
        v4 = v7
    end
    v5 = v4.X < v4.Z
    if not v5 then
        LookVector = v3.RightVector
    else
        LookVector = v3.LookVector
    end
    v7 = getHalfExtentAlongAxis(v3, v4, LookVector) * 2
    local Attribute = p1:GetAttribute("AutoDoorSlideDistance")
    if typeof(Attribute) ~= "number" then
        v8 = v7
    else
        v8 = Attribute
    end
    local Attribute_2 = p1:GetAttribute("AutoDoorSlideSign")
    if typeof(Attribute_2) ~= "number" then
        v1 = -1
    else
        v1 = Attribute_2
    end
    local v11 = {
        Type = "singlewindowdoor",
        Open = false,
        OpenSoundId = "rbxassetid://103078327187339",
        CloseSoundId = "rbxassetid://80748848783665",
        Id = p1:GetFullName(),
        Model = p1,
    }
    local Attribute_3 = p1:GetAttribute("AutoDoorRadius")
    if typeof(Attribute_3) ~= "number" then
        v2 = 12
    else
        v2 = Attribute_3
    end
    v11.Radius = v2
    local Attribute_4 = p1:GetAttribute("AutoDoorCloseDelay")
    if typeof(Attribute_4) ~= "number" then
        v2 = 0.75
    else
        v2 = Attribute_4
    end
    v11.CloseDelay = v2
    local Attribute_5 = p1:GetAttribute("AutoDoorTweenTime")
    if typeof(Attribute_5) ~= "number" then
        v2 = 0.45
    else
        v2 = Attribute_5
    end
    v11.TweenTime = v2
    v11.Movers = {
        {Model = v9, Closed = v10, Open = v10 + LookVector * (v1 * v8)},
    }
    return v11
end
function v1.buildDoorRecord(p1, p2) -- Line: 314 -- upvalues: buildLargeGateDoor (val), buildDoubleDoors (val), buildSingleWindowDoor (val)
    local v1 = string.lower(p1.Name):gsub("[^%w]", "")
    if string.find(v1, "fake", 1, true) then
        return nil
    end
    if string.find(v1, "largegate", 1, true) then
        return (buildLargeGateDoor(p1, p2))
    end
    if string.find(v1, "doubledoors", 1, true) then
        return (buildDoubleDoors(p1, p2))
    end
    if string.find(v1, "singlewindowdoor", 1, true) then
        return (buildSingleWindowDoor(p1, p2))
    end
    return nil
end
return v1