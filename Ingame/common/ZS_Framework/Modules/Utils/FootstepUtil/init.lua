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
u288[Enum.Material.Concrete] = {
    {27.499095938007, 28.191199290016},
    {28.191199290016, 28.841360940965},
    {28.841360940965, 29.459017269974},
    {29.459017269974, 30.10904514397},
    {30.10904514397, 30.759077816937},
}
u288[Enum.Material.Ground] = {
    {52.089024086044, 52.865063716015},
    {52.865063716015, 53.59772350804},
    {53.59772350804, 54.349850330061},
    {54.349850330061, 55.049090898034},
    {55.049090898034, 55.765139073025},
}
u288[Enum.Material.Grass] = {
    {69.490977494005, 70.18383049398},
    {70.18383049398, 70.883929414011},
    {70.883929414011, 71.634821655975},
    {71.634821655975, 72.300559200943},
    {72.300559200943, 73.001347635015},
    {73.001347635015, 73.833708473982},
}
local v1 = {
    {93.751799195995, 94.861757991969},
    {94.861757991969, 96.01217642598},
    {96.01217642598, 96.895755909973},
}
u288[Enum.Material.Pebble] = v1
local u290 = {}
u290[Enum.Material.SmoothPlastic] = {
    {17.587918779957, 18.247896654019},
    {18.247896654019, 18.863809216006},
    {18.863809216006, 19.463111553951},
    {19.463111553951, 20.064853589997},
    {20.064853589997, 20.714110644009},
    {20.714110644009, 21.347603467945},
    {21.347603467945, 21.979916113962},
}
local v2 = {}
local v3 = {20.714110644009, 21.347603467945}
local v4 = {21.347603467945, 21.979916113962}
v2[1] = {17.587918779957, 18.247896654019}
v2[2] = {18.247896654019, 18.863809216006}
v2[3] = {18.863809216006, 19.463111553951}
v2[4] = {19.463111553951, 20.064853589997}
v2[5] = {20.064853589997, 20.714110644009}
v2[6] = v3
v2[7] = v4
u290[Enum.Material.Plastic] = v2
v2 = {}
local v5 = {38.475547555016, 39.257744491053}
local v6 = {39.257744491053, 40.092227406016}
v2[1] = {37.680434650031, 38.475547555016}
v2[2] = v5
v2[3] = v6
v2[4] = {40.092227406016, 40.923779830011}
u290[Enum.Material.Metal] = v2
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
    v3 = {}
    Children_4 = j:WaitForChild("Walk"):GetChildren()
    if not (j:FindFirstChild("Run")) then
        Children_5 = nil
    else
        Children_5 = j.Run:GetChildren()
    end
    v3[1] = Children_4
    v3[2] = Children_5
    u280[Name] = v3
end
local humanoid = u284.humanoid
local u233 = nil
local u234 = -1
local function FootstepPlayer(p1, p2, p3, p4) -- Line: 118 -- upvalues: humanoid (val), u284 (val), u286 (val), u280 (val), u288 (val), u290 (val), u234 (ref), u233 (ref)
    local FloorMaterial
    if not humanoid.Humanoid then
        return
    end
    if p2 then
        FloorMaterial = p2
    else
        FloorMaterial = humanoid.Humanoid.FloorMaterial
    end
    if u284.States.IsDead then
        local v1, v2, v3, v4, v5
        if p1 ~= true then
            return
        end
        if p1 and p3 and FloorMaterial == Enum.Material.Air then
            while true do
                task.wait()
                FloorMaterial = humanoid.Humanoid.FloorMaterial
                if FloorMaterial ~= Enum.Material.Air then
                    break
                end
            end
        end
        local WaterSensor = humanoid.WaterSensor
        if not WaterSensor then
            v3 = u286[FloorMaterial] or "Concrete"
        elseif WaterSensor.TouchingSurface then
            v3 = "Water"
        end
        local v6 = if 16 < humanoid.Humanoid.WalkSpeed and u280[v3][2] then u280[v3][2] else u280[v3][1]
        local Footsteps1 = false
        if p4 then
            v4 = u288[FloorMaterial]
            if not v4 then
                v4 = u290[FloorMaterial]
                if v4 then
                    Footsteps1 = script.Footsteps2
                end
            else
                Footsteps1 = script.Footsteps1
            end
            v6 = v4 or v6
        end
        if not v6 then
            if v6 then
                if not p1 then
                    return
                end
                if Footsteps1 then
                    v4 = math.random(1, #v6)
                    v5 = Footsteps1:Clone()
                    v5.Name = "Yeet"
                    v5.Volume = 0.4
                    v5.Parent = humanoid.Humanoid.Parent.HumanoidRootPart
                    v2 = math.random(3, 7) * 0.02
                    v5.PlaybackSpeed = v5.PlaybackSpeed + v2 * u234
                    u234 = u234 * -1
                    v5:Play()
                    v5.TimePosition = math.max(v6[v4][1] - 0.076918916, 0)
                    game.Debris:AddItem(v5, v6[v4][2] - v6[v4][1] - 0.09)
                    u233 = v5
                    return
                end
                v4 = v6[math.random(1, #v6)]:Clone()
                v4.Name = "Yeet"
                v4.Volume = 0.4
                v4.Parent = humanoid.Humanoid.Parent.HumanoidRootPart
                v1 = math.random(3, 7) * 0.02
                v4.PlaybackSpeed = v4.PlaybackSpeed + v1 * u234
                u234 = u234 * -1
                v4:Play()
                game.Debris:AddItem(v4, 3)
                u233 = v4
                v6 = u280.Cloth[1]
                v5 = v6[math.random(1, #v6)]:Clone()
                v5.Name = "Yeet"
                v5.Volume = 0.4
                v5.Parent = humanoid.Humanoid.Parent.HumanoidRootPart
                v2 = math.random(3, 7) * 0.02
                v5.PlaybackSpeed = v5.PlaybackSpeed + v2 * u234
                v5:Play()
                game.Debris:AddItem(v5, 3)
                return
            end
            return
        end
        if 0 < humanoid.Humanoid.MoveDirection.Magnitude then
            if Footsteps1 then
                v4 = math.random(1, #v6)
                v5 = Footsteps1:Clone()
                v5.Name = "Yeet"
                v5.Volume = 0.4
                v5.Parent = humanoid.Humanoid.Parent.HumanoidRootPart
                v2 = math.random(3, 7) * 0.02
                v5.PlaybackSpeed = v5.PlaybackSpeed + v2 * u234
                u234 = u234 * -1
                v5:Play()
                v5.TimePosition = math.max(v6[v4][1] - 0.076918916, 0)
                game.Debris:AddItem(v5, v6[v4][2] - v6[v4][1] - 0.09)
                u233 = v5
                return
            end
            v4 = v6[math.random(1, #v6)]:Clone()
            v4.Name = "Yeet"
            v4.Volume = 0.4
            v4.Parent = humanoid.Humanoid.Parent.HumanoidRootPart
            v1 = math.random(3, 7) * 0.02
            v4.PlaybackSpeed = v4.PlaybackSpeed + v1 * u234
            u234 = u234 * -1
            v4:Play()
            game.Debris:AddItem(v4, 3)
            u233 = v4
            v6 = u280.Cloth[1]
            v5 = v6[math.random(1, #v6)]:Clone()
            v5.Name = "Yeet"
            v5.Volume = 0.4
            v5.Parent = humanoid.Humanoid.Parent.HumanoidRootPart
            v2 = math.random(3, 7) * 0.02
            v5.PlaybackSpeed = v5.PlaybackSpeed + v2 * u234
            v5:Play()
            game.Debris:AddItem(v5, 3)
            return
        end
        if not v6 or not p1 then
            return
        end
        if Footsteps1 then
            v4 = math.random(1, #v6)
            v5 = Footsteps1:Clone()
            v5.Name = "Yeet"
            v5.Volume = 0.4
            v5.Parent = humanoid.Humanoid.Parent.HumanoidRootPart
            v2 = math.random(3, 7) * 0.02
            v5.PlaybackSpeed = v5.PlaybackSpeed + v2 * u234
            u234 = u234 * -1
            v5:Play()
            v5.TimePosition = math.max(v6[v4][1] - 0.076918916, 0)
            game.Debris:AddItem(v5, v6[v4][2] - v6[v4][1] - 0.09)
            u233 = v5
            return
        end
        v4 = v6[math.random(1, #v6)]:Clone()
        v4.Name = "Yeet"
        v4.Volume = 0.4
        v4.Parent = humanoid.Humanoid.Parent.HumanoidRootPart
        v1 = math.random(3, 7) * 0.02
        v4.PlaybackSpeed = v4.PlaybackSpeed + v1 * u234
        u234 = u234 * -1
        v4:Play()
        game.Debris:AddItem(v4, 3)
        u233 = v4
        v6 = u280.Cloth[1]
        v5 = v6[math.random(1, #v6)]:Clone()
        v5.Name = "Yeet"
        v5.Volume = 0.4
        v5.Parent = humanoid.Humanoid.Parent.HumanoidRootPart
        v2 = math.random(3, 7) * 0.02
        v5.PlaybackSpeed = v5.PlaybackSpeed + v2 * u234
        v5:Play()
        game.Debris:AddItem(v5, 3)
        return
    elseif FloorMaterial ~= Enum.Material.Air then
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