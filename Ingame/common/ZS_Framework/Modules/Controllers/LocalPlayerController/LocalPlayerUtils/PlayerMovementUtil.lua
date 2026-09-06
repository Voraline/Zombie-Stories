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
local PlayerScripts = LocalPlayer:WaitForChild("PlayerScripts")
local ControlScript = PlayerScripts:WaitForChild("ControlScript")
local MasterControl = require(ControlScript:WaitForChild("MasterControl"))
local SpringUtil = require(Utils:WaitForChild("SpringUtil"))
local u86 = {Direction = SpringUtil.new((new()))}
u86.Direction.Speed = 16
u86.MoveVector = Vector3.new()
u86.ShuffleEvent = BindableEvent.Event
u86.Diving = false
function u86.Init(p1) -- Line: 78 -- upvalues: u48 (ref), RunService (val), u86 (val)
    u48 = require(script.Parent.Parent)
    RunService:BindToRenderStep("movement", Enum.RenderPriority.Input.Value, function() -- Line: 81 -- upvalues: u86 (upval)
        u86:Update()
    end)
end
function u86.Update(p1) -- Line: 131 -- upvalues: u86 (val), MasterControl (val), u48 (ref), u33 (ref), new (val), u52 (ref), LocalPlayer (val), u49 (ref), BindableEvent (val), Character (ref)
    local v1
    local MoveVector = MasterControl:GetMoveVector()
    if not u48.AutoRun then
        v1 = Vector3.new()
    else
        v1 = Vector3.new(-0, -0, -1)
    end
    u86.Direction.Target = MoveVector + v1
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
        LocalPlayer:Move(new(), true)
        return
    end
    local v2 = u48.humanoid.HasLanded == true
    if not v2 and u86.MoveVector.Magnitude <= 0 then
        u52 = new()
    end
    if u86.Direction.Target.Magnitude > 0.01 then
        if 0.01 < u86.Direction.Target.Magnitude and not u49 then
            u49 = true
        end
    elseif u49 then
        u49 = false
        BindableEvent:Fire()
    end
    if not Character then
        return
    end
    if not u48.MovementEnabled then
        u86.Direction.Target = new()
        u86.MoveVector = new()
        u52 = new()
        LocalPlayer:Move(new(), true)
        return
    end
    if 0.001 >= u86.Direction.Position.Magnitude then
        if u86.Diving then
            u86.MoveVector = u52
            return
        end
        return
    end
    if not u86.Diving then
        LocalPlayer:Move(u86.Direction.Position, true)
        u52 = u86.Direction.Position
        u86.MoveVector = u52
        return
    end
    if not u86.Diving then
        return
    end
    u86.MoveVector = u52
end
v1.InputBegan:Connect(function(p1, p2) -- Line: 173 -- upvalues: u33 (ref), u55 (ref), u53 (ref)
    if not p2 and p1.UserInputType == Enum.UserInputType.Keyboard and u33 and p1.KeyCode == Enum.KeyCode.Space then
        u55 = true
        local v1 = os.clock() - u53
        if 1.4 <= v1 then
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