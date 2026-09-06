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
local u45 = {
    HasLanded = true,
    Climbing = false,
    GetOff = false,
    Jumped = BindableEvent.Event,
    Landed = BindableEvent_2.Event,
    Respawned = BindableEvent_3.Event,
    JumpPower = 30,
    Animations = {},
    hpUpdated = function(p1, p2) end,
    SetJumpPower = function(p1, p2) -- Line: 43
        p1.JumpPower = p2
        if p1.Humanoid then
            p1.Humanoid.JumpPower = p2
        end
    end,
}
function ConEvents(p1) -- Line: 51 -- upvalues: Humanoid (ref), u45 (val), Children (val), BindableEvent (val), BindableEvent_2 (val), LocalPlayer (val), BindableEvent_3 (val), ConEvents (val), peek (val), u34 (val)
    local Animator
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
        if not HumanoidRootPart or not (HumanoidRootPart:IsA("BasePart")) then
            warn("[HumanoidUtil] Cannot attach BuoyancySensor; character has no suitable body part")
            return
        end
        local BuoyancySensor = Instance.new("BuoyancySensor")
        BuoyancySensor.Parent = HumanoidRootPart
        u45.WaterSensor = BuoyancySensor
    end)
    for k, v in pairs(Children) do
        Animator = Humanoid:WaitForChild("Animator")
        u45.Animations[v.Name] = Animator:LoadAnimation(v)
    end
    Humanoid.Jumping:Connect(function() -- Line: 79 -- upvalues: u45 (upval), BindableEvent (upval)
        if u45.HasLanded then
            BindableEvent:Fire()
        end
        u45.HasLanded = false
    end)
    Humanoid.Running:Connect(function() -- Line: 85 -- upvalues: u45 (upval)
        if u45.Climbing == true then
            u45.Climbing = false
        end
    end)
    Humanoid.StateChanged:Connect(function(p1, p2) -- Line: 91 -- upvalues: u45 (upval), BindableEvent_2 (upval)
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
    Humanoid.Climbing:Connect(function() -- Line: 102 -- upvalues: u45 (upval)
        u45.Climbing = true
    end)
    Humanoid.Seated:Connect(function(p1) -- Line: 106 -- upvalues: u45 (upval)
        if p1 == true then
            u45.HasLanded = false
            return
        end
        u45.GetOff = true
    end)
    Humanoid.Died:Connect(function() -- Line: 114 -- upvalues: u45 (upval), p1 (ref), LocalPlayer (upval), Humanoid (upval), BindableEvent_3 (upval), ConEvents (upval)
        u45.Alive = false
        u45.WaterSensor = nil
        p1 = LocalPlayer.CharacterAdded:Wait()
        Humanoid = p1:WaitForChild("Humanoid")
        BindableEvent_3:Fire(Humanoid)
        ConEvents()
    end)
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, false)
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
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