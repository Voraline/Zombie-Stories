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
local NPCs_Shared = game.ReplicatedStorage.common:WaitForChild("NPCs_Shared")
local Utils = NPCs_Shared:WaitForChild("Utils")
local ClassMirror = require(Utils:WaitForChild("ClassMirror"))
local u128 = require("@game/ReplicatedStorage/common/NPCs_Shared/Utils/Encoder_Util")
local u133 = TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
local u138 = PartCache.new(ImpactPart, 50, Ignore)
local u142 = peek(Settings.Graphics.ParticleQuality)
local u143 = {}
local function isInView(p1, p2) -- Line: 58 -- upvalues: CurrentCamera (val)
    local v1
    local v2 = p1 - CurrentCamera.CFrame.Position
    local v3 = CurrentCamera.FieldOfView + 2
    if math.floor((math.deg((v2.Unit:Angle(CurrentCamera.CFrame.LookVector))))) > v3 then
        return false
    end
    if not game.Players.LocalPlayer.Character then
        v1 = v2
    elseif not game.Players.LocalPlayer.Character.PrimaryPart then
        v1 = v2
    else
        v1 = p1 - game.Players.LocalPlayer.Character.PrimaryPart.Position
        if not v1 then
            v1 = v2
        end
    end
    v2 = v1
    if Vector3.new(v2.X, 0, v2.Z).Magnitude <= p2 then
        return true
    end
    return false
end
Settings.SettingsChanged:Connect(function() -- Line: 79 -- upvalues: u142 (ref), peek (val), Settings (val)
    u142 = peek(Settings.Graphics.ParticleQuality)
end)
local u150 = {
    BloodQueue = {},
    BulletTrail = function(p1, p2, p3, p4) -- Line: 88 -- upvalues: peek (val), Settings (val), Beam (val), Terrain (val)
        local Attachment, Properties, u47
        if not (peek(Settings.Graphics.BulletTracers)) then
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
            Properties = p4.Properties
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
    end,
}
function u150.BloodNPC(p1, p2, p3, p4, p5) -- Line: 127 -- upvalues: ClassMirror (val), u142 (ref), u128 (val), u150 (val)
    local ID, PlaybackSpeed, v1, v2, v3
    if game:GetService("GuiService"):IsTenFootInterface() then
        return
    end
    local ObjFromId = ClassMirror:GetObjFromId(p3)
    if not ObjFromId or not ObjFromId.UIDTable or not (ObjFromId.UIDTable[p4]) then
        return
    end
    local v4 = ObjFromId.UIDTable[p4]
    local Sound = Instance.new("Sound")
    local v5 = "rbxassetid://"
    if not p2.HitSFX then
        ID = "358942915"
    else
        ID = p2.HitSFX.ID
    end
    Sound.SoundId = v5 .. ID
    if not p2.HitSFX then
        PlaybackSpeed = 1
    else
        PlaybackSpeed = p2.HitSFX.PlaybackSpeed
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
    end
    if v4.Parent then
        local HumanoidRootPart
        if v4.Name ~= "Head" then
            HumanoidRootPart = v4
        else
            HumanoidRootPart = v4.Parent.HumanoidRootPart
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
    table.insert(u150.BloodQueue, {v4, v3})
end
function u150.MakeImpact(p1, p2, p3, p4, p5) -- Line: 177 -- upvalues: peek (val), Settings (val), u138 (val), u49 (val), u142 (ref), isInView (val), u143 (val), TweenService (val), u133 (val)
    local Instance
    if not p3 then
        local Position, v1
        local Material = nil
        if not p3 then
            local v2, v3
            Instance = p4.h
            local r = p4.r
            local p = p4.p
            local s = p4.s
            if not Instance then
                return
            end
            local v4 = RaycastParams.new()
            v4.FilterType = Enum.RaycastFilterType.Whitelist
            v4.FilterDescendantsInstances = {Instance}
            v4.IgnoreWater = true
            if not r and not p then
                r = Vector3.new()
            end
            if r then
                p = Instance.CFrame:ToWorldSpace(CFrame.new(r)).Position
            end
            local v5 = (p - s).Unit * 1000
            local v6 = workspace:Raycast(s, v5, v4)
            if not v6 or not v6.Position then
                return
            end
            local Position_2 = v6.Position
            v1 = Instance.CFrame:ToObjectSpace(CFrame.new(Position_2, Position_2 + v6.Normal))
            if not (peek(Settings.Graphics.BulletHoles)) then
                return v1
            end
            local Part = u138:GetPart()
            Part.Size = Vector3.new(0.05000000074505806, 0.05000000074505806, 0.05000000074505806)
            Part.Decal.Texture = "rbxassetid://64291961"
            Part.Decal.Transparency = 0
            local u108 = nil
            if not p5 then
                u108 = Instance.new("Weld")
                u108.Part0 = Instance
                u108.Part1 = Part
                u108.C0 = v1
                u108.Parent = Part
                Part.Anchored = false
            else
                Part.Anchored = true
                Part.Decal.Transparency = 1
                Part.CFrame = Instance.CFrame * v1
            end
            if Instance ~= workspace.Terrain then
                v3 = Color3.new(1, 1, 1)
                v2 = Instance.Color:lerp(v3, 0.5)
            elseif Material and u49[Material] then
                local MaterialColor = workspace.Terrain:GetMaterialColor(Material)
                v3 = Color3.new(1, 1, 1)
                v2 = MaterialColor:Lerp(v3, 0.5)
            end
            local Sound = Part.Sound
            if not Instance then
                Sound.SoundId = "rbxassetid://142082166"
            elseif Instance ~= workspace.Terrain then
                local Material_2 = Instance.Material
                if Material_2 == Enum.Material.Metal then
                    Sound.SoundId = "rbxassetid://142082170"
                elseif Material_2 ~= Enum.Material.Neon and Material_2 ~= Enum.Material.CorrodedMetal and Material_2 ~= Enum.Material.DiamondPlate then
                    if Material_2 == Enum.Material.Wood then
                        Sound.SoundId = "rbxassetid://142082171"
                    elseif Material_2 ~= Enum.Material.WoodPlanks then
                        if Material_2 == Enum.Material.Grass then
                            Sound.SoundId = "rbxassetid://4427231299"
                        elseif Material_2 ~= Enum.Material.Sand and Material_2 ~= Enum.Material.Pebble and Material_2 ~= Enum.Material.Snow and Material_2 ~= Enum.Material.Ground then
                            Sound.SoundId = "rbxassetid://142082166"
                        end
                    end
                end
            end
            local Parent = Instance.Parent
            local Parent_2 = if Parent then Parent.Parent else nil
            local v7 = nil
            v5 = nil
            if Parent then
                v7 = Parent:GetAttribute("ImpactSFX")
                if not v7 and Parent_2 then
                    v7 = Parent_2:GetAttribute("ImpactSFX")
                end
                if not p2.isMelee then
                    v5 = Parent:GetAttribute("ImpactTextureGun")
                    if not v5 and Parent_2 then
                        v5 = Parent_2:GetAttribute("ImpactTextureGun")
                    end
                end
            end
            if v7 then
                Sound.SoundId = v7
            end
            if v5 then
                Part.Decal.Texture = v5
            end
            if p2.IsMelee then
                Part.Decal.Transparency = 1
            end
            Sound:Stop()
            Sound:Play()
            local Emitter1 = Part.Emitter1
            local v8 = Color3.new(1, 1, 1)
            Emitter1.Color = ColorSequence.new(v2:lerp(v8, 0.5))
            local Emitter2 = Part.Emitter2
            Emitter2.Color = ColorSequence.new(v2)
            v6 = u142
            v3 = game.Players.LocalPlayer:GetAttribute("ClientCPULoad") or 0
            if 25 <= v3 then
                v6 = 1
            end
            if isInView(Part.Position, 150) then
                v7 = 0
                if v6 == 4 then
                    v7 = math.random(10, 20)
                    Part.Emitter2:Emit(v7)
                elseif v6 == 3 then
                    Part.Emitter2:Emit(3)
                elseif v6 == 2 then
                    v7 = 3
                    Part.Emitter2:Emit(1)
                end
                Part.Emitter1:Emit(v7)
            end
            if 3 > v6 then
                task.delay(3, function() -- Line: 351 -- upvalues: u108 (ref), Part (val), u138 (upval)
                    if u108 then
                        u108:Destroy()
                    end
                    Part.Anchored = true
                    u138:ReturnPart(Part)
                end)
            elseif not u108 then
                task.delay(3, function() -- Line: 351 -- upvalues: u108 (ref), Part (val), u138 (upval)
                    if u108 then
                        u108:Destroy()
                    end
                    Part.Anchored = true
                    u138:ReturnPart(Part)
                end)
            else
                if not (u143[Part]) then
                    u143[Part] = TweenService:Create(Part.Decal, u133, {Transparency = 1})
                end
                u143[Part]:Play()
                local delay = nil
            end
            return v1
        else
            Instance = p3.Instance
            if not Instance then
                return
            end
            Material = p3.Instance.Material
            Position = p3.Position
            v1 = Instance.CFrame:ToObjectSpace(CFrame.new(Position, Position + p3.Normal))
        end
    elseif not p3.Instance and not p4 then
        return
    end
end
local u155 = 0
game:GetService("RunService").Heartbeat:Connect(function(p1) -- Line: 367 -- upvalues: u150 (val), u46 (val), u155 (ref), u142 (ref), Debris (val)
    local v1 = #u150.BloodQueue
    if 0 < v1 then
        local v2, v3, v4, v5, v6, v7, v8, v9
        local v10 = 0
        local BloodQueue = u150.BloodQueue
        local v11 = nil
        local v12 = nil
        for i, j in BloodQueue, v11, v12 do
            v10 = v10 + 1
            if 24 < v10 then
                break
            end
            table.remove(u150.BloodQueue, 1)
            v8, v9 = table.unpack(j)
            v2 = u46()
            v2.Parent = v8
            v2.Position = v9 or Vector3.new(0, 0, 0)
            u155 = u155 + 1
            v2.Destroying:Once(function() -- Line: 390 -- upvalues: u155 (upval)
                u155 = u155 - 1
            end)
            v3 = v1 + u155
            if 50 < v3 then
                v4 = 0.1
            elseif 10 >= v3 then
                v4 = 1
            else
                v4 = 0.25
            end
            v5 = v4 * (0.25 * u142)
            v6 = math.ceil(math.random(10, 15) * v5)
            v7 = math.ceil(math.random(5, 8) * v5)
            Debris:AddItem(v2, 2)
            if 2 < u142 then
                v2.Dots:Emit(v6)
            end
            v2.Smoke:Emit(v7)
        end
    end
end)
return u150