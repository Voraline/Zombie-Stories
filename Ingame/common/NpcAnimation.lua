local ContentProvider = game:GetService("ContentProvider")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local u25 = {
    High = {maxTracks = 20, radius = 140, frustum = false, lineOfSight = false},
    Medium = {maxTracks = 10, radius = 90, frustum = true, lineOfSight = false},
    Low = {maxTracks = 6, radius = 55, frustum = true, lineOfSight = true},
}
local u29 = {}
u29.__index = u29

local function disconnect(p1) -- Line: 30
    if p1 then
        p1:Disconnect()
    end
end

local function findCaseInsensitiveChild(p1, p2) -- Line: 36
    local v1 = string.lower(p2)
    for i, v in ipairs(p1:GetChildren()) do
        if string.lower(v.Name) == v1 then
            return v
        end
    end
    return nil
end

local function getRoot(p1) -- Line: 46
    local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart")
    if not HumanoidRootPart then
        HumanoidRootPart = p1.PrimaryPart
    end
    if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
        return HumanoidRootPart
    end
    return p1:FindFirstChildWhichIsA("BasePart", true)
end

local function getLookAtTarget(p1) -- Line: 54
    if typeof(p1) ~= "Instance" then
        return nil
    end
    if p1:IsA("BasePart") then
        return p1
    end
    if p1:IsA("Model") then
        local Head = p1:FindFirstChild("Head", true)
        if Head and Head:IsA("BasePart") then
            return Head
        end
        local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart", true)
        if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
            return HumanoidRootPart
        end
    end
    return nil
end

local function getHeadNeck(p1) -- Line: 74
    local Head = p1:FindFirstChild("Head", true)
    if Head and Head:IsA("BasePart") then
        for i, v in ipairs(p1:GetDescendants()) do
            if v:IsA("Motor6D") and v.Part1 == Head and v.Part0 and v.Part0:IsA("BasePart") then
                return Head, v
            end
        end
        return Head, nil
    end
    return nil, nil
end

local function getIdleId(p1, p2) -- Line: 90
    local Attribute = p1:GetAttribute("NpcIdleAnimation")
    if typeof(Attribute) == "string" and Attribute ~= "" then
        return Attribute
    end
    local v1 = p2[p1.Name]
    local idleByOccurrence = v1
    if idleByOccurrence then
        idleByOccurrence = v1.idleByOccurrence
    end
    if type(idleByOccurrence) == "table" and p1.Parent then
        local v2
        local v3 = 0
        for i, v in ipairs(p1.Parent:GetChildren()) do
            if v:IsA("Model") and v.Name == p1.Name then
                v3 = v3 + 1
                if v == p1 then
                    v2 = idleByOccurrence[v3]
                    if typeof(v2) ~= "string" or v2 == "" then
                        break
                    end
                    return v2
                end
            end
        end
    end
    local idle = v1
    if idle then
        idle = v1.idle
    end
    if typeof(idle) == "string" and idle ~= "" then
        return idle
    end
    return nil
end

local function resolveAutoTier(p1) -- Line: 116 -- upvalues: UserInputService (val)
    local TouchEnabled = UserInputService.TouchEnabled
    if TouchEnabled then
        TouchEnabled = not UserInputService.KeyboardEnabled
    end
    local Attribute = p1:GetAttribute("ClientCPULoad")
    local v1 = tonumber(Attribute) or 0
    if not TouchEnabled and not (60 <= v1) then
        if 35 <= v1 then
            return "Medium"
        end
        return "High"
    end
    return "Low"
end

function u29.new(p1) -- Line: 127 -- upvalues: u29 (val), Players (val), u25 (val)
    local v1 = u29
    local v2 = setmetatable({}, v1)
    local Player = p1.Player
    if not Player then
        Player = Players.LocalPlayer
    end
    v2.Player = Player
    local Containers = p1.Containers
    if not Containers then
        Containers = p1.containerNames
        if not Containers then
            Containers = {}
        end
    end
    v2.ContainerNames = Containers
    local Npcs = p1.Npcs
    if not Npcs then
        Npcs = p1.npcs
        if not Npcs then
            Npcs = {}
        end
    end
    v2.Npcs = Npcs
    local Tiers = p1.Tiers
    if not Tiers then
        Tiers = p1.tiers
        if not Tiers then
            Tiers = u25
        end
    end
    v2.Tiers = Tiers
    local v3 = p1.Enabled ~= false
    v2.Enabled = v3
    v2.States = {}
    v2.StateByModel = {}
    v2.Connections = {}
    v2.NpcContainers = {}
    v2.LosParams = RaycastParams.new()
    v2.LosParams.FilterType = Enum.RaycastFilterType.Exclude
    v2.LosParams.IgnoreWater = true
    v2.LosFilterCharacter = nil
    v2.LosFilterIgnore = nil
    v2.Accumulator = 0
    v2.CurrentTier = nil
    v2.Warned = {}
    v2.Initialized = false
    return v2
end

function u29:_warnOnce(p2, p3) -- Line: 150
    if self.Warned[p2] then
        return
    end
    self.Warned[p2] = true
    warn("[NpcAnimation] " .. p3)
end

function u29:_refreshTier() -- Line: 158 -- upvalues: UserInputService (val)
    local v1, v2
    local Attribute = self.Player:GetAttribute("QualityTier")
    if Attribute == "High" or Attribute == "Medium" then
        v1 = Attribute
    elseif Attribute ~= "Low" then
        local Player = self.Player
        local TouchEnabled = UserInputService.TouchEnabled
        if TouchEnabled then
            TouchEnabled = not UserInputService.KeyboardEnabled
        end
        local Attribute_2 = Player:GetAttribute("ClientCPULoad")
        v2 = tonumber(Attribute_2) or 0
        if TouchEnabled or 60 <= v2 then
            v1 = "Low"
        elseif not (35 <= v2) then
            v1 = "High"
        else
            v1 = "Medium"
        end
    else
        v1 = Attribute
    end
    if not self.Tiers[v1] then
        v1 = "High"
    end
    if v1 == self.CurrentTier then
        return
    end
    self.CurrentTier = v1
    v2 = os.clock()
    self:_applyBudget(v2, true)
end

function u29:_registerModel(p2) -- Line: 175 -- upvalues: getIdleId (val)
    if p2:IsA("Model") and not self.StateByModel[p2] then
        local v1
        local v2 = getIdleId(p2, self.Npcs)
        if not v2 then
            return
        end
        local Humanoid = p2:FindFirstChildWhichIsA("Humanoid", true)
        local HumanoidRootPart = p2:FindFirstChild("HumanoidRootPart")
        if not HumanoidRootPart then
            HumanoidRootPart = p2.PrimaryPart
        end
        if not HumanoidRootPart or not HumanoidRootPart:IsA("BasePart") then
            v1 = p2:FindFirstChildWhichIsA("BasePart", true)
        else
            v1 = HumanoidRootPart
        end
        if Humanoid and v1 then
            local v3 = {
                IdleActive = false,
                IdleStartedAt = 0,
                SeededTimePosition = false,
                Eligible = false,
                DistanceFrustumEligible = false,
                DistanceSq = (1 / 0),
                LineOfSight = false,
                LosMisses = 0,
                LosCheckedAt = 0,
                SeedGeneration = 0,
                OverrideGeneration = 0,
                CreatedAnimator = false,
                Model = p2,
                Humanoid = Humanoid,
                Root = v1,
                IdleId = v2,
                OverrideTracks = {},
            }
            local preloadAnimations = self.Npcs[p2.Name]
            if preloadAnimations then
                preloadAnimations = self.Npcs[p2.Name].preloadAnimations
            end
            v3.PreloadAnimationIds = preloadAnimations
            self.StateByModel[p2] = v3
            local States = self.States
            table.insert(States, v3)
            return
        end
        local format = string.format
        local FullName = p2:GetFullName()
        local v4 = format("Skipping %s because it has no Humanoid/root part", FullName)
        self:_warnOnce(p2, v4)
        return
    end
end

function u29:_preloadConfiguredAnimations() -- Line: 221 -- upvalues: ContentProvider (val)
    local Animation, PreloadAnimationIds, v1
    local u85 = {}
    local v2 = {}
    for i, v in ipairs(self.States) do
        v1 = ipairs
        PreloadAnimationIds = v.PreloadAnimationIds
        if not PreloadAnimationIds then
            PreloadAnimationIds = {}
        end
        for i2, i3 in v1(PreloadAnimationIds) do
            if typeof(i3) == "string" and i3 ~= "" and not v2[i3] then
                v2[i3] = true
                Animation = Instance.new("Animation")
                Animation.Name = "NpcPreload"
                Animation.AnimationId = i3
                table.insert(u85, Animation)
            end
        end
    end
    if #u85 == 0 then
        return
    end
    local success, result = pcall(function() -- Line: 239 -- upvalues: ContentProvider (upval), u85 (val)
        local v1 = ContentProvider
        local v2 = u85
        v1:PreloadAsync(v2)
    end)
    for i4, j in ipairs(u85) do
        j:Destroy()
    end
    if not success then
        v1 = "Could not preload configured NPC animations (" .. (tostring(result)) .. ")"
        v3:_warnOnce("configured-preload", v1)
    end
end

function u29:_scanModels() -- Line: 250 -- upvalues: findCaseInsensitiveChild (val)
    local NpcContainers, v1, v2, v3
    local v4 = self
    for i, v in ipairs(self.ContainerNames) do
        v2 = findCaseInsensitiveChild(workspace, v)
        if v2 then
            NpcContainers = v4.NpcContainers
            table.insert(NpcContainers, v2)
            for i2, i3 in ipairs(v2:GetChildren()) do
                v4:_registerModel(i3)
            end
        else
            v3 = "container:" .. v
            v1 = string.format("Container %s was not found", v)
            v4:_warnOnce(v3, v1)
        end
    end
end

function u29:_refreshLosFilters(p2, p3) -- Line: 264
    local Ignore = workspace:FindFirstChild("Ignore")
    if not p3 and self.LosFilterCharacter == p2 and self.LosFilterIgnore == Ignore then
        return
    end
    local v1 = {}
    if p2 then
        table.insert(v1, p2)
    end
    if Ignore then
        table.insert(v1, Ignore)
    end
    for i, v in ipairs(self.NpcContainers) do
        if v.Parent then
            table.insert(v1, v)
        end
    end
    self.LosParams.FilterDescendantsInstances = v1
    self.LosFilterCharacter = p2
    self.LosFilterIgnore = Ignore
end

function u29._getAnimator(p1, p2) -- Line: 288
    if p2.Animator and p2.Animator.Parent then
        return p2.Animator
    end
    local Animator = p2.Humanoid:FindFirstChildOfClass("Animator")
    if not Animator then
        Animator = Instance.new("Animator")
        Animator.Name = "NpcAnimationDirectorAnimator"
        Animator.Parent = p2.Humanoid
        p2.CreatedAnimator = true
    end
    p2.Animator = Animator
    return Animator
end

function u29:_loadTrack(p2, p3, p4, p5, p6) -- Line: 303
    local Animation = Instance.new("Animation")
    Animation.Name = p5
    Animation.AnimationId = p3
    local success, result = pcall(function() -- Line: 307 -- upvalues: self (val), p2 (val), Animation (val)
        local v1 = self
        local v2 = p2
        v1 = v1:_getAnimator(v2)
        v2 = Animation
        return v1:LoadAnimation(v2)
    end)
    if success and result then
        local v1
        result.Priority = p4
        if p6 ~= nil then
            v1 = p6 == true
        else
            v1 = true
        end
        result.Looped = v1
        return result, Animation
    end
    Animation:Destroy()
    local v2 = (p2.Model:GetFullName()) .. ":" .. p3
    local format = string.format
    local FullName_2 = p2.Model:GetFullName()
    local v3 = tostring(result)
    local v4 = format("Could not load %s for %s (%s)", p3, FullName_2, v3)
    self:_warnOnce(v2, v4)
    return nil, nil
end

function u29._seedOrRestorePosition(p1, p2, p3) -- Line: 323
    local SeedGeneration = p2.SeedGeneration

    local function seedOrRestore() -- Line: 325 -- upvalues: p2 (val), p3 (val)
        pcall(function() -- Line: 326 -- upvalues: p2 (upval), p3 (upval)
            local v1, v2, v3
            if p2.SavedTimePosition then
                v1 = p3
                v2 = p2
                local SavedTimePosition = v2.SavedTimePosition
                v3 = p3.Length - 0.01
                local v4 = math.max(v3, 0)
                v1.TimePosition = math.min(SavedTimePosition, v4)
                return
            end
            if not p2.SeededTimePosition then
                v1 = p3
                v2 = math.random()
                v3 = p3.Length - 0.01
                v1.TimePosition = v2 * math.max(v3, 0)
                p2.SeededTimePosition = true
            end
        end)
    end

    if 0 < p3.Length then
        pcall(function() -- Line: 326 -- upvalues: p2 (val), p3 (val)
            local v1, v2, v3
            if p2.SavedTimePosition then
                v1 = p3
                v2 = p2
                local SavedTimePosition = v2.SavedTimePosition
                v3 = p3.Length - 0.01
                local v4 = math.max(v3, 0)
                v1.TimePosition = math.min(SavedTimePosition, v4)
                return
            end
            if not p2.SeededTimePosition then
                v1 = p3
                v2 = math.random()
                v3 = p3.Length - 0.01
                v1.TimePosition = v2 * math.max(v3, 0)
                p2.SeededTimePosition = true
            end
        end)
        return
    end
    task.spawn(function() -- Line: 341 -- upvalues: p1 (val), p3 (val), p2 (val), SeedGeneration (val)
        local v1 = os.clock() + 2
        while p1.Initialized do
            if not (p3.Length <= 0) or not (os.clock() < v1) then
                break
            end
            task.wait()
        end
        if p1.Initialized and p2.SeedGeneration == SeedGeneration and not (p3.Length <= 0) and p3.IsPlaying then
            pcall(function() -- Line: 326 -- upvalues: p2 (upval), p3 (upval)
                local v1, v2, v3
                if p2.SavedTimePosition then
                    v1 = p3
                    v2 = p2
                    local SavedTimePosition = v2.SavedTimePosition
                    v3 = p3.Length - 0.01
                    local v4 = math.max(v3, 0)
                    v1.TimePosition = math.min(SavedTimePosition, v4)
                    return
                end
                if not p2.SeededTimePosition then
                    v1 = p3
                    v2 = math.random()
                    v3 = p3.Length - 0.01
                    v1.TimePosition = v2 * math.max(v3, 0)
                    p2.SeededTimePosition = true
                end
            end)
            return
        end
    end)
end

function u29:_startIdle(p2, p3, p4) -- Line: 353
    if not p2.IdleActive and not p2.Override and p2.Model.Parent then
        if not p4 and p2.IdleStoppedAt and p3 - p2.IdleStoppedAt < 0.5 then
            return
        end
        if not p2.IdleTrack then
            local IdleId = p2.IdleId
            local Idle = Enum.AnimationPriority.Idle
            local v1, v2 = self:_loadTrack(p2, IdleId, Idle, "NpcIdle")
            if not v1 then
                p2.Eligible = false
                return
            end
            p2.IdleTrack = v1
            p2.IdleAnimation = v2
        end
        if not pcall(function() -- Line: 369 -- upvalues: p2 (val)
            local v0, v1
            p2.IdleTrack:Play(0.2, 1, 1)
            return
        end) then
            local v3 = (p2.Model:GetFullName()) .. ":play"
            local v4 = "Could not play idle for " .. (p2.Model:GetFullName())
            self:_warnOnce(v3, v4)
            return
        end
        p2.IdleActive = true
        p2.IdleStartedAt = p3
        p2.SeedGeneration = p2.SeedGeneration + 1
        local IdleTrack = p2.IdleTrack
        self:_seedOrRestorePosition(p2, IdleTrack)
        return
    end
end

function u29._stopIdle(p1, p2, p3, p4) -- Line: 382
    if p2.IdleActive and p2.IdleTrack then
        pcall(function() -- Line: 386 -- upvalues: p2 (val), p3 (val)
            local v1
            if 0 < p2.IdleTrack.Length then
                p2.SavedTimePosition = p2.IdleTrack.TimePosition
            end
            local IdleTrack = p2.IdleTrack
            if not p3 then
                v1 = 0.35
            else
                v1 = 0
            end
            IdleTrack:Stop(v1)
        end)
        p2.IdleActive = false
        local v1 = p4
        if not v1 then
            v1 = os.clock()
        end
        p2.IdleStoppedAt = v1
        return
    end
end

function u29:_hasLineOfSight(p2, p3) -- Line: 396
    local Position = p3.CFrame.Position
    local v1 = p2.Root.Position - Position
    if v1.Magnitude <= 0 then
        return true
    end
    local v2 = workspace
    local LosParams = self.LosParams
    local v3 = v2:Raycast(Position, v1, LosParams) == nil
    return v3
end

function u29._scoreDistanceAndFrustum(p1, p2, p3, p4, p5) -- Line: 405
    if p2.Model.Parent and p2.Root.Parent then
        local v1
        local v2 = p2.Root.Position - p4
        local v3 = v2:Dot(v2)
        local radius = p3.radius
        if not p2.IdleActive then
            v1 = 1
        else
            v1 = 1.15
        end
        local v4 = radius * v1
        local v5 = v3 <= v4 * v4
        if v5 and p3.frustum then
            if p5 then
                v1 = p2.Root.Position - p5.CFrame.Position
                if 0 < v1.Magnitude then
                    local Unit = v1.Unit
                    local LookVector = p5.CFrame.LookVector
                    if (Unit:Dot(LookVector)) < -0.2 then
                        v5 = false
                    end
                end
            else
                v5 = false
            end
        end
        if not v5 or not p3.lineOfSight then
            p2.LineOfSight = true
            p2.LosMisses = 0
        end
        p2.DistanceSq = v3
        p2.DistanceFrustumEligible = v5
        local LineOfSight = v5
        if LineOfSight then
            LineOfSight = p2.LineOfSight
        end
        p2.Eligible = LineOfSight
        return
    end
    p2.Eligible = false
    p2.DistanceFrustumEligible = false
    p2.DistanceSq = (1 / 0)
end

function u29:_refreshLineOfSight(p2, p3, p4) -- Line: 438
    local v1 = self:_hasLineOfSight(p2, p3)
    p2.LosCheckedAt = p4
    if not v1 then
        p2.LosMisses = p2.LosMisses + 1
        if 3 <= p2.LosMisses then
            p2.LineOfSight = false
        end
    else
        p2.LineOfSight = true
        p2.LosMisses = 0
    end
    local DistanceFrustumEligible = p2.DistanceFrustumEligible
    if DistanceFrustumEligible then
        DistanceFrustumEligible = p2.LineOfSight
    end
    p2.Eligible = DistanceFrustumEligible
end

function u29:_idleStatesSorted() -- Line: 453
    local v1 = {}
    for i, v in ipairs(self.States) do
        if v.Eligible and not v.Override then
            table.insert(v1, v)
        end
    end
    table.sort(v1, function(p1, p2) -- Line: 460
        local v1
        if p1.DistanceSq == p2.DistanceSq then
            v1 = p1.Model.Name < p2.Model.Name
            return v1
        end
        v1 = p1.DistanceSq < p2.DistanceSq
        return v1
    end)
    return v1
end

function u29:_activeIdleStatesSortedWorstFirst() -- Line: 469
    local v1 = {}
    for i, v in ipairs(self.States) do
        if v.IdleActive then
            table.insert(v1, v)
        end
    end
    table.sort(v1, function(p1, p2) -- Line: 476
        local DistanceSq = p1.DistanceSq
        local v1 = p2.DistanceSq < DistanceSq
        return v1
    end)
    return v1
end

function u29:_overrideCount() -- Line: 482
    local v1 = 0
    for i, v in ipairs(self.States) do
        if v.Override then
            v1 = v1 + 1
        end
    end
    return v1
end

function u29:_applyBudget(p2, p3) -- Line: 492 -- upvalues: u25 (val)
    local Eligible, v1, v2
    local High = self.Tiers[self.CurrentTier]
    if not High then
        High = u25.High
    end
    local v3 = High.maxTracks - (self:_overrideCount())
    local v4 = math.max(0, v3)
    local v5 = self:_idleStatesSorted()
    v3 = {}
    local v6 = #v5
    local v7 = math.min(v4, v6)
    for i = 1, v7 do
        v3[v5[i]] = true
    end
    v7 = 0
    for i2, v in ipairs(self.States) do
        if v.IdleActive then
            v7 = v7 + 1
        end
    end
    if not (v4 < v7) then
        v1, v2 = self, p2
    else
        local v8, v9
        v9, v2, v1 = p3, p2, self
        for i3, j in ipairs(self:_activeIdleStatesSortedWorstFirst()) do
            if v7 <= v4 then
                break
            end
            v8 = v9 == true
            v1:_stopIdle(j, v8, v2)
            v7 = v7 - 1
        end
    end
    for i4, k in ipairs(v1.States) do
        if k.IdleActive and not v3[k] and 1.5 <= v2 - k.IdleStartedAt then
            Eligible = k.Eligible
            if not Eligible then
                Eligible = k.IneligibleSince
                if Eligible then
                    Eligible = 0.75 <= v2 - k.IneligibleSince
                end
            end
            if Eligible then
                v1:_stopIdle(k, false, v2)
                v7 = v7 - 1
            end
        end
    end
    if not v1.Enabled then
        return
    end
    for i5, n in ipairs(v5) do
        if v4 <= v7 then
            break
        end
        if v3[n] and not n.IdleActive then
            v1:_startIdle(n, v2)
            if n.IdleActive then
                v7 = v7 + 1
            end
        end
    end
end

function u29:_update() -- Line: 544 -- upvalues: u25 (val)
    if not self.Enabled then
        return
    end
    local Character = self.Player.Character
    local HumanoidRootPart = Character
    if HumanoidRootPart then
        HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    end
    if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
        local Position, v1
        if #self.States == 0 then
            return
        end
        local High = self.Tiers[self.CurrentTier]
        if not High then
            High = u25.High
        end
        local CurrentCamera = workspace.CurrentCamera
        local v2 = os.clock()
        self:_refreshLosFilters(Character)
        local v3 = {}
        for i, v in ipairs(self.States) do
            Position = HumanoidRootPart.Position
            self:_scoreDistanceAndFrustum(v, High, Position, CurrentCamera)
            if High.lineOfSight and CurrentCamera and v.DistanceFrustumEligible then
                table.insert(v3, v)
            end
        end
        table.sort(v3, function(p1, p2) -- Line: 568
            local v1
            if p1.DistanceSq == p2.DistanceSq then
                v1 = p1.Model.Name < p2.Model.Name
                return v1
            end
            v1 = p1.DistanceSq < p2.DistanceSq
            return v1
        end)
        while true do
            v1 = #v3
            if not (High.maxTracks * 2 < v1) then
                break
            end
            table.remove(v3)
        end
        table.sort(v3, function(p1, p2) -- Line: 577
            local v1
            if p1.LosCheckedAt ~= p2.LosCheckedAt then
                v1 = p1.LosCheckedAt < p2.LosCheckedAt
                return v1
            end
            if p1.DistanceSq == p2.DistanceSq then
                v1 = p1.Model.Name < p2.Model.Name
                return v1
            end
            v1 = p1.DistanceSq < p2.DistanceSq
            return v1
        end)
        local v4 = #v3
        v1 = math.min(4, v4)
        for i2 = 1, v1 do
            v4 = v3[i2]
            self:_refreshLineOfSight(v4, CurrentCamera, v2)
        end
        for i3, j in ipairs(self.States) do
            if j.Eligible then
                j.IneligibleSince = nil
            elseif not j.IneligibleSince then
                j.IneligibleSince = v2
            end
        end
        self:_applyBudget(v2, false)
        return
    end
end

function u29.Init(p1) -- Line: 599 -- upvalues: RunService (val)
    if p1.Initialized then
        return p1
    end
    p1.Initialized = true
    p1:_scanModels()
    local Character = p1.Player.Character
    p1:_refreshLosFilters(Character, true)
    p1:_preloadConfiguredAnimations()
    local Connections = p1.Connections
    local v1 = p1.Player.CharacterAdded:Connect(function(p1_2) -- Line: 609 -- upvalues: p1 (val)
        p1:_refreshLosFilters(p1_2, true)
    end)
    table.insert(Connections, v1)
    local Connections_2 = p1.Connections
    v1 = (p1.Player:GetAttributeChangedSignal("QualityTier")):Connect(function() -- Line: 615 -- upvalues: p1 (val)
        p1:_refreshTier()
    end)
    table.insert(Connections_2, v1)
    local Connections_3 = p1.Connections
    v1 = (p1.Player:GetAttributeChangedSignal("ClientCPULoad")):Connect(function() -- Line: 621 -- upvalues: p1 (val)
        if p1.Player:GetAttribute("QualityTier") == nil or p1.Player:GetAttribute("QualityTier") == "Auto" then
            p1:_refreshTier()
        end
    end)
    table.insert(Connections_3, v1)
    local Connections_4 = p1.Connections
    v1 = RunService
    v1 = v1.Heartbeat:Connect(function(p1_2) -- Line: 629 -- upvalues: p1 (val)
        local v1 = p1
        v1.Accumulator = v1.Accumulator + p1_2
        if p1.Accumulator < 0.2 then
            return
        end
        p1.Accumulator = 0
        p1:_update()
    end)
    table.insert(Connections_4, v1)
    p1:_refreshTier()
    return p1
end

function u29.SetEnabled(p1, p2) -- Line: 642
    local v1 = p2 == true
    p1.Enabled = v1
    if p1.Enabled then
        p1:_update()
        return
    end
    for i, v in ipairs(p1.States) do
        p1:_stopIdle(v, false)
        p1:_stopLookAt(v, false)
        if v.Override then
            v.OverrideGeneration = v.OverrideGeneration + 1
            pcall(function() -- Line: 650 -- upvalues: v (val)
                v.Override.track:Stop(0.35)
            end)
            v.Override = nil
        end
    end
end

function u29._stopLookAt(p1, p2, p3) -- Line: 661
    local LookAt = p2.LookAt
    if not LookAt then
        return
    end
    if LookAt.BlendingOut and not p3 then
        return
    end
    if not p3 and LookAt.Neck.Parent then
        LookAt.BlendingOut = true
        return
    end
    local Connection = LookAt.Connection
    if Connection then
        Connection:Disconnect()
    end
    LookAt.Connection = nil
    if LookAt.Neck.Parent then
        LookAt.Neck.C0 = LookAt.BaseC0
    end
    p2.LookAt = nil
end

function u29.StartLookAt(p1, p2, p3) -- Line: 682
    -- upvalues: getLookAtTarget (val), getHeadNeck (val), RunService (val), TweenService (val)
    local u4 = p1.StateByModel[p2]
    local u7 = getLookAtTarget(p3)
    if p1.Enabled and u4 and u7 then
        local u11, u12 = getHeadNeck(p2)
        if u11 and u12 then
            p1:_stopLookAt(u4, true)
            local u18 = {Blend = 0, BlendingOut = false}
            u18.Neck = u12
            u18.BaseC0 = u12.C0
            u4.LookAt = u18
            local v1 = RunService
            local RenderStepped = v1.RenderStepped
            u18.Connection = RenderStepped:Connect(function(p1_2) -- Line: 703
                -- upvalues: u4 (val), u18 (val), u11 (val), u12 (val), u7 (val), p1 (val), TweenService (upval)
                local v1, v2
                if u4.LookAt ~= u18 then
                    return
                end
                if u11.Parent and u12.Parent and u12.Part0 and u7.Parent then
                    local v3, v4, v5
                    if not u18.BlendingOut then
                        v1 = u18
                        v5 = u18
                        v4 = v5.Blend + p1_2 / 0.25
                        v1.Blend = math.min(1, v4)
                    else
                        v1 = u18
                        v5 = u18
                        v4 = v5.Blend - p1_2 / 0.3
                        v1.Blend = math.max(0, v4)
                    end
                    v1 = u7.Position - u11.Position
                    if 0 < v1.Magnitude then
                        v3 = u12
                        local CFrame_2 = v3.Part0.CFrame
                        local Unit = v1.Unit
                        v3 = CFrame_2:VectorToObjectSpace(Unit)
                        v5 = -v3.X
                        local v6 = -v3.Z
                        v4 = math.atan2(v5, v6)
                        v2 = math.clamp(v4, -1.2217304763960306, 1.2217304763960306)
                        local Y = v3.Y
                        v6 = math.clamp(Y, -1, 1)
                        v5 = math.asin(v6)
                        v4 = math.clamp(v5, -0.4363323129985824, 0.4363323129985824)
                        v5 = u18.BaseC0 * CFrame.Angles(v4, v2, 0)
                        v6 = TweenService
                        local v7 = u18
                        local Blend_3 = v7.Blend
                        local Sine = Enum.EasingStyle.Sine
                        local InOut = Enum.EasingDirection.InOut
                        local Value = v6:GetValue(Blend_3, Sine, InOut)
                        u12.C0 = u18.BaseC0:Lerp(v5, Value)
                    end
                    if u18.BlendingOut and u18.Blend <= 0 then
                        v3 = p1
                        v4 = u4
                        v3:_stopLookAt(v4, true)
                    end
                    return
                end
                v1 = p1
                v2 = u4
                v1:_stopLookAt(v2, true)
            end)
            local u26 = false
            return function() -- Line: 735 -- upvalues: u26 (ref), u4 (val), u18 (val), p1 (val)
                if u26 then
                    return
                end
                u26 = true
                if u4.LookAt == u18 then
                    local v1 = p1
                    local v2 = u4
                    v1:_stopLookAt(v2, false)
                end
            end
        end
        local v2 = (p2:GetFullName()) .. ":look-at"
        local v3 = "Could not resolve a neck chain for " .. (p2:GetFullName())
        p1:_warnOnce(v2, v3)
        return function() end
    end
    return function() end
end

function u29.PlayOverride(p1, p2, p3, p4) -- Line: 746 -- upvalues: u25 (val)
    local u5 = p1.StateByModel[p2]
    if p1.Enabled and u5 and typeof(p3) == "string" and p3 ~= "" then
        local High, u140, v1, v2, v3, v4, v5, v6, v7
        if p3 == u5.IdleId then
            if not u5.IdleActive then
                v6 = os.clock()
                p1:_startIdle(u5, v6, true)
            end
            return function() end
        end
        u5.OverrideGeneration = u5.OverrideGeneration + 1
        if u5.Override then
            pcall(function() -- Line: 763 -- upvalues: u5 (val)
                u5.Override.track:Stop(0.15)
            end)
            u5.Override = nil
        end
        p1:_stopIdle(u5, false)
        local u36 = u5.OverrideTracks[p3]
        if u36 then
            local track = u36.track
            local Action_2 = p4 or Enum.AnimationPriority.Action
            track.Priority = Action_2
            u36.track.Looped = true
            pcall(function() -- Line: 782 -- upvalues: u36 (ref)
                u36.track:AdjustSpeed(1)
            end)
            High = p1.Tiers[p1.CurrentTier]
            if not High then
                High = u25.High
            end
            local maxTracks = High.maxTracks
            v1 = p1:_overrideCount()
            v7 = maxTracks - (v1 + 1)
            v5 = math.max(0, v7)
            v6 = p1:_activeIdleStatesSortedWorstFirst()
            v3 = #v6 - v5
            v7 = math.max(0, v3)
            for i = 1, v7 do
                v3 = v6[i]
                p1:_stopIdle(v3, true)
            end
            if not pcall(function() -- Line: 796 -- upvalues: u36 (ref)
                local v0, v1
                u36.track:Play(0.15, 1, 1)
                return
            end) then
                v1 = (u5.Model:GetFullName()) .. ":override-play"
                v2 = "Could not play dialogue override for " .. (u5.Model:GetFullName())
                p1:_warnOnce(v1, v2)
                return function() end
            end
            u5.Override = u36
            u140 = false
            return function() -- Line: 808 -- upvalues: u140 (ref), u5 (val), u36 (ref), p1 (val)
                if u140 then
                    return
                end
                u140 = true
                if u5.Override ~= u36 then
                    return
                end
                pcall(function() -- Line: 816 -- upvalues: u36 (upval)
                    u36.track:Stop(0.2)
                end)
                u5.Override = nil
                local v1 = p1
                local v2 = os.clock()
                v1:_applyBudget(v2, false)
            end
        end
        local Action = p4 or Enum.AnimationPriority.Action
        v4, v5 = p1:_loadTrack(u5, p3, Action, "NpcDialogueOverride")
        if not v4 then
            return function() end
        end
        u36 = {track = v4, animation = v5}
        u5.OverrideTracks[p3] = u36
        High = p1.Tiers[p1.CurrentTier]
        if not High then
            High = u25.High
        end
        v7 = High.maxTracks - ((p1:_overrideCount()) + 1)
        v5 = math.max(0, v7)
        v6 = p1:_activeIdleStatesSortedWorstFirst()
        v3 = #v6 - v5
        v7 = math.max(0, v3)
        for j = 1, v7 do
            v3 = v6[j]
            p1:_stopIdle(v3, true)
        end
        if pcall(function() -- Line: 796 -- upvalues: u36 (ref)
            local v0, v1
            u36.track:Play(0.15, 1, 1)
            return
        end) then
            u5.Override = u36
            u140 = false
            return function() -- Line: 808 -- upvalues: u140 (ref), u5 (val), u36 (ref), p1 (val)
                if u140 then
                    return
                end
                u140 = true
                if u5.Override ~= u36 then
                    return
                end
                pcall(function() -- Line: 816 -- upvalues: u36 (upval)
                    u36.track:Stop(0.2)
                end)
                u5.Override = nil
                local v1 = p1
                local v2 = os.clock()
                v1:_applyBudget(v2, false)
            end
        end
        v1 = (u5.Model:GetFullName()) .. ":override-play"
        v2 = "Could not play dialogue override for " .. (u5.Model:GetFullName())
        p1:_warnOnce(v1, v2)
        return function() end
    end
    return function() end
end

function u29.PlaySequence(p1, p2, p3, p4) -- Line: 824 -- upvalues: u25 (val)
    local BindableEvent = Instance.new("BindableEvent")
    local BindableEvent_2 = Instance.new("BindableEvent")
    local u11 = p1.StateByModel[p2]
    if p1.Enabled and u11 and type(p3) == "table" and #p3 ~= 0 then
        local id, u108, v1, v2
        local u17 = {}
        for i, v in ipairs(p3) do
            v1 = v
            if type(v1) == "table" then
                id = v.id
                if typeof(id) == "string" and v.id ~= "" then
                    v2 = v
                    table.insert(u17, v2)
                end
            end
        end
        if #u17 == 0 then
            task.defer(function() -- Line: 847 -- upvalues: BindableEvent (val)
                pcall(BindableEvent.Fire, BindableEvent, "invalid")
            end)
            return function() -- Line: 850 -- upvalues: BindableEvent (val), BindableEvent_2 (val)
                BindableEvent:Destroy()
                BindableEvent_2:Destroy()
            end, BindableEvent.Event, BindableEvent_2.Event
        end
        u11.OverrideGeneration = u11.OverrideGeneration + 1
        local OverrideGeneration = u11.OverrideGeneration
        if u11.Override then
            pcall(function() -- Line: 861 -- upvalues: u11 (val)
                u11.Override.track:Stop(0.15)
            end)
            u11.Override = nil
        end
        p1:_stopIdle(u11, false)
        local High = p1.Tiers[p1.CurrentTier]
        if not High then
            High = u25.High
        end
        local v3 = High.maxTracks - ((p1:_overrideCount()) + 1)
        local v4 = math.max(0, v3)
        local v5 = p1:_activeIdleStatesSortedWorstFirst()
        local v6 = #v5 - v4
        v3 = math.max(0, v6)
        for i2 = 1, v3 do
            v6 = v5[i2]
            p1:_stopIdle(v6, true)
        end
        local u98 = true
        local u99 = nil
        local u100 = nil
        local u101 = false

        local function fireFinished(p1) -- Line: 881 -- upvalues: u101 (ref), BindableEvent (val)
            if u101 then
                return
            end
            u101 = true
            BindableEvent:Fire(p1)
        end

        function u108(p1_2) -- Line: 890
            -- upvalues: u98 (ref), u11 (val), OverrideGeneration (val), u99 (ref), u17 (val), u100 (ref), p1 (val)
            -- upvalues: u101 (ref), BindableEvent (val), p4 (val), u108 (ref), BindableEvent_2 (val)
            if u98 and u11.OverrideGeneration == OverrideGeneration then
                local v1, v2, v3
                local v4 = u99
                if v4 then
                    v4:Disconnect()
                end
                u99 = nil
                local u12 = u17[p1_2]
                if not u12 then
                    if u11.Override == u100 then
                        u11.Override = nil
                    end
                    v1 = p1
                    v2 = os.clock()
                    v1:_applyBudget(v2, false)
                    if u101 then
                        return
                    end
                    u101 = true
                    BindableEvent:Fire("completed")
                    return
                end
                v1 = u12.looped == true
                local u63 = u11.OverrideTracks[u12.id]
                if not u63 then
                    v2 = p1
                    local v5 = u11
                    local id = u12.id
                    local Action = p4
                    if not Action then
                        Action = Enum.AnimationPriority.Action
                    end
                    v2, v3 = v2:_loadTrack(v5, id, Action, "NpcSequenceOverride", v1)
                    if not v2 then
                        u108(p1_2 + 1)
                        return
                    end
                    u63 = {track = v2, animation = v3}
                    u11.OverrideTracks[u12.id] = u63
                end
                u100 = u63
                local track = u63.track
                local Action_2 = p4
                if not Action_2 then
                    Action_2 = Enum.AnimationPriority.Action
                end
                track.Priority = Action_2
                u63.track.Looped = v1
                pcall(function() -- Line: 928 -- upvalues: u63 (ref)
                    u63.track:AdjustSpeed(1)
                    u63.track.TimePosition = 0
                end)
                u11.Override = u63
                if not v1 then
                    local Ended
                    if u12.waitForEnded ~= true then
                        Ended = u63.track.Stopped
                    else
                        Ended = u63.track.Ended
                    end
                    u99 = Ended:Connect(function() -- Line: 936
                        -- upvalues: u98 (upval), u11 (upval), OverrideGeneration (upval), u63 (ref), u99 (upval)
                        -- upvalues: u12 (val), p1 (upval), u101 (upval), BindableEvent (upval), u108 (upval)
                        -- upvalues: p1_2 (val)
                        if u98 and u11.OverrideGeneration == OverrideGeneration and u11.Override == u63 then
                            local v1 = u99
                            if v1 then
                                v1:Disconnect()
                            end
                            u99 = nil
                            if u12.hold ~= true then
                                u108(p1_2 + 1)
                                return
                            end
                            if not pcall(function() -- Line: 943 -- upvalues: u63 (upval)
                                local track, v0, v1, v2
                                u63.track:Play(0, 1, 1)
                                v0 = u63
                                track = v0.track
                                v2 = u63.track.Length - 0.016666666666666666
                                track.TimePosition = math.max(v2, 0)
                                u63.track:AdjustSpeed(0)
                                return
                            end) then
                                local v2 = p1
                                local v3 = (u11.Model:GetFullName()) .. ":sequence-hold"
                                local v4 = "Could not hold the final sequence pose for " .. (u11.Model:GetFullName())
                                v2:_warnOnce(v3, v4)
                            end
                            if u101 then
                                return
                            end
                            u101 = true
                            BindableEvent:Fire("held")
                            return
                        end
                    end)
                end
                if pcall(function() -- Line: 961 -- upvalues: u63 (ref)
                    local v0, v1
                    u63.track:Play(0.15, 1, 1)
                    return
                end) then
                    v3 = BindableEvent_2
                    local id_2 = u12.id
                    v3:Fire(p1_2, id_2)
                else
                    v3 = p1
                    local v6 = (u11.Model:GetFullName()) .. ":sequence-play:" .. u12.id
                    local v7 = "Could not play an animation sequence step for " .. (u11.Model:GetFullName())
                    v3:_warnOnce(v6, v7)
                    u108(p1_2 + 1)
                end
                return
            end
        end

        task.defer(u108, 1)
        local u134 = false
        local Event_2 = BindableEvent.Event
        local Event = BindableEvent_2.Event
        return function() -- Line: 980
            -- upvalues: u134 (ref), u98 (ref), u99 (ref), u11 (val), OverrideGeneration (val), u100 (ref), p1 (val)
            -- upvalues: BindableEvent (val), BindableEvent_2 (val)
            if u134 then
                return
            end
            u134 = true
            u98 = false
            local v1 = u99
            if v1 then
                v1:Disconnect()
            end
            u99 = nil
            if u11.OverrideGeneration == OverrideGeneration then
                v1 = u11
                v1.OverrideGeneration = v1.OverrideGeneration + 1
                if u11.Override == u100 and u100 then
                    pcall(function() -- Line: 991 -- upvalues: u100 (upval)
                        u100.track:AdjustSpeed(1)
                        u100.track:Stop(0.2)
                    end)
                    u11.Override = nil
                end
                v1 = p1
                local v2 = os.clock()
                v1:_applyBudget(v2, false)
            end
            BindableEvent:Destroy()
            BindableEvent_2:Destroy()
        end, Event_2, Event
    end
    task.defer(function() -- Line: 829 -- upvalues: BindableEvent (val)
        pcall(BindableEvent.Fire, BindableEvent, "invalid")
    end)
    return function() -- Line: 832 -- upvalues: BindableEvent (val), BindableEvent_2 (val)
        BindableEvent:Destroy()
        BindableEvent_2:Destroy()
    end, BindableEvent.Event, BindableEvent_2.Event
end

function u29.GetActiveCount(p1) -- Line: 1006
    local v1 = 0
    for i, v in ipairs(p1.States) do
        if v.IdleActive or v.Override then
            v1 = v1 + 1
        end
    end
    return v1
end

function u29.GetTier(p1) -- Line: 1016
    return p1.CurrentTier
end

function u29:Destroy() -- Line: 1020
    if not self.Initialized then
        return
    end
    self.Initialized = false
    for i, v in ipairs(self.Connections) do
        if v then
            v:Disconnect()
        end
    end
    table.clear(self.Connections)
    local v1 = self
    for i2, i3 in ipairs(self.States) do
        v1:_stopIdle(i3, true)
        v1:_stopLookAt(i3, true)
        i3.OverrideGeneration = i3.OverrideGeneration + 1
        if i3.Override then
            pcall(function() -- Line: 1034 -- upvalues: i3 (val)
                i3.Override.track:Stop(0)
            end)
            i3.Override = nil
        end
        if i3.IdleAnimation then
            i3.IdleAnimation:Destroy()
        end
        for k, j in pairs(i3.OverrideTracks) do
            pcall(function() -- Line: 1043 -- upvalues: j (val)
                j.track:Stop(0)
            end)
            j.animation:Destroy()
        end
        if i3.CreatedAnimator and i3.Animator and i3.Animator.Parent then
            i3.Animator:Destroy()
        end
    end
    table.clear(v1.States)
    table.clear(v1.StateByModel)
end

return u29