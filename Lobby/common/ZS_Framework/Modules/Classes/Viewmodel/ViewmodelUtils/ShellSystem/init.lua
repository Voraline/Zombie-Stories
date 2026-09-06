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
function v1.Eject(p1, p2) -- Line: 21 -- upvalues: peek (val), u23 (val), u28 (ref), u31 (val), u20 (val), u30 (ref), Children_2 (val), Children (val), TweenService (val), u1 (val)
    local EjectionAttachment
    if not p2.EjectionAttachment or not (peek(u23.Graphics.BulletShells)) then
        return
    end
    EjectionAttachment = p2.EjectionAttachment
    u28 = EjectionAttachment
    local u12 = p2.Weapon.Config.BulletCasing or "rifle"
    if not (u31[u12]) then
        u31[u12] = u20.new(game.ReplicatedStorage.common.SharedResources.Shells[u12], 30, workspace.Ignore)
    end
    local Part = u31[u12]:GetPart()
    Part.Name = u12
    Part.Anchored = true
    Part.CFrame = EjectionAttachment.WorldCFrame
    Part.Size = game.ReplicatedStorage.common.SharedResources.Shells[u12].Size * (p2.Weapon.Config.WorldScaleValue or 1)
    Part.Transparency = 0
    Part.Parent = workspace.Ignore
    local CFrame = Part.CFrame
    local v1 = EjectionAttachment.WorldCFrame.RightVector.Unit * math.random(11, 17)
    v1 = {
        Lifetime = 0,
        Shell = Part,
        Attachment = EjectionAttachment,
        InitialCFrame = CFrame,
        InitialVelocity = v1 * (1 + (u30 or 1)),
        YPos = 6 - math.random(-5, 5),
        InitRotation = math.random(-360, 360),
    }
    local v2 = 0.4 + math.random(100, 500) * 0.001
    task.delay(v2, function() -- Line: 54 -- upvalues: Part (val), u12 (val), Children_2 (upval), Children (upval), TweenService (upval)
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
            local v2 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false)
            TweenService:Create(v1, v2, {Volume = 0}):Play()
        end
        game.Debris:AddItem(Attachment, 7)
    end)
    local v3 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0.75)
    TweenService:Create(Part, v3, {Transparency = 1}):Play()
    table.insert(u1, v1)
end
function v1.Update(p1, p2) -- Line: 73 -- upvalues: u2 (ref), u28 (ref), u29 (ref), u30 (ref), u1 (val), u31 (val)
    local Shell, v1, v2, v3, v4, v5, v6
    u2 = u2 + p2
    if u2 < 0.016666666666666666 then
        return
    end
    local v7 = u2
    u2 = 0
    if u28 then
        if u29 then
            u30 = (u28.WorldPosition - u29):Dot(u28.WorldCFrame.RightVector) / v7 * 0.05
        end
        u29 = u28.WorldPosition
    end
    local v8 = {}
    local v9 = {}
    local v10 = 1
    local v11 = -1
    for i = #u1, v10, v11 do
        v6 = u1[i]
        Shell = v6.Shell
        if 1.5 <= v6.Lifetime then
            u31[Shell.Name]:ReturnPart(Shell)
            table.remove(u1, i)
        elseif Shell.Parent then
            v6.Lifetime = v6.Lifetime + v7
            v1 = math.clamp(v6.Lifetime / 0.15, 0, 1)
            v6.YPos = math.clamp(v6.YPos - v7 * 25, -100, 15)
            v5 = math.rad(v6.InitRotation)
            v2 = CFrame.Angles(0, 0, v5 + v6.Lifetime * 12)
            v4 = v6.InitialVelocity + Vector3.new(0, v6.YPos, 0)
            v3 = v4 * v6.Lifetime
            v5 = (v6.Attachment.WorldCFrame * v2 + v3):Lerp(v6.InitialCFrame * v2 + v3, v1)
            table.insert(v8, Shell)
            table.insert(v9, v5)
        end
    end
    if 0 < #v8 then
        workspace:BulkMoveTo(v8, v9, Enum.BulkMoveMode.FireCFrameChanged)
    end
end
return v1