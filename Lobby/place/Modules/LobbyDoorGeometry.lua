local v1 = {}

local function normalizeName(p1) -- Line: 22
    return string.lower(p1):gsub("[^%w]", "")
end

local function isUnderBriefingRoom(p1) -- Line: 27
    local Name, v1
    local Parent = p1.Parent
    while Parent do
        if Parent:IsA("Model") then
            Name = Parent.Name
            v1 = string.lower(Name):gsub("[^%w]", "")
            if string.find(v1, "briefingroom", 1, true) then
                return true
            end
        end
        Parent = Parent.Parent
    end
    return false
end

function v1.shouldAutoDiscover(p1) -- Line: 41 -- upvalues: isUnderBriefingRoom (val)
    local Name = p1.Name
    local v1 = string.lower(Name):gsub("[^%w]", "")
    if string.find(v1, "fake", 1, true) then
        return false
    end
    if string.find(v1, "largegate", 1, true) == nil and string.find(v1, "doubledoors", 1, true) == nil then
        if string.find(v1, "singlewindowdoor", 1, true) then
            return not isUnderBriefingRoom(p1)
        end
        return false
    end
    return true
end

local function getModelPivot(p1) -- Line: 61
    local success, result = pcall(p1.GetPivot, p1)
    if success and typeof(result) == "CFrame" then
        return result
    end
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
end

local function getModelBoundingBox(p1) -- Line: 84 -- upvalues: getModelPivot (val)
    local success, result, v1 = pcall(p1.GetBoundingBox, p1)
    if success and typeof(result) == "CFrame" and typeof(v1) == "Vector3" then
        return result, v1
    end
    return getModelPivot(p1), (Vector3.new(6, 6, 6))
end

local function getHalfExtentAlongAxis(p1, p2, p3) -- Line: 94
    local Unit
    if not (0 < p3.Magnitude) then
        Unit = Vector3.new(1, 0, 0)
    else
        Unit = p3.Unit
        if not Unit then
            Unit = Vector3.new(1, 0, 0)
        end
    end
    local v1 = p2.X * 0.5
    local v2 = p2.Y * 0.5
    local v3 = p2.Z * 0.5
    local RightVector = p1.RightVector
    local v4 = Unit:Dot(RightVector)
    local v5 = math.abs(v4) * v1
    local UpVector = p1.UpVector
    local v6 = Unit:Dot(UpVector)
    local v7 = v5 + math.abs(v6) * v2
    local LookVector = p1.LookVector
    v4 = Unit:Dot(LookVector)
    return v7 + math.abs(v4) * v3
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
    local v1 = findFirstDescendantModel
    return (v1(p1, function(p1) -- Line: 115 -- upvalues: p2 (val)
        local Name = p1.Name
        local v1 = string.lower(Name):gsub("[^%w]", "")
        for i, v in ipairs(p2) do
            if string.find(v1, v, 1, true) then
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
    local v1 = findFirstDescendantModel
    local v2 = v1(p1, function(p1) -- Line: 115 -- upvalues: u1 (val)
        local Name = p1.Name
        local v1 = string.lower(Name):gsub("[^%w]", "")
        for i, v in ipairs(u1) do
            if string.find(v1, v, 1, true) then
                return true
            end
        end
        return false
    end)
    if v2 then
        return v2
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

local function buildLargeGateDoor(p1, p2) -- Line: 179
    -- upvalues: findFirstDescendantModel (val), findTopBottomChildModels (val), warnMissing (val), getModelPivot (val)
    local u2 = {"upperdoor", "upper"}
    local v1 = findFirstDescendantModel
    local v2 = v1(p1, function(p1) -- Line: 115 -- upvalues: u2 (val)
        local Name = p1.Name
        local v1 = string.lower(Name):gsub("[^%w]", "")
        for i, v in ipairs(u2) do
            if string.find(v1, v, 1, true) then
                return true
            end
        end
        return false
    end)
    local u10 = {"lowerdoor", "lower"}
    local v3 = findFirstDescendantModel
    local v4 = v3(p1, function(p1) -- Line: 115 -- upvalues: u10 (val)
        local Name = p1.Name
        local v1 = string.lower(Name):gsub("[^%w]", "")
        for i, v in ipairs(u10) do
            if string.find(v1, v, 1, true) then
                return true
            end
        end
        return false
    end)
    if not v2 or not v4 then
        v1, v3 = findTopBottomChildModels(p1)
        v2 = v2 or v1
        v4 = v4 or v3
    end
    if v2 and v4 then
        local v5, v6, v7
        local v8 = v2
        local success, result, v9 = pcall(v8.GetBoundingBox, v8)
        if not success or typeof(result) ~= "CFrame" or typeof(v9) ~= "Vector3" then
            v1 = getModelPivot(v8)
            v3 = Vector3.new(6, 6, 6)
        else
            v1 = result
            v3 = v9
        end
        local v10 = v4
        local success_2, result_2, v11 = pcall(v10.GetBoundingBox, v10)
        if not success_2 or typeof(result_2) ~= "CFrame" or typeof(v11) ~= "Vector3" then
            v8 = getModelPivot(v10)
            v7 = Vector3.new(6, 6, 6)
        else
            v8 = result_2
            v7 = v11
        end
        local Y = v3.Y
        local Y_2 = v7.Y
        v10 = math.max(Y, Y_2, 6)
        local Attribute = p1:GetAttribute("AutoDoorSlideDistance")
        if typeof(Attribute) ~= "number" then
            v9 = v10
        else
            v9 = Attribute
        end
        local Attribute_2 = p1:GetAttribute("AutoDoorTweenTime")
        if typeof(Attribute_2) ~= "number" then
            v5 = 1.5
        else
            v5 = Attribute_2
        end
        v11 = {
            Type = "largegate",
            Open = false,
            OpenSoundId = "rbxassetid://110428049010781",
            CloseSoundId = "rbxassetid://76567106762000",
            Id = p1:GetFullName(),
            Model = p1,
        }
        local Attribute_3 = p1:GetAttribute("AutoDoorRadius")
        if typeof(Attribute_3) ~= "number" then
            v6 = 12
        else
            v6 = Attribute_3
        end
        v11.Radius = v6
        local Attribute_4 = p1:GetAttribute("AutoDoorCloseDelay")
        if typeof(Attribute_4) ~= "number" then
            v6 = 0.75
        else
            v6 = Attribute_4
        end
        v11.CloseDelay = v6
        v11.TweenTime = v5
        v6 = {}
        local v12 = {Model = v2, Closed = v1, Open = v1 + v1.UpVector * v9}
        local v13 = {Model = v4, Closed = v8, Open = v8 - v8.UpVector * v9}
        v6[1] = v12
        v6[2] = v13
        v11.Movers = v6
        return v11
    end
    warnMissing(p2, p1, "Skipping largeGate without upper/lower parts", p1:GetFullName())
    return nil
end

local function buildDoubleDoors(p1, p2) -- Line: 225
    -- upvalues: findFirstDescendantModel (val), warnMissing (val), getModelPivot (val), getHalfExtentAlongAxis (val)
    local u2 = {"leftdoor", "doorleft", "left"}
    local v1 = findFirstDescendantModel
    local v2 = v1(p1, function(p1) -- Line: 115 -- upvalues: u2 (val)
        local Name = p1.Name
        local v1 = string.lower(Name):gsub("[^%w]", "")
        for i, v in ipairs(u2) do
            if string.find(v1, v, 1, true) then
                return true
            end
        end
        return false
    end)
    local u11 = {"rightdoor", "doorright", "right"}
    local v3 = findFirstDescendantModel
    local v4 = v3(p1, function(p1) -- Line: 115 -- upvalues: u11 (val)
        local Name = p1.Name
        local v1 = string.lower(Name):gsub("[^%w]", "")
        for i, v in ipairs(u11) do
            if string.find(v1, v, 1, true) then
                return true
            end
        end
        return false
    end)
    if v2 and v4 then
        local v5, v6, v7, v8
        local success, result, v9 = pcall(v2.GetBoundingBox, v2)
        if not success or typeof(result) ~= "CFrame" or typeof(v9) ~= "Vector3" then
            v1 = getModelPivot(v2)
            v3 = Vector3.new(6, 6, 6)
        else
            v1 = result
            v3 = v9
        end
        local success_2, result_2, v10 = pcall(v4.GetBoundingBox, v4)
        if not success_2 or typeof(result_2) ~= "CFrame" or typeof(v10) ~= "Vector3" then
            v7 = getModelPivot(v4)
            v8 = Vector3.new(6, 6, 6)
        else
            v7 = result_2
            v8 = v10
        end
        local RightVector = v7.Position - v1.Position
        if RightVector.Magnitude < 0.001 then
            RightVector = getModelPivot(p1).RightVector
        end
        local Unit = RightVector.Unit
        local v11 = getHalfExtentAlongAxis(v1, v3, Unit)
        v10 = getHalfExtentAlongAxis(v7, v8, Unit)
        local v12 = v11 * 2
        local v13 = v10 * 2
        local v14 = math.max(v12, v13)
        v12 = 0.05 < v14 and v14 or 6
        local Attribute = p1:GetAttribute("AutoDoorSlideDistance")
        if typeof(Attribute) ~= "number" then
            v13 = v12
        else
            v13 = Attribute
        end
        local Attribute_2 = p1:GetAttribute("AutoDoorTweenTime")
        if typeof(Attribute_2) ~= "number" then
            v5 = 1.25
        else
            v5 = Attribute_2
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
            v6 = 12
        else
            v6 = Attribute_3
        end
        v15.Radius = v6
        local Attribute_4 = p1:GetAttribute("AutoDoorCloseDelay")
        if typeof(Attribute_4) ~= "number" then
            v6 = 0.75
        else
            v6 = Attribute_4
        end
        v15.CloseDelay = v6
        v15.TweenTime = v5
        local Attribute_5 = p1:GetAttribute("AutoDoorOpenTweenTime")
        if typeof(Attribute_5) ~= "number" then
            v6 = 1.25
        else
            v6 = Attribute_5
        end
        v15.OpenTweenTime = v6
        v15.CloseTweenTime = v5
        v6 = {}
        local v16 = {Model = v2, Closed = v1, Open = v1 - Unit * v13}
        local v17 = {Model = v4, Closed = v7, Open = v7 + Unit * v13}
        v6[1] = v16
        v6[2] = v17
        v15.Movers = v6
        return v15
    end
    warnMissing(p2, p1, "Skipping doubleDoors without left/right parts", p1:GetFullName())
    return nil
end

local function buildSingleWindowDoor(p1, p2) -- Line: 278
    -- upvalues: findDoorLeaf (val), warnMissing (val), getModelPivot (val), getHalfExtentAlongAxis (val)
    local LookVector, v1, v2, v3, v4, v5
    local v6 = findDoorLeaf(p1)
    if not v6 then
        warnMissing(p2, p1, "Skipping singleWindowDoor without child door model", p1:GetFullName())
        return nil
    end
    local v7 = getModelPivot(v6)
    local success, result, v8 = pcall(v6.GetBoundingBox, v6)
    if not success or typeof(result) ~= "CFrame" or typeof(v8) ~= "Vector3" then
        v3 = getModelPivot(v6)
        v4 = Vector3.new(6, 6, 6)
    else
        v3 = result
        v4 = v8
    end
    local Z = v4.Z
    local v9 = v4.X < Z
    if not v9 then
        LookVector = v3.RightVector
    else
        LookVector = v3.LookVector
        if not LookVector then
            LookVector = v3.RightVector
        end
    end
    v8 = getHalfExtentAlongAxis(v3, v4, LookVector) * 2
    local Attribute = p1:GetAttribute("AutoDoorSlideDistance")
    if typeof(Attribute) ~= "number" then
        v5 = v8
    else
        v5 = Attribute
    end
    local Attribute_2 = p1:GetAttribute("AutoDoorSlideSign")
    if typeof(Attribute_2) ~= "number" then
        v1 = -1
    else
        v1 = Attribute_2
    end
    local v10 = {
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
    v10.Radius = v2
    local Attribute_4 = p1:GetAttribute("AutoDoorCloseDelay")
    if typeof(Attribute_4) ~= "number" then
        v2 = 0.75
    else
        v2 = Attribute_4
    end
    v10.CloseDelay = v2
    local Attribute_5 = p1:GetAttribute("AutoDoorTweenTime")
    if typeof(Attribute_5) ~= "number" then
        v2 = 0.45
    else
        v2 = Attribute_5
    end
    v10.TweenTime = v2
    v10.Movers = {
        {Model = v6, Closed = v7, Open = v7 + LookVector * (v1 * v5)},
    }
    return v10
end

function v1.buildDoorRecord(p1, p2) -- Line: 314
    -- upvalues: buildLargeGateDoor (val), buildDoubleDoors (val), buildSingleWindowDoor (val)
    local Name = p1.Name
    local v1 = string.lower(Name):gsub("[^%w]", "")
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