local ConEvents
game:GetService("ReplicatedStorage")
local LocalPlayer = game.Players.LocalPlayer
local Character = LocalPlayer.Character
local Humanoid = Character
if Humanoid then
    Humanoid = Character:WaitForChild("Humanoid", 5)
end
local Children = script:WaitForChild("Animations"):GetChildren()
local BindableEvent = Instance.new("BindableEvent")
local BindableEvent_2 = Instance.new("BindableEvent")
local BindableEvent_3 = Instance.new("BindableEvent")
local u34 = require("@game/ReplicatedStorage/common/Settings")
local peek = require(game:GetService("ReplicatedStorage").Packages.Fusion).peek
local u45 = {HasLanded = true, Climbing = false, GetOff = false}
u45.Jumped = BindableEvent.Event
u45.Landed = BindableEvent_2.Event
u45.Respawned = BindableEvent_3.Event
u45.JumpPower = 30
u45.Animations = {}

function u45.hpUpdated(p1, p2) end

function u45.SetJumpPower(p1, p2) -- Line: 43
    p1.JumpPower = p2
    if p1.Humanoid then
        p1.Humanoid.JumpPower = p2
    end
end

function ConEvents(p1) -- Line: 51
    -- upvalues: Humanoid (ref), u45 (val), Children (val), BindableEvent (val), BindableEvent_2 (val)
    -- upvalues: LocalPlayer (val), BindableEvent_3 (val), ConEvents (val), peek (val), u34 (val)
    local Animations, Name, v1
    if not Humanoid then
        Humanoid = p1:WaitForChild("Humanoid")
    end
    local u6 = Humanoid
    task.defer(function() -- Line: 57 -- upvalues: u6 (val), p1 (ref), u45 (upval)
        local v1
        if u6.Parent ~= p1 then
            return
        end
        if u6.RigType ~= Enum.HumanoidRigType.R6 then
            v1 = "LeftFoot"
        else
            v1 = "Left Leg"
        end
        local HumanoidRootPart = p1:FindFirstChild(v1)
        if not HumanoidRootPart then
            HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart")
        end
        if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
            local BuoyancySensor = Instance.new("BuoyancySensor")
            BuoyancySensor.Parent = HumanoidRootPart
            u45.WaterSensor = BuoyancySensor
            return
        end
        warn("[HumanoidUtil] Cannot attach BuoyancySensor; character has no suitable body part")
    end)
    for k, v in pairs(Children) do
        v1 = u45
        Animations = v1.Animations
        Name = v.Name
        Animations[Name] = ((Humanoid:WaitForChild("Animator")):LoadAnimation(v))
    end
    local v2 = Humanoid
    v2.Jumping:Connect(function() -- Line: 79 -- upvalues: u45 (upval), BindableEvent (upval)
        if u45.HasLanded then
            BindableEvent:Fire()
        end
        u45.HasLanded = false
    end)
    v2 = Humanoid
    v2.Running:Connect(function() -- Line: 85 -- upvalues: u45 (upval)
        if u45.Climbing == true then
            u45.Climbing = false
        end
    end)
    v2 = Humanoid
    v2.StateChanged:Connect(function(p1, p2) -- Line: 91 -- upvalues: u45 (upval), BindableEvent_2 (upval)
        if p2 == Enum.HumanoidStateType.Freefall then
            u45.HasLanded = false
            return
        end
        if p2 == Enum.HumanoidStateType.Landed then
            if not u45.HasLanded then
                BindableEvent_2:Fire()
            end
            u45.HasLanded = true
        end
    end)
    v2 = Humanoid
    v2.Climbing:Connect(function() -- Line: 102 -- upvalues: u45 (upval)
        u45.Climbing = true
    end)
    v2 = Humanoid
    v2.Seated:Connect(function(p1) -- Line: 106 -- upvalues: u45 (upval)
        if p1 == true then
            u45.HasLanded = false
            return
        end
        u45.GetOff = true
    end)
    v2 = Humanoid
    v2.Died:Connect(function() -- Line: 114
        -- upvalues: u45 (upval), p1 (ref), LocalPlayer (upval), Humanoid (upval), BindableEvent_3 (upval)
        -- upvalues: ConEvents (upval)
        u45.Alive = false
        u45.WaterSensor = nil
        p1 = LocalPlayer.CharacterAdded:Wait()
        Humanoid = p1:WaitForChild("Humanoid")
        local v1 = BindableEvent_3
        local v2 = Humanoid
        v1:Fire(v2)
        ConEvents()
    end)
    v2 = Humanoid
    local Swimming = Enum.HumanoidStateType.Swimming
    v2:SetStateEnabled(Swimming, false)
    v2 = Humanoid
    local Ragdoll = Enum.HumanoidStateType.Ragdoll
    v2:SetStateEnabled(Ragdoll, false)
    v2 = Humanoid
    local FallingDown = Enum.HumanoidStateType.FallingDown
    v2:SetStateEnabled(FallingDown, false)
    Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
    u45.Humanoid = Humanoid
    Humanoid.UseJumpPower = true
    Humanoid.JumpPower = u45.JumpPower
    Humanoid.AutoJumpEnabled = peek(u34.Controls.AutoJump) or false
end

if not Character then
    task.defer(function() -- Line: 138 -- upvalues: Character (ref), LocalPlayer (val), Humanoid (ref), ConEvents (val)
        if Character then
            return
        end
        local Character_2 = LocalPlayer.Character
        if not Character_2 then
            Character_2 = LocalPlayer.CharacterAdded:Wait()
        end
        task.wait()
        Character = Character_2
        if Humanoid then
            return
        end
        Humanoid = Character:WaitForChild("Humanoid")
        ConEvents(Character)
        print("HumanoidUtil defer")
    end)
else
    print("HumanoidUtil Char")
    ConEvents(Character)
end
LocalPlayer.CharacterAdded:Connect(function(p1) -- Line: 157 -- upvalues: ConEvents (val)
    print("HumanoidUtil Add")
    ConEvents(p1)
end)
LocalPlayer.CharacterRemoving:Connect(function() -- Line: 161 -- upvalues: u45 (val), Humanoid (ref)
    print("HumanoidUtil Remove")
    u45.Humanoid = nil
    Humanoid = nil
end)
u34.SettingsChanged:Connect(function() -- Line: 167 -- upvalues: Humanoid (ref), peek (val), u34 (val)
    if Humanoid then
        Humanoid.AutoJumpEnabled = peek(u34.Controls.AutoJump) or false
    end
end)
return u45