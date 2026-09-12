local v1 = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = game.Players.LocalPlayer
local Character = LocalPlayer.Character
local u33 = nil
local Utils = script.Parent.Parent.Parent.Parent:WaitForChild("Utils")
local new = Vector3.new
local BindableEvent = Instance.new("BindableEvent")
if Character then
    u33 = Character:WaitForChild("Humanoid")
end
LocalPlayer.CharacterAdded:Connect(function(p1) -- Line: 15 -- upvalues: Character (ref), u33 (ref)
    Character = p1
    u33 = p1:WaitForChild("Humanoid")
end)
LocalPlayer.CharacterRemoving:Connect(function() -- Line: 19 -- upvalues: Character (ref), u33 (ref)
    Character = nil
    u33 = nil
end)

local function isSeated() -- Line: 24 -- upvalues: u33 (ref)
    local Sit = false
    if u33 ~= nil then
        Sit = u33.Sit
        if not Sit then
            Sit = u33.SeatPart ~= nil
        end
    end
    return Sit
end

local u48 = nil
local u49 = false
local u52 = new()
local u53 = 0
local u55 = false
local v2 = {}
local v3 = {Direction = Vector3.new(-0, -0, -1), KeyCode = Enum.KeyCode.W}
local v4 = {Direction = Vector3.new(-1, -0, -0), KeyCode = Enum.KeyCode.A}
local v5 = {Direction = Vector3.new(0, 0, 1), KeyCode = Enum.KeyCode.S}
local v6 = {Direction = Vector3.new(1, 0, 0), KeyCode = Enum.KeyCode.D}
v2[1] = v3
v2[2] = v4
v2[3] = v5
v2[4] = v6
local MasterControl = require(((LocalPlayer:WaitForChild("PlayerScripts")):WaitForChild("ControlScript")):WaitForChild("MasterControl"))
local SpringUtil = require(Utils:WaitForChild("SpringUtil"))
local u86 = {}
u86.Direction = SpringUtil.new((new()))
u86.Direction.Speed = 16
u86.MoveVector = Vector3.new()
u86.ShuffleEvent = BindableEvent.Event
u86.Diving = false

function u86.Init(p1) -- Line: 78 -- upvalues: u48 (ref), RunService (val), u86 (val)
    u48 = require(script.Parent.Parent)
    local v1 = RunService
    local Value = Enum.RenderPriority.Input.Value
    v1:BindToRenderStep("movement", Value, function() -- Line: 81 -- upvalues: u86 (upval)
        u86:Update()
    end)
end

function u86.Update(p1) -- Line: 131
    -- upvalues: u86 (val), MasterControl (val), u48 (ref), u33 (ref), new (val), u52 (ref), LocalPlayer (val)
    -- upvalues: u49 (ref), BindableEvent (val), Character (ref)
    local v1, v2
    local Direction = u86.Direction
    local MoveVector = MasterControl:GetMoveVector()
    if not u48.AutoRun then
        v2 = Vector3.new()
    else
        v2 = Vector3.new(-0, -0, -1)
    end
    Direction.Target = MoveVector + v2
    local Sit = false
    if u33 ~= nil then
        Sit = u33.Sit
        if not Sit then
            Sit = u33.SeatPart ~= nil
        end
    end
    if Sit then
        u86.Direction.Target = new()
        u86.MoveVector = new()
        u52 = new()
        v1 = LocalPlayer
        local v3 = new
        v3 = v3()
        v1:Move(v3, true)
        return
    end
    v1 = u48.humanoid.HasLanded == true
    if not v1 and u86.MoveVector.Magnitude <= 0 then
        u52 = new()
    end
    if not (u86.Direction.Target.Magnitude <= 0.01) then
        if 0.01 < u86.Direction.Target.Magnitude and not u49 then
            u49 = true
        end
    elseif u49 then
        u49 = false
        BindableEvent:Fire()
    elseif 0.01 < u86.Direction.Target.Magnitude and not u49 then
        u49 = true
    end
    if Character then
        local v4
        if not u48.MovementEnabled then
            u86.Direction.Target = new()
            u86.MoveVector = new()
            u52 = new()
            v4 = LocalPlayer
            v2 = new
            v2 = v2()
            v4:Move(v2, true)
        else
            if 0.001 < u86.Direction.Position.Magnitude and not u86.Diving then
                v4 = LocalPlayer
                v2 = u86
                local Position = v2.Direction.Position
                v4:Move(Position, true)
                u52 = u86.Direction.Position
                u86.MoveVector = u52
                return
            end
            if u86.Diving then
                u86.MoveVector = u52
                return
            end
        end
    end
end

v1.InputBegan:Connect(function(p1, p2) -- Line: 173 -- upvalues: u33 (ref), u55 (ref), u53 (ref)
    if not p2 and p1.UserInputType == Enum.UserInputType.Keyboard and u33 and p1.KeyCode == Enum.KeyCode.Space then
        u55 = true
        if 1.4 <= os.clock() - u53 then
            u33.Jump = true
            u53 = os.clock()
        end
    end
end)
v1.InputEnded:Connect(function(p1, p2) -- Line: 185 -- upvalues: u55 (ref)
    if p1.UserInputType == Enum.UserInputType.Keyboard and p1.KeyCode == Enum.KeyCode.Space then
        u55 = false
    end
end)
return u86