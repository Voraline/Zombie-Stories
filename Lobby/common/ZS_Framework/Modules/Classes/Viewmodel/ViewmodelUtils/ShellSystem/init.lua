local v1 = {}
local u1 = {}
local u2 = 0
local Children = script.SFX:GetChildren()
local Children_2 = script.SFX_Shell:GetChildren()
local TweenService = game:GetService("TweenService")
local u20 = require("@game/ReplicatedStorage/common/PartCache")
local u23 = require("@game/ReplicatedStorage/common/Settings")
local peek = require("@game/ReplicatedStorage/Packages/Fusion").peek
local u28 = nil
local u29 = nil
local u30 = nil
local u31 = {}

function v1.Eject(p1, p2) -- Line: 21
    -- upvalues: peek (val), u23 (val), u28 (ref), u31 (val), u20 (val), u30 (ref), Children_2 (val), Children (val)
    -- upvalues: TweenService (val), u1 (val)
    local v1
    if not p2.EjectionAttachment or not peek(u23.Graphics.BulletShells) then
        return
    end
    local EjectionAttachment = p2.EjectionAttachment
    u28 = EjectionAttachment
    local u12 = p2.Weapon.Config.BulletCasing or "rifle"
    if not u31[u12] then
        local v2 = u31
        local v3 = u20
        local new = v3.new
        v1 = game.ReplicatedStorage.common.SharedResources.Shells[u12]
        v2[u12] = (new(v1, 30, workspace.Ignore))
    end
    local Part = u31[u12]:GetPart()
    Part.Name = u12
    Part.Anchored = true
    Part.CFrame = EjectionAttachment.WorldCFrame
    Part.Size = game.ReplicatedStorage.common.SharedResources.Shells[u12].Size * (p2.Weapon.Config.WorldScaleValue or 1)
    Part.Transparency = 0
    Part.Parent = workspace.Ignore
    local CFrame = Part.CFrame
    v1 = EjectionAttachment.WorldCFrame.RightVector.Unit * math.random(11, 17) * (1 + (u30 or 1))
    local v4 = {
        Lifetime = 0,
        Shell = Part,
        Attachment = EjectionAttachment,
        InitialCFrame = CFrame,
        InitialVelocity = v1,
        YPos = 6 - math.random(-5, 5),
        InitRotation = math.random(-360, 360),
    }
    task.delay(0.4 + math.random(100, 500) * 0.001, function() -- Line: 54 -- upvalues: Part (val), u12 (val), Children_2 (upval), Children (upval), TweenService (upval)
        local v1
        local Attachment = Instance.new("Attachment")
        Attachment.Parent = workspace.Terrain
        Attachment.WorldCFrame = Part.CFrame
        if u12 ~= "shotgun" then
            v1 = Children[math.random(1, #Children)]:Clone()
        else
            v1 = Children_2[math.random(1, #Children_2)]:Clone()
        end
        v1.PlaybackSpeed = 0.95
        v1.Parent = Attachment
        v1:Play()
        if u12 ~= "shotgun" then
            local v2 = TweenService
            local v3 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false)
            v2:Create(v1, v3, {Volume = 0}):Play()
        end
        game.Debris:AddItem(Attachment, 7)
    end)
    local v5 = TweenService
    local v6 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0.75)
    v5:Create(Part, v6, {Transparency = 1}):Play()
    local v7 = u1
    table.insert(v7, v4)
end

function v1.Update(p1, p2) -- Line: 73 -- upvalues: u2 (ref), u28 (ref), u29 (ref), u30 (ref), u1 (val), u31 (val)
    local Angles, InitRotation, InitialVelocity, Shell, YPos, v1, v2, v3, v4, v5, v6, v7, v8
    u2 = u2 + p2
    if u2 < 0.016666666666666666 then
        return
    end
    local v9 = u2
    u2 = 0
    if u28 then
        if u29 then
            v6 = u28.WorldPosition - u29
            v7 = u28
            local RightVector = v7.WorldCFrame.RightVector
            u30 = v6:Dot(RightVector) / v9 * 0.05
        end
        u29 = u28.WorldPosition
    end
    v6 = {}
    v7 = {}
    for i = #u1, 1, -1 do
        v8 = u1[i]
        Shell = v8.Shell
        if 1.5 <= v8.Lifetime then
            u31[Shell.Name]:ReturnPart(Shell)
            table.remove(u1, i)
        elseif Shell.Parent then
            v8.Lifetime = v8.Lifetime + v9
            v2 = v8.Lifetime / 0.15
            v1 = math.clamp(v2, 0, 1)
            v3 = v8.YPos - v9 * 25
            v8.YPos = math.clamp(v3, -100, 15)
            Angles = CFrame.Angles
            InitRotation = v8.InitRotation
            v2 = Angles(0, 0, (math.rad(InitRotation)) + v8.Lifetime * 12)
            InitialVelocity = v8.InitialVelocity
            YPos = v8.YPos
            v3 = (InitialVelocity + Vector3.new(0, YPos, 0)) * v8.Lifetime
            v4 = v8.InitialCFrame * v2 + v3
            v5 = (v8.Attachment.WorldCFrame * v2 + v3):Lerp(v4, v1)
            table.insert(v6, Shell)
            table.insert(v7, v5)
        else
            u31[Shell.Name]:ReturnPart(Shell)
            table.remove(u1, i)
        end
    end
    if 0 < #v6 then
        local v10 = workspace
        local FireCFrameChanged = Enum.BulkMoveMode.FireCFrameChanged
        v10:BulkMoveTo(v6, v7, FireCFrameChanged)
    end
end

return v1