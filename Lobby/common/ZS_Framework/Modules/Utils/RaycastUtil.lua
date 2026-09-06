local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Ignore = Workspace:WaitForChild("Ignore")
ReplicatedStorage.common:WaitForChild("Remotes")
local CurrentCamera = Workspace.CurrentCamera
local Controllers = script.Parent.Parent:WaitForChild("Controllers")
local LocalPlayerController = require(Controllers:WaitForChild("LocalPlayerController"))
local u39 = nil
local function getCameraController() -- Line: 16 -- upvalues: u39 (ref), Controllers (val)
    if not u39 then
        u39 = require(Controllers:WaitForChild("CameraController"))
    end
    return u39
end
local u44 = Random.new(os.clock())
local LocalPlayer = Players.LocalPlayer
LocalPlayer:GetMouse()
local u49 = {}
local u50 = {}
local u51 = {}
local u52 = {}
local GuiInset = game:GetService("GuiService"):GetGuiInset()
local u62 = RaycastParams.new()
u62.FilterType = Enum.RaycastFilterType.Blacklist
u62.FilterDescendantsInstances = u49
u62.IgnoreWater = true
local u66 = RaycastParams.new()
u66.FilterType = Enum.RaycastFilterType.Blacklist
u66.FilterDescendantsInstances = u50
u66.IgnoreWater = true
u66.RespectCanCollide = true
local u71 = RaycastParams.new()
u71.FilterType = Enum.RaycastFilterType.Blacklist
u71.FilterDescendantsInstances = u51
u71.IgnoreWater = true
u71.RespectCanCollide = true
local v1 = {
    GetRaycastParams = function(p1) -- Line: 55 -- upvalues: u62 (val)
        return u62
    end,
    GetAltRaycastParams = function(p1) -- Line: 59 -- upvalues: u66 (val)
        return u66
    end,
    GetCollisionRaycastParams = function(p1) -- Line: 63 -- upvalues: u71 (val)
        return u71
    end,
    GetAltFilter = function() -- Line: 67 -- upvalues: u66 (val)
        return u66.FilterDescendantsInstances
    end,
    GetCenterDirection = function() -- Line: 71 -- upvalues: CurrentCamera (val), u39 (ref), Controllers (val), GuiInset (val)
        if not u39 then
            u39 = require(Controllers:WaitForChild("CameraController"))
        end
        CurrentCamera.CFrame = u39.AimCFrame
        local v1 = Vector2.new(CurrentCamera.ViewportSize.X / 2, CurrentCamera.ViewportSize.Y / 2)
        local v2 = CurrentCamera:ScreenPointToRay(v1.X - GuiInset.X, v1.Y - GuiInset.Y)
        CurrentCamera.CFrame = CurrentCamera.CFrame
        return v2.Direction
    end,
    CustomRayDirection = function(p1, p2, p3) -- Line: 82 -- upvalues: u66 (val), u62 (val)
        local v1
        if not p3 then
            v1 = u62
        else
            v1 = u66
        end
        local v2 = workspace:Raycast(p1, p2, v1)
        if v2 then
            return v2
        end
        return {Position = p1 + p2}
    end,
    CustomRay = function(p1, p2, p3) -- Line: 94 -- upvalues: u66 (val), u62 (val)
        local v1
        local v2 = p2 - p1
        if not p3 then
            v1 = u62
        else
            v1 = u66
        end
        local v3 = workspace:Raycast(p1, v2, v1)
        if v3 then
            return v3
        end
        return {Position = p1 + v2}
    end,
    CollisionRayDirection = function(p1, p2) -- Line: 111 -- upvalues: u71 (val)
        local v1 = workspace:Raycast(p1, p2, u71)
        if v1 then
            return v1
        end
        return {Position = p1 + p2}
    end,
    CollisionRay = function(p1, p2) -- Line: 120 -- upvalues: u71 (val)
        local v1 = p2 - p1
        local v2 = workspace:Raycast(p1, v1, u71)
        if v2 then
            return v2
        end
        return {Position = p1 + v1}
    end,
    CastBaseRay = function(p1) -- Line: 131 -- upvalues: CurrentCamera (val), GuiInset (val), u66 (val), u62 (val)
        local v1
        local v2 = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2)
        local v3 = CurrentCamera:ScreenPointToRay(v2.X - GuiInset.X, v2.Y - GuiInset.Y).Direction * 50
        if not p1 then
            v1 = u62
        else
            v1 = u66
        end
        local v4 = workspace:Raycast(CurrentCamera.CFrame.Position, v3, v1)
        if v4 then
            return v4
        end
        return {Position = CurrentCamera.CFrame.Position + v3}
    end,
    CastNoneRay = function() -- Line: 148 -- upvalues: CurrentCamera (val), u39 (ref), Controllers (val), GuiInset (val)
        if not u39 then
            u39 = require(Controllers:WaitForChild("CameraController"))
        end
        local AimCFrame = u39.AimCFrame
        CurrentCamera.CFrame = AimCFrame
        local v1 = Vector2.new(CurrentCamera.ViewportSize.X / 2, CurrentCamera.ViewportSize.Y / 2)
        local v2 = CurrentCamera:ScreenPointToRay(v1.X - GuiInset.X, v1.Y - GuiInset.Y)
        CurrentCamera.CFrame = CurrentCamera.CFrame
        return {Position = AimCFrame.Position + v2.Direction * 50}
    end,
    CastRay = function(p1, p2, p3) -- Line: 163 -- upvalues: CurrentCamera (val), u39 (ref), Controllers (val), GuiInset (val), u49 (ref), u62 (val)
        if not u39 then
            u39 = require(Controllers:WaitForChild("CameraController"))
        end
        local AimCFrame = u39.AimCFrame
        CurrentCamera.CFrame = AimCFrame
        local v1 = Vector2.new(CurrentCamera.ViewportSize.X / 2, CurrentCamera.ViewportSize.Y / 2)
        local Direction = CurrentCamera:ScreenPointToRay(v1.X - GuiInset.X, v1.Y - GuiInset.Y).Direction
        if p3 and 0.0001 < p3.Magnitude then
            Direction = Direction + AimCFrame.RightVector.Unit * p3.X + AimCFrame.UpVector.Unit * p3.Y
        end
        CurrentCamera.CFrame = CurrentCamera.CFrame
        local v2 = math.rad(p1.Inaccuracy / 6)
        local v3 = rand(v2)
        local v4 = rand(v2)
        v3 = (Direction + Vector3.new(v3, v4, rand(v2))) * 5000
        if p2 then
            v4 = {}
            local v5 = u49
            local v6 = nil
            local v7 = nil
            for i, j in v5, v6, v7 do
                table.insert(v4, j)
            end
            v5 = p2
            v6 = nil
            v7 = nil
            for k, n in v5, v6, v7 do
                table.insert(v4, n)
            end
            u62.FilterDescendantsInstances = v4
        end
        v4 = workspace:Raycast(AimCFrame.Position, v3, u62)
        u62.FilterDescendantsInstances = u49
        if v4 then
            return v4
        end
        return {Position = AimCFrame.Position + v3}
    end,
    StandardCast = function(p1, p2, p3) -- Line: 209 -- upvalues: u49 (ref), u62 (val)
        local v1
        if p3 then
            v1 = {}
            local v2 = u49
            local v3 = nil
            local v4 = nil
            for i, j in v2, v3, v4 do
                table.insert(v1, j)
            end
            v2 = p3
            v3 = nil
            v4 = nil
            for k, n in v2, v3, v4 do
                table.insert(v1, n)
            end
            u62.FilterDescendantsInstances = v1
        end
        v1 = workspace:Raycast(p1, p2, u62)
        u62.FilterDescendantsInstances = u49
        return v1
    end,
}
function rand(p1) -- Line: 227 -- upvalues: u44 (val)
    return u44:NextNumber(-p1, p1)
end
local u90 = {}
local u91 = {}
local u92 = 0
local u93 = {}
local u94 = {}
local u95 = {}
local u96 = nil
local u97 = false
local function requestRefresh() -- Line: 242 -- upvalues: u97 (ref), u96 (ref)
    if u97 then
        return
    end
    u97 = true
    task.defer(function() -- Line: 248 -- upvalues: u97 (upval), u96 (upval)
        u97 = false
        if u96 then
            u96()
        end
    end)
end
local function rebuildFriendlyResolverOrder() -- Line: 256 -- upvalues: u91 (ref), u90 (val)
    u91 = {}
    for k, v in pairs(u90) do
        table.insert(u91, v)
    end
    table.sort(u91, function(p1, p2) -- Line: 262
        local v1
        if p1.priority == p2.priority then
            v1 = p1.sequence < p2.sequence
            return v1
        end
        v1 = p2.priority < p1.priority
        return v1
    end)
end
local function evaluateFriendlyResolvers(p1, p2) -- Line: 270 -- upvalues: u91 (ref)
    local v1, v2
    for i, v in ipairs(u91) do
        v1, v2 = pcall(v.fn, p1, p2)
        if v1 and v2 ~= nil then
            return v2
        end
    end
end
local function playersAreFriendly(p1, p2) -- Line: 279 -- upvalues: evaluateFriendlyResolvers (val)
    if not p1 or not p2 then
        return true
    end
    local v1 = evaluateFriendlyResolvers(p1, p2)
    if v1 ~= nil then
        return v1
    end
    local v2 = p2.TeamColor == p1.TeamColor
    return v2
end
local function attachAttributeTracker(p1, p2) -- Line: 292 -- upvalues: u95 (val), requestRefresh (val)
    local v1 = u95[p1]
    if not v1 then
        v1 = {}
    end
    u95[p1] = v1
    if u95[p1][p2] then
        u95[p1][p2]:Disconnect()
    end
    local v2 = u95[p1]
    local AttributeChangedSignal = p1:GetAttributeChangedSignal(p2)
    v2[p2] = AttributeChangedSignal:Connect(requestRefresh)
end
local function detachAttributeTracker(p1, p2) -- Line: 302 -- upvalues: u95 (val)
    local v1 = u95[p1]
    if not v1 then
        return
    end
    if v1[p2] then
        v1[p2]:Disconnect()
        v1[p2] = nil
    end
    if next(v1) == nil then
        u95[p1] = nil
    end
end
local function bindPlayer(p1) -- Line: 318 -- upvalues: u94 (val), requestRefresh (val), u93 (val), attachAttributeTracker (val)
    if u94[p1] then
        u94[p1]:Disconnect()
    end
    u94[p1] = p1.CharacterAdded:Connect(requestRefresh)
    for k in pairs(u93) do
        attachAttributeTracker(p1, k)
    end
end
local function cleanupPlayer(p1) -- Line: 330 -- upvalues: u94 (val), u95 (val)
    if u94[p1] then
        u94[p1]:Disconnect()
        u94[p1] = nil
    end
    if u95[p1] then
        local v1
        for k, v in pairs(u95[p1]) do
            v:Disconnect()
            v1 = u95[p1]
            v1[k] = nil
        end
        u95[p1] = nil
    end
end
function v1.RegisterFriendlyResolver(p1, p2, p3) -- Line: 345 -- upvalues: u92 (ref), u90 (val), rebuildFriendlyResolverOrder (val), u97 (ref), u96 (ref)
    local v1 = if typeof(p1) == "string" then p1 ~= "" else false
    assert(v1, "Resolver id must be a non-empty string")
    v1 = typeof(p2) == "function"
    assert(v1, "Resolver must be a function")
    u92 = u92 + 1
    u90[p1] = {id = p1, fn = p2, priority = p3 or 0, sequence = u92}
    rebuildFriendlyResolverOrder()
    if not u97 then
        u97 = true
        task.defer(function() -- Line: 248 -- upvalues: u97 (upval), u96 (upval)
            u97 = false
            if u96 then
                u96()
            end
        end)
    end
    return function() -- Line: 360 -- upvalues: u90 (upval), p1 (val), rebuildFriendlyResolverOrder (upval), u97 (upval), u96 (upval)
        if not (u90[p1]) then
            return
        end
        u90[p1] = nil
        rebuildFriendlyResolverOrder()
        if u97 then
            return
        end
        u97 = true
        task.defer(function() -- Line: 248 -- upvalues: u97 (upval), u96 (upval)
            u97 = false
            if u96 then
                u96()
            end
        end)
    end
end
function v1.UnregisterFriendlyResolver(p1) -- Line: 369 -- upvalues: u90 (val), rebuildFriendlyResolverOrder (val), u97 (ref), u96 (ref)
    if not (u90[p1]) then
        return
    end
    u90[p1] = nil
    rebuildFriendlyResolverOrder()
    if u97 then
        return
    end
    u97 = true
    task.defer(function() -- Line: 248 -- upvalues: u97 (upval), u96 (upval)
        u97 = false
        if u96 then
            u96()
        end
    end)
end
function v1.RegisterFriendlyAttribute(p1) -- Line: 377 -- upvalues: u93 (val), Players (val), attachAttributeTracker (val), u97 (ref), u96 (ref)
    local v1 = if typeof(p1) == "string" then p1 ~= "" else false
    assert(v1, "Attribute name must be a non-empty string")
    if u93[p1] then
        return
    end
    u93[p1] = true
    for i, v in ipairs(Players:GetPlayers()) do
        attachAttributeTracker(v, p1)
    end
    if u97 then
        return
    end
    u97 = true
    task.defer(function() -- Line: 248 -- upvalues: u97 (upval), u96 (upval)
        u97 = false
        if u96 then
            u96()
        end
    end)
end
function v1.UnregisterFriendlyAttribute(p1) -- Line: 393 -- upvalues: u93 (val), Players (val), u95 (val), u97 (ref), u96 (ref)
    local v1
    if not (u93[p1]) then
        return
    end
    u93[p1] = nil
    local v2 = p1
    for i, v in ipairs(Players:GetPlayers()) do
        v1 = u95[v]
        if v1 then
            if v1[v2] then
                v1[v2]:Disconnect()
                v1[v2] = nil
            end
            if next(v1) == nil then
                u95[v] = nil
            end
        end
    end
    if u97 then
        return
    end
    u97 = true
    task.defer(function() -- Line: 248 -- upvalues: u97 (upval), u96 (upval)
        u97 = false
        if u96 then
            u96()
        end
    end)
end
function v1.NotifyFriendlyStateChanged() -- Line: 407 -- upvalues: u97 (ref), u96 (ref)
    if u97 then
        return
    end
    u97 = true
    task.defer(function() -- Line: 248 -- upvalues: u97 (upval), u96 (upval)
        u97 = false
        if u96 then
            u96()
        end
    end)
end
function u96() -- Line: 411 -- upvalues: LocalPlayer (val), u52 (ref), Players (val), evaluateFriendlyResolvers (val), u49 (ref), Ignore (val), LocalPlayerController (val), u50 (ref), Workspace (val), u51 (ref), u62 (val), u66 (val), u71 (val)
    local v1, v2
    local v3 = LocalPlayer
    if not v3 then
        return
    end
    u52 = {}
    local v4 = {}
    for i, j in Players:GetPlayers() do
        if j ~= v3 and j.Character then
            if not v3 then
                v1 = true
            elseif j then
                v2 = evaluateFriendlyResolvers(v3, j)
                if v2 == nil then
                    v1 = j.TeamColor == v3.TeamColor
                else
                    v1 = v2
                end
            end
            if v1 then
                table.insert(v4, j.Character)
                table.insert(u52, j.Character)
            end
        end
    end
    local NPCRaycastCollide = workspace:FindFirstChild("NPCRaycastCollide")
    u49 = {Ignore, NPCRaycastCollide, LocalPlayerController.character, unpack(v4)}
    local v5 = {}
    local Zombies = Workspace:FindFirstChild("Zombies")
    v5[1] = Ignore
    v5[2] = NPCRaycastCollide
    v5[3] = LocalPlayerController.character
    v5[4] = Zombies
    v5[5] = unpack(v4)
    u50 = v5
    v5 = {}
    local Zombies_2 = Workspace:FindFirstChild("Zombies")
    v5[1] = NPCRaycastCollide
    v5[2] = LocalPlayerController.character
    v5[3] = Zombies_2
    v5[4] = unpack(v4)
    u51 = v5
    u62.FilterDescendantsInstances = u49
    u66.FilterDescendantsInstances = u50
    u71.FilterDescendantsInstances = u51
end
if LocalPlayerController.character then
    u49[2] = LocalPlayerController.character
    u50[2] = LocalPlayerController.character
    u62.FilterDescendantsInstances = u49
    u66.FilterDescendantsInstances = u50
end
LocalPlayerController.CharacterChanged:Connect(function(p1) -- Line: 460 -- upvalues: u49 (ref), u50 (ref), u62 (val), u66 (val), u97 (ref), u96 (ref)
    if not p1 then
        return
    end
    u49[2] = p1
    u50[2] = p1
    u62.FilterDescendantsInstances = u49
    u66.FilterDescendantsInstances = u50
    if u97 then
        return
    end
    u97 = true
    task.defer(function() -- Line: 248 -- upvalues: u97 (upval), u96 (upval)
        u97 = false
        if u96 then
            u96()
        end
    end)
end)
;(function() -- Line: 436 -- upvalues: Players (val), bindPlayer (val), u97 (ref), u96 (ref), cleanupPlayer (val)
    for i, v in ipairs(Players:GetPlayers()) do
        bindPlayer(v)
    end
    Players.PlayerAdded:Connect(function(p1) -- Line: 441 -- upvalues: bindPlayer (upval), u97 (upval), u96 (upval)
        bindPlayer(p1)
        if u97 then
            return
        end
        u97 = true
        task.defer(function() -- Line: 248 -- upvalues: u97 (upval), u96 (upval)
            u97 = false
            if u96 then
                u96()
            end
        end)
    end)
    Players.PlayerRemoving:Connect(function(p1) -- Line: 446 -- upvalues: cleanupPlayer (upval), u97 (upval), u96 (upval)
        cleanupPlayer(p1)
        if u97 then
            return
        end
        u97 = true
        task.defer(function() -- Line: 248 -- upvalues: u97 (upval), u96 (upval)
            u97 = false
            if u96 then
                u96()
            end
        end)
    end)
end)()
if not u97 then
    u97 = true
    task.defer(function() -- Line: 248 -- upvalues: u97 (ref), u96 (ref)
        u97 = false
        if u96 then
            u96()
        end
    end)
end
return v1