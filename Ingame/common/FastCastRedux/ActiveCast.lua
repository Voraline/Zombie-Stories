require("./TypeDefinitions")
local u5 = require("./TypeMarshaller")
local u6 = {}
u6.__index = u6
u6.__type = "ActiveCast"
local RunService = game:GetService("RunService")
local u15 = require("./Table")
local u16 = nil
local function GetFastCastVisualizationContainer() -- Line: 61
    local FastCastVisualizationObjects = workspace.Terrain:FindFirstChild("FastCastVisualizationObjects")
    if FastCastVisualizationObjects ~= nil then
        return FastCastVisualizationObjects
    end
    local v1 = Instance.new("Folder")
    v1.Name = "FastCastVisualizationObjects"
    v1.Archivable = false
    v1.Parent = workspace.Terrain
    return v1
end
local function PrintDebug(p1) -- Line: 79 -- upvalues: u16 (ref)
    if u16.DebugLogging == true then
        print(p1)
    end
end
function DbgVisualizeSegment(p1, p2) -- Line: 86 -- upvalues: u16 (ref)
    local v1
    if u16.VisualizeCasts ~= true then
        return nil
    end
    local ConeHandleAdornment = Instance.new("ConeHandleAdornment")
    ConeHandleAdornment.Adornee = workspace.Terrain
    ConeHandleAdornment.CFrame = p1
    ConeHandleAdornment.Height = p2
    ConeHandleAdornment.Color3 = Color3.new()
    ConeHandleAdornment.Radius = 0.25
    ConeHandleAdornment.Transparency = 0.5
    local FastCastVisualizationObjects = workspace.Terrain:FindFirstChild("FastCastVisualizationObjects")
    if FastCastVisualizationObjects == nil then
        local v2 = Instance.new("Folder")
        v2.Name = "FastCastVisualizationObjects"
        v2.Archivable = false
        v2.Parent = workspace.Terrain
        v1 = v2
    else
        v1 = FastCastVisualizationObjects
    end
    ConeHandleAdornment.Parent = v1
    return ConeHandleAdornment
end
function DbgVisualizeHit(p1, p2) -- Line: 100 -- upvalues: u16 (ref)
    local v1
    if u16.VisualizeCasts ~= true then
        return nil
    end
    local SphereHandleAdornment = Instance.new("SphereHandleAdornment")
    SphereHandleAdornment.Adornee = workspace.Terrain
    SphereHandleAdornment.CFrame = p1
    SphereHandleAdornment.Radius = 0.4
    SphereHandleAdornment.Transparency = 0.25
    if p2 ~= false then
        v1 = Color3.new(1, 0.2, 0.2)
    else
        v1 = Color3.new(0.2, 1, 0.5)
        if not v1 then
            v1 = Color3.new(1, 0.2, 0.2)
        end
    end
    SphereHandleAdornment.Color3 = v1
    local FastCastVisualizationObjects = workspace.Terrain:FindFirstChild("FastCastVisualizationObjects")
    if FastCastVisualizationObjects == nil then
        local v2 = Instance.new("Folder")
        v2.Name = "FastCastVisualizationObjects"
        v2.Archivable = false
        v2.Parent = workspace.Terrain
        v1 = v2
    else
        v1 = FastCastVisualizationObjects
    end
    SphereHandleAdornment.Parent = v1
    return SphereHandleAdornment
end
local function GetPositionAtTime(p1, p2, p3, p4) -- Line: 120
    local v1 = Vector3.new(p4.X * p1 ^ 2 / 2, p4.Y * p1 ^ 2 / 2, p4.Z * p1 ^ 2 / 2)
    return p2 + p3 * p1 + v1
end
local function GetVelocityAtTime(p1, p2, p3) -- Line: 126
    return p2 + p3 * p1
end
local function GetTrajectoryInfo(p1, p2) -- Line: 130
    local v1 = p1.StateInfo.UpdateConnection ~= nil
    assert(v1, "This ActiveCast has been terminated. It can no longer be used.")
    v1 = p1.StateInfo.Trajectories[p2]
    local v2 = v1.EndTime - v1.StartTime
    local InitialVelocity = v1.InitialVelocity
    local Acceleration = v1.Acceleration
    local v3 = {}
    local v4 = Vector3.new(Acceleration.X * v2 ^ 2 / 2, Acceleration.Y * v2 ^ 2 / 2, Acceleration.Z * v2 ^ 2 / 2)
    v3[1] = v1.Origin + InitialVelocity * v2 + v4
    v3[2] = InitialVelocity + Acceleration * v2
    return v3
end
local function GetLatestTrajectoryEndInfo(p1) -- Line: 143 -- upvalues: GetTrajectoryInfo (val)
    local v1 = p1.StateInfo.UpdateConnection ~= nil
    assert(v1, "This ActiveCast has been terminated. It can no longer be used.")
    return (GetTrajectoryInfo(p1, #p1.StateInfo.Trajectories))
end
local function CloneCastParams(p1) -- Line: 148
    local v1 = RaycastParams.new()
    v1.CollisionGroup = p1.CollisionGroup
    v1.FilterType = p1.FilterType
    v1.FilterDescendantsInstances = p1.FilterDescendantsInstances
    v1.IgnoreWater = p1.IgnoreWater
    return v1
end
local function SendRayHit(p1, p2, p3, p4) -- Line: 157
    p1.Caster.RayHit:Fire(p1, p2, p3, p4)
end
local function SendRayPierced(p1, p2, p3, p4) -- Line: 162
    p1.Caster.RayPierced:Fire(p1, p2, p3, p4)
end
local function SendLengthChanged(p1, p2, p3, p4, p5, p6) -- Line: 167
    p1.Caster.LengthChanged:Fire(p1, p2, p3, p4, p5, p6)
end
local function SimulateCast(p1, p2, p3) -- Line: 173 -- upvalues: u16 (ref), u15 (val)
    local StateInfo, v1, v2
    local v3 = p1.StateInfo.UpdateConnection ~= nil
    assert(v3, "This ActiveCast has been terminated. It can no longer be used.")
    if u16.DebugLogging == true then
        print("Casting for frame.")
    end
    local v4 = p1.StateInfo.Trajectories[#p1.StateInfo.Trajectories]
    local Origin = v4.Origin
    local InitialVelocity = v4.InitialVelocity
    local Acceleration = v4.Acceleration
    local v5 = p1.StateInfo.TotalRuntime - v4.StartTime
    local v6 = Vector3.new(Acceleration.X * v5 ^ 2 / 2, Acceleration.Y * v5 ^ 2 / 2, Acceleration.Z * v5 ^ 2 / 2)
    local v7 = Origin + InitialVelocity * v5 + v6
    v6 = p1.StateInfo.TotalRuntime - v4.StartTime
    StateInfo = p1.StateInfo
    StateInfo.TotalRuntime = StateInfo.TotalRuntime + p2
    local v8 = p1.StateInfo.TotalRuntime - v4.StartTime
    local v9 = v8
    local v10 = Vector3.new(Acceleration.X * v9 ^ 2 / 2, Acceleration.Y * v9 ^ 2 / 2, Acceleration.Z * v9 ^ 2 / 2)
    local v11 = Origin + InitialVelocity * v9 + v10
    v9 = InitialVelocity + Acceleration * v8
    local v12 = (v11 - v7).Unit * v9.Magnitude * p2
    local WorldRoot = p1.RayInfo.WorldRoot
    local v13 = WorldRoot:Raycast(v7, v12, p1.RayInfo.Parameters)
    local Position = v11
    local Instance = nil
    local Air = Enum.Material.Air
    Vector3.new()
    if v13 ~= nil then
        Position = v13.Position
        Instance = v13.Instance
        Air = v13.Material
    end
    local Magnitude = (Position - v7).Magnitude
    p1.Caster.LengthChanged:Fire(p1, v7, v12.Unit, Magnitude, v9, p1.RayInfo.CosmeticBulletObject)
    local StateInfo_2 = p1.StateInfo
    StateInfo_2.DistanceCovered = StateInfo_2.DistanceCovered + Magnitude
    local v14 = nil
    if 0 < p2 then
        v2 = CFrame.new(v7, v7 + v12)
        v14 = DbgVisualizeSegment(v2, Magnitude)
    end
    if not Instance then
        v1 = p1
        if v1.RayInfo.MaxDistance <= v1.StateInfo.DistanceCovered then
            v1:Terminate()
            v2 = CFrame.new(v11)
            DbgVisualizeHit(v2, false)
        end
        return
    elseif Instance == p1.RayInfo.CosmeticBulletObject then
        v1 = p1
        if v1.RayInfo.MaxDistance <= v1.StateInfo.DistanceCovered then
            v1:Terminate()
            v2 = CFrame.new(v11)
            DbgVisualizeHit(v2, false)
        end
        return
    else
        local v15, v16, v17, v18
        tick()
        if u16.DebugLogging == true then
            print("Hit something, testing now.")
        end
        if p1.RayInfo.CanPierceCallback ~= nil then
            if p3 == false and p1.StateInfo.IsActivelySimulatingPierce then
                p1:Terminate()
                error("ERROR: The latest call to CanPierceCallback took too long to complete! This cast is going to suffer desyncs which WILL cause unexpected behavior and errors. Please fix your performance problems, or remove statements that yield (e.g. wait() calls)")
            end
            p1.StateInfo.IsActivelySimulatingPierce = true
        end
        if p1.RayInfo.CanPierceCallback == nil then
            if u16.DebugLogging == true then
                print("Piercing function is nil or it returned FALSE to not pierce this hit.")
            end
            p1.StateInfo.IsActivelySimulatingPierce = false
            if p1.StateInfo.HighFidelityBehavior ~= 2 then
                if p1.StateInfo.HighFidelityBehavior == 1 or p1.StateInfo.HighFidelityBehavior == 3 then
                    if u16.DebugLogging == true then
                        print("Hit was successful. Terminating.")
                    end
                    p1.Caster.RayHit:Fire(p1, v13, v9, p1.RayInfo.CosmeticBulletObject)
                    p1:Terminate()
                    v15 = CFrame.new(Position)
                    DbgVisualizeHit(v15, false)
                    return
                end
                p1:Terminate()
                error("Invalid value " .. p1.StateInfo.HighFidelityBehavior .. " for HighFidelityBehavior.")
                v1 = p1
                if v1.RayInfo.MaxDistance <= v1.StateInfo.DistanceCovered then
                    v1:Terminate()
                    v2 = CFrame.new(v11)
                    DbgVisualizeHit(v2, false)
                end
                return
            elseif v4.Acceleration ~= Vector3.new() and p1.StateInfo.HighFidelitySegmentSize ~= 0 then
                local v19, v20, v21, v22, v23, v24, v25, v26
                p1.StateInfo.CancelHighResCast = false
                if p1.StateInfo.IsActivelyResimulating then
                    p1:Terminate()
                    error("Cascading cast lag encountered! The caster attempted to perform a high fidelity cast before the previous one completed, resulting in exponential cast lag. Consider increasing HighFidelitySegmentSize.")
                end
                p1.StateInfo.IsActivelyResimulating = true
                if u16.DebugLogging == true then
                    print("Hit was registered, but recalculation is on for physics based casts. Recalculating to verify a real hit...")
                end
                v15 = math.floor(Magnitude / p1.StateInfo.HighFidelitySegmentSize)
                local v27 = p2 / v15
                v16 = v15
                v17 = 1
                v1, v19 = p1, p2
                for i = 1, v16, v17 do
                    if v1.StateInfo.CancelHighResCast then
                        v1.StateInfo.CancelHighResCast = false
                        break
                    end
                    v20 = v6 + v27 * i
                    v21 = Vector3.new(Acceleration.X * v20 ^ 2 / 2, Acceleration.Y * v20 ^ 2 / 2, Acceleration.Z * v20 ^ 2 / 2)
                    v18 = Origin + InitialVelocity * v20 + v21
                    v20 = InitialVelocity + Acceleration * (v6 + v27 * i)
                    v22 = WorldRoot:Raycast(v18, v20 * v19, v1.RayInfo.Parameters)
                    if v22 ~= nil then
                        v25 = CFrame.new(v18, v18 + v20)
                        v24 = DbgVisualizeSegment(v25, (v18 - v22.Position).Magnitude)
                        if v24 ~= nil then
                            v24.Color3 = Color3.new(0.286275, 0.329412, 0.247059)
                        end
                        if v1.RayInfo.CanPierceCallback == nil then
                            v1.StateInfo.IsActivelyResimulating = false
                            v1.Caster.RayHit:Fire(v1, v22, v20, v1.RayInfo.CosmeticBulletObject)
                            v1:Terminate()
                            v26 = CFrame.new(Position)
                            v25 = DbgVisualizeHit(v26, false)
                            if v25 ~= nil then
                                v25.Color3 = Color3.new(0.0588235, 0.87451, 1)
                            end
                            return
                        end
                        if v1.RayInfo.CanPierceCallback ~= nil and v1.RayInfo.CanPierceCallback(v1, v22, v20, v1.RayInfo.CosmeticBulletObject) == false then
                            v1.StateInfo.IsActivelyResimulating = false
                            v1.Caster.RayHit:Fire(v1, v22, v20, v1.RayInfo.CosmeticBulletObject)
                            v1:Terminate()
                            v26 = CFrame.new(Position)
                            v25 = DbgVisualizeHit(v26, false)
                            if v25 ~= nil then
                                v25.Color3 = Color3.new(0.0588235, 0.87451, 1)
                            end
                            return
                        end
                        v1.Caster.RayPierced:Fire(v1, v22, v20, v1.RayInfo.CosmeticBulletObject)
                        v26 = CFrame.new(Position)
                        v25 = DbgVisualizeHit(v26, true)
                        if v25 ~= nil then
                            v25.Color3 = Color3.new(1, 0.113725, 0.588235)
                        end
                        if v24 ~= nil then
                            v24.Color3 = Color3.new(0.305882, 0.243137, 0.329412)
                        end
                        continue
                    end
                    v24 = CFrame.new(v18, v18 + v20)
                    v23 = DbgVisualizeSegment(v24, (v18 - (v18 + v20)).Magnitude)
                    if v23 ~= nil then
                        v23.Color3 = Color3.new(0.286275, 0.329412, 0.247059)
                    end
                end
                v1.StateInfo.IsActivelyResimulating = false
                if v1.RayInfo.MaxDistance <= v1.StateInfo.DistanceCovered then
                    v1:Terminate()
                    v2 = CFrame.new(v11)
                    DbgVisualizeHit(v2, false)
                end
                return
            end
        elseif p1.RayInfo.CanPierceCallback == nil then
            local FilterDescendantsInstances_2, FilterDescendantsInstances_3, v28
            if u16.DebugLogging == true then
                print("Piercing function returned TRUE to pierce this part.")
            end
            if v14 ~= nil then
                v14.Color3 = Color3.new(0.4, 0.05, 0.05)
            end
            v15 = CFrame.new(Position)
            DbgVisualizeHit(v15, true)
            local Parameters = p1.RayInfo.Parameters
            v15 = {}
            local v29 = 0
            local FilterDescendantsInstances = Parameters.FilterDescendantsInstances
            v16 = false
            v1 = p1
            while true do
                if v13.Instance:IsA("Terrain") then
                    if Air == Enum.Material.Water then
                        v1:Terminate()
                        error("Do not add Water as a piercable material. If you need to pierce water, set cast.RayInfo.Parameters.IgnoreWater = true instead", 0)
                    end
                    warn("WARNING: The pierce callback for this cast returned TRUE on Terrain! This can cause severely adverse effects.")
                end
                if Parameters.FilterType ~= Enum.RaycastFilterType.Blacklist then
                    FilterDescendantsInstances_3 = Parameters.FilterDescendantsInstances
                    u15.removeObject(FilterDescendantsInstances_3, v13.Instance)
                    u15.insert(v15, v13.Instance)
                    Parameters.FilterDescendantsInstances = FilterDescendantsInstances_3
                else
                    FilterDescendantsInstances_2 = Parameters.FilterDescendantsInstances
                    u15.insert(FilterDescendantsInstances_2, v13.Instance)
                    u15.insert(v15, v13.Instance)
                    Parameters.FilterDescendantsInstances = FilterDescendantsInstances_2
                end
                v1.Caster.RayPierced:Fire(v1, v13, v9, v1.RayInfo.CosmeticBulletObject)
                v13 = WorldRoot:Raycast(v7, v12, Parameters)
                if v13 ~= nil then
                    if 100 > v29 then
                        v29 = v29 + 1
                        if v1.RayInfo.CanPierceCallback(v1, v13, v9, v1.RayInfo.CosmeticBulletObject) ~= false then
                            continue
                        else
                            v16 = true
                        end
                    else
                        warn("WARNING: Exceeded maximum pierce test budget for a single ray segment (attempted to test the same segment " .. 100 .. " times!)")
                    end
                end
                v1.RayInfo.Parameters.FilterDescendantsInstances = FilterDescendantsInstances
                v1.StateInfo.IsActivelySimulatingPierce = false
                if not v16 then
                    if v1.RayInfo.MaxDistance <= v1.StateInfo.DistanceCovered then
                        v1:Terminate()
                        v2 = CFrame.new(v11)
                        DbgVisualizeHit(v2, false)
                    end
                    return
                end
                v18 = tostring(v13.Instance)
                v17 = "Broke because the ray hit something solid (" .. v18 .. ") while testing for a pierce. Terminating the cast."
                if u16.DebugLogging == true then
                    print(v17)
                end
                v1.Caster.RayHit:Fire(v1, v13, v9, v1.RayInfo.CosmeticBulletObject)
                v1:Terminate()
                v28 = CFrame.new(v13.Position)
                DbgVisualizeHit(v28, false)
                return
            end
        elseif p1.RayInfo.CanPierceCallback(p1, v13, v9, p1.RayInfo.CosmeticBulletObject) ~= false then
        end
    end
end
function u6.new(p1, p2, p3, p4, p5) -- Line: 422 -- upvalues: u5 (val), u15 (val), RunService (val), u6 (val), u16 (ref), SimulateCast (val)
    local CurrentCacheParent, Parameters, RayInfo, RenderStepped, StateInfo, v1, v2
    if u5(p4) ~= "number" then
        v1 = p4
    else
        v1 = p3.Unit * p4
    end
    if p5.HighFidelitySegmentSize <= 0 then
        error("Cannot set FastCastBehavior.HighFidelitySegmentSize <= 0!", 0)
    end
    local u17 = {Caster = p1}
    local v3 = {
        Paused = false,
        TotalRuntime = 0,
        DistanceCovered = 0,
        IsActivelySimulatingPierce = false,
        IsActivelyResimulating = false,
        CancelHighResCast = false,
        HighFidelitySegmentSize = p5.HighFidelitySegmentSize,
        HighFidelityBehavior = p5.HighFidelityBehavior,
    }
    local v4 = {}
    local v5 = {
        StartTime = 0,
        EndTime = -1,
        Origin = p2,
        InitialVelocity = v1,
        Acceleration = p5.Acceleration,
    }
    v4[1] = v5
    v3.Trajectories = v4
    u17.StateInfo = v3
    u17.RayInfo = {
        Parameters = p5.RaycastParams,
        WorldRoot = workspace,
        MaxDistance = p5.MaxDistance or 1000,
        CosmeticBulletObject = p5.CosmeticBulletTemplate,
        CanPierceCallback = p5.CanPierceFunction,
    }
    u17.UserData = {}
    if u17.StateInfo.HighFidelityBehavior == 2 then
        u17.StateInfo.HighFidelityBehavior = 3
    end
    if u17.RayInfo.Parameters == nil then
        local RayInfo_2 = u17.RayInfo
        RayInfo_2.Parameters = RaycastParams.new()
    else
        RayInfo = u17.RayInfo
        Parameters = u17.RayInfo.Parameters
        v2 = RaycastParams.new()
        v2.CollisionGroup = Parameters.CollisionGroup
        v2.FilterType = Parameters.FilterType
        v2.FilterDescendantsInstances = Parameters.FilterDescendantsInstances
        v2.IgnoreWater = Parameters.IgnoreWater
        RayInfo.Parameters = v2
    end
    v3 = false
    if p5.CosmeticBulletProvider ~= nil then
        if u5(p5.CosmeticBulletProvider) ~= "PartCache" then
            warn("FastCastBehavior.CosmeticBulletProvider was not an instance of the PartCache module (an external/separate model)! Are you inputting an instance created via PartCache.new? If so, are you on the latest version of PartCache? Setting FastCastBehavior.CosmeticBulletProvider to nil.")
            p5.CosmeticBulletProvider = nil
        else
            if u17.RayInfo.CosmeticBulletObject ~= nil then
                warn("Do not define FastCastBehavior.CosmeticBulletTemplate and FastCastBehavior.CosmeticBulletProvider at the same time! The provider will be used, and CosmeticBulletTemplate will be set to nil.")
                u17.RayInfo.CosmeticBulletObject = nil
                p5.CosmeticBulletTemplate = nil
            end
            local RayInfo_4 = u17.RayInfo
            RayInfo_4.CosmeticBulletObject = p5.CosmeticBulletProvider:GetPart()
            u17.RayInfo.CosmeticBulletObject.CFrame = CFrame.new(p2, p2 + p3)
            v3 = true
        end
    elseif u17.RayInfo.CosmeticBulletObject ~= nil then
        local RayInfo_3 = u17.RayInfo
        RayInfo_3.CosmeticBulletObject = u17.RayInfo.CosmeticBulletObject:Clone()
        u17.RayInfo.CosmeticBulletObject.CFrame = CFrame.new(p2, p2 + p3)
        u17.RayInfo.CosmeticBulletObject.Parent = p5.CosmeticBulletContainer
    end
    if not v3 then
        CurrentCacheParent = p5.CosmeticBulletContainer
    else
        CurrentCacheParent = p5.CosmeticBulletProvider.CurrentCacheParent
    end
    if p5.AutoIgnoreContainer == true and CurrentCacheParent ~= nil then
        local FilterDescendantsInstances = u17.RayInfo.Parameters.FilterDescendantsInstances
        if u15.find(FilterDescendantsInstances, CurrentCacheParent) == nil then
            u15.insert(FilterDescendantsInstances, CurrentCacheParent)
            u17.RayInfo.Parameters.FilterDescendantsInstances = FilterDescendantsInstances
        end
    end
    if not (RunService:IsClient()) then
        RenderStepped = RunService.Heartbeat
    else
        RenderStepped = RunService.RenderStepped
    end
    setmetatable(u17, u6)
    StateInfo = u17.StateInfo
    StateInfo.UpdateConnection = RenderStepped:Connect(function(p1) -- Line: 535 -- upvalues: u17 (val), u16 (upval), SimulateCast (upval)
        local Acceleration, Position, StateInfo, v1
        if u17.StateInfo.Paused then
            return
        end
        if u16.DebugLogging == true then
            print("Casting for frame.")
        end
        local v2 = u17.StateInfo.Trajectories[#u17.StateInfo.Trajectories]
        if u17.StateInfo.HighFidelityBehavior ~= 3 or v2.Acceleration == Vector3.new() or 0 >= u17.StateInfo.HighFidelitySegmentSize then
            SimulateCast(u17, p1, false)
            return
        end
        local v3 = tick()
        if u17.StateInfo.IsActivelyResimulating then
            u17:Terminate()
            error("Cascading cast lag encountered! The caster attempted to perform a high fidelity cast before the previous one completed, resulting in exponential cast lag. Consider increasing HighFidelitySegmentSize.")
        end
        u17.StateInfo.IsActivelyResimulating = true
        local Origin = v2.Origin
        local InitialVelocity = v2.InitialVelocity
        Acceleration = v2.Acceleration
        local v4 = u17.StateInfo.TotalRuntime - v2.StartTime
        local v5 = Vector3.new(Acceleration.X * v4 ^ 2 / 2, Acceleration.Y * v4 ^ 2 / 2, Acceleration.Z * v4 ^ 2 / 2)
        local v6 = Origin + InitialVelocity * v4 + v5
        StateInfo = u17.StateInfo
        StateInfo.TotalRuntime = StateInfo.TotalRuntime + p1
        local v7 = u17.StateInfo.TotalRuntime - v2.StartTime
        local v8 = v7
        local v9 = Vector3.new(Acceleration.X * v8 ^ 2 / 2, Acceleration.Y * v8 ^ 2 / 2, Acceleration.Z * v8 ^ 2 / 2)
        local v10 = Origin + InitialVelocity * v8 + v9
        local v11 = u17.RayInfo.WorldRoot:Raycast(v6, (v10 - v6).Unit * (InitialVelocity + Acceleration * v7).Magnitude * p1, u17.RayInfo.Parameters)
        Position = if v11 ~= nil then v11.Position else v10
        local StateInfo_2 = u17.StateInfo
        StateInfo_2.TotalRuntime = StateInfo_2.TotalRuntime - p1
        local v12 = math.floor((Position - v6).Magnitude / u17.StateInfo.HighFidelitySegmentSize)
        if v12 == 0 then
            v12 = 1
        end
        local v13 = p1 / v12
        local v14 = v12
        local v15 = 1
        for i = 1, v14, v15 do
            if getmetatable(u17) == nil then
                return
            end
            if u17.StateInfo.CancelHighResCast then
                u17.StateInfo.CancelHighResCast = false
                break
            end
            v1 = "[" .. i .. "] Subcast of time increment " .. v13
            if u16.DebugLogging == true then
                print(v1)
            end
            SimulateCast(u17, v13, true)
        end
        if getmetatable(u17) == nil then
            return
        end
        u17.StateInfo.IsActivelyResimulating = false
        v14 = tick() - v3
        if 0.08 >= v14 then
            return
        end
        warn("Extreme cast lag encountered! Consider increasing HighFidelitySegmentSize.")
    end)
    return u17
end
function u6.SetStaticFastCastReference(p1) -- Line: 619 -- upvalues: u16 (ref)
    u16 = p1
end
local function ModifyTransformation(p1, p2, p3, p4) -- Line: 625 -- upvalues: GetTrajectoryInfo (val), u15 (val)
    local Acceleration, InitialVelocity, Origin, v1, v2
    local Trajectories = p1.StateInfo.Trajectories
    local v3 = Trajectories[#Trajectories]
    if v3.StartTime == p1.StateInfo.TotalRuntime then
        if p2 ~= nil then
            InitialVelocity = p2
        else
            InitialVelocity = v3.InitialVelocity
        end
        if p3 ~= nil then
            Acceleration = p3
        else
            Acceleration = v3.Acceleration
        end
        if p4 ~= nil then
            Origin = p4
        else
            Origin = v3.Origin
        end
        v3.Origin = Origin
        v3.InitialVelocity = InitialVelocity
        v3.Acceleration = Acceleration
        return
    end
    v3.EndTime = p1.StateInfo.TotalRuntime
    local v4 = p1.StateInfo.UpdateConnection ~= nil
    assert(v4, "This ActiveCast has been terminated. It can no longer be used.")
    v1, v2 = unpack((GetTrajectoryInfo(p1, #p1.StateInfo.Trajectories)))
    if p2 ~= nil then
        InitialVelocity = p2
    else
        InitialVelocity = v2
    end
    if p3 ~= nil then
        Acceleration = p3
    else
        Acceleration = v3.Acceleration
    end
    if p4 ~= nil then
        Origin = p4
    else
        Origin = v1
    end
    u15.insert(p1.StateInfo.Trajectories, {
        EndTime = -1,
        StartTime = p1.StateInfo.TotalRuntime,
        Origin = Origin,
        InitialVelocity = InitialVelocity,
        Acceleration = Acceleration,
    })
    p1.StateInfo.CancelHighResCast = true
end
function u6:SetVelocity(p2) -- Line: 671 -- upvalues: u6 (val), ModifyTransformation (val)
    local v1 = getmetatable(self)
    local v2 = v1 == u6
    assert(v2, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("SetVelocity", "ActiveCast.new(...)"))
    v2 = self.StateInfo.UpdateConnection ~= nil
    assert(v2, "This ActiveCast has been terminated. It can no longer be used.")
    ModifyTransformation(self, p2, nil, nil)
end
function u6:SetAcceleration(p2) -- Line: 677 -- upvalues: u6 (val), ModifyTransformation (val)
    local v1 = getmetatable(self)
    local v2 = v1 == u6
    assert(v2, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("SetAcceleration", "ActiveCast.new(...)"))
    v2 = self.StateInfo.UpdateConnection ~= nil
    assert(v2, "This ActiveCast has been terminated. It can no longer be used.")
    ModifyTransformation(self, nil, p2, nil)
end
function u6:SetPosition(p2) -- Line: 683 -- upvalues: u6 (val), ModifyTransformation (val)
    local v1 = getmetatable(self)
    local v2 = v1 == u6
    assert(v2, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("SetPosition", "ActiveCast.new(...)"))
    v2 = self.StateInfo.UpdateConnection ~= nil
    assert(v2, "This ActiveCast has been terminated. It can no longer be used.")
    ModifyTransformation(self, nil, nil, p2)
end
function u6:GetVelocity() -- Line: 689 -- upvalues: u6 (val)
    local v1 = getmetatable(self)
    local v2 = v1 == u6
    assert(v2, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("GetVelocity", "ActiveCast.new(...)"))
    v2 = self.StateInfo.UpdateConnection ~= nil
    assert(v2, "This ActiveCast has been terminated. It can no longer be used.")
    local v3 = self.StateInfo.Trajectories[#self.StateInfo.Trajectories]
    return v3.InitialVelocity + v3.Acceleration * (self.StateInfo.TotalRuntime - v3.StartTime)
end
function u6:GetAcceleration() -- Line: 696 -- upvalues: u6 (val)
    local v1 = getmetatable(self)
    local v2 = v1 == u6
    assert(v2, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("GetAcceleration", "ActiveCast.new(...)"))
    v2 = self.StateInfo.UpdateConnection ~= nil
    assert(v2, "This ActiveCast has been terminated. It can no longer be used.")
    return self.StateInfo.Trajectories[#self.StateInfo.Trajectories].Acceleration
end
function u6:GetPosition() -- Line: 703 -- upvalues: u6 (val)
    local v1 = getmetatable(self)
    local v2 = v1 == u6
    assert(v2, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("GetPosition", "ActiveCast.new(...)"))
    v2 = self.StateInfo.UpdateConnection ~= nil
    assert(v2, "This ActiveCast has been terminated. It can no longer be used.")
    local v3 = self.StateInfo.Trajectories[#self.StateInfo.Trajectories]
    v1 = self.StateInfo.TotalRuntime - v3.StartTime
    local Acceleration = v3.Acceleration
    local v4 = Vector3.new(Acceleration.X * v1 ^ 2 / 2, Acceleration.Y * v1 ^ 2 / 2, Acceleration.Z * v1 ^ 2 / 2)
    return v3.Origin + v3.InitialVelocity * v1 + v4
end
function u6.AddVelocity(p1, p2) -- Line: 712 -- upvalues: u6 (val)
    local v1 = getmetatable(p1)
    local v2 = v1 == u6
    assert(v2, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("AddVelocity", "ActiveCast.new(...)"))
    v2 = p1.StateInfo.UpdateConnection ~= nil
    assert(v2, "This ActiveCast has been terminated. It can no longer be used.")
    p1:SetVelocity(p1:GetVelocity() + p2)
end
function u6.AddAcceleration(p1, p2) -- Line: 718 -- upvalues: u6 (val)
    local v1 = getmetatable(p1)
    local v2 = v1 == u6
    assert(v2, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("AddAcceleration", "ActiveCast.new(...)"))
    v2 = p1.StateInfo.UpdateConnection ~= nil
    assert(v2, "This ActiveCast has been terminated. It can no longer be used.")
    p1:SetAcceleration(p1:GetAcceleration() + p2)
end
function u6.AddPosition(p1, p2) -- Line: 724 -- upvalues: u6 (val)
    local v1 = getmetatable(p1)
    local v2 = v1 == u6
    assert(v2, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("AddPosition", "ActiveCast.new(...)"))
    v2 = p1.StateInfo.UpdateConnection ~= nil
    assert(v2, "This ActiveCast has been terminated. It can no longer be used.")
    p1:SetPosition(p1:GetPosition() + p2)
end
function u6.Pause(p1) -- Line: 732 -- upvalues: u6 (val)
    local v1 = getmetatable(p1)
    local v2 = v1 == u6
    assert(v2, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("Pause", "ActiveCast.new(...)"))
    v2 = p1.StateInfo.UpdateConnection ~= nil
    assert(v2, "This ActiveCast has been terminated. It can no longer be used.")
    p1.StateInfo.Paused = true
end
function u6.Resume(p1) -- Line: 738 -- upvalues: u6 (val)
    local v1 = getmetatable(p1)
    local v2 = v1 == u6
    assert(v2, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("Resume", "ActiveCast.new(...)"))
    v2 = p1.StateInfo.UpdateConnection ~= nil
    assert(v2, "This ActiveCast has been terminated. It can no longer be used.")
    p1.StateInfo.Paused = false
end
function u6:Terminate() -- Line: 744 -- upvalues: u6 (val)
    local v1 = getmetatable(self)
    local v2 = v1 == u6
    assert(v2, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("Terminate", "ActiveCast.new(...)"))
    v2 = self.StateInfo.UpdateConnection ~= nil
    assert(v2, "This ActiveCast has been terminated. It can no longer be used.")
    local Trajectories = self.StateInfo.Trajectories
    v2 = Trajectories[#Trajectories]
    v2.EndTime = self.StateInfo.TotalRuntime
    self.StateInfo.UpdateConnection:Disconnect()
    self.Caster.CastTerminating:FireSync(self)
    self.StateInfo.UpdateConnection = nil
    self.Caster = nil
    self.StateInfo = nil
    self.RayInfo = nil
    self.UserData = nil
    setmetatable(self, nil)
end
return u6