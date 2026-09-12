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
    local v1 = p4.X * p1 ^ 2 / 2
    local v2 = p4.Y * p1 ^ 2 / 2
    local v3 = p4.Z * p1 ^ 2 / 2
    local v4 = Vector3.new(v1, v2, v3)
    return p2 + p3 * p1 + v4
end

local function GetVelocityAtTime(p1, p2, p3) -- Line: 126
    return p2 + p3 * p1
end

local function GetTrajectoryInfo(p1, p2) -- Line: 130
    local v1 = p1.StateInfo.UpdateConnection ~= nil
    assert(v1, "This ActiveCast has been terminated. It can no longer be used.")
    v1 = p1.StateInfo.Trajectories[p2]
    local v2 = v1.EndTime - v1.StartTime
    local Origin = v1.Origin
    local InitialVelocity = v1.InitialVelocity
    local Acceleration = v1.Acceleration
    local v3 = {}
    local v4 = Acceleration.X * v2 ^ 2 / 2
    local v5 = Acceleration.Y * v2 ^ 2 / 2
    local v6 = Acceleration.Z * v2 ^ 2 / 2
    local v7 = Vector3.new(v4, v5, v6)
    v3[1] = Origin + InitialVelocity * v2 + v7
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
    local DistanceCovered, v1
    local v2 = p1.StateInfo.UpdateConnection ~= nil
    assert(v2, "This ActiveCast has been terminated. It can no longer be used.")
    if u16.DebugLogging == true then
        print("Casting for frame.")
    end
    local v3 = p1.StateInfo.Trajectories[#p1.StateInfo.Trajectories]
    local Origin = v3.Origin
    local v4 = p1.StateInfo.TotalRuntime - v3.StartTime
    local InitialVelocity = v3.InitialVelocity
    local Acceleration = v3.Acceleration
    local v5 = v4
    local v6 = Acceleration.X * v5 ^ 2 / 2
    local v7 = Acceleration.Y * v5 ^ 2 / 2
    local v8 = Acceleration.Z * v5 ^ 2 / 2
    local v9 = Vector3.new(v6, v7, v8)
    local v10 = Origin + InitialVelocity * v5 + v9
    v5 = InitialVelocity + Acceleration * v4
    v9 = p1.StateInfo.TotalRuntime - v3.StartTime
    local StateInfo = p1.StateInfo
    StateInfo.TotalRuntime = StateInfo.TotalRuntime + p2
    v4 = p1.StateInfo.TotalRuntime - v3.StartTime
    v7 = v4
    local v11 = Acceleration.X * v7 ^ 2 / 2
    local v12 = Acceleration.Y * v7 ^ 2 / 2
    local v13 = Acceleration.Z * v7 ^ 2 / 2
    v8 = Vector3.new(v11, v12, v13)
    v6 = Origin + InitialVelocity * v7 + v8
    v7 = InitialVelocity + Acceleration * v4
    v11 = (v6 - v10).Unit * v7.Magnitude * p2
    local WorldRoot = p1.RayInfo.WorldRoot
    local Parameters = p1.RayInfo.Parameters
    v13 = WorldRoot:Raycast(v10, v11, Parameters)
    local Position = v6
    local Instance = nil
    local Air = Enum.Material.Air
    Vector3.new()
    if v13 ~= nil then
        Position = v13.Position
        Instance = v13.Instance
        Air = v13.Material
        local Normal = v13.Normal
    end
    local Magnitude = (Position - v10).Magnitude
    local Unit = v11.Unit
    local CosmeticBulletObject = p1.RayInfo.CosmeticBulletObject
    p1.Caster.LengthChanged:Fire(p1, v10, Unit, Magnitude, v7, CosmeticBulletObject)
    local StateInfo_2 = p1.StateInfo
    StateInfo_2.DistanceCovered = StateInfo_2.DistanceCovered + Magnitude
    local v14 = nil
    if 0 < p2 then
        v14 = DbgVisualizeSegment(CFrame.new(v10, v10 + v11), Magnitude)
    end
    if not Instance then
        v1 = p1
    else
        if Instance ~= p1.RayInfo.CosmeticBulletObject then
            local CosmeticBulletObject_4, CosmeticBulletObject_5, CosmeticBulletObject_6, Magnitude_2, Magnitude_3, Parameters_3, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26, v27, v28
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
            if p1.RayInfo.CanPierceCallback ~= nil then
                local CosmeticBulletObject_2, CosmeticBulletObject_3, FilterDescendantsInstances_2, FilterDescendantsInstances_3, Instance_2, v29
                if p1.RayInfo.CanPierceCallback ~= nil
                    and p1.RayInfo.CanPierceCallback(p1, v13, v7, p1.RayInfo.CosmeticBulletObject) == false then
                    if u16.DebugLogging == true then
                        print("Piercing function is nil or it returned FALSE to not pierce this hit.")
                    end
                    p1.StateInfo.IsActivelySimulatingPierce = false
                    if p1.StateInfo.HighFidelityBehavior == 2
                        and v3.Acceleration ~= Vector3.new()
                        and p1.StateInfo.HighFidelitySegmentSize ~= 0 then
                        p1.StateInfo.CancelHighResCast = false
                        if p1.StateInfo.IsActivelyResimulating then
                            p1:Terminate()
                            error("Cascading cast lag encountered! The caster attempted to perform a high fidelity cast before the previous one completed, resulting in exponential cast lag. Consider increasing HighFidelitySegmentSize.")
                        end
                        p1.StateInfo.IsActivelyResimulating = true
                        if u16.DebugLogging == true then
                            print("Hit was registered, but recalculation is on for physics based casts. Recalculating to verify a real hit...")
                        end
                        v16 = Magnitude / p1.StateInfo.HighFidelitySegmentSize
                        v17 = math.floor(v16)
                        v18 = Magnitude / v17
                        v19 = p2 / v17
                        v20 = v17
                        v1, v15 = p1, p2
                        for i = 1, v20 do
                            if v1.StateInfo.CancelHighResCast then
                                v1.StateInfo.CancelHighResCast = false
                                break
                            end
                            v22 = v9 + v19 * i
                            v24 = Acceleration.X * v22 ^ 2 / 2
                            v25 = Acceleration.Y * v22 ^ 2 / 2
                            v27 = Acceleration.Z * v22 ^ 2
                            v26 = v27 / 2
                            v23 = Vector3.new(v24, v25, v26)
                            v21 = Origin + InitialVelocity * v22 + v23
                            v22 = InitialVelocity + Acceleration * (v9 + v19 * i)
                            v23 = v22 * v15
                            Parameters_3 = v1.RayInfo.Parameters
                            v24 = WorldRoot:Raycast(v21, v23, Parameters_3)
                            Magnitude_2 = (v21 - (v21 + v22)).Magnitude
                            if v24 ~= nil then
                                Magnitude_3 = (v21 - v24.Position).Magnitude
                                v27 = DbgVisualizeSegment
                                v28 = CFrame.new(v21, v21 + v22)
                                v27 = v27(v28, Magnitude_3)
                                if v27 ~= nil then
                                    v27.Color3 = Color3.new(0.286275, 0.329412, 0.247059)
                                end
                                if v1.RayInfo.CanPierceCallback == nil then
                                    v1.StateInfo.IsActivelyResimulating = false
                                    CosmeticBulletObject_5 = v1.RayInfo.CosmeticBulletObject
                                    v1.Caster.RayHit:Fire(v1, v24, v22, CosmeticBulletObject_5)
                                    v1:Terminate()
                                    v28 = DbgVisualizeHit(CFrame.new(Position), false)
                                    if v28 ~= nil then
                                        v28.Color3 = Color3.new(0.0588235, 0.87451, 1)
                                    end
                                    return
                                end
                                if v1.RayInfo.CanPierceCallback ~= nil
                                    and v1.RayInfo.CanPierceCallback(v1, v24, v22, v1.RayInfo.CosmeticBulletObject) == false then
                                    v1.StateInfo.IsActivelyResimulating = false
                                    CosmeticBulletObject_5 = v1.RayInfo.CosmeticBulletObject
                                    v1.Caster.RayHit:Fire(v1, v24, v22, CosmeticBulletObject_5)
                                    v1:Terminate()
                                    v28 = DbgVisualizeHit(CFrame.new(Position), false)
                                    if v28 ~= nil then
                                        v28.Color3 = Color3.new(0.0588235, 0.87451, 1)
                                    end
                                    return
                                end
                                CosmeticBulletObject_4 = v1.RayInfo.CosmeticBulletObject
                                v1.Caster.RayPierced:Fire(v1, v24, v22, CosmeticBulletObject_4)
                                v28 = DbgVisualizeHit(CFrame.new(Position), true)
                                if v28 ~= nil then
                                    v28.Color3 = Color3.new(1, 0.113725, 0.588235)
                                end
                                if v27 ~= nil then
                                    v27.Color3 = Color3.new(0.305882, 0.243137, 0.329412)
                                end
                                continue
                            end
                            v26 = DbgVisualizeSegment(CFrame.new(v21, v21 + v22), Magnitude_2)
                            if v26 ~= nil then
                                v26.Color3 = Color3.new(0.286275, 0.329412, 0.247059)
                            end
                        end
                        v1.StateInfo.IsActivelyResimulating = false
                        DistanceCovered = v1.StateInfo.DistanceCovered
                        if v1.RayInfo.MaxDistance <= DistanceCovered then
                            v1:Terminate()
                            DbgVisualizeHit(CFrame.new(v6), false)
                        end
                        return
                    end
                    if p1.StateInfo.HighFidelityBehavior ~= 1 and p1.StateInfo.HighFidelityBehavior ~= 3 then
                        p1:Terminate()
                        error("Invalid value " .. p1.StateInfo.HighFidelityBehavior .. " for HighFidelityBehavior.")
                        v1 = p1
                        DistanceCovered = v1.StateInfo.DistanceCovered
                        if v1.RayInfo.MaxDistance <= DistanceCovered then
                            v1:Terminate()
                            DbgVisualizeHit(CFrame.new(v6), false)
                        end
                        return
                    end
                    if u16.DebugLogging == true then
                        print("Hit was successful. Terminating.")
                    end
                    CosmeticBulletObject_6 = p1.RayInfo.CosmeticBulletObject
                    p1.Caster.RayHit:Fire(p1, v13, v7, CosmeticBulletObject_6)
                    p1:Terminate()
                    DbgVisualizeHit(CFrame.new(Position), false)
                    return
                end
                if u16.DebugLogging == true then
                    print("Piercing function returned TRUE to pierce this part.")
                end
                if v14 ~= nil then
                    v14.Color3 = Color3.new(0.4, 0.05, 0.05)
                end
                DbgVisualizeHit(CFrame.new(Position), true)
                local Parameters_2 = p1.RayInfo.Parameters
                v17 = {}
                v18 = 0
                local FilterDescendantsInstances = Parameters_2.FilterDescendantsInstances
                v20 = false
                v1 = p1
                while true do
                    if v13.Instance:IsA("Terrain") then
                        if Air == Enum.Material.Water then
                            v1:Terminate()
                            error(
                                "Do not add Water as a piercable material. If you need to pierce water, set cast.RayInfo.Parameters.IgnoreWater = true instead",
                                0
                            )
                        end
                        warn("WARNING: The pierce callback for this cast returned TRUE on Terrain! This can cause severely adverse effects.")
                    end
                    if Parameters_2.FilterType ~= Enum.RaycastFilterType.Blacklist then
                        FilterDescendantsInstances_3 = Parameters_2.FilterDescendantsInstances
                        u15.removeObject(FilterDescendantsInstances_3, v13.Instance)
                        u15.insert(v17, v13.Instance)
                        Parameters_2.FilterDescendantsInstances = FilterDescendantsInstances_3
                    else
                        FilterDescendantsInstances_2 = Parameters_2.FilterDescendantsInstances
                        u15.insert(FilterDescendantsInstances_2, v13.Instance)
                        u15.insert(v17, v13.Instance)
                        Parameters_2.FilterDescendantsInstances = FilterDescendantsInstances_2
                    end
                    CosmeticBulletObject_2 = v1.RayInfo.CosmeticBulletObject
                    v1.Caster.RayPierced:Fire(v1, v13, v7, CosmeticBulletObject_2)
                    v13 = WorldRoot:Raycast(v10, v11, Parameters_2)
                    if v13 ~= nil then
                        if not (100 <= v18) then
                            v18 = v18 + 1
                            if v1.RayInfo.CanPierceCallback(v1, v13, v7, v1.RayInfo.CosmeticBulletObject) ~= false then
                                continue
                            else
                                v20 = true
                            end
                        else
                            warn("WARNING: Exceeded maximum pierce test budget for a single ray segment (attempted to test the same segment " .. 100 .. " times!)")
                        end
                    end
                    v1.RayInfo.Parameters.FilterDescendantsInstances = FilterDescendantsInstances
                    v1.StateInfo.IsActivelySimulatingPierce = false
                    if not v20 then
                        DistanceCovered = v1.StateInfo.DistanceCovered
                        if v1.RayInfo.MaxDistance <= DistanceCovered then
                            v1:Terminate()
                            DbgVisualizeHit(CFrame.new(v6), false)
                        end
                        return
                    end
                    Instance_2 = v13.Instance
                    v29 = "Broke because the ray hit something solid (" .. (tostring(Instance_2)) .. ") while testing for a pierce. Terminating the cast."
                    if u16.DebugLogging == true then
                        print(v29)
                    end
                    CosmeticBulletObject_3 = v1.RayInfo.CosmeticBulletObject
                    v1.Caster.RayHit:Fire(v1, v13, v7, CosmeticBulletObject_3)
                    v1:Terminate()
                    DbgVisualizeHit(CFrame.new(v13.Position), false)
                    return
                end
            end
            if u16.DebugLogging == true then
                print("Piercing function is nil or it returned FALSE to not pierce this hit.")
            end
            p1.StateInfo.IsActivelySimulatingPierce = false
            if p1.StateInfo.HighFidelityBehavior == 2
                and v3.Acceleration ~= Vector3.new()
                and p1.StateInfo.HighFidelitySegmentSize ~= 0 then
                p1.StateInfo.CancelHighResCast = false
                if p1.StateInfo.IsActivelyResimulating then
                    p1:Terminate()
                    error("Cascading cast lag encountered! The caster attempted to perform a high fidelity cast before the previous one completed, resulting in exponential cast lag. Consider increasing HighFidelitySegmentSize.")
                end
                p1.StateInfo.IsActivelyResimulating = true
                if u16.DebugLogging == true then
                    print("Hit was registered, but recalculation is on for physics based casts. Recalculating to verify a real hit...")
                end
                v16 = Magnitude / p1.StateInfo.HighFidelitySegmentSize
                v17 = math.floor(v16)
                v18 = Magnitude / v17
                v19 = p2 / v17
                v20 = v17
                v1, v15 = p1, p2
                for j = 1, v20 do
                    if v1.StateInfo.CancelHighResCast then
                        v1.StateInfo.CancelHighResCast = false
                        break
                    end
                    v22 = v9 + v19 * j
                    v24 = Acceleration.X * v22 ^ 2 / 2
                    v25 = Acceleration.Y * v22 ^ 2 / 2
                    v27 = Acceleration.Z * v22 ^ 2
                    v26 = v27 / 2
                    v23 = Vector3.new(v24, v25, v26)
                    v21 = Origin + InitialVelocity * v22 + v23
                    v22 = InitialVelocity + Acceleration * (v9 + v19 * j)
                    v23 = v22 * v15
                    Parameters_3 = v1.RayInfo.Parameters
                    v24 = WorldRoot:Raycast(v21, v23, Parameters_3)
                    Magnitude_2 = (v21 - (v21 + v22)).Magnitude
                    if v24 ~= nil then
                        Magnitude_3 = (v21 - v24.Position).Magnitude
                        v27 = DbgVisualizeSegment
                        v28 = CFrame.new(v21, v21 + v22)
                        v27 = v27(v28, Magnitude_3)
                        if v27 ~= nil then
                            v27.Color3 = Color3.new(0.286275, 0.329412, 0.247059)
                        end
                        if v1.RayInfo.CanPierceCallback == nil then
                            v1.StateInfo.IsActivelyResimulating = false
                            CosmeticBulletObject_5 = v1.RayInfo.CosmeticBulletObject
                            v1.Caster.RayHit:Fire(v1, v24, v22, CosmeticBulletObject_5)
                            v1:Terminate()
                            v28 = DbgVisualizeHit(CFrame.new(Position), false)
                            if v28 ~= nil then
                                v28.Color3 = Color3.new(0.0588235, 0.87451, 1)
                            end
                            return
                        end
                        if v1.RayInfo.CanPierceCallback ~= nil
                            and v1.RayInfo.CanPierceCallback(v1, v24, v22, v1.RayInfo.CosmeticBulletObject) == false then
                            v1.StateInfo.IsActivelyResimulating = false
                            CosmeticBulletObject_5 = v1.RayInfo.CosmeticBulletObject
                            v1.Caster.RayHit:Fire(v1, v24, v22, CosmeticBulletObject_5)
                            v1:Terminate()
                            v28 = DbgVisualizeHit(CFrame.new(Position), false)
                            if v28 ~= nil then
                                v28.Color3 = Color3.new(0.0588235, 0.87451, 1)
                            end
                            return
                        end
                        CosmeticBulletObject_4 = v1.RayInfo.CosmeticBulletObject
                        v1.Caster.RayPierced:Fire(v1, v24, v22, CosmeticBulletObject_4)
                        v28 = DbgVisualizeHit(CFrame.new(Position), true)
                        if v28 ~= nil then
                            v28.Color3 = Color3.new(1, 0.113725, 0.588235)
                        end
                        if v27 ~= nil then
                            v27.Color3 = Color3.new(0.305882, 0.243137, 0.329412)
                        end
                        continue
                    end
                    v26 = DbgVisualizeSegment(CFrame.new(v21, v21 + v22), Magnitude_2)
                    if v26 ~= nil then
                        v26.Color3 = Color3.new(0.286275, 0.329412, 0.247059)
                    end
                end
                v1.StateInfo.IsActivelyResimulating = false
                DistanceCovered = v1.StateInfo.DistanceCovered
                if v1.RayInfo.MaxDistance <= DistanceCovered then
                    v1:Terminate()
                    DbgVisualizeHit(CFrame.new(v6), false)
                end
                return
            end
            if p1.StateInfo.HighFidelityBehavior ~= 1 and p1.StateInfo.HighFidelityBehavior ~= 3 then
                p1:Terminate()
                error("Invalid value " .. p1.StateInfo.HighFidelityBehavior .. " for HighFidelityBehavior.")
                v1 = p1
                DistanceCovered = v1.StateInfo.DistanceCovered
                if v1.RayInfo.MaxDistance <= DistanceCovered then
                    v1:Terminate()
                    DbgVisualizeHit(CFrame.new(v6), false)
                end
                return
            end
            if u16.DebugLogging == true then
                print("Hit was successful. Terminating.")
            end
            CosmeticBulletObject_6 = p1.RayInfo.CosmeticBulletObject
            p1.Caster.RayHit:Fire(p1, v13, v7, CosmeticBulletObject_6)
            p1:Terminate()
            DbgVisualizeHit(CFrame.new(Position), false)
            return
        end
        v1 = p1
    end
    DistanceCovered = v1.StateInfo.DistanceCovered
    if v1.RayInfo.MaxDistance <= DistanceCovered then
        v1:Terminate()
        DbgVisualizeHit(CFrame.new(v6), false)
    end
end

function u6.new(p1, p2, p3, p4, p5) -- Line: 422
    -- upvalues: u5 (val), u15 (val), RunService (val), u6 (val), u16 (ref), SimulateCast (val)
    local CurrentCacheParent, RenderStepped, v1
    if u5(p4) ~= "number" then
        v1 = p4
    else
        v1 = p3.Unit * p4
    end
    if p5.HighFidelitySegmentSize <= 0 then
        error("Cannot set FastCastBehavior.HighFidelitySegmentSize <= 0!", 0)
    end
    local u17 = {}
    u17.Caster = p1
    local v2 = {
        Paused = false,
        TotalRuntime = 0,
        DistanceCovered = 0,
        IsActivelySimulatingPierce = false,
        IsActivelyResimulating = false,
        CancelHighResCast = false,
        HighFidelitySegmentSize = p5.HighFidelitySegmentSize,
        HighFidelityBehavior = p5.HighFidelityBehavior,
        Trajectories = {
            {
                StartTime = 0,
                EndTime = -1,
                Origin = p2,
                InitialVelocity = v1,
                Acceleration = p5.Acceleration,
            },
        },
    }
    u17.StateInfo = v2
    v2 = {
        Parameters = p5.RaycastParams,
        WorldRoot = workspace,
        MaxDistance = p5.MaxDistance or 1000,
        CosmeticBulletObject = p5.CosmeticBulletTemplate,
        CanPierceCallback = p5.CanPierceFunction,
    }
    u17.RayInfo = v2
    u17.UserData = {}
    if u17.StateInfo.HighFidelityBehavior == 2 then
        u17.StateInfo.HighFidelityBehavior = 3
    end
    if u17.RayInfo.Parameters == nil then
        local RayInfo_2 = u17.RayInfo
        RayInfo_2.Parameters = RaycastParams.new()
    else
        local RayInfo = u17.RayInfo
        local Parameters = u17.RayInfo.Parameters
        local v3 = RaycastParams.new()
        v3.CollisionGroup = Parameters.CollisionGroup
        v3.FilterType = Parameters.FilterType
        v3.FilterDescendantsInstances = Parameters.FilterDescendantsInstances
        v3.IgnoreWater = Parameters.IgnoreWater
        RayInfo.Parameters = v3
    end
    v2 = false
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
            v2 = true
        end
    elseif u17.RayInfo.CosmeticBulletObject ~= nil then
        local RayInfo_3 = u17.RayInfo
        RayInfo_3.CosmeticBulletObject = u17.RayInfo.CosmeticBulletObject:Clone()
        u17.RayInfo.CosmeticBulletObject.CFrame = CFrame.new(p2, p2 + p3)
        u17.RayInfo.CosmeticBulletObject.Parent = p5.CosmeticBulletContainer
    end
    if not v2 then
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
    if not RunService:IsClient() then
        RenderStepped = RunService.Heartbeat
    else
        RenderStepped = RunService.RenderStepped
    end
    local v4 = u6
    setmetatable(u17, v4)
    local StateInfo = u17.StateInfo
    StateInfo.UpdateConnection = RenderStepped:Connect(function(p1) -- Line: 535 -- upvalues: u17 (val), u16 (upval), SimulateCast (upval)
        if u17.StateInfo.Paused then
            return
        end
        if u16.DebugLogging == true then
            print("Casting for frame.")
        end
        local v1 = u17.StateInfo.Trajectories[#u17.StateInfo.Trajectories]
        if u17.StateInfo.HighFidelityBehavior == 3
            and v1.Acceleration ~= Vector3.new()
            and 0 < u17.StateInfo.HighFidelitySegmentSize then
            local v2, v3
            local v4 = tick()
            if u17.StateInfo.IsActivelyResimulating then
                u17:Terminate()
                error("Cascading cast lag encountered! The caster attempted to perform a high fidelity cast before the previous one completed, resulting in exponential cast lag. Consider increasing HighFidelitySegmentSize.")
            end
            u17.StateInfo.IsActivelyResimulating = true
            local Origin = v1.Origin
            local v5 = u17.StateInfo.TotalRuntime - v1.StartTime
            local InitialVelocity = v1.InitialVelocity
            local Acceleration = v1.Acceleration
            local v6 = v5
            local v7 = Acceleration.X * v6 ^ 2 / 2
            local v8 = Acceleration.Y * v6 ^ 2 / 2
            local v9 = Acceleration.Z * v6 ^ 2 / 2
            local v10 = Vector3.new(v7, v8, v9)
            local v11 = Origin + InitialVelocity * v6 + v10
            v6 = InitialVelocity + Acceleration * v5
            v10 = u17.StateInfo.TotalRuntime - v1.StartTime
            local StateInfo = u17.StateInfo
            StateInfo.TotalRuntime = StateInfo.TotalRuntime + p1
            v5 = u17.StateInfo.TotalRuntime - v1.StartTime
            v8 = v5
            local v12 = Acceleration.X * v8 ^ 2 / 2
            local v13 = Acceleration.Y * v8 ^ 2 / 2
            local v14 = Acceleration.Z * v8 ^ 2 / 2
            v9 = Vector3.new(v12, v13, v14)
            v7 = Origin + InitialVelocity * v8 + v9
            v8 = InitialVelocity + Acceleration * v5
            v12 = (v7 - v11).Unit * v8.Magnitude * p1
            v13 = u17
            local WorldRoot = v13.RayInfo.WorldRoot
            local v15 = u17
            local Parameters = v15.RayInfo.Parameters
            v14 = WorldRoot:Raycast(v11, v12, Parameters)
            local Position = v7
            if v14 ~= nil then
                Position = v14.Position
            end
            local Magnitude = (Position - v11).Magnitude
            local StateInfo_2 = u17.StateInfo
            StateInfo_2.TotalRuntime = StateInfo_2.TotalRuntime - p1
            v15 = u17
            local v16 = Magnitude / v15.StateInfo.HighFidelitySegmentSize
            v15 = math.floor(v16)
            if v15 == 0 then
                v15 = 1
            end
            local v17 = p1 / v15
            local v18 = v15
            for i = 1, v18 do
                v3 = u17
                if getmetatable(v3) == nil then
                    return
                end
                if u17.StateInfo.CancelHighResCast then
                    u17.StateInfo.CancelHighResCast = false
                    break
                end
                v2 = "[" .. i .. "] Subcast of time increment " .. v17
                if u16.DebugLogging == true then
                    print(v2)
                end
                SimulateCast(u17, v17, true)
            end
            local v19 = u17
            if getmetatable(v19) == nil then
                return
            end
            u17.StateInfo.IsActivelyResimulating = false
            if not (0.08 < tick() - v4) then
                return
            end
            warn("Extreme cast lag encountered! Consider increasing HighFidelitySegmentSize.")
            return
        end
        SimulateCast(u17, p1, false)
    end)
    return u17
end

function u6.SetStaticFastCastReference(p1) -- Line: 619 -- upvalues: u16 (ref)
    u16 = p1
end

local function ModifyTransformation(p1, p2, p3, p4) -- Line: 625 -- upvalues: GetTrajectoryInfo (val), u15 (val)
    local Acceleration, InitialVelocity, Origin, v1
    local Trajectories = p1.StateInfo.Trajectories
    local v2 = Trajectories[#Trajectories]
    if v2.StartTime == p1.StateInfo.TotalRuntime then
        if p2 ~= nil then
            InitialVelocity = p2
        else
            InitialVelocity = v2.InitialVelocity
        end
        if p3 ~= nil then
            Acceleration = p3
        else
            Acceleration = v2.Acceleration
        end
        if p4 ~= nil then
            Origin = p4
        else
            Origin = v2.Origin
        end
        v2.Origin = Origin
        v2.InitialVelocity = InitialVelocity
        v2.Acceleration = Acceleration
        return
    end
    v2.EndTime = p1.StateInfo.TotalRuntime
    local v3 = p1.StateInfo.UpdateConnection ~= nil
    assert(v3, "This ActiveCast has been terminated. It can no longer be used.")
    local v4 = GetTrajectoryInfo
    v3 = #p1.StateInfo.Trajectories
    v4 = v4(p1, v3)
    v1, v4 = unpack(v4)
    if p2 ~= nil then
        InitialVelocity = p2
    else
        InitialVelocity = v4
    end
    if p3 ~= nil then
        Acceleration = p3
    else
        Acceleration = v2.Acceleration
    end
    if p4 ~= nil then
        Origin = p4
    else
        Origin = v1
    end
    local v5 = u15
    v5.insert(p1.StateInfo.Trajectories, {
        EndTime = -1,
        StartTime = p1.StateInfo.TotalRuntime,
        Origin = Origin,
        InitialVelocity = InitialVelocity,
        Acceleration = Acceleration,
    })
    p1.StateInfo.CancelHighResCast = true
end

function u6:SetVelocity(p2) -- Line: 671 -- upvalues: u6 (val), ModifyTransformation (val)
    local v1 = (getmetatable(self)) == u6
    local v2 = ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format(
        "SetVelocity",
        "ActiveCast.new(...)"
    )
    assert(v1, v2)
    v1 = self.StateInfo.UpdateConnection ~= nil
    assert(v1, "This ActiveCast has been terminated. It can no longer be used.")
    ModifyTransformation(self, p2, nil, nil)
end

function u6:SetAcceleration(p2) -- Line: 677 -- upvalues: u6 (val), ModifyTransformation (val)
    local v1 = (getmetatable(self)) == u6
    local v2 = ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format(
        "SetAcceleration",
        "ActiveCast.new(...)"
    )
    assert(v1, v2)
    v1 = self.StateInfo.UpdateConnection ~= nil
    assert(v1, "This ActiveCast has been terminated. It can no longer be used.")
    ModifyTransformation(self, nil, p2, nil)
end

function u6:SetPosition(p2) -- Line: 683 -- upvalues: u6 (val), ModifyTransformation (val)
    local v1 = (getmetatable(self)) == u6
    local v2 = ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format(
        "SetPosition",
        "ActiveCast.new(...)"
    )
    assert(v1, v2)
    v1 = self.StateInfo.UpdateConnection ~= nil
    assert(v1, "This ActiveCast has been terminated. It can no longer be used.")
    ModifyTransformation(self, nil, nil, p2)
end

function u6:GetVelocity() -- Line: 689 -- upvalues: u6 (val)
    local v1 = (getmetatable(self)) == u6
    local v2 = ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format(
        "GetVelocity",
        "ActiveCast.new(...)"
    )
    assert(v1, v2)
    v1 = self.StateInfo.UpdateConnection ~= nil
    assert(v1, "This ActiveCast has been terminated. It can no longer be used.")
    local v3 = self.StateInfo.Trajectories[#self.StateInfo.Trajectories]
    v2 = self.StateInfo.TotalRuntime - v3.StartTime
    return v3.InitialVelocity + v3.Acceleration * v2
end

function u6:GetAcceleration() -- Line: 696 -- upvalues: u6 (val)
    local v1 = (getmetatable(self)) == u6
    local v2 = ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format(
        "GetAcceleration",
        "ActiveCast.new(...)"
    )
    assert(v1, v2)
    v1 = self.StateInfo.UpdateConnection ~= nil
    assert(v1, "This ActiveCast has been terminated. It can no longer be used.")
    return self.StateInfo.Trajectories[#self.StateInfo.Trajectories].Acceleration
end

function u6:GetPosition() -- Line: 703 -- upvalues: u6 (val)
    local v1 = (getmetatable(self)) == u6
    local v2 = ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format(
        "GetPosition",
        "ActiveCast.new(...)"
    )
    assert(v1, v2)
    v1 = self.StateInfo.UpdateConnection ~= nil
    assert(v1, "This ActiveCast has been terminated. It can no longer be used.")
    local v3 = self.StateInfo.Trajectories[#self.StateInfo.Trajectories]
    v2 = self.StateInfo.TotalRuntime - v3.StartTime
    local Origin = v3.Origin
    local InitialVelocity = v3.InitialVelocity
    local Acceleration = v3.Acceleration
    local v4 = Acceleration.X * v2 ^ 2 / 2
    local v5 = Acceleration.Y * v2 ^ 2 / 2
    local v6 = Acceleration.Z * v2 ^ 2 / 2
    local v7 = Vector3.new(v4, v5, v6)
    return Origin + InitialVelocity * v2 + v7
end

function u6.AddVelocity(p1, p2) -- Line: 712 -- upvalues: u6 (val)
    local v1 = (getmetatable(p1)) == u6
    local v2 = ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format(
        "AddVelocity",
        "ActiveCast.new(...)"
    )
    assert(v1, v2)
    v1 = p1.StateInfo.UpdateConnection ~= nil
    assert(v1, "This ActiveCast has been terminated. It can no longer be used.")
    v2 = (p1:GetVelocity()) + p2
    p1:SetVelocity(v2)
end

function u6.AddAcceleration(p1, p2) -- Line: 718 -- upvalues: u6 (val)
    local v1 = (getmetatable(p1)) == u6
    local v2 = ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format(
        "AddAcceleration",
        "ActiveCast.new(...)"
    )
    assert(v1, v2)
    v1 = p1.StateInfo.UpdateConnection ~= nil
    assert(v1, "This ActiveCast has been terminated. It can no longer be used.")
    v2 = (p1:GetAcceleration()) + p2
    p1:SetAcceleration(v2)
end

function u6.AddPosition(p1, p2) -- Line: 724 -- upvalues: u6 (val)
    local v1 = (getmetatable(p1)) == u6
    local v2 = ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format(
        "AddPosition",
        "ActiveCast.new(...)"
    )
    assert(v1, v2)
    v1 = p1.StateInfo.UpdateConnection ~= nil
    assert(v1, "This ActiveCast has been terminated. It can no longer be used.")
    v2 = (p1:GetPosition()) + p2
    p1:SetPosition(v2)
end

function u6.Pause(p1) -- Line: 732 -- upvalues: u6 (val)
    local v1 = (getmetatable(p1)) == u6
    local v2 = ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format(
        "Pause",
        "ActiveCast.new(...)"
    )
    assert(v1, v2)
    v1 = p1.StateInfo.UpdateConnection ~= nil
    assert(v1, "This ActiveCast has been terminated. It can no longer be used.")
    p1.StateInfo.Paused = true
end

function u6.Resume(p1) -- Line: 738 -- upvalues: u6 (val)
    local v1 = (getmetatable(p1)) == u6
    local v2 = ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format(
        "Resume",
        "ActiveCast.new(...)"
    )
    assert(v1, v2)
    v1 = p1.StateInfo.UpdateConnection ~= nil
    assert(v1, "This ActiveCast has been terminated. It can no longer be used.")
    p1.StateInfo.Paused = false
end

function u6:Terminate() -- Line: 744 -- upvalues: u6 (val)
    local v1 = (getmetatable(self)) == u6
    local v2 = ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format(
        "Terminate",
        "ActiveCast.new(...)"
    )
    assert(v1, v2)
    v1 = self.StateInfo.UpdateConnection ~= nil
    assert(v1, "This ActiveCast has been terminated. It can no longer be used.")
    local Trajectories = self.StateInfo.Trajectories
    v1 = Trajectories[#Trajectories]
    v1.EndTime = self.StateInfo.TotalRuntime
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