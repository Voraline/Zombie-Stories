local ContentProvider = game:GetService("ContentProvider")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local u25 = {
    High = {maxTracks = 20, radius = 140, frustum = false, lineOfSight = false},
    Medium = {maxTracks = 10, radius = 90, frustum = true, lineOfSight = false},
}
local v1 = {maxTracks = 6, radius = 55, frustum = true, lineOfSight = true}
u25.Low = v1
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
    if not HumanoidRootPart then
        return p1:FindFirstChildWhichIsA("BasePart", true)
    end
    if HumanoidRootPart:IsA("BasePart") then
        return HumanoidRootPart
    end
    return p1:FindFirstChildWhichIsA("BasePart", true)
end
local function getLookAtTarget(p1) -- Line: 54
    local HumanoidRootPart
    if typeof(p1) ~= "Instance" then
        return nil
    end
    if p1:IsA("BasePart") then
        return p1
    end
    if not (p1:IsA("Model")) then
        return nil
    end
    local Head = p1:FindFirstChild("Head", true)
    if not Head then
        HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart", true)
        if HumanoidRootPart then
            if HumanoidRootPart:IsA("BasePart") then
                return HumanoidRootPart
            end
            return nil
        end
        return nil
    end
    if Head:IsA("BasePart") then
        return Head
    end
    HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart", true)
    if not HumanoidRootPart then
        return nil
    end
    if HumanoidRootPart:IsA("BasePart") then
        return HumanoidRootPart
    end
    return nil
end
local function getHeadNeck(p1) -- Line: 74
    local Head = p1:FindFirstChild("Head", true)
    if not Head or not (Head:IsA("BasePart")) then
        return nil, nil
    end
    for i, v in ipairs(p1:GetDescendants()) do
        if v:IsA("Motor6D") and v.Part1 == Head and v.Part0 and v.Part0:IsA("BasePart") then
            return Head, v
        end
    end
    return Head, nil
end
local function getIdleId(p1, p2) -- Line: 90
    local Attribute = p1:GetAttribute("NpcIdleAnimation")
    if typeof(Attribute) ~= "string" then
        local v1 = p2[p1.Name]
        local idleByOccurrence = v1
        if idleByOccurrence then
            idleByOccurrence = v1.idleByOccurrence
        end
        if type(idleByOccurrence) ~= "table" then
            local idle = v1
            if idle then
                idle = v1.idle
            end
            if typeof(idle) ~= "string" then
                return nil
            end
            if idle ~= "" then
                return idle
            end
            return nil
        elseif p1.Parent then
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
    elseif Attribute ~= "" then
        return Attribute
    end
end
local function resolveAutoTier(p1) -- Line: 116 -- upvalues: UserInputService (val)
    local TouchEnabled = UserInputService.TouchEnabled
    if TouchEnabled then
        TouchEnabled = not UserInputService.KeyboardEnabled
    end
    local v1 = tonumber(p1:GetAttribute("ClientCPULoad")) or 0
    if TouchEnabled or 60 <= v1 then
        return "Low"
    end
    if 35 <= v1 then
        return "Medium"
    end
    return "High"
end
function u29.new(p1) -- Line: 127 -- upvalues: u29 (val), Players (val), u25 (val)
    local v1 = {}
    local v2 = setmetatable(v1, u29)
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
    v1 = p1.Enabled ~= false
    v2.Enabled = v1
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
    local v1
    local Attribute = self.Player:GetAttribute("QualityTier")
    if Attribute == "High" then
        v1 = Attribute
    elseif Attribute ~= "Medium" and Attribute ~= "Low" then
        local TouchEnabled = UserInputService.TouchEnabled
        if TouchEnabled then
            TouchEnabled = not UserInputService.KeyboardEnabled
        end
        local v2 = tonumber(self.Player:GetAttribute("ClientCPULoad")) or 0
        if TouchEnabled then
            v1 = "Low"
        elseif 60 > v2 then
            if 35 > v2 then
                v1 = "High"
            else
                v1 = "Medium"
            end
        end
    end
    if not (self.Tiers[v1]) then
        v1 = "High"
    end
    if v1 == self.CurrentTier then
        return
    end
    self.CurrentTier = v1
    self:_applyBudget(os.clock(), true)
end
function u29:_registerModel(p2) -- Line: 175 -- upvalues: getIdleId (val)
    local v1
    if not (p2:IsA("Model")) or self.StateByModel[p2] then
        return
    end
    local v2 = getIdleId(p2, self.Npcs)
    if not v2 then
        return
    end
    local Humanoid = p2:FindFirstChildWhichIsA("Humanoid", true)
    local HumanoidRootPart = p2:FindFirstChild("HumanoidRootPart")
    if not HumanoidRootPart then
        HumanoidRootPart = p2.PrimaryPart
    end
    if not HumanoidRootPart then
        v1 = p2:FindFirstChildWhichIsA("BasePart", true)
    elseif not (HumanoidRootPart:IsA("BasePart")) then
        v1 = p2:FindFirstChildWhichIsA("BasePart", true)
    else
        v1 = HumanoidRootPart
    end
    if not Humanoid or not v1 then
        self:_warnOnce(p2, string.format("Skipping %s because it has no Humanoid/root part", p2:GetFullName()))
        return
    end
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
    table.insert(self.States, v3)
end
function u29:_preloadConfiguredAnimations() -- Line: 221 -- upvalues: ContentProvider (val)
    local Animation, PreloadAnimationIds, v1, v2
    local u85 = {}
    local v3 = {}
    for i, v in ipairs(self.States) do
        PreloadAnimationIds = v.PreloadAnimationIds
        if not PreloadAnimationIds then
            PreloadAnimationIds = {}
        end
        for i2, i3 in ipairs(PreloadAnimationIds) do
            if typeof(i3) == "string" and i3 ~= "" and not (v3[i3]) then
                v3[i3] = true
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
    v1, v2 = pcall(function() -- Line: 239 -- upvalues: ContentProvider (upval), u85 (val)
        ContentProvider:PreloadAsync(u85)
    end)
    for i4, j in ipairs(u85) do
        j:Destroy()
    end
    if not v1 then
        local v4 = tostring(v2)
        v5:_warnOnce("configured-preload", "Could not preload configured NPC animations (" .. v4 .. ")")
    end
end
function u29:_scanModels() -- Line: 250 -- upvalues: findCaseInsensitiveChild (val)
    local v1
    local v2 = self
    for i, v in ipairs(self.ContainerNames) do
        v1 = findCaseInsensitiveChild(workspace, v)
        if v1 then
            table.insert(v2.NpcContainers, v1)
            for i2, i3 in ipairs(v1:GetChildren()) do
                v2:_registerModel(i3)
            end
        else
            v2:_warnOnce("container:" .. v, string.format("Container %s was not found", v))
        end
    end
end
function u29:_refreshLosFilters(p2, p3) -- Line: 264
    local Ignore = workspace:FindFirstChild("Ignore")
    if p3 then
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
        return
    elseif self.LosFilterCharacter == p2 and self.LosFilterIgnore == Ignore then
        return
    end
end
function u29._getAnimator(p1, p2) -- Line: 288
    local Animator
    if not p2.Animator then
        Animator = p2.Humanoid:FindFirstChildOfClass("Animator")
        if not Animator then
            Animator = Instance.new("Animator")
            Animator.Name = "NpcAnimationDirectorAnimator"
            Animator.Parent = p2.Humanoid
            p2.CreatedAnimator = true
        end
        p2.Animator = Animator
        return Animator
    end
    if p2.Animator.Parent then
        return p2.Animator
    end
    Animator = p2.Humanoid:FindFirstChildOfClass("Animator")
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
    local v1, v2, v3
    local Animation = Instance.new("Animation")
    Animation.Name = p5
    Animation.AnimationId = p3
    v1, v2 = pcall(function() -- Line: 307 -- upvalues: self (val), p2 (val), Animation (val)
        local v1 = self:_getAnimator(p2)
        return v1:LoadAnimation(Animation)
    end)
    if not v1 or not v2 then
        Animation:Destroy()
        local FullName = p2.Model:GetFullName()
        local FullName_2 = p2.Model:GetFullName()
        self:_warnOnce(FullName .. ":" .. p3, string.format("Could not load %s for %s (%s)", p3, FullName_2, (tostring(v2))))
        return nil, nil
    end
    v2.Priority = p4
    if p6 ~= nil then
        v3 = p6 == true
    else
        v3 = true
    end
    v2.Looped = v3
    return v2, Animation
end
function u29._seedOrRestorePosition(p1, p2, p3) -- Line: 323
    local SeedGeneration = p2.SeedGeneration
    local function seedOrRestore() -- Line: 325 -- upvalues: p2 (val), p3 (val)
        pcall(function() -- Line: 326 -- upvalues: p2 (upval), p3 (upval)
            if p2.SavedTimePosition then
                local v1 = p3.Length - 0.01
                p3.TimePosition = math.min(p2.SavedTimePosition, (math.max(v1, 0)))
                return
            end
            if not p2.SeededTimePosition then
                p3.TimePosition = math.random() * math.max(p3.Length - 0.01, 0)
                p2.SeededTimePosition = true
            end
        end)
    end
    if 0 < p3.Length then
        pcall(function() -- Line: 326 -- upvalues: p2 (val), p3 (val)
            if p2.SavedTimePosition then
                local v1 = p3.Length - 0.01
                p3.TimePosition = math.min(p2.SavedTimePosition, (math.max(v1, 0)))
                return
            end
            if not p2.SeededTimePosition then
                p3.TimePosition = math.random() * math.max(p3.Length - 0.01, 0)
                p2.SeededTimePosition = true
            end
        end)
        return
    end
    task.spawn(function() -- Line: 341 -- upvalues: p1 (val), p3 (val), p2 (val), SeedGeneration (val)
        while p1.Initialized do
            if p3.Length > 0 or os.clock() >= os.clock() + 2 then
                break
            end
            task.wait()
        end
        if not p1.Initialized or p2.SeedGeneration ~= SeedGeneration or p3.Length <= 0 or not p3.IsPlaying then
            return
        end
        pcall(function() -- Line: 326 -- upvalues: p2 (upval), p3 (upval)
            if p2.SavedTimePosition then
                local v1 = p3.Length - 0.01
                p3.TimePosition = math.min(p2.SavedTimePosition, (math.max(v1, 0)))
                return
            end
            if not p2.SeededTimePosition then
                p3.TimePosition = math.random() * math.max(p3.Length - 0.01, 0)
                p2.SeededTimePosition = true
            end
        end)
    end)
end
function u29:_startIdle(p2, p3, p4) -- Line: 353
    if p2.IdleActive then
        return
    elseif p2.Override then
        return
    else
        local v1
        if not p2.Model.Parent then
            return
        end
        if p4 then
            local FullName, IdleTrack, v2
            if p2.IdleTrack then
                if not (pcall(function() -- Line: 369 -- upvalues: p2 (val)
    local v3, v4
    p2.IdleTrack:Play(0.2, 1, 1)
    return
end)) then
                    FullName = p2.Model:GetFullName()
                    self:_warnOnce(FullName .. ":play", "Could not play idle for " .. p2.Model:GetFullName())
                    return
                end
                p2.IdleActive = true
                p2.IdleStartedAt = p3
                p2.SeedGeneration = p2.SeedGeneration + 1
                self:_seedOrRestorePosition(p2, p2.IdleTrack)
                return
            end
            v1, v2 = self:_loadTrack(p2, p2.IdleId, Enum.AnimationPriority.Idle, "NpcIdle")
            if not v1 then
                p2.Eligible = false
                return
            end
            p2.IdleTrack = v1
            p2.IdleAnimation = v2
            if not (pcall(function() -- Line: 369 -- upvalues: p2 (val)
    local v3, v4
    p2.IdleTrack:Play(0.2, 1, 1)
    return
end)) then
                FullName = p2.Model:GetFullName()
                self:_warnOnce(FullName .. ":play", "Could not play idle for " .. p2.Model:GetFullName())
                return
            end
            p2.IdleActive = true
            p2.IdleStartedAt = p3
            p2.SeedGeneration = p2.SeedGeneration + 1
            self:_seedOrRestorePosition(p2, p2.IdleTrack)
            return
        elseif p2.IdleStoppedAt then
            v1 = p3 - p2.IdleStoppedAt
            if v1 < 0.5 then
                return
            end
        end
    end
end
function u29._stopIdle(p1, p2, p3, p4) -- Line: 382
    if not p2.IdleActive or not p2.IdleTrack then
        return
    end
    pcall(function() -- Line: 386 -- upvalues: p2 (val), p3 (val)
        local v1
        if 0 < p2.IdleTrack.Length then
            p2.SavedTimePosition = p2.IdleTrack.TimePosition
        end
        if not p3 then
            v1 = 0.35
        else
            v1 = 0
        end
        p2.IdleTrack:Stop(v1)
    end)
    p2.IdleActive = false
    local v1 = p4
    if not v1 then
        v1 = os.clock()
    end
    p2.IdleStoppedAt = v1
end
function u29:_hasLineOfSight(p2, p3) -- Line: 396
    local Position = p3.CFrame.Position
    local v1 = p2.Root.Position - Position
    if v1.Magnitude <= 0 then
        return true
    end
    local v2 = workspace:Raycast(Position, v1, self.LosParams) == nil
    return v2
end
function u29._scoreDistanceAndFrustum(p1, p2, p3, p4, p5) -- Line: 405
    local v1
    if not p2.Model.Parent or not p2.Root.Parent then
        p2.Eligible = false
        p2.DistanceFrustumEligible = false
        p2.DistanceSq = (1 / 0)
        return
    end
    local v2 = p2.Root.Position - p4
    local v3 = v2:Dot(v2)
    if not p2.IdleActive then
        v1 = 1
    else
        v1 = 1.15
    end
    local v4 = p3.radius * v1
    local v5 = v3 <= v4 * v4
    if v5 and p3.frustum then
        if p5 then
            v1 = p2.Root.Position - p5.CFrame.Position
            if 0 < v1.Magnitude then
                local v6 = v1.Unit:Dot(p5.CFrame.LookVector)
                if v6 < -0.2 then
                    v5 = false
                end
            end
        else
            v5 = false
        end
    end
    if not v5 then
        p2.LineOfSight = true
        p2.LosMisses = 0
    elseif not p3.lineOfSight then
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
end
function u29:_refreshLineOfSight(p2, p3, p4) -- Line: 438
    p2.LosCheckedAt = p4
    if not (self:_hasLineOfSight(p2, p3)) then
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
        local v1 = p2.DistanceSq < p1.DistanceSq
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
    local Eligible, v1, v2, v3, v4
    local High = self.Tiers[self.CurrentTier]
    if not High then
        High = u25.High
    end
    local v5 = math.max(0, High.maxTracks - self:_overrideCount())
    local v6 = self:_idleStatesSorted()
    local v7 = {}
    local v8 = math.min(v5, #v6)
    local v9 = 1
    for i = 1, v8, v9 do
        v7[v6[i]] = true
    end
    v8 = 0
    for i2, v in ipairs(self.States) do
        if v.IdleActive then
            v8 = v8 + 1
        end
    end
    if v5 >= v8 then
        v1, v2 = self, p2
    else
        local v10, v11
        v11, v2, v1 = p3, p2, self
        for i3, j in ipairs(self:_activeIdleStatesSortedWorstFirst()) do
            if v8 <= v5 then
                break
            end
            v10 = v11 == true
            v1:_stopIdle(j, v10, v2)
            v8 = v8 - 1
        end
    end
    for i4, k in ipairs(v1.States) do
        if k.IdleActive and not (v7[k]) then
            v3 = v2 - k.IdleStartedAt
            if 1.5 <= v3 then
                Eligible = k.Eligible
                if not Eligible then
                    Eligible = k.IneligibleSince
                    if Eligible then
                        v4 = v2 - k.IneligibleSince
                        Eligible = 0.75 <= v4
                    end
                end
                if Eligible then
                    v1:_stopIdle(k, false, v2)
                    v8 = v8 - 1
                end
            end
        end
    end
    if not v1.Enabled then
        return
    end
    for i5, n in ipairs(v6) do
        if v5 <= v8 then
            break
        end
        if v7[n] and not n.IdleActive then
            v1:_startIdle(n, v2)
            if n.IdleActive then
                v8 = v8 + 1
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
    if not HumanoidRootPart or not (HumanoidRootPart:IsA("BasePart")) or #self.States == 0 then
        return
    end
    local High = self.Tiers[self.CurrentTier]
    if not High then
        High = u25.High
    end
    local CurrentCamera = workspace.CurrentCamera
    local v1 = os.clock()
    self:_refreshLosFilters(Character)
    local v2 = {}
    for i, v in ipairs(self.States) do
        self:_scoreDistanceAndFrustum(v, High, HumanoidRootPart.Position, CurrentCamera)
        if High.lineOfSight and CurrentCamera and v.DistanceFrustumEligible then
            table.insert(v2, v)
        end
    end
    table.sort(v2, function(p1, p2) -- Line: 568
        local v1
        if p1.DistanceSq == p2.DistanceSq then
            v1 = p1.Model.Name < p2.Model.Name
            return v1
        end
        v1 = p1.DistanceSq < p2.DistanceSq
        return v1
    end)
    while High.maxTracks * 2 < #v2 do
        table.remove(v2)
    end
    table.sort(v2, function(p1, p2) -- Line: 577
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
    local v3 = math.min(4, #v2)
    local v4 = 1
    for i2 = 1, v3, v4 do
        self:_refreshLineOfSight(v2[i2], CurrentCamera, v1)
    end
    for i3, j in ipairs(self.States) do
        if j.Eligible then
            j.IneligibleSince = nil
        elseif not j.IneligibleSince then
            j.IneligibleSince = v1
        end
    end
    self:_applyBudget(v1, false)
end
function u29.Init(p1) -- Line: 599 -- upvalues: RunService (val)
    if p1.Initialized then
        return p1
    end
    p1.Initialized = true
    p1:_scanModels()
    p1:_refreshLosFilters(p1.Player.Character, true)
    p1:_preloadConfiguredAnimations()
    table.insert(p1.Connections, p1.Player.CharacterAdded:Connect(function(a1) -- Line: 609 -- upvalues: p1 (val)
        p1:_refreshLosFilters(a1, true)
    end))
    local Connections_2 = p1.Connections
    local AttributeChangedSignal = p1.Player:GetAttributeChangedSignal("QualityTier")
    table.insert(Connections_2, AttributeChangedSignal:Connect(function() -- Line: 615 -- upvalues: p1 (val)
        p1:_refreshTier()
    end))
    local Connections_3 = p1.Connections
    local AttributeChangedSignal_2 = p1.Player:GetAttributeChangedSignal("ClientCPULoad")
    table.insert(Connections_3, AttributeChangedSignal_2:Connect(function() -- Line: 621 -- upvalues: p1 (val)
        if p1.Player:GetAttribute("QualityTier") == nil then
            p1:_refreshTier()
        elseif p1.Player:GetAttribute("QualityTier") == "Auto" then
            p1:_refreshTier()
        end
    end))
    table.insert(p1.Connections, RunService.Heartbeat:Connect(function(a1) -- Line: 629 -- upvalues: p1 (val)
        local v1 = p1
        v1.Accumulator = v1.Accumulator + a1
        if p1.Accumulator < 0.2 then
            return
        end
        p1.Accumulator = 0
        p1:_update()
    end))
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
    if not LookAt.BlendingOut then
        if p3 then
            local Connection = LookAt.Connection
            if Connection then
                Connection:Disconnect()
            end
            LookAt.Connection = nil
            if LookAt.Neck.Parent then
                LookAt.Neck.C0 = LookAt.BaseC0
            end
            p2.LookAt = nil
            return
        elseif LookAt.Neck.Parent then
            LookAt.BlendingOut = true
            return
        end
    elseif not p3 then
        return
    end
end
function u29.StartLookAt(p1, p2, p3) -- Line: 682 -- upvalues: getLookAtTarget (val), getHeadNeck (val), RunService (val), TweenService (val)
    local u11, u12
    local u4 = p1.StateByModel[p2]
    local u7 = getLookAtTarget(p3)
    if not p1.Enabled or not u4 or not u7 then
        return function() end
    end
    u11, u12 = getHeadNeck(p2)
    if not u11 or not u12 then
        local FullName = p2:GetFullName()
        p1:_warnOnce(FullName .. ":look-at", "Could not resolve a neck chain for " .. p2:GetFullName())
        return function() end
    end
    p1:_stopLookAt(u4, true)
    local u18 = {Blend = 0, BlendingOut = false, Neck = u12, BaseC0 = u12.C0}
    u4.LookAt = u18
    u18.Connection = RunService.RenderStepped:Connect(function(a1) -- Line: 703 -- upvalues: u4 (val), u18 (val), u11 (val), u12 (val), u7 (val), p1 (val), TweenService (upval)
        if u4.LookAt ~= u18 then
            return
        end
        if not u11.Parent or not u12.Parent or not u12.Part0 or not u7.Parent then
            p1:_stopLookAt(u4, true)
            return
        end
        if not u18.BlendingOut then
            u18.Blend = math.min(1, u18.Blend + a1 / 0.25)
        else
            u18.Blend = math.max(0, u18.Blend - a1 / 0.3)
        end
        local v1 = u7.Position - u11.Position
        if 0 < v1.Magnitude then
            local v2 = u12.Part0.CFrame:VectorToObjectSpace(v1.Unit)
            local v3 = math.atan2(-v2.X, -v2.Z)
            local v4 = math.clamp(v3, -1.2217304763960306, 1.2217304763960306)
            local v5 = math.asin((math.clamp(v2.Y, -1, 1)))
            v3 = math.clamp(v5, -0.4363323129985824, 0.4363323129985824)
            v5 = u18.BaseC0 * CFrame.Angles(v3, v4, 0)
            local Value = TweenService:GetValue(u18.Blend, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            u12.C0 = u18.BaseC0:Lerp(v5, Value)
        end
        if u18.BlendingOut and u18.Blend <= 0 then
            p1:_stopLookAt(u4, true)
        end
    end)
    local u26 = false
    return function() -- Line: 735 -- upvalues: u26 (ref), u4 (val), u18 (val), p1 (val)
        if u26 then
            return
        end
        u26 = true
        if u4.LookAt == u18 then
            p1:_stopLookAt(u4, false)
        end
    end
end
function u29.PlayOverride(p1, p2, p3, p4) -- Line: 746 -- upvalues: u25 (val)
    local u5 = p1.StateByModel[p2]
    if not p1.Enabled then
        return function() end
    elseif not u5 then
        return function() end
    elseif typeof(p3) ~= "string" then
        return function() end
    else
        local v1
        if p3 == "" then
            return function() end
        end
        if p3 == u5.IdleId then
            if not u5.IdleActive then
                p1:_startIdle(u5, os.clock(), true)
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
            local Action_2 = p4
            if not Action_2 then
                Action_2 = Enum.AnimationPriority.Action
            end
            u36.track.Priority = Action_2
            u36.track.Looped = true
            pcall(function() -- Line: 782 -- upvalues: u36 (ref)
                u36.track:AdjustSpeed(1)
            end)
            local High = p1.Tiers[p1.CurrentTier]
            if not High then
                High = u25.High
            end
            v1 = math.max(0, High.maxTracks - (p1:_overrideCount() + 1))
            local v2 = p1:_activeIdleStatesSortedWorstFirst()
            local v3 = math.max(0, #v2 - v1)
            local v4 = 1
            for i = 1, v3, v4 do
                p1:_stopIdle(v2[i], true)
            end
            if not (pcall(function() -- Line: 796 -- upvalues: u36 (ref)
    local v5, v6
    u36.track:Play(0.15, 1, 1)
    return
end)) then
                local FullName = u5.Model:GetFullName()
                p1:_warnOnce(FullName .. ":override-play", "Could not play dialogue override for " .. u5.Model:GetFullName())
                return function() end
            end
            u5.Override = u36
            local u140 = false
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
                p1:_applyBudget(os.clock(), false)
            end
        else
            local v7
            local Action = p4
            if not Action then
                Action = Enum.AnimationPriority.Action
            end
            v7, v1 = p1:_loadTrack(u5, p3, Action, "NpcDialogueOverride")
            if not v7 then
                return function() end
            end
            u5.OverrideTracks[p3] = {track = v7, animation = v1}
        end
    end
end
function u29.PlaySequence(p1, p2, p3, p4) -- Line: 824 -- upvalues: u25 (val)
    local u108
    local BindableEvent = Instance.new("BindableEvent")
    local BindableEvent_2 = Instance.new("BindableEvent")
    local u11 = p1.StateByModel[p2]
    if not p1.Enabled or not u11 or type(p3) ~= "table" or #p3 == 0 then
        task.defer(function() -- Line: 829 -- upvalues: BindableEvent (val)
            pcall(BindableEvent.Fire, BindableEvent, "invalid")
        end)
        return function() -- Line: 832 -- upvalues: BindableEvent (val), BindableEvent_2 (val)
            BindableEvent:Destroy()
            BindableEvent_2:Destroy()
        end, BindableEvent.Event, BindableEvent_2.Event
    end
    local u17 = {}
    for i, v in ipairs(p3) do
        if type(v) == "table" and typeof(v.id) == "string" and v.id ~= "" then
            table.insert(u17, v)
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
    local v1 = math.max(0, High.maxTracks - (p1:_overrideCount() + 1))
    local v2 = p1:_activeIdleStatesSortedWorstFirst()
    local v3 = math.max(0, #v2 - v1)
    local v4 = 1
    for i2 = 1, v3, v4 do
        p1:_stopIdle(v2[i2], true)
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
    function u108(a1) -- Line: 890 -- upvalues: u98 (ref), u11 (val), OverrideGeneration (val), u99 (ref), u17 (val), u100 (ref), p1 (val), u101 (ref), BindableEvent (val), p4 (val), u108 (ref), BindableEvent_2 (val)
        if not u98 then
            return
        else
            if u11.OverrideGeneration ~= OverrideGeneration then
                return
            end
            local v1 = u99
            if v1 then
                v1:Disconnect()
            end
            u99 = nil
            local u12 = u17[a1]
            if not u12 then
                if u11.Override == u100 then
                    u11.Override = nil
                end
                p1:_applyBudget(os.clock(), false)
                if u101 then
                    return
                end
                u101 = true
                BindableEvent:Fire("completed")
                return
            end
            local v2 = u12.looped == true
            local u63 = u11.OverrideTracks[u12.id]
            if u63 then
                local FullName
                u100 = u63
                local Action_2 = p4
                if not Action_2 then
                    Action_2 = Enum.AnimationPriority.Action
                end
                u63.track.Priority = Action_2
                u63.track.Looped = v2
                pcall(function() -- Line: 928 -- upvalues: u63 (ref)
                    u63.track:AdjustSpeed(1)
                    u63.track.TimePosition = 0
                end)
                u11.Override = u63
                if not v2 then
                    local Ended
                    if u12.waitForEnded ~= true then
                        Ended = u63.track.Stopped
                    else
                        Ended = u63.track.Ended
                    end
                    u99 = Ended:Connect(function() -- Line: 936 -- upvalues: u98 (upval), u11 (upval), OverrideGeneration (upval), u63 (ref), u99 (upval), u12 (val), p1 (upval), u101 (upval), BindableEvent (upval), u108 (upval), a1 (val)
                        local v1, v2
                        if not u98 or u11.OverrideGeneration ~= OverrideGeneration or u11.Override ~= u63 then
                            return
                        end
                        local v3 = u99
                        if v3 then
                            v3:Disconnect()
                        end
                        u99 = nil
                        if u12.hold ~= true then
                            u108(a1 + 1)
                            return
                        end
                        if not (pcall(function() -- Line: 943 -- upvalues: u63 (upval)
    local v3, v1, v2
    u63.track:Play(0, 1, 1)
    v2 = u63.track.Length - 0.016666666666666666
    u63.track.TimePosition = math.max(v2, 0)
    u63.track:AdjustSpeed(0)
    return
end)) then
                            local FullName = u11.Model:GetFullName()
                            p1:_warnOnce(FullName .. ":sequence-hold", "Could not hold the final sequence pose for " .. u11.Model:GetFullName())
                        end
                        if u101 then
                            return
                        end
                        u101 = true
                        BindableEvent:Fire("held")
                    end)
                end
                if pcall(function() -- Line: 961 -- upvalues: u63 (ref)
    local v3, v1
    u63.track:Play(0.15, 1, 1)
    return
end) then
                    BindableEvent_2:Fire(a1, u12.id)
                else
                    FullName = u11.Model:GetFullName()
                    p1:_warnOnce(FullName .. ":sequence-play:" .. u12.id, "Could not play an animation sequence step for " .. u11.Model:GetFullName())
                    u108(a1 + 1)
                end
                return
            else
                local v4, v5
                local Action = p4
                if not Action then
                    Action = Enum.AnimationPriority.Action
                end
                v4, v5 = p1:_loadTrack(u11, u12.id, Action, "NpcSequenceOverride", v2)
                if not v4 then
                    u108(a1 + 1)
                    return
                end
                u11.OverrideTracks[u12.id] = {track = v4, animation = v5}
            end
        end
    end
    task.defer(u108, 1)
    local u134 = false
    return function() -- Line: 980 -- upvalues: u134 (ref), u98 (ref), u99 (ref), u11 (val), OverrideGeneration (val), u100 (ref), p1 (val), BindableEvent (val), BindableEvent_2 (val)
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
            p1:_applyBudget(os.clock(), false)
        end
        BindableEvent:Destroy()
        BindableEvent_2:Destroy()
    end, BindableEvent.Event, BindableEvent_2.Event
end
function u29.GetActiveCount(p1) -- Line: 1006
    local v1 = 0
    for i, v in ipairs(p1.States) do
        if v.IdleActive then
            v1 = v1 + 1
        elseif not v.Override then
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