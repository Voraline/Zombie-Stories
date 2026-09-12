local Children_4, Children_5, Name
local u284 = require("../Controllers/LocalPlayerController")
local Resources = script:WaitForChild("Resources")
local u286 = {}
u286[Enum.Material.Concrete] = "Concrete"
u286[Enum.Material.Grass] = "Grass"
u286[Enum.Material.Sand] = "Grass"
u286[Enum.Material.Ice] = "Grass"
u286[Enum.Material.LeafyGrass] = "Grass"
u286[Enum.Material.Snow] = "Grass"
u286[Enum.Material.Glacier] = "Grass"
u286[Enum.Material.Mud] = "Dirt"
u286[Enum.Material.Fabric] = "Dirt"
u286[Enum.Material.Ground] = "Dirt"
u286[Enum.Material.Wood] = "Wood"
u286[Enum.Material.WoodPlanks] = "Wood"
u286[Enum.Material.Pebble] = "Gravel"
u286[Enum.Material.Metal] = "Metal"
u286[Enum.Material.CorrodedMetal] = "Metal"
u286[Enum.Material.DiamondPlate] = "Metal"
u286[Enum.Material.Foil] = "Metal"
local u288 = {}
local Concrete = Enum.Material.Concrete
u288[Concrete] = {
    {27.499095938007, 28.191199290016},
    {28.191199290016, 28.841360940965},
    {28.841360940965, 29.459017269974},
    {29.459017269974, 30.10904514397},
    {30.10904514397, 30.759077816937},
}
local Ground = Enum.Material.Ground
u288[Ground] = {
    {52.089024086044, 52.865063716015},
    {52.865063716015, 53.59772350804},
    {53.59772350804, 54.349850330061},
    {54.349850330061, 55.049090898034},
    {55.049090898034, 55.765139073025},
}
local Grass = Enum.Material.Grass
u288[Grass] = {
    {69.490977494005, 70.18383049398},
    {70.18383049398, 70.883929414011},
    {70.883929414011, 71.634821655975},
    {71.634821655975, 72.300559200943},
    {72.300559200943, 73.001347635015},
    {73.001347635015, 73.833708473982},
}
local Pebble = Enum.Material.Pebble
u288[Pebble] = {
    {93.751799195995, 94.861757991969},
    {94.861757991969, 96.01217642598},
    {96.01217642598, 96.895755909973},
}
local u290 = {}
local SmoothPlastic = Enum.Material.SmoothPlastic
u290[SmoothPlastic] = {
    {17.587918779957, 18.247896654019},
    {18.247896654019, 18.863809216006},
    {18.863809216006, 19.463111553951},
    {19.463111553951, 20.064853589997},
    {20.064853589997, 20.714110644009},
    {20.714110644009, 21.347603467945},
    {21.347603467945, 21.979916113962},
}
local Plastic = Enum.Material.Plastic
local v1 = {}
local v2 = {20.714110644009, 21.347603467945}
v1[1] = {17.587918779957, 18.247896654019}
v1[2] = {18.247896654019, 18.863809216006}
v1[3] = {18.863809216006, 19.463111553951}
v1[4] = {19.463111553951, 20.064853589997}
v1[5] = {20.064853589997, 20.714110644009}
v1[6] = v2
v1[7] = {21.347603467945, 21.979916113962}
u290[Plastic] = v1
local Metal = Enum.Material.Metal
u290[Metal] = {
    {37.680434650031, 38.475547555016},
    {38.475547555016, 39.257744491053},
    {39.257744491053, 40.092227406016},
    {40.092227406016, 40.923779830011},
}
u290[Enum.Material.Marble] = u290[Enum.Material.SmoothPlastic]
u290[Enum.Material.Ice] = u290[Enum.Material.Sand]
u290[Enum.Material.Snow] = u290[Enum.Material.Sand]
u290[Enum.Material.Glacier] = u290[Enum.Material.Sand]
u290[Enum.Material.Foil] = u290[Enum.Material.Metal]
u288[Enum.Material.Brick] = u288[Enum.Material.Concrete]
u290[Enum.Material.CorrodedMetal] = u290[Enum.Material.Metal]
u288[Enum.Material.Wood] = u288[Enum.Material.WoodPlanks]
u290[Enum.Material.DiamondPlate] = u290[Enum.Material.Metal]
u288[Enum.Material.Cobblestone] = u288[Enum.Material.Concrete]
u288[Enum.Material.Slate] = u288[Enum.Material.Concrete]
u288[Enum.Material.Granite] = u288[Enum.Material.Concrete]
u290[Enum.Material.Neon] = u290[Enum.Material.Metal]
u290[Enum.Material.Glass] = u290[Enum.Material.Metal]
u290[Enum.Material.LeafyGrass] = u288[Enum.Material.Grass]
u290[Enum.Material.Mud] = u288[Enum.Material.Grass]
local u280 = {}
for i, j in Resources:GetChildren() do
    Name = j.Name
    v2 = {}
    Children_4 = j:WaitForChild("Walk"):GetChildren()
    if not j:FindFirstChild("Run") then
        Children_5 = nil
    else
        Children_5 = j.Run:GetChildren()
        if not Children_5 then
            Children_5 = nil
        end
    end
    v2[1] = Children_4
    v2[2] = Children_5
    u280[Name] = v2
end
local humanoid = u284.humanoid
local u233 = nil
local u234 = -1

local function FootstepPlayer(p1, p2, p3, p4) -- Line: 118
    -- upvalues: humanoid (val), u284 (val), u286 (val), u280 (val), u288 (val), u290 (val), u234 (ref), u233 (ref)
    local Debris, FloorMaterial, Footsteps1, WaterSensor, v1, v2, v3, v4, v5, v6
    if not humanoid.Humanoid then
        return
    end
    if p2 then
        FloorMaterial = p2
    else
        FloorMaterial = humanoid.Humanoid.FloorMaterial
    end
    if not u284.States.IsDead and FloorMaterial ~= Enum.Material.Air then
        if p1 and p3 and FloorMaterial == Enum.Material.Air then
            repeat
                task.wait()
                FloorMaterial = humanoid.Humanoid.FloorMaterial
            until FloorMaterial ~= Enum.Material.Air
        end
        WaterSensor = humanoid.WaterSensor
        if not WaterSensor or not WaterSensor.TouchingSurface then
            v3 = u286[FloorMaterial] or "Concrete"
        else
            v3 = "Water"
        end
        v4 = u280[v3][1]
        if 16 < humanoid.Humanoid.WalkSpeed and u280[v3][2] then
            v4 = u280[v3][2]
        end
        Footsteps1 = false
        if p4 then
            v5 = u288[FloorMaterial]
            if not v5 then
                v5 = u290[FloorMaterial]
                if v5 then
                    Footsteps1 = script.Footsteps2
                end
            else
                Footsteps1 = script.Footsteps1
            end
            v4 = v5 or v4
        end
        if v4 and 0 < humanoid.Humanoid.MoveDirection.Magnitude then
            if Footsteps1 then
                v5 = math.random(1, #v4)
                v6 = Footsteps1:Clone()
                v6.Name = "Yeet"
                v6.Volume = 0.4
                v6.Parent = humanoid.Humanoid.Parent.HumanoidRootPart
                v6.PlaybackSpeed = v6.PlaybackSpeed + math.random(3, 7) * 0.02 * u234
                u234 = u234 * -1
                v6:Play()
                v1 = v4[v5][1] - 0.076918916
                v6.TimePosition = math.max(v1, 0)
                Debris = game.Debris
                v2 = v4[v5][2] - v4[v5][1] - 0.09
                Debris:AddItem(v6, v2)
                u233 = v6
                return
            end
            v5 = v4[math.random(1, #v4)]:Clone()
            v5.Name = "Yeet"
            v5.Volume = 0.4
            v5.Parent = humanoid.Humanoid.Parent.HumanoidRootPart
            v5.PlaybackSpeed = v5.PlaybackSpeed + math.random(3, 7) * 0.02 * u234
            u234 = u234 * -1
            v5:Play()
            game.Debris:AddItem(v5, 3)
            u233 = v5
            v4 = u280.Cloth[1]
            v6 = v4[math.random(1, #v4)]:Clone()
            v6.Name = "Yeet"
            v6.Volume = 0.4
            v6.Parent = humanoid.Humanoid.Parent.HumanoidRootPart
            v6.PlaybackSpeed = v6.PlaybackSpeed + math.random(3, 7) * 0.02 * u234
            v6:Play()
            game.Debris:AddItem(v6, 3)
            return
        end
        if v4 and p1 then
            if Footsteps1 then
                v5 = math.random(1, #v4)
                v6 = Footsteps1:Clone()
                v6.Name = "Yeet"
                v6.Volume = 0.4
                v6.Parent = humanoid.Humanoid.Parent.HumanoidRootPart
                v6.PlaybackSpeed = v6.PlaybackSpeed + math.random(3, 7) * 0.02 * u234
                u234 = u234 * -1
                v6:Play()
                v1 = v4[v5][1] - 0.076918916
                v6.TimePosition = math.max(v1, 0)
                Debris = game.Debris
                v2 = v4[v5][2] - v4[v5][1] - 0.09
                Debris:AddItem(v6, v2)
                u233 = v6
                return
            end
            v5 = v4[math.random(1, #v4)]:Clone()
            v5.Name = "Yeet"
            v5.Volume = 0.4
            v5.Parent = humanoid.Humanoid.Parent.HumanoidRootPart
            v5.PlaybackSpeed = v5.PlaybackSpeed + math.random(3, 7) * 0.02 * u234
            u234 = u234 * -1
            v5:Play()
            game.Debris:AddItem(v5, 3)
            u233 = v5
            v4 = u280.Cloth[1]
            v6 = v4[math.random(1, #v4)]:Clone()
            v6.Name = "Yeet"
            v6.Volume = 0.4
            v6.Parent = humanoid.Humanoid.Parent.HumanoidRootPart
            v6.PlaybackSpeed = v6.PlaybackSpeed + math.random(3, 7) * 0.02 * u234
            v6:Play()
            game.Debris:AddItem(v6, 3)
        end
        return
    end
    if p1 == true then
        if p1 and p3 and FloorMaterial == Enum.Material.Air then
            repeat
                task.wait()
                FloorMaterial = humanoid.Humanoid.FloorMaterial
            until FloorMaterial ~= Enum.Material.Air
        end
        WaterSensor = humanoid.WaterSensor
        if not WaterSensor or not WaterSensor.TouchingSurface then
            v3 = u286[FloorMaterial] or "Concrete"
        else
            v3 = "Water"
        end
        v4 = u280[v3][1]
        if 16 < humanoid.Humanoid.WalkSpeed and u280[v3][2] then
            v4 = u280[v3][2]
        end
        Footsteps1 = false
        if p4 then
            v5 = u288[FloorMaterial]
            if not v5 then
                v5 = u290[FloorMaterial]
                if v5 then
                    Footsteps1 = script.Footsteps2
                end
            else
                Footsteps1 = script.Footsteps1
            end
            v4 = v5 or v4
        end
        if v4 and 0 < humanoid.Humanoid.MoveDirection.Magnitude then
            if Footsteps1 then
                v5 = math.random(1, #v4)
                v6 = Footsteps1:Clone()
                v6.Name = "Yeet"
                v6.Volume = 0.4
                v6.Parent = humanoid.Humanoid.Parent.HumanoidRootPart
                v6.PlaybackSpeed = v6.PlaybackSpeed + math.random(3, 7) * 0.02 * u234
                u234 = u234 * -1
                v6:Play()
                v1 = v4[v5][1] - 0.076918916
                v6.TimePosition = math.max(v1, 0)
                Debris = game.Debris
                v2 = v4[v5][2] - v4[v5][1] - 0.09
                Debris:AddItem(v6, v2)
                u233 = v6
                return
            end
            v5 = v4[math.random(1, #v4)]:Clone()
            v5.Name = "Yeet"
            v5.Volume = 0.4
            v5.Parent = humanoid.Humanoid.Parent.HumanoidRootPart
            v5.PlaybackSpeed = v5.PlaybackSpeed + math.random(3, 7) * 0.02 * u234
            u234 = u234 * -1
            v5:Play()
            game.Debris:AddItem(v5, 3)
            u233 = v5
            v4 = u280.Cloth[1]
            v6 = v4[math.random(1, #v4)]:Clone()
            v6.Name = "Yeet"
            v6.Volume = 0.4
            v6.Parent = humanoid.Humanoid.Parent.HumanoidRootPart
            v6.PlaybackSpeed = v6.PlaybackSpeed + math.random(3, 7) * 0.02 * u234
            v6:Play()
            game.Debris:AddItem(v6, 3)
            return
        end
        if v4 and p1 then
            if Footsteps1 then
                v5 = math.random(1, #v4)
                v6 = Footsteps1:Clone()
                v6.Name = "Yeet"
                v6.Volume = 0.4
                v6.Parent = humanoid.Humanoid.Parent.HumanoidRootPart
                v6.PlaybackSpeed = v6.PlaybackSpeed + math.random(3, 7) * 0.02 * u234
                u234 = u234 * -1
                v6:Play()
                v1 = v4[v5][1] - 0.076918916
                v6.TimePosition = math.max(v1, 0)
                Debris = game.Debris
                v2 = v4[v5][2] - v4[v5][1] - 0.09
                Debris:AddItem(v6, v2)
                u233 = v6
                return
            end
            v5 = v4[math.random(1, #v4)]:Clone()
            v5.Name = "Yeet"
            v5.Volume = 0.4
            v5.Parent = humanoid.Humanoid.Parent.HumanoidRootPart
            v5.PlaybackSpeed = v5.PlaybackSpeed + math.random(3, 7) * 0.02 * u234
            u234 = u234 * -1
            v5:Play()
            game.Debris:AddItem(v5, 3)
            u233 = v5
            v4 = u280.Cloth[1]
            v6 = v4[math.random(1, #v4)]:Clone()
            v6.Name = "Yeet"
            v6.Volume = 0.4
            v6.Parent = humanoid.Humanoid.Parent.HumanoidRootPart
            v6.PlaybackSpeed = v6.PlaybackSpeed + math.random(3, 7) * 0.02 * u234
            v6:Play()
            game.Debris:AddItem(v6, 3)
        end
    end
end

u284.PlayerMovementUtil.ShuffleEvent:Connect(function() -- Line: 187 -- upvalues: FootstepPlayer (val)
    FootstepPlayer(true, nil, nil, true)
end)
humanoid.Jumped:Connect(function() -- Line: 191 -- upvalues: humanoid (val), u233 (ref), FootstepPlayer (val)
    if humanoid.HasLanded == true then
        if u233 then
            u233:Stop()
        end
        FootstepPlayer(true, nil, nil, true)
    end
end)
humanoid.Landed:Connect(function() -- Line: 200 -- upvalues: FootstepPlayer (val)
    FootstepPlayer(true, nil, true)
end)
return FootstepPlayer