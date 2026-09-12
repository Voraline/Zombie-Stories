local v1 = {}
local Parent = script.Parent.Parent.Parent.Parent.Parent
local LocalPlayerController = (Parent:WaitForChild("Controllers")):WaitForChild("LocalPlayerController")
local u17 = require(LocalPlayerController)
local SpringUtil = require((Parent:WaitForChild("Utils")):WaitForChild("SpringUtil"))
local PlayerMovementUtil = require((LocalPlayerController:WaitForChild("LocalPlayerUtils")):WaitForChild("PlayerMovementUtil"))
local PointRotationUtil = require(script.Parent.Parent:WaitForChild("PointRotationUtil"))
local Camera = workspace.Camera
local u51 = SpringUtil.new(0)
u51.Target = 0
u51.Speed = 6
u51.Damper = 0.4
local u57 = SpringUtil.new(0)
u57.Target = 0
u57.Speed = 6
u57.Damper = 0.4
local u65 = CFrame.new(0.588401794, -0.546500206, -4.0329895)
local u66 = {}
local v2 = u57.Position / 2
u66[1] = v2
u66[2] = u51.Position / 2

function v1.Update(p1) -- Line: 33
    -- upvalues: u17 (val), Camera (val), PlayerMovementUtil (val), u51 (val), u57 (val), u66 (val)
    -- upvalues: PointRotationUtil (val), u65 (val)
    local Character = u17.Character
    if not Character then
        return
    end
    local Humanoid = Character.Humanoid
    local MoveDirection = Humanoid.MoveDirection
    local v1 = Camera
    local RightVector = v1.CFrame.RightVector
    local v2 = MoveDirection:Dot(RightVector)
    local MoveDirection_2 = Humanoid.MoveDirection
    local v3 = Camera
    local LookVector = v3.CFrame.LookVector
    local v4 = MoveDirection_2:Dot(LookVector)
    if not (0.75 < PlayerMovementUtil.MoveVector.Magnitude) then
        u51.Target = 0
        u57.Target = 0
    else
        if 0.1 < v2 then
            u51.Target = -5 * v2
        elseif not (v2 < 0.1) then
            u51.Target = 0
        else
            u51.Target = -5 * v2
        end
        if 0.1 < v4 then
            u57.Target = -0.5 * v4
        elseif not (v4 < 0.1) then
            u57.Target = 0
        else
            u57.Target = -0.5 * v4
        end
    end
    u66[1] = u57.Position / 2
    u66[2] = u51.Position / 2
    local v5 = u66
    v3 = nil
    v1 = nil
    for i, j in v5, v3, v1 do
        if j <= 0.0001 and -0.0001 <= j then
            u66[i] = 0
        end
    end
    local Angles = CFrame.Angles
    local v6 = u66
    v1 = v6[1]
    v3 = math.rad(v1)
    local v7 = u66
    local v8 = v7[2]
    v5 = Angles(v3, 0, (math.rad(v8)))
    PointRotationUtil.UpdateRotation("Directional", u65, v5)
end

return v1