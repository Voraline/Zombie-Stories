local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
game:GetService("CollectionService")
local common = ReplicatedStorage.common
local Ignore = workspace:WaitForChild("Ignore")
local Terrain = workspace:WaitForChild("Terrain")
local Resources = script:WaitForChild("Resources")
local Beam = Resources:WaitForChild("Beam")
local ImpactPart = Resources:WaitForChild("ImpactPart")
local u46 = require("@self/BloodVFX")
local CurrentCamera = workspace.CurrentCamera
local u49 = {}
u49[Enum.Material.Asphalt] = true
u49[Enum.Material.Basalt] = true
u49[Enum.Material.Brick] = true
u49[Enum.Material.Cobblestone] = true
u49[Enum.Material.CrackedLava] = true
u49[Enum.Material.Glacier] = true
u49[Enum.Material.Grass] = true
u49[Enum.Material.Ground] = true
u49[Enum.Material.Ice] = true
u49[Enum.Material.LeafyGrass] = true
u49[Enum.Material.Limestone] = true
u49[Enum.Material.Mud] = true
u49[Enum.Material.Pavement] = true
u49[Enum.Material.Rock] = true
u49[Enum.Material.Salt] = true
u49[Enum.Material.Sand] = true
u49[Enum.Material.Sandstone] = true
u49[Enum.Material.Slate] = true
u49[Enum.Material.Snow] = true
u49[Enum.Material.WoodPlanks] = true
local PartCache = require(common:WaitForChild("PartCache"))
local Settings = require(common.Settings)
local peek = require(game:GetService("ReplicatedStorage").Packages.Fusion).peek
local ClassMirror = require(((game.ReplicatedStorage.common:WaitForChild("NPCs_Shared")):WaitForChild("Utils")):WaitForChild("ClassMirror"))
local u128 = require("@game/ReplicatedStorage/common/NPCs_Shared/Utils/Encoder_Util")
local u133 = TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
local u138 = PartCache.new(ImpactPart, 50, Ignore)
local u142 = peek(Settings.Graphics.ParticleQuality)
local u143 = {}

local function isInView(p1, p2) -- Line: 58 -- upvalues: CurrentCamera (val)
    local v1 = CurrentCamera
    local LookVector = v1.CFrame.LookVector
    local v2 = p1 - CurrentCamera.CFrame.Position
    local v3 = CurrentCamera.FieldOfView + 2
    local v4 = v2.Unit:Angle(LookVector)
    local v5 = math.deg(v4)
    if not (math.floor(v5) <= v3) then
        return false
    end
    if not game.Players.LocalPlayer.Character or not game.Players.LocalPlayer.Character.PrimaryPart then
        v5 = v2
    else
        v5 = p1 - game.Players.LocalPlayer.Character.PrimaryPart.Position
        if not v5 then
            v5 = v2
        end
    end
    v2 = v5
    local X = v2.X
    local Z = v2.Z
    if Vector3.new(X, 0, Z).Magnitude <= p2 then
        return true
    end
    return false
end

Settings.SettingsChanged:Connect(function() -- Line: 79 -- upvalues: u142 (ref), peek (val), Settings (val)
    u142 = peek(Settings.Graphics.ParticleQuality)
end)
local u150 = {BloodQueue = {}}

function u150.BulletTrail(p1, p2, p3, p4) -- Line: 88 -- upvalues: peek (val), Settings (val), Beam (val), Terrain (val)
    local Attachment, u47
    if not peek(Settings.Graphics.BulletTracers) then
        return
    end
    local FaceFrontAttachment = p2
    if not FaceFrontAttachment then
        FaceFrontAttachment = game.Players.LocalPlayer.Character.Head.FaceFrontAttachment
    end
    local v1 = FaceFrontAttachment
    if not p4 then
        u47 = Beam:Clone()
        Attachment = Instance.new("Attachment")
        Attachment.Parent = Terrain
        Attachment.WorldPosition = p3
        u47.Attachment0 = Attachment
        u47.Attachment1 = v1
        u47.Parent = Terrain
        task.delay(0.07, function() -- Line: 121 -- upvalues: u47 (ref), Attachment (val)
            u47:Destroy()
            Attachment:Destroy()
        end)
        return
    end
    if p4.CustomTrailVFX then
        p4.CustomTrailVFX(v1, p3)
        return
    end
    u47 = Beam:Clone()
    if p4.Properties then
        local Properties = p4.Properties
        local v2 = nil
        local v3 = nil
        for i, j in Properties, v2, v3 do
            u47[i] = j
        end
    end
    Attachment = Instance.new("Attachment")
    Attachment.Parent = Terrain
    Attachment.WorldPosition = p3
    u47.Attachment0 = Attachment
    u47.Attachment1 = v1
    u47.Parent = Terrain
    task.delay(0.07, function() -- Line: 121 -- upvalues: u47 (ref), Attachment (val)
        u47:Destroy()
        Attachment:Destroy()
    end)
end

function u150.BloodNPC(p1, p2, p3, p4, p5) -- Line: 127
    -- upvalues: ClassMirror (val), u142 (ref), u128 (val), u150 (val)
    if game:GetService("GuiService"):IsTenFootInterface() then
        return
    end
    local ObjFromId = ClassMirror:GetObjFromId(p3)
    if not ObjFromId then
        return
    end
    if ObjFromId.UIDTable and ObjFromId.UIDTable[p4] then
        local ID, PlaybackSpeed, v1, v2, v3
        local v4 = ObjFromId.UIDTable[p4]
        local Sound = Instance.new("Sound")
        local v5 = "rbxassetid://"
        if not p2.HitSFX then
            ID = "358942915"
        else
            ID = p2.HitSFX.ID
            if not ID then
                ID = "358942915"
            end
        end
        Sound.SoundId = v5 .. ID
        if not p2.HitSFX then
            PlaybackSpeed = 1
        else
            PlaybackSpeed = p2.HitSFX.PlaybackSpeed
            if not PlaybackSpeed then
                PlaybackSpeed = 1
            end
        end
        Sound.PlaybackSpeed = PlaybackSpeed + math.random(-100, 100) * 0.002
        if not p2.HitSFX then
            if not p2.IsShotgun then
                Sound.Volume = 1.5
            else
                Sound.Volume = 1.5
            end
        elseif p2.HitSFX.Volume then
            Sound.Volume = p2.HitSFX.Volume
        elseif not p2.IsShotgun then
            Sound.Volume = 1.5
        else
            Sound.Volume = 1.5
        end
        if v4.Parent then
            local HumanoidRootPart
            if v4.Name ~= "Head" then
                HumanoidRootPart = v4
            else
                HumanoidRootPart = v4.Parent.HumanoidRootPart
                if not HumanoidRootPart then
                    HumanoidRootPart = v4
                end
            end
            Sound.Parent = HumanoidRootPart
            Sound:Play()
        end
        if u142 == 1 then
            return
        end
        if p2.CustomHitVFX then
            v3 = nil
            if p5 then
                v5, v1, v2 = u128.DecodePositioningData(p5)
                v3 = Vector3.new(v5, v1, v2)
            end
            p2.CustomHitVFX(v4, v3)
            return
        end
        v3 = nil
        if p5 then
            v5, v1, v2 = u128.DecodePositioningData(p5)
            v3 = Vector3.new(v5, v1, v2)
        end
        v1 = u150
        local BloodQueue = v1.BloodQueue
        v2 = {v4, v3}
        table.insert(BloodQueue, v2)
        return
    end
end

function u150.MakeImpact(p1, p2, p3, p4, p5) -- Line: 177
    -- upvalues: peek (val), Settings (val), u138 (val), u49 (val), u142 (ref), isInView (val), u143 (val)
    -- upvalues: TweenService (val), u133 (val)
    local Color, Decal, Emitter1, Emitter1_2, Emitter2, Emitter2_2, Emitter2_3, Instance_2, MaterialColor, Material_2, Parent, Parent_2, Part, Sound, new_4, u108, u373, v1, v2, v3, v4, v5, v6, v7, v8, v9
    if p3 and not p3.Instance and not p4 then
        return
    end
    local Material = nil
    if p3 then
        Instance_2 = p3.Instance
        if not Instance_2 then
            return
        end
        Material = p3.Instance.Material
        local Position = p3.Position
        local Normal = p3.Normal
        local CFrame_2 = Instance_2.CFrame
        v2 = CFrame.new(Position, Position + Normal)
        v9 = CFrame_2:ToObjectSpace(v2)
        if not peek(Settings.Graphics.BulletHoles) then
            return v9
        end
        Part = u138:GetPart()
        Part.Size = Vector3.new(0.05000000074505806, 0.05000000074505806, 0.05000000074505806)
        Part.Decal.Texture = "rbxassetid://64291961"
        Part.Decal.Transparency = 0
        u108 = nil
        if not p5 then
            u108 = Instance.new("Weld")
            u108.Part0 = Instance_2
            u108.Part1 = Part
            u108.C0 = v9
            u108.Parent = Part
            Part.Anchored = false
        else
            Part.Anchored = true
            Part.Decal.Transparency = 1
            Part.CFrame = Instance_2.CFrame * v9
        end
        if Instance_2 ~= workspace.Terrain or not Material or not u49[Material] then
            Color = Instance_2.Color
            v3 = Color3.new(1, 1, 1)
            v1 = Color:lerp(v3, 0.5)
        else
            MaterialColor = workspace.Terrain:GetMaterialColor(Material)
            v3 = Color3.new(1, 1, 1)
            v1 = MaterialColor:Lerp(v3, 0.5)
        end
        Sound = Part.Sound
        if not Instance_2 or Instance_2 == workspace.Terrain then
            Sound.SoundId = "rbxassetid://142082166"
        else
            Material_2 = Instance_2.Material
            if Material_2 == Enum.Material.Metal
                or Material_2 == Enum.Material.Neon
                or Material_2 == Enum.Material.CorrodedMetal
                or Material_2 == Enum.Material.DiamondPlate then
                Sound.SoundId = "rbxassetid://142082170"
            elseif Material_2 == Enum.Material.Wood or Material_2 == Enum.Material.WoodPlanks then
                Sound.SoundId = "rbxassetid://142082171"
            elseif Material_2 == Enum.Material.Grass
                or Material_2 == Enum.Material.Sand
                or Material_2 == Enum.Material.Pebble
                or Material_2 == Enum.Material.Snow then
                Sound.SoundId = "rbxassetid://4427231299"
            elseif Material_2 ~= Enum.Material.Ground then
                Sound.SoundId = "rbxassetid://142082166"
            else
                Sound.SoundId = "rbxassetid://4427231299"
            end
        end
        Parent = Instance_2.Parent
        Parent_2 = nil
        if Parent then
            Parent_2 = Parent.Parent
        end
        v4 = nil
        v5 = nil
        if Parent then
            v4 = Parent:GetAttribute("ImpactSFX")
            if not v4 and Parent_2 then
                v4 = Parent_2:GetAttribute("ImpactSFX")
            end
            if not p2.isMelee then
                v5 = Parent:GetAttribute("ImpactTextureGun")
                if not v5 and Parent_2 then
                    v5 = Parent_2:GetAttribute("ImpactTextureGun")
                end
            end
        end
        if v4 then
            Sound.SoundId = v4
        end
        if v5 then
            Part.Decal.Texture = v5
        end
        if p2.IsMelee then
            Part.Decal.Transparency = 1
        end
        Sound:Stop()
        Sound:Play()
        Emitter1 = Part.Emitter1
        new_4 = ColorSequence.new
        v6 = Color3.new(1, 1, 1)
        Emitter1.Color = new_4(v1:lerp(v6, 0.5))
        Emitter2 = Part.Emitter2
        Emitter2.Color = ColorSequence.new(v1)
        v2 = u142
        if 25 <= (game.Players.LocalPlayer:GetAttribute("ClientCPULoad") or 0) then
            v2 = 1
        end
        if isInView(Part.Position, 150) then
            v4 = 0
            if v2 == 4 then
                v4 = math.random(10, 20)
                Emitter2_2 = Part.Emitter2
                v7 = v4
                Emitter2_2:Emit(v7)
            elseif v2 == 3 then
                v4 = 3
                Emitter2_3 = Part.Emitter2
                v7 = v4
                Emitter2_3:Emit(v7)
            elseif v2 == 2 then
                v4 = 3
                Part.Emitter2:Emit(1)
            end
            Emitter1_2 = Part.Emitter1
            v7 = v4
            Emitter1_2:Emit(v7)
        end
        if not (3 <= v2) then
            task.delay(3, function() -- Line: 351 -- upvalues: u108 (ref), Part (val), u138 (upval)
                if u108 then
                    u108:Destroy()
                end
                Part.Anchored = true
                local v1 = u138
                local v2 = Part
                v1:ReturnPart(v2)
            end)
        elseif not u108 then
            task.delay(3, function() -- Line: 351 -- upvalues: u108 (ref), Part (val), u138 (upval)
                if u108 then
                    u108:Destroy()
                end
                Part.Anchored = true
                local v1 = u138
                local v2 = Part
                v1:ReturnPart(v2)
            end)
        else
            if not u143[Part] then
                v4 = u143
                v5 = TweenService
                Decal = Part.Decal
                v8 = u133
                v4[Part] = (v5:Create(Decal, v8, {Transparency = 1}))
            end
            u143[Part]:Play()
            u373 = nil
            v6 = u143
            v5 = v6[Part].Completed:Connect(function(p1) -- Line: 343 -- upvalues: u108 (ref), Part (val), u138 (upval), u373 (ref)
                u108:Destroy()
                Part.Anchored = true
                local v1 = u138
                local v2 = Part
                v1:ReturnPart(v2)
                u373:Disconnect()
                u373 = nil
            end)
        end
        return v9
    end
    Instance_2 = p4.h
    local r = p4.r
    local p = p4.p
    local s = p4.s
    if not Instance_2 then
        return
    end
    local v10 = RaycastParams.new()
    v10.FilterType = Enum.RaycastFilterType.Whitelist
    v10.FilterDescendantsInstances = {Instance_2}
    v10.IgnoreWater = true
    if not r and not p then
        r = Vector3.new()
    end
    if r then
        local CFrame_3 = Instance_2.CFrame
        v4 = CFrame.new(r)
        p = CFrame_3:ToWorldSpace(v4).Position
    end
    v2 = workspace
    v5 = (p - s).Unit * 1000
    v2 = v2:Raycast(s, v5, v10)
    if v2 and v2.Position then
        local Position_2 = v2.Position
        local Normal_2 = v2.Normal
        local CFrame_4 = Instance_2.CFrame
        v7 = CFrame.new(Position_2, Position_2 + Normal_2)
        v9 = CFrame_4:ToObjectSpace(v7)
        if not peek(Settings.Graphics.BulletHoles) then
            return v9
        end
        Part = u138:GetPart()
        Part.Size = Vector3.new(0.05000000074505806, 0.05000000074505806, 0.05000000074505806)
        Part.Decal.Texture = "rbxassetid://64291961"
        Part.Decal.Transparency = 0
        u108 = nil
        if not p5 then
            u108 = Instance.new("Weld")
            u108.Part0 = Instance_2
            u108.Part1 = Part
            u108.C0 = v9
            u108.Parent = Part
            Part.Anchored = false
        else
            Part.Anchored = true
            Part.Decal.Transparency = 1
            Part.CFrame = Instance_2.CFrame * v9
        end
        if Instance_2 ~= workspace.Terrain or not Material or not u49[Material] then
            Color = Instance_2.Color
            v3 = Color3.new(1, 1, 1)
            v1 = Color:lerp(v3, 0.5)
        else
            MaterialColor = workspace.Terrain:GetMaterialColor(Material)
            v3 = Color3.new(1, 1, 1)
            v1 = MaterialColor:Lerp(v3, 0.5)
        end
        Sound = Part.Sound
        if not Instance_2 or Instance_2 == workspace.Terrain then
            Sound.SoundId = "rbxassetid://142082166"
        else
            Material_2 = Instance_2.Material
            if Material_2 == Enum.Material.Metal
                or Material_2 == Enum.Material.Neon
                or Material_2 == Enum.Material.CorrodedMetal
                or Material_2 == Enum.Material.DiamondPlate then
                Sound.SoundId = "rbxassetid://142082170"
            elseif Material_2 == Enum.Material.Wood or Material_2 == Enum.Material.WoodPlanks then
                Sound.SoundId = "rbxassetid://142082171"
            elseif Material_2 == Enum.Material.Grass
                or Material_2 == Enum.Material.Sand
                or Material_2 == Enum.Material.Pebble
                or Material_2 == Enum.Material.Snow then
                Sound.SoundId = "rbxassetid://4427231299"
            elseif Material_2 ~= Enum.Material.Ground then
                Sound.SoundId = "rbxassetid://142082166"
            else
                Sound.SoundId = "rbxassetid://4427231299"
            end
        end
        Parent = Instance_2.Parent
        Parent_2 = nil
        if Parent then
            Parent_2 = Parent.Parent
        end
        v4 = nil
        v5 = nil
        if Parent then
            v4 = Parent:GetAttribute("ImpactSFX")
            if not v4 and Parent_2 then
                v4 = Parent_2:GetAttribute("ImpactSFX")
            end
            if not p2.isMelee then
                v5 = Parent:GetAttribute("ImpactTextureGun")
                if not v5 and Parent_2 then
                    v5 = Parent_2:GetAttribute("ImpactTextureGun")
                end
            end
        end
        if v4 then
            Sound.SoundId = v4
        end
        if v5 then
            Part.Decal.Texture = v5
        end
        if p2.IsMelee then
            Part.Decal.Transparency = 1
        end
        Sound:Stop()
        Sound:Play()
        Emitter1 = Part.Emitter1
        new_4 = ColorSequence.new
        v6 = Color3.new(1, 1, 1)
        Emitter1.Color = new_4(v1:lerp(v6, 0.5))
        Emitter2 = Part.Emitter2
        Emitter2.Color = ColorSequence.new(v1)
        v2 = u142
        if 25 <= (game.Players.LocalPlayer:GetAttribute("ClientCPULoad") or 0) then
            v2 = 1
        end
        if isInView(Part.Position, 150) then
            v4 = 0
            if v2 == 4 then
                v4 = math.random(10, 20)
                Emitter2_2 = Part.Emitter2
                v7 = v4
                Emitter2_2:Emit(v7)
            elseif v2 == 3 then
                v4 = 3
                Emitter2_3 = Part.Emitter2
                v7 = v4
                Emitter2_3:Emit(v7)
            elseif v2 == 2 then
                v4 = 3
                Part.Emitter2:Emit(1)
            end
            Emitter1_2 = Part.Emitter1
            v7 = v4
            Emitter1_2:Emit(v7)
        end
        if not (3 <= v2) then
            task.delay(3, function() -- Line: 351 -- upvalues: u108 (ref), Part (val), u138 (upval)
                if u108 then
                    u108:Destroy()
                end
                Part.Anchored = true
                local v1 = u138
                local v2 = Part
                v1:ReturnPart(v2)
            end)
        elseif not u108 then
            task.delay(3, function() -- Line: 351 -- upvalues: u108 (ref), Part (val), u138 (upval)
                if u108 then
                    u108:Destroy()
                end
                Part.Anchored = true
                local v1 = u138
                local v2 = Part
                v1:ReturnPart(v2)
            end)
        else
            if not u143[Part] then
                v4 = u143
                v5 = TweenService
                Decal = Part.Decal
                v8 = u133
                v4[Part] = (v5:Create(Decal, v8, {Transparency = 1}))
            end
            u143[Part]:Play()
            u373 = nil
            v6 = u143
            v5 = v6[Part].Completed:Connect(function(p1) -- Line: 343 -- upvalues: u108 (ref), Part (val), u138 (upval), u373 (ref)
                u108:Destroy()
                Part.Anchored = true
                local v1 = u138
                local v2 = Part
                v1:ReturnPart(v2)
                u373:Disconnect()
                u373 = nil
            end)
        end
        return v9
    end
end

local u155 = 0
;(game:GetService("RunService")).Heartbeat:Connect(function(p1) -- Line: 367 -- upvalues: u150 (val), u46 (val), u155 (ref), u142 (ref), Debris (val)
    local v1 = #u150.BloodQueue
    if 0 < v1 then
        local Dots, Smoke, v2, v3, v4, v5, v6, v7, v8, v9, v10
        local v11 = 0
        local BloodQueue = u150.BloodQueue
        local v12 = nil
        local v13 = nil
        for i, j in BloodQueue, v12, v13 do
            v11 = v11 + 1
            if 24 < v11 then
                break
            end
            table.remove(u150.BloodQueue, 1)
            v9, v10 = table.unpack(j)
            v2 = u46()
            v2.Parent = v9
            v2.Position = v10 or Vector3.new(0, 0, 0)
            u155 = u155 + 1
            v2.Destroying:Once(function() -- Line: 390 -- upvalues: u155 (upval)
                u155 = u155 - 1
            end)
            v3 = v1 + u155
            if 50 < v3 then
                v4 = 0.1
            elseif not (10 < v3) then
                v4 = 1
            else
                v4 = 0.25
            end
            v5 = v4 * (0.25 * u142)
            v7 = (math.random(10, 15)) * v5
            v6 = math.ceil(v7)
            v8 = (math.random(5, 8)) * v5
            v7 = math.ceil(v8)
            Debris:AddItem(v2, 2)
            Smoke = v2.Smoke
            Dots = v2.Dots
            if 2 < u142 then
                Dots:Emit(v6)
            end
            Smoke:Emit(v7)
        end
    end
end)
return u150